# 💾 Data
This folder stores the files that contain data used in the test cases validations.

## JSON Schemas (json_schemas)
Here, each API service feature has a folder with its name, and they keep the JSON schemas of the responses of each endpoint.

## Test Data (test_data)
Works the same way of `json_schemas`, but it keeps the data related to the payload, for its validation.
The files must be `.csv` and the content must follow the [DataDriver](https://github.com/Snooz82/robotframework-datadriver) presets.
