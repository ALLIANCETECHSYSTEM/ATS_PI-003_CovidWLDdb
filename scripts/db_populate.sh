#!/bin/bash

############## 
# REQUIREMENTS
# csvkit - sudo pip install csvkit

############## 
# Setup new data workspace
#DB_PATH=databases/sqlite/covid19WLDdb.sqlite3 ### Passed as ENV
CSV_DIR=/tmp/covid19wld
mkdir -p $CSV_DIR

################ 
# Download the files into $CSV_DIR
curl 'https://docs.google.com/spreadsheets/d/140m-MGvRmfyku3rT0qwflfTyobm2MZSK3-m4IBYuttw/export?format=csv&id=140m-MGvRmfyku3rT0qwflfTyobm2MZSK3-m4IBYuttw&gid=510014428' \
      -o $CSV_DIR/covidwld-all.csv
curl 'https://docs.google.com/spreadsheets/d/140m-MGvRmfyku3rT0qwflfTyobm2MZSK3-m4IBYuttw/export?format=csv&id=140m-MGvRmfyku3rT0qwflfTyobm2MZSK3-m4IBYuttw&gid=1116965246' \
      -o $CSV_DIR/covidwld-counties.csv
curl 'https://docs.google.com/spreadsheets/d/140m-MGvRmfyku3rT0qwflfTyobm2MZSK3-m4IBYuttw/export?format=csv&id=140m-MGvRmfyku3rT0qwflfTyobm2MZSK3-m4IBYuttw&gid=1287373792' \
      -o $CSV_DIR/covidwld-countries.csv
curl 'https://raw.githubusercontent.com/flavianogjc/covid_web_scraping/master/countries_data.csv' \
      -o $CSV_DIR/covidwld-historical.csv

#####################
# Insert the data

## Insert the tables data
csvsql $CSV_DIR/covidwld-all.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_all   
csvsql $CSV_DIR/covidwld-counties.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_counties   
csvsql $CSV_DIR/covidwld-countries.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_countries    
csvsql $CSV_DIR/covidwld-historical.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables wrldcovid_hist

#####################
# EXIT
exit 0
