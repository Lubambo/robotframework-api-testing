*** Settings ***
Documentation  Database interaction and data local storage management.
Resource  ./FileManager.robot
Resource  ./Database/ConnectionsRouter.robot
Resource  ${EXECDIR}/resources/common/database/DatabaseManager.robot

*** Variables ***
# Standard database, so it is not necessary to set in every test spec.
${standardDb}  ${project['database']['dbOneName']}

# Standard path to test data file.
# If you want to use a local CSV data file, define the data file path
# inside the sqlSetup.file, in the spec file.
${testDataFile}  ${project['testData']['filePath']}

*** Keywords ***
Query and record test data
    [Documentation]  Query database the test data using the parameters defined
    ...              in 'sqlSetup' and record the query result in a CSV file,
    ...              properly formatted to fit DataDriver needs.
    ...              That CSV file is stored in the directory defined in the
    ...              'filePath' property inside 'project.properties'.
    [Arguments]  ${sqlSetup}

    ${result}  Query through SQL script  ${sqlSetup}

    Save CSV test data file  ${testDataFile}  ${sqlSetup.columns}  @{result}  delimiter=\t

Set data test file
    [Documentation]  Verify if a data file path was setted. If not, the standard value
    ...              ${testDataFile} (defined in the ./specs/common/GeneralConfig.robot)
    ...              is used as file path.

    [Arguments]  ${setup}

    ${filePath}  Set Variable  ${testDataFile}

    IF  "file" in ${setup}
        ${filePath}  Set Variable  ${setup.file}
    END

    [Return]  ${filePath}

Make database connection if exists
    [Documentation]  Check if there is a database connection defined in the setup.
    ...              If it is, the query is made and the test data file is created.
    ...              If it isn't, the DataDriver will use the test data file setted
    ...              in the setup.file.

    [Arguments]  ${setup}

    # It avoids the need to set the database name when there is a main one.
    IF  "dbName" not in ${setup}
        Set To Dictionary  ${setup}  dbName=${standardDb}
    END

    # If the dbName is passed as None, the script will use the file path stated in sqlSetup.file.
    # It is mandatory to state the file path if dbName value is None.
    IF  '${setup.dbName}' != '${None}'
        ${connParams}  Set Database Connection  ${setup.dbName}

        Set To Dictionary  ${setup}  connParams=${connParams}
        
        Query and record test data  ${setup}
    END

Set DataDriver configurations
    [Documentation]  Define the DataDriver configurations.

    [Arguments]  ${filePath}  ${originalConfig}

    ${newConfig}  Set Variable  ${originalConfig}
    
    Set To Dictionary  ${newConfig}  file        ${filePath}
    Set To Dictionary  ${newConfig}  dialect     UserDefined
    Set To Dictionary  ${newConfig}  delimiter   \t
    Set To Dictionary  ${newConfig}  quotechar   '
    Set To Dictionary  ${newConfig}  escapechar  \

    [Return]  &{newConfig}

Update DataDriver
    [Documentation]  Pre-run DataDriver update. This allows each test case to have its own data test file.
    ...              https://github.com/Snooz82/robotframework-datadriver#configure-datadriver-by-pre-run-keyword.
    ...
    ...              Arguments:
    ...                 ${original_config}: DataDriver Lib required argument, it contains the DataDriver
    ...                                     execution characteristics;
    ...
    ...                 ${sqlSetup}: Due to the config_keyword DataDriver limitation, not allowing to
    ...                              pass more than one argument, this variable can not be required in
    ...                              the [Arguments] tag.
    ...                              This is a required 'argument' and it is defined inside the spec file
    ...                              in the *** Variables *** section. Because the config_keyword is called
    ...                              in the spec file, it can access the spec's global variables.
    ...                              This 'argument' must contain the parameters that defines if and how DataDriver
    ...                              will work with the database or a local test data file.

    [Arguments]  ${original_config}

    Print console INFO  - [ORIGINAL]\n${original_config}\n

    ${filePath}  Set data test file  ${sqlSetup}

    Make database connection if exists  ${sqlSetup}

    ${new_config}  Set DataDriver configurations  ${filePath}  ${original_config}
    
    Print console INFO  - [NEW]\n${new_config}\n

    [Return]  ${new_config}