module.exports = class Messager
  httpError:(response) ->
    json = {}
    try json = JSON.parse response.responseText
    message = json.message or response.statusText or 'Unknow error'
    console.error message

