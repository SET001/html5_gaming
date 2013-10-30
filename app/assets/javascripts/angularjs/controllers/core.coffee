window.CoreCtrl = ['$rootScope', '$location', '$routeParams', '$translate']
window.CoreCtrl.push (self, $location, $routeParams, $translate) ->

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

  self.changeLang = (lang) ->
    $translate.uses(lang).then ->
      console.log 'asdasd'