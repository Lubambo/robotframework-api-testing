# ๐งช API service testing automation
This is proposal for a project structure for API services testing automation using [robot framework](https://robotframework.org/). There is a simple exemple of the project with all configurations defined (except those related to the database) using the [SWAPI - Star Wars API](https://swapi.dev/) that can be executed using the command `robot -i people -d ./output ./features` in the terminal.

## ๐ค Why robot framework?
The main reason for choosing the robot framework is that I was studying it ๐. There are many things that could be done in python in order to speed up the execution, but it another thing that I intended with this is that anyone with knowledge of robot framework but low or none knowledge of python can custom the structure at will.

## ๐งฐ The Project
The idea behind this project structure is to make possible the feature codification apart from the project running structure, that is, the tester can code the feature specifications and its related data and values comparisons without worry about how it will be linked.

The Robot Framework library [`DataDriver`](https://github.com/Snooz82/robotframework-datadriver) has big impact in this structure because the test data processing was centered on how `DataDriver` handles data. The reason for choosing this library is that it allows to write the test's feature and specification in a more clean way and therefore generating a log output easier to read.

### [๐ Usage Guide](./UsageGuide.md)
The [Usage Guide](./UsageGuide.md) is a project set up proposal and to understand how the [testsManagement](./testsManagement/README.md) works.

**Project files tree:**
* ๐พ [data](./data/README.md)
* ๐ณ [docker](./docker/README.md)
* ๐งช [features](./features/README.md)
* ๐ output
* ๐ผ [resources](./resources/README.md)
* ๐ [specs](./specs/README.md)
* ๐น๏ธ [testsManagement](./testsManagement/README.md)


A keywords interface is proposed so the feature specification has a clear procedure, making easy to write the specification and maintaing it, and this interface is presented as four main keywords: `HTTP Request`, `Validate Response`, `Validate Payload` and `Validate Endpoint`. See [features README](./features/README.md).

## ๐ง TODO
- [ ] Add configuration to enable the possibility of one request for the entire test case;
- [ ] Translate to english;
- [ ] Write a README file for each main directory;
- [ ] Elaborate and test docker partition;
- [ ] Some feedback, please?๐;
- [ ] Refactor, refactor, refactor...;

## ๐ค Future ideas
- [ ] Create a GUI to run tests. It must read the tag of each feature file, making a selection list to run tests through it avoiding the terminal.
