#####################################################################
#
# ResultsToMolgenis.R
#
# copyright (c) 2009, Danny Arends
# last modified Apr, 2009
# first written Feb, 2009
#
#     This program is free software; you can redistribute it and/or
#     modify it under the terms of the GNU General Public License, as
#     published by the Free Software Foundation; either version 2 of
#     the License, or (at your option) any later version. 
# 
#     This program is distributed in the hope that it will be useful,
#     but without any warranty; without even the implied warranty of
#     merchantability or fitness for a particular purpose.  See the
#     GNU General Public License for more details.
# 
#     A copy of the GNU General Public License is available at
#     http://www.r-project.org/Licenses/
#
# Part of the R/qtl package
# Contains: ResultsToMolgenis: Stores results from scanone scanMQM and scanALL into a molgenis database
#
######################################################################

ResultsToMolgenis <- function(intervalQTLmap=NULL,name="MQMresultsTest",Trait_num=0,DBpath=NULL,verbose=TRUE){
	library("RCurl")
	if(!("RCurl" %in% names( getLoadedDLLs()))){
		ourstop("Please install the package RCurl from bioconductor to use the molgenis interface\n")
	}
	if(is.null(DBpath)){
		ourstop("Please provide a valid DBpath\n")
	}else{
		#Set the path to molgenis
		molgenispath <- paste(DBpath,"/api/R/",sep="")
		
		#Source the interface
		if(!exists(".MOLGENIS")){
			source(molgenispath)
		}
	}

	#get data from server
	if(is.null(intervalQTLmap)){
		ourstop("Please supply a QTL interval map\n")
	}
	if(any(class(intervalQTLmap) == "scanone")){
		#cat("INFO: Valid object from scanone, containing 1 phenotype\n")
		num_pheno <- 1
	}
	if(any(class(intervalQTLmap) == "MQMmulti")){
		#cat("INFO: Valid object from MultiQTL scan, containing ",length(intervalQTLmap)," phenotypes\n")
		num_pheno <- length(intervalQTLmap)
	}
	investi <- find.investigation(.verbose=verbose)
	if(verbose)cat("INFO: Found",dim(investi)[1],"investigations in the current database\n")
	if("MQMQTL" %in% investi$name){
		if(verbose)cat("INFO: Found MQMQTL investigation in the current database\n")
		num <- find.investigation(name="MQMQTL",.verbose=verbose)
	}else{
		if(verbose)cat("INFO: Created a new instance of an MQMQTL investigation in the current database\n")
		num <- add.investigation(name="MQMQTL",.verbose=verbose)
	}
	
	#Get all the markers
	markers <- find.marker(.verbose=verbose)
	if(verbose)cat("INFO: Found",dim(markers)[1],"markers in the current database\n")
	if(verbose)cat("INFO: num_pheno:",num_pheno,"phenotypes 2 upload\n")
	if(verbose)cat("INFO: length:",length(intervalQTLmap),"should be above line\n")
	cnt <- 0
	for(j in 1:num_pheno){
		#cat("j value:",j,"\n")
		#cat(class(intervalQTLmap[[j]]),"\n")
		for(i in 1:dim(intervalQTLmap[[j]])[1]) {
			if(!rownames(intervalQTLmap[[j]])[i] %in% markers$name){
				add.marker(name=rownames(intervalQTLmap[[j]])[i],chr=intervalQTLmap[[j]][i,"chr"],cm=intervalQTLmap[[j]][i,"pos (Cm)"],investigation_id=num$id)
				cnt=cnt+1
			}
		}
	}
	if(verbose)cat("INFO: Added",cnt,"markers to the current database\n")	
	#Markers are inside molgenis, now we need to get the QTL's in
	
	aaa <- find.data(name=name,.verbose=verbose)
	if(!dim(aaa)[1]){
		#No find, so we'll create one
		if(verbose)cat("INFO: Not matrix named",name,"found in the current database\n")
		if(verbose)cat("INFO: Creating:",name,"in the current database\n")
		aaa <- add.data(name = name,investigation_id=num$id,rowtype="Marker",coltype="Trait",totalrows=1,totalcols=1,valuetype="Decimal",.verbose=verbose)
	}else{
		if(verbose)cat("INFO: Matrix named",name,"found in the current database\n")
	}

	for(j in 1:num_pheno){
		colnam <- colnames(intervalQTLmap[[j]])[3]
		colnam <- substr(colnam,5,nchar(colnames(intervalQTLmap[[j]])[3]))
		if(colnam ==""){
			colnam = paste("unknown",j,sep="")
		}
		names <- NULL
		values <- NULL
		rowindex <- NULL
		colindex <- (j+Trait_num)-1
		for(i in 1:dim(intervalQTLmap[[j]])[1]) {
			names <- c(names,rownames(intervalQTLmap[[j]])[i])
			values <- c(values,intervalQTLmap[[j]][i,3])
			rowindex <- c(rowindex,i-1)
		}
		if(verbose)cat("INFO: Trying to upload a trait ",colnam," to column:",colindex,"\n")  
		add.decimaldataelement(data_id=aaa$id, col_name=colnam, row_name=names, rowindex=rowindex, colindex=colindex, value=values,.verbose=verbose)
	}
}

# end of ResultsToMolgenis.R
