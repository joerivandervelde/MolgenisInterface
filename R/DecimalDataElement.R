
# File:        xgapui/R/generated\java\xgap4brassica\R/DecimalDataElement.R
# Copyright:   GBIC 2000-2.009, all rights reserved
# Date:        June 2, 2009
#
# generator:   org.molgenis.generators.R.REntityGen 3.3.0-testing
#
# This file provides action methods to MOLGENIS for entity DecimalDataElement
#
# THIS FILE HAS BEEN GENERATED, PLEASE DO NOT EDIT!
#

#create valid data_frame for DecimalDataElement
.create.decimaldataelement <- function(data_frame, value_list, .usesession=T, .verbose=T)
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
    if(.usesession && is.null(data_frame$data__id) && !is.null(.MOLGENIS$session.data.id))    
    {
        data_frame$data = .MOLGENIS$session.data.id
        if(.verbose) 
        {
        	cat("Using data (id='",.MOLGENIS$session.data.id,"'", sep="")
			cat(", name='",.MOLGENIS$session.data.name,"'", sep="")
			cat(", investigation='",.MOLGENIS$session.data.investigation,"'", sep="")
			cat(") from session (.usession = T).\n")
		} 
    }
        
    return(data_frame)
}

#freely find DecimalDataElement 
find.decimaldataelement <- function( id=NULL , data_id=NULL, data_name=NULL , col_id=NULL, col_name=NULL , row_id=NULL, row_name=NULL , rowindex=NULL , colindex=NULL , value=NULL , .usesession = T, .verbose=T )
{
	#add session parameters
    if(.usesession && is.null(data_id) && !is.null(.MOLGENIS$session.data.id))    
    {
        data_id = .MOLGENIS$session.data.id
        cat("Using data_id (id='",.MOLGENIS$session.data.id,"'", sep="")
		cat(", name='",.MOLGENIS$session.data.name,"'", sep="")
		cat(", investigation='",.MOLGENIS$session.data.investigation,"'", sep="")
		cat(") from session (.usession = T).\n")        
    } 
    
	result <- MOLGENIS.find( "xgap4brassica.data.types.DecimalDataElement", mget(ls(),environment()), .verbose=.verbose)
	#use secondary key as rownames
	#rownames(result)<-result$colindex
	return(result)
}

#add data.frame of DecimalDataElement or each column individually
#note: each column must have the same length
add.decimaldataelement <- function(.data_frame=NULL, data_id=NULL, data_name=NULL, col_id=NULL, col_name=NULL, row_id=NULL, row_name=NULL, rowindex=NULL, colindex=NULL, value=NULL, .usesession = T, .verbose=T )
{
	.data_frame = .create.decimaldataelement(.data_frame, mget(ls(),environment()), .usesession = .usesession, .verbose = .verbose)
   	return( MOLGENIS.update("xgap4brassica.data.types.DecimalDataElement", .data_frame, "ADD", .verbose=.verbose) )
}


#remove data.frame of DecimalDataElement or just one row using named arguments.
remove.decimaldataelement <- function( .data_frame=NULL, id=NULL, colindex=NULL, rowindex=NULL, data=NULL, .usesession = T )
{	
	#todo: translate to skey to pkey
	.data_frame = .create.decimaldataelement(.data_frame, mget(ls(),environment()), .usesession = .usesession)
   	return( MOLGENIS.update("xgap4brassica.data.types.DecimalDataElement", .data_frame, "REMOVE") )
}

use.decimaldataelement<-function(id=NULL, colindex=NULL, rowindex=NULL, data=NULL)
{
	#add session parameters
    if(is.null(data) && !is.null(.MOLGENIS$session.data.id))    
    {
        data = .MOLGENIS$session.data.id
        cat("Using data (id='",.MOLGENIS$session.data.id,"'", sep="")
		cat(", name='",.MOLGENIS$session.data.name,"'", sep="")
		cat(", investigation='",.MOLGENIS$session.data.investigation,"'", sep="")
		cat(") from session.\n")        
    } 
    
    #retrieve the decimaldataelement by pkey or skey
    row<-F
    if(!is.null(id))
    {
    	row<-find.decimaldataelement(id=id) 
    }  
	else if( !(is.null(colindex) ||is.null(rowindex) ||is.null(data)) )
	{
		row<-find.decimaldataelement(colindex=colindex,rowindex=rowindex,data=data)
	} 
	else if( !(is.null(rowindex) ||is.null(colindex) ||is.null(data)) )
	{
		row<-find.decimaldataelement(rowindex=rowindex,colindex=colindex,data=data)
	} 
    else
    {
    	stop('you need to provide {id} or {colindex and rowindex and data} or {rowindex and colindex and data}')
    }       
    
    #if exists, put in session
    if(!is.logical(row) && nrow(row) == 1)
    {
    	cat("Using decimaldataelement with:\n")
    	cat("\tid=",row$id,"\n")
		.MOLGENIS$session.decimaldataelement.id<<-row$id
		cat("\tcolindex=",row$colindex,"\n")
		.MOLGENIS$session.decimaldataelement.colindex<<-row$colindex
		cat("\trowindex=",row$rowindex,"\n")
		.MOLGENIS$session.decimaldataelement.rowindex<<-row$rowindex
		cat("\tdata=",row$data,"\n")
		.MOLGENIS$session.decimaldataelement.data<<-row$data
		cat("\trowindex=",row$rowindex,"\n")
		.MOLGENIS$session.decimaldataelement.rowindex<<-row$rowindex
		cat("\tcolindex=",row$colindex,"\n")
		.MOLGENIS$session.decimaldataelement.colindex<<-row$colindex
		cat("\tdata=",row$data,"\n")
		.MOLGENIS$session.decimaldataelement.data<<-row$data
    }
    else
    {
       cat("Did not find decimaldataelement using ","id=",id,"colindex=",colindex,"rowindex=",rowindex,"data=",data,"\n")
    }
}