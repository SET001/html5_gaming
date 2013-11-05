window.SettingsCtrl = ['$rootScope', '$modalInstance', 'settings', (self, $modalInstance, settings) ->
  self.settings = settings
  self.cancel = ->
    $modalInstance.close()
]