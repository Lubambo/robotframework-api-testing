from jsonschema import validate

# Compara o json com o esquema esperado.
# Caso a função jsonschema.validade() verifique
# que o json não possui o esquema esperado, é
# apresentado erro e a função para, ou seja, jamais
# retornará True caso não seja um json com esquema
# esperado.
def Validate_Json_Schema(json, schema):
    isValid = True
    validate(instance=json, schema=schema)
    
    return isValid