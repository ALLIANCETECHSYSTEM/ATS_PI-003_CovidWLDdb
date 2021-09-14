#!/bin/bash

############## 
# REQUIREMENTS
# sqlite3 - sudo apt-get install sqlite3

############## 
# Setup our workspace
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
  Todayrecovered INTEGER,
  Active INTEGER,
  Critical INTEGER,
  Casesperonemillion INTEGER,
  Deathsperonemillion INTEGER,
  Tests INTEGER,
  Testsperonemillion NUMBER,
  Population INTEGER,
  Onecaseperpeople INTEGER,
  Onedeathperpeople INTEGER,
  Onetestperpeople INTEGER,
  Activeperonemillion NUMBER,
  Recoveredperonemillion NUMBER,
  Criticalperonemillion NUMBER,
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
  Todayrecovered INTEGER,
  Active INTEGER,
  Critical INTEGER,
  Casesperonemillion NUMBER,
  Deathsperonemillion NUMBER,
  Tests INTEGER,
  Testsperonemillion NUMBER,
  Population INTEGER,
  Continent VARCHAR,
  Activeperonemillion NUMBER,
  Recoveredperonemillion NUMBER,
  Criticalperonemillion NUMBER,
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
  Todayrecovered INTEGER,
  Active INTEGER,
  Critical INTEGER,
  Casesperonemillion INTEGER,
  Deathsperonemillion INTEGER,
  Tests INTEGER,
  Testsperonemillion NUMBER,
  Population INTEGER,
  Continent VARCHAR,
  Onecaseperpeople INTEGER,
  Onedeathperpeople INTEGER,
  Onetestperpeople INTEGER,
  Activeperonemillion NUMBER
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

#####################
# EXIT
exit 0
