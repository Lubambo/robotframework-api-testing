# Data Management (dataManagment)
Data Management defines how every test case will interact with the database or a local test data file.

## Database
Create the database connection inside the folder _connections_ and add each of these connections in the _ConnectionsRouter.robot_.

## DataManager.robot
This robot file manages how the test case interacts with _test data_, according to what is setted in the **${sqlSetup}** dictionary, defined in each test case _spec_.
The **${sqlSetup}** dictionary structure:
| Key | Type | Requirement | Description |
| --- | --- | --- | --- |
| `template` | `string` | Only required if there is interaction with database | SQL script template file path.<br/>If the _spec_ will interact with a database, it must be defined, but if it will interact with a local data test file, it can be ignored. |
| `columns` | `list` | Only required if there is interaction with database | A robot framework list containing all columns that will be picked in the SQL query.<br/>The [`FileManager.robot`](#filemanager.robot) will use the columns names to create the header of the test data `CSV` file. If a column uses an alias (using the `AS` SQL keyword), the `FileManager.robot` will use the alias in the header. |
| `table` | `string` | Only required if there is interaction with database | Contains the string with all the SQL configurations related to the table or tables after SQL keyword `FROM` (e.g.: `tb_a INNER JOIN tb_b ON tb_a.fk_b = tb_b.id`).<br/>It was decided to use a string instead of a dictionary with a structured organization to privilege fast coding, so the tester can simply copy and paste the query mounted in the database, and edit quickly when necessary. |
| `filters` | `string` | Only required if there is interaction with database | It works the same way of `table`, but it contains the filters that de SQL query requires. |
| `amount` | `int` | Only required if there is interaction with database | It will say how many data records the SQL query must return. |
| `dbName` | `string` | Required | This contains the database name. It is advisable to define the database in the `project.properties` and use its value as database name.<br/>In the `DataManager.robot`, a standard database name can be defined in the variable `${standardDb}`, so there is no need to inform the `dbName` if a database is always used or way more than others.<br/>If the test case will use a local file to define the test data, it is **required** set the value of `dbName` as `None` (it is advisable to use the robot framework keyword `${None}`) and the file path in the `file` `${sqlSetup}` property. |
| `file` | `string` | Only if `dbName` value is equal to `None` | This property contains the local test data file path. If a local file will be used, it is mandatory to set `dbName` property as `None`. |

# FileManager.robot
It is responsable for consuming the data returned from a database query and mount the CSV file following the DataDriver presets.
