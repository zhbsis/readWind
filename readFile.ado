*===============================================================================
* Program: readFile.ado
* Purpose: read Excel File into stata
* Version: 1.0 (2019/04/13)
* Author:  Devin Chu
* Website: http://www.github.com/zhbsis/readWind
*===============================================================================

capture program drop readFile
program define readFile
	version 14.0
	syntax, key(str) [type(str) encoding(str) sheet(integer 1) tostring]	

	* set default excel type
	if("`type'"==""){
		local type "xlsx"   
	}
	
	* set default coding type
	if("`encoding'"==""){
		local encoding "UTF-8"   
	}
	
	* read all .type into local name
	local name ""
	local ff:dir . files "*.`type'"
	foreach var_ of local ff{
		local temp=subinstr("`var_'", ".`type'", "",.)
		local name "`name' `temp'"
	}

	* regexm and import function
	foreach VAR of local name{	
		local match1=upper("`VAR'")
		local match2=upper("`key'")
		
		if(regexm("`match1'","`match2'")==1){             // regexm
			/* detect the dataset's format*/
			if("`type'"=="csv"){
				/*import csv*/
				import delimited `VAR'.csv, varnames(1) encoding(`encoding') clear
				
				/* force to change all var in to string*/
				if("`tostring'"=="tostring"){
					qui tostring _all, replace force
				}		
			}
			if("`type'"=="xls")|("`type'"=="xlsx"){
				/*information of imported excel*/
				qui import excel `VAR'.`type', describe
				local SHEET = r(worksheet_`sheet')            // default sheet=1
				local RANGE = r(range_`sheet')                // default sheet=1

				/*import excel*/
				import excel `VAR'.`type', sheet("`SHEET'") cellrange(`RANGE') firstrow	clear
				
				/* force to change all var in to string*/
				if("`tostring'"=="tostring"){
					qui tostring _all, replace force
				}
			}
		}
	}
end
