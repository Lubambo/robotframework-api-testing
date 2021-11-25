# 🧪 Features
## Keywords Interface
A keywords interface is proposed so the feature specification has a clear procedure, making easy to write the specification and maintaing it, and this interface is presented as four main keywords:
* `HTTP Request`: responsable for create and send a request for the API service;

* `Validate Response`: this keyword verify if the response status code, headers, json schema and so on are those expected;

* `Validate Payload`: verify the data received in the response by comparing with an expected data values;

* `Validate Endpoint`: it concentrates all above keywords, so the feature file (spec caller) can use it as a test template


## Standard requests' values table
The table bellow shows the standard values used in every request:  

| Variable | Value | Description |
| -------- | ----- | ----------- |
| `${base_url}` | `https://swapi.dev/api/` | base URL |

Features list:
* [People](./people/README.md)