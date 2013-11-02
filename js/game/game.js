(function() {
  window.rand = function(max, min) {
    if (min == null) {
      min = 0;
    }
    return Math.floor(Math.random() * max) + min;
  };

  window.Game = (function() {
    Game.things = {
      stone: {
        passable: false
      }
    };

    Game.prototype.units = [];

    Game.prototype.cells = [];

    Game.prototype.config = {
      map: {
        width: 10,
        height: 10
      },
      screen: {
        width: 20,
        height: 20
      },
      units: 5,
      stones: 0.1
    };

    Game.prototype.add_thing = function(thing, x, y) {
      return this.cells[x][y].put_thing(thing);
    };

    Game.prototype.add_unit = function(x, y) {
      var count, unit,
        _this = this;
      count = rand(999);
      unit = new ManUnit(this.cells[x][y], count);
      unit.init.done(function(unit) {
        _this.units.push(unit);
        unit.draw();
        unit.think();
        if (_this.scope) {
          return _this.scope.$apply();
        }
      });
      return unit.init;
    };

    Game.prototype.run = function() {
      var cells, i, stones, x, y, _i, _j, _ref, _ref1;
      cells = this.config.map.width * this.config.map.height;
      if (isNaN(this.config.stones) || this.config.stones > 1 || this.config.stones < 0) {
        throw "config.stones should be numeric 0-1";
      }
      if (stones = cells / 100 * this.config.stones * 100) {
        for (i = _i = 0, _ref = stones - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          while (true) {
            x = rand(this.config.map.width);
            y = rand(this.config.map.height);
            if (!this.cells[x][y].type) {
              break;
            }
          }
          this.cells[x][y].put_thing('stone');
        }
      }
      if (cells === stones && this.config.units) {
        throw 'Nowhere to spawn units. Need more passable cells!';
      }
      for (i = _j = 1, _ref1 = this.config.units; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 1 <= _ref1 ? ++_j : --_j) {
        while (true) {
          x = rand(this.config.map.width);
          y = rand(this.config.map.height);
          if (this.cells[x][y].passable) {
            break;
          }
        }
        this.add_unit(x, y);
      }
      return this.field.draw();
    };

    function Game(el, scope, config) {
      var row, x, y, _i, _j, _ref, _ref1;
      _.assign(this.config, config);
      this.scope = scope;
      this.field = new Field(el, this);
      for (x = _i = 0, _ref = this.config.map.width; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
        row = [];
        for (y = _j = 0, _ref1 = this.config.map.height; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
          row.push(new Cell(this, x, y));
        }
        this.cells.push(row);
      }
    }

    return Game;

  })();

  window.onload = function() {
    var pair, param, params, _i, _len, _ref, _ref1, _results;
    params = {};
    _ref = window.location.search.substring(1).split('&');
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      pair = _ref[_i];
      param = pair.split('=');
      if (((_ref1 = param[0]) === 'width' || _ref1 === 'height' || _ref1 === 'units' || _ref1 === 'stones') && !isNaN(param[1])) {
        _results.push(params[param[0]] = param[1]);
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

}).call(this);
