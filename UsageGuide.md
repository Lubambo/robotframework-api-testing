# 📖 Usage Guide
This is a guide to assist in the project configuration, in order to make this process easier.

## Configuring the Tests Management settings.
The [Tests Management](./testsManagement/README.md) settings are responsable for the interaction between the project and the [database](./testsManagement/dataManagent/README.md) and [api service](./testsManagement/webServiceManagent/README.md). Follow the steps bellow:

### 1. Setting up project properties
The [`project.properties`](./project.properties) file has some properties keywords defined. They are active used in the rest of the project as they are, so if you edit any of them it is necessary to rename all of the references of the edited one.

> It is encouraged to change some database properties for a better reading of the code, because the way they are were meant to be generic.
> 
> These are the properties:
> - `dbOneName` and `dbTwoName` (database name);
> - `dbOneUser` and `dbTwoUser` (database user);
> - `dbOnePass` and `dbTwoPass` (database password).
> 
> Remember to change all their references inside the project if you rename any of them.

### 2. Define the endpoints
As the endpoints are what will be verified and validated in this automation process, everything depends on it. Because of that, the endpoints are the first thing to define here. The endpoints files are placed inside the `endpoints` folder, found inside `webServiceManagement` folder.

#### Step 1 - Setting up the api service feature constant words
Inside the endpoints folder there is the [`Standard.robot`](./testsManagement/webServiceManagement/endpoints/Standard.robot) file where the api service features constant words are defined, centralizing them all in one place.

> The [`Standard.robot`](./testsManagement/webServiceManagement/endpoints/Standard.robot) file contains some constants defined that can be seen as an example.

<br/>

#### Step 2 - Assemble the features' endpoints
Inside the endpoints' folder, create a folder for each feature and inside of it create a `.robot` for each http verb that the feature involve (e.g.: [`GET.robot`](./testsManagement/webServiceManagement/endpoints/people/GET.robot) contains all the endpoints of the `people` SWAPI feature related to requests using GET http verb).

When you setting up the endpoint, do not add the `base url` of the api because it was aready setted in the `project.properties`.

<br/>

#### Step 3 - Adjusting request and session manager
This step is optional. If the default way this project use to make requests ([`RequestManager.robot`](./testsManagement/webServiceManagement/RequestManager.robot) ) and open/close sessions (([`SessionManager.robot`](./testsManagement/webServiceManagement/SessionManager.robot) )) doesn't meet your project needs, build up yours in the respective files.

### 3. Create and route your database connection
If your project will interact with one or more database to gather data for tests validations, you must create the conections and set them up in the [connections router manager](./testsManagement/dataManagent/Database/ConnectionsRouter.robot). The connections file are placed in the `connections` folder, found inside the `Database` folder of [dataManager](./testsManagement/dataManagent/README.md).

#### Step 1 - Create database connection
The connection is a `.robot` file with a `keyword` that assembles the connection parameters in a standard dictionary and return it as result to be consumed in the connections router manager. See [DbOneConnection.robot](./testsManagement/dataManagent/Database/connections/DbOneConnection.robot) or [DbTwoConnection.robot](./testsManagement/dataManagent/Database/connections/DbTwoConnection.robot).

<br/>

#### Step 2 - Route database connection
In the [connections router manager](./testsManagement/dataManagent/Database/ConnectionsRouter.robot) you set up the connection. There is a `keyword` that create a base database connection params (`Create Database Connection Params`) that is consumed inside of another `keyword` that sets the database connection (`Set Database Connection`).

To add a database connection you only have to create a dictionary with the database connection inside and the `Set Database Connection` will consume it and return a full working database connection. If you have more than one database, add all of the connections in `Set Database Connection` and it will manage what connection to use according to the `database name` informed in the test case `spec`.

### 4. Configure data file presets for consumption in the DataDriver
Data files must be formatted to attend the DataDriver Library needs. If the file is a local one, it must be formatted manually, but if the data is gathered from a database, the [File Manager](./testsManagement/dataManagent/Database/FileManager.robot) gets this data and creates a CSV file ready to be consumed by the DataDriver.

The DataDriver is setted up to consume a CSV file *tab-delimited*. If it doesn't suits your project's needs, you can edit the DataDriver configurations in the `Set DataDriver configurations` keyword, that is found in the []. In case you change the *delimiter*, remember to inform the new one in the `Query and record test data` keyword in the `Save CSV test data file` `delimiter`parameter:
```python
Save CSV test data file  ${testDataFile}  ${sqlSetup.columns}  @{result}  delimiter=\t
```

### 5. Write yours *specs*
Now that the project is setted up, you can start to design your test cases.

Inside the [specs](./specs/README.md) folder are placed all test cases specifications and there is a proposal of [specification design standard](./specs/README.md#standard) to make this process fast to read, write and edit, also making easier to find erros.

For better organization, group the specifications in folders named according to the feature the are related to.

### 6. Connect Test Case and Test Data
Lastly, inside of [features](./features/README.md) we organize the features in folders with their names and inside each one we group the test cases according to the http verb or your project needs.

The `.robot` files here will connect the *spec* with the DataDriver to consume its related test data. This will make easier to read and understand the test case goal, without worry about how it will work programmatically.
