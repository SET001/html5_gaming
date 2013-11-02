(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.JoeUnit = (function(_super) {
    __extends(JoeUnit, _super);

    function JoeUnit() {
      _ref = JoeUnit.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    JoeUnit.prototype.image_url = '/assets/joe.gif';

    JoeUnit.prototype.speed = 10;

    JoeUnit.prototype.max_health = 1000;

    return JoeUnit;

  })(Unit);

}).call(this);
