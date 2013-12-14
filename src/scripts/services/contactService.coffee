class Service
  urlBase = '/contacts'

  constructor: (@$log, @$http) ->

  get: ->
    @$http.get(urlBase)
    .then (results) ->
      results.data

  getPerson: (id) ->
    @$http.get("#{urlBase}/#{id}")
    .then (results) ->
      results.data

  save: (contact) ->
    @$http.post("#{urlBase}", contact)
    .error (results, status) ->
      {results, status}

angular.module('app').service 'contactService', ['$log', '$http', Service]
