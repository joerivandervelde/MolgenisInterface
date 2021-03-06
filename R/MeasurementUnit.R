
# File:        xgapui/R/generated\java\xgap4brassica\R/MeasurementUnit.R
# Copyright:   GBIC 2000-2.009, all rights reserved
# Date:        June 2, 2009
#
# generator:   org.molgenis.generators.R.REntityGen 3.3.0-testing
#
# This file provides action methods to MOLGENIS for entity MeasurementUnit
#
# THIS FILE HAS BEEN GENERATED, PLEASE DO NOT EDIT!
#

#create valid data_frame for MeasurementUnit
.create.measurementunit <- function(data_frame, value_list, .usesession=T, .verbose=T)
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
  	  	  	
        
    return(data_frame)
}

#freely find MeasurementUnit 
find.measurementunit <- function( type=NULL , id=NULL , name=NULL , term=NULL , termaccession=NULL , ontologysource_id=NULL, ontologysource_name=NULL , .usesession = T, .verbose=T )
{
	#add session parameters
    
	result <- MOLGENIS.find( "xgap4brassica.data.types.MeasurementUnit", mget(ls(),environment()), .verbose=.verbose)
	return(result)
}

#add data.frame of MeasurementUnit or each column individually
#note: each column must have the same length
add.measurementunit <- function(.data_frame=NULL, name=NULL, term=NULL, termaccession=NULL, ontologysource_id=NULL, ontologysource_name=NULL, .usesession = T, .verbose=T )
{
	.data_frame = .create.measurementunit(.data_frame, mget(ls(),environment()), .usesession = .usesession, .verbose = .verbose)
   	return( MOLGENIS.update("xgap4brassica.data.types.MeasurementUnit", .data_frame, "ADD", .verbose=.verbose) )
}


#remove data.frame of MeasurementUnit or just one row using named arguments.
remove.measurementunit <- function( .data_frame=NULL, id=NULL, .usesession = T )
{	
	#todo: translate to skey to pkey
	.data_frame = .create.measurementunit(.data_frame, mget(ls(),environment()), .usesession = .usesession)
   	return( MOLGENIS.update("xgap4brassica.data.types.MeasurementUnit", .data_frame, "REMOVE") )
}

use.measurementunit<-function(id=NULL)
{
	#add session parameters
    
    #retrieve the measurementunit by pkey or skey
    row<-F
    if(!is.null(id))
    {
    	row<-find.measurementunit(id=id) 
    }  
    else
    {
    	stop('you need to provide {id}')
    }       
    
    #if exists, put in session
    if(!is.logical(row) && nrow(row) == 1)
    {
    	cat("Using measurementunit with:\n")
    	cat("\tid=",row$id,"\n")
		.MOLGENIS$session.measurementunit.id<<-row$id
    }
    else
    {
       cat("Did not find measurementunit using ","id=",id,"\n")
    }
}