
generateRunfile <- function(job, est){
	#Generate a runfile to submit to the cluster
	runfile <- paste("~/run/run",job,".sh",sep="")
	cat("#!/bin/sh","\n",sep="",file=runfile)
	cat("#PBS -l nodes=1","\n",sep="",file=runfile,append=T)
	cat("#PBS -l walltime=",est,"\n",sep="",file=runfile,append=T)
	cat("cd $HOME/run","\n",sep="",file=runfile,append=T)
	cat("R CMD BATCH qtl",job,".R",sep="",file=runfile,append=T)
	runfile
}

#tryCatch(stop(9), error = function(e) e) Do this for eveything that could fail on the servlets...

Generate_Statement <- function(statement){
	secured <- paste("tryCatch(\n\t",statement,"\t,error = report(-1,\"Error\")\n)\n",sep="")
	secured
}

generateQTLfile <- function(DBmarkerID = 0, DBtraitID = 0, DBpath = "", job, b_size,Ntraits,name,taskID){
	#Generate a qtl<#>.R file to do the analysis on
	qtlfile <- paste("~/run/qtl",job,".R",sep="")
	cat("library(qtl,lib.loc='~/libs')","\n",sep="",file=qtlfile)
	cat("library(RCurl,lib.loc='~/libs')","\n",sep="",file=qtlfile,append=T)
	cat("library(molgenis,lib.loc='~/libs')","\n",sep="",file=qtlfile,append=T)
	cat("library(snow,lib.loc='~/libs')","\n",sep="",file=qtlfile,append=T)
	cat("\nreport <- function(status,text){\n",file=qtlfile,append=T)
	cat("\ttask <- ",taskID,"\n",file=qtlfile,append=T)
	cat("\tjob <- ",job,"\n",file=qtlfile,append=T)
	cat("\tlink <- paste(\"",DBpath,"/taskreporter?task=\",task,\"&job=\",job,\"&status=\",status,\"&additional=\",text,sep=\"\")\n",sep="",file=qtlfile,append=T)
	cat("\tcat(link,\"\n\")\n",file=qtlfile,append=T)
	cat("\tgetURL(link)\n",file=qtlfile,append=T)
	cat("\tif(status==-1){\n\t\tq(\"no\")\n\t}\n",file=qtlfile,append=T)
	cat("}\n\n",file=qtlfile,append=T)
	cat("report(1,\"GonnaGetJob\")\n",file=qtlfile,append=T)
	cat((paste("cross <- CrossFromMolgenis(DBmarkerID=",DBmarkerID,",DBtraitID=",DBtraitID,",DBpath='",DBpath,"',verbose=T)","\n",sep="")),file=qtlfile,append=T)
	cat("report(1,\"DoneGettingJob\")\n",file=qtlfile,append=T)
	if(((job-1)*b_size)+b_size > Ntraits){
		#final batch
		cat("cross$pheno <- cross$pheno[",((job-1)*b_size)+1,":",Ntraits,"]","\n",sep="",file=qtlfile,append=T)
	}else{
		cat("cross$pheno <- cross$pheno[",((job-1)*b_size)+1,":",((job-1)*b_size)+b_size,"]","\n",sep="",file=qtlfile,append=T)
	}
	cat((paste("results <- scanall(cross,multiC=FALSE,verbose=TRUE)","\n",sep="")),file=qtlfile,append=T)
	cat("report(1,\"GonnaPutResult\")\n",file=qtlfile,append=T)
	cat((paste("ResultsToMolgenis(results,'",name,"',",(job-1)*b_size,",DBpath='",DBpath,"')","\n",sep="")),file=qtlfile,append=T)
	cat("report(2,\"Finished\")\n",file=qtlfile,append=T)
	cat("q(\"no\")","\n",sep="",file=qtlfile,append=T)
}

