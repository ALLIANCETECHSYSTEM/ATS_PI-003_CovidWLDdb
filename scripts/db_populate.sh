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
curl 'https://datahub.io/core/covid-19/r/time-series-19-covid-combined.csv' \
      -o $CSV_DIR/covidwld-combined.csv
curl 'https://datahub.io/core/covid-19/r/countries-aggregated.csv' \
      -o $CSV_DIR/covidwld-aggregated.csv
curl 'https://datahub.io/core/covid-19/r/worldwide-aggregated.csv' \
      -o $CSV_DIR/covidwld-incrementrate.csv   
curl 'https://datahub.io/core/covid-19/r/reference.csv' \
      -o $CSV_DIR/covidwld-reference.csv
curl 'https://raw.githubusercontent.com/flavianogjc/covid_web_scraping/master/country_datas.csv' \
      -o $CSV_DIR/covidwld-30days.csv 

#####################
# Insert the data

## Insert the tables data
csvsql $CSV_DIR/covidwld-combined.csv  \
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