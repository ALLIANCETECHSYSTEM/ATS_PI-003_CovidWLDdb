#!/bin/bash

############## 
# REQUIREMENTS
# sqlite3 - sudo apt-get install sqlite3

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/covid19WLDdb.sqlite3 ### Passed as ENV

#################
# Build the database Covid_BR

# First remove the existing database file, if any
rm -f $DB_PATH

## Create the wrldcovid_DHGen table
echo "CREATE TABLE wrldcovid_DHComb (
  Date DATE, 
  Country/Region VARCHAR,
  Province/State VARCHAR,
  Lat NUMBER,
  Long NUMBER,
  Confirmed INTEGER,
  Recovered INTEGER,
  Deaths INTEGER
);" | sqlite3 $DB_PATH

## Create the wrldcovid_DHAgreg table
echo "CREATE TABLE wrldcovid_DHAgreg (
  Date DATE, 
  Country VARCHAR,
  Confirmed INTEGER,
  Recovered INTEGER,
  Deaths INTEGER
);" | sqlite3 $DB_PATH

## Create the wrldcovid_DHIncR table
echo "CREATE TABLE wrldcovid_DHIncR (
  Date DATE, 
  Confirmed INTEGER,
  Recovered INTEGER,
  Deaths INTEGER,
  Increase rate NUMBER
);" | sqlite3 $DB_PATH

## Create the wrldcovid_DHRef table
echo "CREATE TABLE wrldcovid_DHRef (
  UID INTEGER,
  iso2 VARCHAR,
  iso3 VARCHAR,
  code3 INTEGER,
  FIPS VARCHAR,
  Admin2 VARCHAR,
  Province_State VARCHAR,
  Country_Region VARCHAR,
  Lat NUMBER,
  Long_ NUMBER,
  Combined_Key VARCHAR,
  Population INTEGER
);" | sqlite3 $DB_PATH

## Create the wrldcovid_30days table
echo "CREATE TABLE wrldcovid_30days (
  Date DATE, 
  Country VARCHAR,
  Province VARCHAR,
  Cases INTEGER,
  Recovered INTEGER,
  Deaths INTEGER
);" | sqlite3 $DB_PATH

#####################
# EXIT
exit 0