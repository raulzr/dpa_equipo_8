#
#
# AWK Filtering MEX as an actor
#
#
BEGIN { 
	     FS =  "\t" 
	     OFS = "\t"
	     
} 
{   	
			if ( $6 == "MEX" ){
			   	print $0 
   		} 	 
}
END{
		
}
