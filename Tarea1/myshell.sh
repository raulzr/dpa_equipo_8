#!/bin/bash          

function generate_dates(){
#  genera un rango de fechas 
	startdate=$1 
	#enddate='date +%Y%m%d'
	enddate=$2

	curr="$startdate"
	while true; do
    	echo "$curr"
    	[ "$curr" \< "$enddate" ] || break
    	curr=$( date +%Y%m%d --date "$curr +1 day" )
	done
}
#
#   Ejecutar proceso de :
#   Descargar archivos usando parallel
#   Aplicar filtros incicial para cosntruir un grupo de registros con la cadena MEX
#   Aplicar filtro en el que Actor es la cadena MEX
#   Insertar en la base de datos gdelt.db
#
generate_dates 20161201 20170130 > fechas.txt

#cat fechas.txt | parallel  wget  --tries=0 -r --no-parent -A  {}.export.CSV.zip  http://data.gdeltproject.org/events/index.html
#cat fechas.txt | parallel  echo -r  {}.export.CSV.zip  http://data.gdeltproject.org/events/index.html
cat fechas.txt | parallel zgrep MEX ./data.gdeltproject.org/events/{}.export.CSV.zip  > salida_grep.csv
cat salida_grep.csv | awk -f mex.awk  > salida_awk.csv
cat headers_mex.csv salida_awk.csv | tee temporal.csv > eventos.csv 
csvsql --db sqlite:///gdelt.db --insert eventos.csv
csvsql --db sqlite:///gdelt.db --insert temporal.csv
sqlite3 gdelt.db < comandos.sql
