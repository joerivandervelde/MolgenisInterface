
# File:        xgapui/R/generated\java\xgap4brassica\R/Individual.R
# Copyright:   GBIC 2000-2.009, all rights reserved
# Date:        June 2, 2009
#
# generator:   org.molgenis.generators.R.REntityGen 3.3.0-testing
#
# This file provides action methods to MOLGENIS for entity Individual
#
# THIS FILE HAS BEEN GENERATED, PLEASE DO NOT EDIT!
#

#create valid data_frame for Individual
.create.individual <- function(data_frame, value_list, .usesession=T, .verbose=T)
{
	#convert to data_frame, remove null columns
	if(!is.data.frame(data_frame))
	{
		if(is.matrix(data_frame))
		{
			data_frame <- as.data.frame(data_frame)
		}
		else if(is.list(data_frame))
		{
			data_frame <- as.data.frame(data_frame[!sapply(data_frame, is.null)])
		}
		#transform non-null values into data.frame
		else
		{
			data_frame <- as.data.frame(value_list[!sapply(value_list, is.null)])
		}
  	}	
  	  	  	
    #add missing xref values from session parameters (optional)
    if(.usesession && is.null(data_frame$investigation__id) && !is.null(.MOLGENIS$session.investigation.id))    
    {
        data_frame$investigation = .MOLGENIS$session.investigation.id
        if(.verbose) 
        {
        	cat("Using investigation (id='",.MOLGENIS$session.investigation.id,"'", sep="")
			cat(", name='",.MOLGENIS$session.investigation.name,"'", sep="")
			cat(") from session (.usession = T).\n")
		} 
    }
        
    return(data_frame)
}

#freely find Individual 
find.individual <- function( type=NULL , id=NULL , name=NULL , investigation_id=NULL, investigation_name=NULL , species_id=NULL, species_name=NULL , strain_id=NULL, strain_name=NULL , mother_id=NULL, mother_name=NULL , father_id=NULL, father_name=NULL , .usesession = T, .verbose=T )
{
	#add session parameters
    if(.usesession && is.null(investigation_id) && !is.null(.MOLGENIS$session.investigation.id))    
    {
        investigation_id = .MOLGENIS$session.investigation.id
        cat("Using investigation_id (id='",.MOLGENIS$session.investigation.id,"'", sep="")
		cat(", name='",.MOLGENIS$session.investigation.name,"'", sep="")
		cat(") from session (.usession = T).\n")        
    } 
    
	result <- MOLGENIS.find( "xgap4brassica.data.types.Individual", mget(ls(),environment()), .verbose=.verbose)
	#use secondary key as rownames
	#rownames(result)<-result$name
	return(result)
}

#add data.frame of Individual or each column individually
#note: each column must have the same length
add.individual <- function(.data_frame=NULL, name=NULL, investigation_id=NULL, investigation_name=NULL, species_id=NULL, species_name=NULL, strain_id=NULL, strain_name=NULL, mother_id=NULL, mother_name=NULL, father_id=NULL, father_name=NULL, .usesession = T, .verbose=T )
{
	.data_frame = .create.individual(.data_frame, mget(ls(),environment()), .usesession = .usesession, .verbose = .verbose)
   	return( MOLGENIS.update("xgap4brassica.data.types.Individual", .data_frame, "ADD", .verbose=.verbose) )
}


#remove data.frame of Individual or just one row using named arguments.
remove.individual <- function( .data_frame=NULL, id=NULL, name=NULL, investigation=NULL, type=NULL, .usesession = T )
{	
	#todo: translate to skey to pkey
	.data_frame = .create.individual(.data_frame, mget(ls(),environment()), .usesession = .usesession)
   	return( MOLGENIS.update("xgap4brassica.data.types.Individual", .data_frame, "REMOVE") )
}

use.individual<-function(id=NULL, name=NULL, investigation=NULL, type=NULL)
{
	#add session parameters
    if(is.null(investigation) && !is.null(.MOLGENIS$session.investigation.id))    
    {
        investigation = .MOLGENIS$session.investigation.id
        cat("Using investigation (id='",.MOLGENIS$session.investigation.id,"'", sep="")
		cat(", name='",.MOLGENIS$session.investigation.name,"'", sep="")
		cat(") from session.\n")        
    } 
    
    #retrieve the individual by pkey or skey
    row<-F
    if(!is.null(id))
    {
    	row<-find.individual(id=id) 
    }  
	else if( !(is.null(name) ||is.null(investigation) ||is.null(type)) )
	{
		row<-find.individual(name=name,investigation=investigation,type=type)
	} 
    else
    {
    	stop('you need to provide {id} or {name and investigation and type}')
    }       
    
    #if exists, put in session
    if(!is.logical(row) && nrow(row) == 1)
    {
    	cat("Using individual with:\n")
    	cat("\tid=",row$id,"\n")
		.MOLGENIS$session.individual.id<<-row$id
		cat("\tname=",row$name,"\n")
		.MOLGENIS$session.individual.name<<-row$name
		cat("\tinvestigation=",row$investigation,"\n")
		.MOLGENIS$session.individual.investigation<<-row$investigation
		cat("\ttype=",row$type,"\n")
		.MOLGENIS$session.individual.type<<-row$type
    }
    else
    {
       cat("Did not find individual using ","id=",id,"name=",name,"investigation=",investigation,"type=",type,"\n")
    }
}