
# File:        xgapui/R/generated\java\xgap4brassica\R/Strain_FounderStrains.R
# Copyright:   GBIC 2000-2.009, all rights reserved
# Date:        June 2, 2009
#
# generator:   org.molgenis.generators.R.REntityGen 3.3.0-testing
#
# This file provides action methods to MOLGENIS for entity Strain_FounderStrains
#
# THIS FILE HAS BEEN GENERATED, PLEASE DO NOT EDIT!
#

#create valid data_frame for Strain_FounderStrains
.create.strain_founderstrains <- function(data_frame, value_list, .usesession=T, .verbose=T)
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

#freely find Strain_FounderStrains 
find.strain_founderstrains <- function( strain_id=NULL, strain_name=NULL , .usesession = T, .verbose=T )
{
	#add session parameters
    
	result <- MOLGENIS.find( "xgap4brassica.data.types.Strain_FounderStrains", mget(ls(),environment()), .verbose=.verbose)
	return(result)
}

#add data.frame of Strain_FounderStrains or each column individually
#note: each column must have the same length
add.strain_founderstrains <- function(.data_frame=NULL, strain_id=NULL, strain_name=NULL, .usesession = T, .verbose=T )
{
	.data_frame = .create.strain_founderstrains(.data_frame, mget(ls(),environment()), .usesession = .usesession, .verbose = .verbose)
   	return( MOLGENIS.update("xgap4brassica.data.types.Strain_FounderStrains", .data_frame, "ADD", .verbose=.verbose) )
}


#remove data.frame of Strain_FounderStrains or just one row using named arguments.
remove.strain_founderstrains <- function( .data_frame=NULL, .usesession = T )
{	
	#todo: translate to skey to pkey
	.data_frame = .create.strain_founderstrains(.data_frame, mget(ls(),environment()), .usesession = .usesession)
   	return( MOLGENIS.update("xgap4brassica.data.types.Strain_FounderStrains", .data_frame, "REMOVE") )
}

use.strain_founderstrains<-function(key_unknown_for_strain_founderstrains=NULL)
{
	#add session parameters
    
    #retrieve the strain_founderstrains by pkey or skey
    row<-F
    if(!is.null(key_unknown_for_strain_founderstrains))
    {
    	row<-find.strain_founderstrains(key_unknown_for_strain_founderstrains=key_unknown_for_strain_founderstrains) 
    }  
    else
    {
    	stop('you need to provide {key_unknown_for_strain_founderstrains}')
    }       
    
    #if exists, put in session
    if(!is.logical(row) && nrow(row) == 1)
    {
    	cat("Using strain_founderstrains with:\n")
    	cat("\tkey_unknown_for_strain_founderstrains=",row$key_unknown_for_strain_founderstrains,"\n")
		.MOLGENIS$session.strain_founderstrains.key_unknown_for_strain_founderstrains<<-row$key_unknown_for_strain_founderstrains
    }
    else
    {
       cat("Did not find strain_founderstrains using ","key_unknown_for_strain_founderstrains=",key_unknown_for_strain_founderstrains,"\n")
    }
}