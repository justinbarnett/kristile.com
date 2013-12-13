class Run
	constructor: (@$log, @$httpBackend) ->
		nextId = 0

		quotes = [
			{id: nextId++, project: 'floor', total: 4 }
			{id: nextId++, project: 'shower', total: 10 }
		]



		@$httpBackend.whenGET('/quotes').respond quotes

		@$httpBackend.whenPOST('/quotes').respond (method, url, data) ->
			quote = angular.fromJson data
			name = quote.name
			isUnique = (name for q in quotes when q.name is name).length is 0

			return if not isUnique
				message =
					title: 'Duplicate!'
					message: "#{name} is a duplicate.  Please enter a new name."

				[403, message]

			quote.id = nextId++

			quotes.push quote

			[200, quote]

angular.module('app').run ['$log', '$httpBackend', Run]