class Controller
  constructor: (@$log, @quoteService) ->
    setQuotes = =>
      @quoteService.get().then (results) =>
        @quotes = results
        # defaults / placeholders:
        @sf = 28
        # @quotes = [{ price: 2, amount: 0, total: 0, added: false }]
        sum = () =>
          this.price * this.amount
        @labor = { price: 10, amount: 0, total: sum(), added: true }
        @inserts = { price: 10, amount: 0, total: 0, added: false }
        @caulking = { price: 15, amount: 0, total: 0, added: false }
        @sealer = { price: 15, amount: 0, total: 0, added: false }
        @labor.amount = @sf
        @sealer.amount = @sf
        @project = {name: "floor"}
        @options = {}
        # user inputs:
        # @sf = 0
        @inserts.amount = 0
        @caulking.added = true
        @sealer.added = true

        for option in @options
          option.total = option.price * option.amount
          if option.added?
            @quote.total += option.total

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

angular.module('app')
  .controller 'quoteController', ['$log', 'quoteService', Controller]
