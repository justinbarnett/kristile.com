describe "person controller test", ->
  people = []
  httpMock = null
  ctrl = null
  beforeEach module 'app'

  beforeEach inject ($rootScope, $httpBackend, $http, $controller) ->
    people = [{name: 'foo'}]
    httpMock = $httpBackend

    httpMock.expectGET('/people').respond(people)
    ctrl = $controller('personController')

  afterEach ->
    httpMock.verifyNoOutstandingExpectation()
    httpMock.verifyNoOutstandingRequest()

  it 'should get people', ->
    expect(ctrl.people).toBe(undefined)

    httpMock.flush()
    expect(ctrl.people.length).toBe(1)
    expect(ctrl.people[0].name).toEqual('foo')

  it 'should save person', ->
    newPerson = {name: 'bar'}

    httpMock.flush()
    expect(ctrl.people.length).toBe(1)

    httpMock.expectPOST('/people', (data) ->
      people.push angular.fromJson(data)
    ).respond({})
    httpMock.whenGET('/people').respond people

    ctrl.insertPerson(newPerson)

    httpMock.flush()
    expect(ctrl.people.length).toBe(2)
