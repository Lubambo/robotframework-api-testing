from configparser import ConfigParser

FILE_PROJECT_PROPERTIES = 'project.properties'

### Project Properties
project = ConfigParser()
project.read(FILE_PROJECT_PROPERTIES)