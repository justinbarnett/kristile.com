class Config
	constructor: ($routeProvider) ->
		$routeProvider
		.when '/home/:id',
			controller: 'contactController'
		.otherwise
			redirectTo: '/home'

angular.module('app').config ['$routeProvider', Config]
