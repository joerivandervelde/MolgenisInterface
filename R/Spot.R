
# File:        xgapui/R/generated\java\xgap4brassica\R/Spot.R
# Copyright:   GBIC 2000-2.009, all rights reserved
# Date:        June 2, 2009
#
# generator:   org.molgenis.generators.R.REntityGen 3.3.0-testing
#
# This file provides action methods to MOLGENIS for entity Spot
#
# THIS FILE HAS BEEN GENERATED, PLEASE DO NOT EDIT!
#

#create valid data_frame for Spot
.create.spot <- function(data_frame, value_list, .usesession=T, .verbose=T)
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
    #add missing xref values from session parameters (optional)
    if(.usesession && is.null(data_frame$protocol__id) && !is.null(.MOLGENIS$session.protocol.id))    
    {
        data_frame$protocol = .MOLGENIS$session.protocol.id
        if(.verbose) 
        {
        	cat("Using protocol (id='",.MOLGENIS$session.protocol.id,"'", sep="")
			cat(") from session (.usession = T).\n")
		} 
    }
        
    return(data_frame)
}

#freely find Spot 
find.spot <- function( cm=NULL , chr=NULL , bpstart=NULL , bpend=NULL , species_id=NULL, species_name=NULL , seq=NULL , type=NULL , id=NULL , name=NULL , investigation_id=NULL, investigation_name=NULL , protocol_id=NULL, protocol_name=NULL , mismatch=NULL , probeset_id=NULL, probeset_name=NULL , x=NULL , y=NULL , gridx=NULL , gridy=NULL , .usesession = T, .verbose=T )
{
	#add session parameters
    if(.usesession && is.null(investigation_id) && !is.null(.MOLGENIS$session.investigation.id))    
    {
        investigation_id = .MOLGENIS$session.investigation.id
        cat("Using investigation_id (id='",.MOLGENIS$session.investigation.id,"'", sep="")
		cat(", name='",.MOLGENIS$session.investigation.name,"'", sep="")
		cat(") from session (.usession = T).\n")        
    } 
    if(.usesession && is.null(protocol_id) && !is.null(.MOLGENIS$session.protocol.id))    
    {
        protocol_id = .MOLGENIS$session.protocol.id
        cat("Using protocol_id (id='",.MOLGENIS$session.protocol.id,"'", sep="")
		cat(") from session (.usession = T).\n")        
    } 
    
	result <- MOLGENIS.find( "xgap4brassica.data.types.Spot", mget(ls(),environment()), .verbose=.verbose)
	#use secondary key as rownames
	#rownames(result)<-result$name
	return(result)
}

#add data.frame of Spot or each column individually
#note: each column must have the same length
add.spot <- function(.data_frame=NULL, cm=NULL, chr=NULL, bpstart=NULL, bpend=NULL, species_id=NULL, species_name=NULL, seq=NULL, name=NULL, investigation_id=NULL, investigation_name=NULL, protocol_id=NULL, protocol_name=NULL, mismatch=NULL, probeset_id=NULL, probeset_name=NULL, x=NULL, y=NULL, gridx=NULL, gridy=NULL, .usesession = T, .verbose=T )
{
	.data_frame = .create.spot(.data_frame, mget(ls(),environment()), .usesession = .usesession, .verbose = .verbose)
   	return( MOLGENIS.update("xgap4brassica.data.types.Spot", .data_frame, "ADD", .verbose=.verbose) )
}


#remove data.frame of Spot or just one row using named arguments.
remove.spot <- function( .data_frame=NULL, id=NULL, name=NULL, investigation=NULL, type=NULL, protocol=NULL, x=NULL, y=NULL, gridx=NULL, gridy=NULL, .usesession = T )
{	
	#todo: translate to skey to pkey
	.data_frame = .create.spot(.data_frame, mget(ls(),environment()), .usesession = .usesession)
   	return( MOLGENIS.update("xgap4brassica.data.types.Spot", .data_frame, "REMOVE") )
}

use.spot<-function(id=NULL, name=NULL, investigation=NULL, type=NULL, protocol=NULL, x=NULL, y=NULL, gridx=NULL, gridy=NULL)
{
	#add session parameters
    if(is.null(investigation) && !is.null(.MOLGENIS$session.investigation.id))    
    {
        investigation = .MOLGENIS$session.investigation.id
        cat("Using investigation (id='",.MOLGENIS$session.investigation.id,"'", sep="")
		cat(", name='",.MOLGENIS$session.investigation.name,"'", sep="")
		cat(") from session.\n")        
    } 
    if(is.null(protocol) && !is.null(.MOLGENIS$session.protocol.id))    
    {
        protocol = .MOLGENIS$session.protocol.id
        cat("Using protocol (id='",.MOLGENIS$session.protocol.id,"'", sep="")
		cat(") from session.\n")        
    } 
    
    #retrieve the spot by pkey or skey
    row<-F
    if(!is.null(id))
    {
    	row<-find.spot(id=id) 
    }  
	else if( !(is.null(name) ||is.null(investigation) ||is.null(type)) )
	{
		row<-find.spot(name=name,investigation=investigation,type=type)
	} 
	else if( !(is.null(protocol) ||is.null(x) ||is.null(y) ||is.null(gridx) ||is.null(gridy)) )
	{
		row<-find.spot(protocol=protocol,x=x,y=y,gridx=gridx,gridy=gridy)
	} 
    else
    {
    	stop('you need to provide {id} or {name and investigation and type} or {protocol and x and y and gridx and gridy}')
    }       
    
    #if exists, put in session
    if(!is.logical(row) && nrow(row) == 1)
    {
    	cat("Using spot with:\n")
    	cat("\tid=",row$id,"\n")
		.MOLGENIS$session.spot.id<<-row$id
		cat("\tname=",row$name,"\n")
		.MOLGENIS$session.spot.name<<-row$name
		cat("\tinvestigation=",row$investigation,"\n")
		.MOLGENIS$session.spot.investigation<<-row$investigation
		cat("\ttype=",row$type,"\n")
		.MOLGENIS$session.spot.type<<-row$type
		cat("\tprotocol=",row$protocol,"\n")
		.MOLGENIS$session.spot.protocol<<-row$protocol
		cat("\tx=",row$x,"\n")
		.MOLGENIS$session.spot.x<<-row$x
		cat("\ty=",row$y,"\n")
		.MOLGENIS$session.spot.y<<-row$y
		cat("\tgridx=",row$gridx,"\n")
		.MOLGENIS$session.spot.gridx<<-row$gridx
		cat("\tgridy=",row$gridy,"\n")
		.MOLGENIS$session.spot.gridy<<-row$gridy
    }
    else
    {
       cat("Did not find spot using ","id=",id,"name=",name,"investigation=",investigation,"type=",type,"protocol=",protocol,"x=",x,"y=",y,"gridx=",gridx,"gridy=",gridy,"\n")
    }
}