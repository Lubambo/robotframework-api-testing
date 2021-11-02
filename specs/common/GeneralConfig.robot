*** Settings ***
Documentation  Condenses libraries and variables used in more than one test.
...            It ensures that all tests will, at least, query the test data from database.

Resource       ${testsManager}/webServiceManagement/SessionManager.robot
Resource       ${testsManager}/webServiceManagement/RequestManager.robot
Resource       ${testsManager}/dataManagement/DataManager.robot
Resource       ${commonRes}/json/JsonUtils.robot
Resource       ${commonRes}/ConsoleUtils.robot

Variables   ${EXECDIR}/resources/locators.py

Library  DataDriver  ${testDataFile}  config_keyword=Update DataDriver
Library  String
Library  Collections

*** Variables ***
# Common resources path.
${commonRes}  ${EXECDIR}/resources/common

# Test Management path.
${testsManager}  ${EXECDIR}/testsManagement

# The path that test data file will be placed.
${testDataFile}  ${project['testData']['filePath']}

# SQL script to query random data from data base.
${sqlScript}  ${EXECDIR}/resources/SqlScripts/selectRandom.sql

# Amount of data that will be collected from database.
${sqlAmount}  ${project['testData']['dataSize']}