class Controller
  constructor: (@$log, @contactService) ->
    setContacts = =>
      @contactService.get().then (results) =>
        @contacts = results

    @insertContact = (contact) =>
      @contactService.save(contact)
      .success (results) =>
        @error = ''
        @contact = {}

        setContacts()
      .error (results, status) =>
        if status is 403
          @error = results
      .then (results) ->
        results

    setContacts()

angular.module('app').controller 'contactController', ['$log', 'contactService', Controller]
