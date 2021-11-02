# 📋 Specs
This folder contains the features' tests specifications following the standardization explained bellow.

## Standard
Each `spec` follows a `keywords` interface to ease and speed up the `specs` code writing.
segue uma interface padrão de `keywords` para facilitar e agilizar o etendimento das `spec` existentes e a escrita das futuras. Segue abaixo:

* `HTTP Request`: responsable to manage the request and return the `response` in the format of `robotframework-requests` lib;

* `Validate Response`: validates the response properties:
    * headers;
    * status code;
    * json schema;

* `Validate Payload`: validates the *payload* returned in the `response`;

* `Validate Endpoint`: condenses all `keywords` on `specs` that will be responsable for testing the respective feature. It acts as a template to be called in the respective feature file;

## Directories list
Listing `specs` directories:

* `common`: contains specs configurations used in more than one specs files;

* `some_spec`: this specs definition.