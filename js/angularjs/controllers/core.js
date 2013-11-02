(function() {
  window.CoreCtrl = ['$rootScope', '$location', '$routeParams', '$translate'];

  window.CoreCtrl.push(function(self, $location, $routeParams, $translate) {
    self.go = function(url) {
      return $location.path(url);
    };
    self.get = function(param) {
      return $routeParams[param];
    };
    self.loading = false;
    self.block = function() {
      return self.loading = true;
    };
    self.unblock = function() {
      return self.loading = false;
    };
    self.menu = '';
    self.at = function(name) {
      if (self.menu === name) {
        return true;
      }
    };
    self.toMenu = function(name) {
      return self.menu = name;
    };
    return self.changeLang = function(lang) {
      return $translate.uses(lang).then(function() {
        return console.log('asdasd');
      });
    };
  });

}).call(this);
