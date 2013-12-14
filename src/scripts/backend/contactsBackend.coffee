class Run
  constructor: (@$log, @$httpBackend) ->
    nextId = 0

    contacts = [
      {id: nextId++, name: 'Saasha', email: 'foobar@email.com', message: 'I have a question about a job', quote: 400}
      {id: nextId++, name: 'Planet', email: 'foobar@email.com'}
    ]

    @$httpBackend.whenGET('/contacts').respond contacts

    @$httpBackend.whenPOST('/contacts').respond (method, url, data) ->
      contact = angular.fromJson data
      name = contact.name
      isUnique = (name for c in contacts when c.name is name).length is 0

      return if not isUnique
        message =
          title: 'Duplicate!'
          message: "#{name} is a duplicate.  Please enter a new name."

        [403, message]

      contact.id = nextId++

      contacts.push contact

      [200, contact]

angular.module('app').run ['$log', '$httpBackend', Run]
