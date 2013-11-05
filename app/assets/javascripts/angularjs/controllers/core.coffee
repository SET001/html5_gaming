window.CoreCtrl = ['$rootScope', '$location', '$routeParams']
window.CoreCtrl.push (self, $location, $routeParams) ->

  self.go = (url) ->
    $location.path url

  self.get = (param) ->
    $routeParams[param]

  self.loading = false
  self.block = ->
    self.loading = true
  self.unblock = ->
    self.loading = false

  self.menu = ''
  self.at = (name) ->
    return true if self.menu is name
  self.toMenu = (name) ->
    self.menu = name