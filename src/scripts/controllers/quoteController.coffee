class Controller
	constructor: (@$log, @quoteService) ->
		setQuotes = =>
			@quoteService.get().then (results) =>
				@quotes = results

		@insertQuote = (quote) =>
			@quoteService.save(quote)
			.success (results) =>
				@error = ''
				@quote = {}

				setQuotes()
			.error (results, status) =>
				if status is 403
					@error = results
			.then (results) ->
				results

		setQuotes()


    @sf = {28}
    sealer = { price: 2*sf, amount: 0}
    labor = { price: 10, amount: sf}
    inserts = { price: 10, amount: 0}
    caulking = { price: 15, amount: 0}

angular.module('app').controller 'quoteController', ['$log', 'quoteService', Controller]