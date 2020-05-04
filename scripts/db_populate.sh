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
curl 'https://raw.githubusercontent.com/ALLIANCETECHSYSTEM/CovidWLDdb/master/files/reference_csv.csv' \
      -o $CSV_DIR/covidwld-reference.csv
curl 'https://raw.githubusercontent.com/flavianogjc/covid_web_scraping/master/country_datas.csv' \
      -o $CSV_DIR/covidwld-historical.csv   
curl 'https://raw.githubusercontent.com/flavianogjc/covid_web_scraping/master/arquivo_geral.csv' \
      -o $CSV_DIR/covidwld-brazil.csv

#####################
# Insert the data

## Insert the tables data
csvsql $CSV_DIR/covidwld-reference.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_DHRef    
csvsql $CSV_DIR/covidwld-historical.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_Hist
csvsql $CSV_DIR/covidwld-brazil.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_br

#####################
# EXIT
exit 0