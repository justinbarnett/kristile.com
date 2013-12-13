class Controller
  constructor: (@$log, @quoteService) ->
    # TODO How do I see what value this is? like the RoR debug script
    @foo = [1]
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


    # defaults / placeholders:
    sf = 28 
    sealer = { price: 2, amount: 0, total: 0}
    labor = { price: 10, amount: 0, total: 0}
    inserts = { price: 10, amount: 0, total: 0}
    caulking = { price: 15, amount: 0, total: 0}
    labor.amount = sf
    sealer.amount = sf
    project.name = "floor"
    # user inputs:
    sf = 0
    inserts.amount = 0
    caulking.added = true
    sealer.added = true

    for option in options
      option.total = option.price * option.amount
      if option.added?
        quote.total += option.total)



angular.module('app').controller 'quoteController', ['$log', 'quoteService', Controller]