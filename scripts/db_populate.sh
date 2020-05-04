#!/bin/bash

############## 
# REQUIREMENTS
# csvkit - sudo pip install csvkit

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/covid19WLDdb.sqlite3 ### Passed as ENV
CSV_DIR=/tmp/covid19wld
mkdir -p $CSV_DIR

################ 
# Download the files into $CSV_DIR
curl 'https://raw.githubusercontent.com/ALLIANCETECHSYSTEM/CovidWLDdb/master/files/time-series-19-covid-combined_csv.csv' \
      -o sed -e 's/\///_/g' $CSV_DIR/covidwld-combined.csv > $CSV_DIR/covidwld-combined2.csv
curl 'https://raw.githubusercontent.com/ALLIANCETECHSYSTEM/CovidWLDdb/master/files/countries-aggregated_csv.csv' \
      -o $CSV_DIR/covidwld-aggregated.csv
curl 'https://raw.githubusercontent.com/ALLIANCETECHSYSTEM/CovidWLDdb/master/files/worldwide-aggregated_csv.csv' \
      -o $CSV_DIR/covidwld-incrementrate.csv   
curl 'https://raw.githubusercontent.com/ALLIANCETECHSYSTEM/CovidWLDdb/master/files/reference_csv.csv' \
      -o $CSV_DIR/covidwld-reference.csv
curl 'https://raw.githubusercontent.com/ALLIANCETECHSYSTEM/CovidWLDdb/master/files/country_datas.csv' \
      -o $CSV_DIR/covidwld-30days.csv 

#####################
# Insert the data

## Insert the tables data
csvsql $CSV_DIR/covidwld-combined2.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_DHComb    
csvsql $CSV_DIR/covidwld-aggregated.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_DHAgreg
csvsql $CSV_DIR/covidwld-incrementrate.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_DHIncR
csvsql $CSV_DIR/covidwld-reference.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_DHRef
csvsql $CSV_DIR/covidwld-30days.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_30days

#####################
# EXIT
exit 0