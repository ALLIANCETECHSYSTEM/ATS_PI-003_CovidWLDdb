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

## Create the wrldcovid_all table
echo "CREATE TABLE wrldcovid_all (
  Updated DATETIME DEFAULT CURRENT_TIMESTAMP,
  Cases INTEGER,
  Todaycases INTEGER,
  Deaths INTEGER,
  Todaydeaths INTEGER,
  Recovered INTEGER,
  Active INTEGER,
  Critical INTEGER,
  Casesperonemillion INTEGER,
  Deathsperonemillion INTEGER,
  Tests INTEGER,
  Testsperonemillion NUMBER,
  Affectedcountries INTEGER
);" | sqlite3 $DB_PATH

## Create the wrldcovid_counties table
echo "CREATE TABLE wrldcovid_counties (
  Updated DATETIME DEFAULT CURRENT_TIMESTAMP,
  Cases INTEGER,
  Todaycases INTEGER,
  Deaths INTEGER,
  Todaydeaths INTEGER,
  Recovered INTEGER,
  Active INTEGER,
  Critical INTEGER,
  Continent VARCHAR,
  Countries VARCHAR
);" | sqlite3 $DB_PATH

## Create the wrldcovid_countries table
echo "CREATE TABLE wrldcovid_countries (
  Updated DATETIME DEFAULT CURRENT_TIMESTAMP,
  Country VARCHAR,
  Cases INTEGER,
  Todaycases INTEGER,
  Deaths INTEGER,
  Todaydeaths INTEGER,
  Recovered INTEGER,
  Active INTEGER,
  Critical INTEGER,
  Casesperonemillion INTEGER,
  Deathsperonemillion INTEGER,
  Tests INTEGER,
  Testsperonemillion NUMBER,
  Continent VARCHAR
);" | sqlite3 $DB_PATH

## Create the wrldcovid_hist table
echo "CREATE TABLE wrldcovid_hist (
  Date DATE, 
  Country VARCHAR,
  Province VARCHAR,
  Cases INTEGER,
  Recovered INTEGER,
  Deaths INTEGER
);" | sqlite3 $DB_PATH

## Create the wrldcovid_br table
echo "CREATE TABLE wrldcovid_br (
  regiao VARCHAR,
  estado VARCHAR,
  data DATE, 
  casosNovos INTEGER,
  casosAcumulados INTEGER,
  obitosNovos INTEGER,
  obitosAcumulados INTEGER
);" | sqlite3 $DB_PATH

#####################
# EXIT
exit 0