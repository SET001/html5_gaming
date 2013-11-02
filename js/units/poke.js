(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.PokeUnit = (function(_super) {
    __extends(PokeUnit, _super);

    function PokeUnit() {
      _ref = PokeUnit.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PokeUnit.prototype.image_url = 'images/poke.png';

    PokeUnit.prototype.speed = 10;

    PokeUnit.prototype.max_health = 1000;

    return PokeUnit;

  })(Unit);

}).call(this);