generateESTfile <- function(DBmarkerID = 0, DBtraitID = 0, DBpath = ""){
	#Generates a qtlfile to estimate walltime
	qtlfile <- paste("~/run/ESTtime.R",sep="")
	cat("library(qtl,lib.loc='~/libs')","\n",sep="",file=qtlfile)
	cat("library(RCurl,lib.loc='~/libs')","\n",sep="",file=qtlfile,append=T)
	cat("library(molgenis,lib.loc='~/libs')","\n",sep="",file=qtlfile,append=T)
	cat("cross <- CrossFromMolgenis(DBmarkerID=",DBmarkerID,",DBtraitID=",DBtraitID,",DBpath='",DBpath,"')","\n",sep="",file=qtlfile,append=T)
	cat("cross$pheno <- cross$pheno[1]","\n",sep="",file=qtlfile,append=T)
	cat("results <- scanall(cross,multiC=FALSE,verbose=TRUE)","\n",sep="",file=qtlfile,append=T)
	cat("q(\"no\")","\n",sep="",file=qtlfile,append=T)
}

prepare_cluster <- function(){
	#Commands to execute to install R-libs
	system("R CMD INSTALL ~/required/qtl_1.12-16.tar.gz --library=~/libs")
	system("R CMD INSTALL ~/required/RCurl_0.91-0.tar.gz --library=~/libs")
	system("R CMD INSTALL ~/required/molgenis_0.01.tar.gz --library=~/libs")
	system("R CMD INSTALL ~/required/snow_0.3-3.tar.gz --library=~/libs")
	cat("Deleting old run-files\n")
	system("rm -rf ~/run")
	system("rm -f run*")
	cat("Resetting directory\n")
	system("mkdir run")
	system("cd run")
	setwd("~/run")
}

est_runtime <- function(njobs,DBmarkerID=0, DBtraitID = 0,ntraits=1, DBpath = "",num_per_run=1){
	#Crude estimation of time that it would take a job of num_per_run qtls to finish, we get all the data from molgenis and run 2 qtls profiles
	s <- proc.time()
	generateESTfile(DBmarkerID, DBtraitID, DBpath)
	system("R CMD BATCH ESTtime.R")
	e <- proc.time()
	EST <- (num_per_run/10)*((e[3]-s[3])*1.25)
	ESTtime <- sprintf("%02.f:%02.f:%02.f",EST %/% 3600, (EST%%3600) %/% 60, round(EST%%60, digits = 0))
	ESTtime 
}


report_status <- function(DBpath,taskID,ID,status,text,file){
	link <- paste(DBpath,"/taskreporter?task=",taskID,"&job=",ID,"&status=",status,"&additional=",text,sep="")
	cat("link <- \"",link,"\"\n",sep="",file=file,append=T)
	cat("getURL(link)\n",file=file,append=T)
}

run_cluster <- function(name = "qtlTEST",DBmarkerID = 0, DBtraitID = 0,ntraits=1, njobs=1,DBpath = "",taskID="1"){
	#initializes the cluster, installs R-libraries (could only be done once)
	#Estimated time needed for each run (very crude)
	#--Generate a QTLfile
	#--Generate runfile for cluster
	#--Sends the runfile as a job to the cluster
	est = NULL
	runfile = NULL
	if(ntraits < njobs){
		njobs = ntraits
	}
	nprun <- ceiling(ntraits/njobs)
	cat("# of Traits:",ntraits,"\n# of Jobs",njobs,"# per run",nprun,"\n")
	prepare_cluster()
	est <- est_runtime(njobs,DBmarkerID,DBtraitID,ntraits,DBpath=DBpath,nprun)
	if(is.null(name)) name="qtlTEST"
	cat("Estimated for ",name,". Runtime per job=",est,"\n")
	#ALL DONE NOW WE CAN GO INTO/run directory and make some calculations
	for(x in 1:njobs){
		cat("Generating: ",x,".1/",njobs,"\n",sep="")
		generateQTLfile(DBmarkerID=DBmarkerID, DBtraitID=DBtraitID, DBpath=DBpath, job=x, b_size=nprun,Ntraits=ntraits,name=name,taskID)
		cat("Generating: ",x,".2/",njobs,"\n",sep="")
		runfile <- generateRunfile(x,est)
		cat("Submitting: ",x,".3/",njobs,":",runfile,"\n",sep="")
		#OLD call to sh to compute on the Sceduler
		system(paste("sh ",runfile,sep=""))
		#system(paste("qsub ",runfile,sep=""))
	}
}