class Service
  urlBase = '/quotes'

  constructor: (@$log, @$http) ->

  get: ->
    @$http.get(urlBase)
    .then (results) ->
      results.data

  getQuote: (id) ->
    @$http.get("#{urlBase}/#{id}")
    .then (results) ->
      results.data

  save: (quote) ->
    @$http.post("#{urlBase}", quote)
    .error (results, status) ->
      {results, status}

angular.module('app').service 'quoteService', ['$log', '$http', Service]
