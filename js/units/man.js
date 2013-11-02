(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.ManUnit = (function(_super) {
    __extends(ManUnit, _super);

    function ManUnit() {
      _ref = ManUnit.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ManUnit.prototype.image_url = 'images/astronaut.png';

    ManUnit.prototype.f = 0;

    ManUnit.prototype.state = 1;

    ManUnit.prototype.direction = 0;

    ManUnit.prototype.width = 32;

    ManUnit.prototype.height = 32;

    ManUnit.prototype.speed = 10;

    ManUnit.prototype.max_health = 1000;

    ManUnit.prototype.dm = [
      {
        x: 0,
        y: 1,
        name: 'down'
      }, {
        x: -1,
        y: 0,
        name: 'left'
      }, {
        x: 1,
        y: 0,
        name: 'right'
      }, {
        x: 0,
        y: -1,
        name: 'up'
      }
    ];

    ManUnit.prototype.random_direction = function() {
      var direction, directions, x, y;
      directions = [0, 1, 2, 3];
      direction = null;
      while (true) {
        direction = directions[rand(directions.length)];
        x = this.cell.x + this.dm[direction].x;
        y = this.cell.y + this.dm[direction].y;
        if (x < 0 || y < 0 || x === this.game.config.map.width || y === this.game.config.map.height || !this.game.cells[x][y].passable) {
          directions = _.without(directions, direction);
          if (!directions.length) {
            console.log('can`t move!');
            direction = null;
            break;
          }
        } else {
          break;
        }
      }
      return direction;
    };

    ManUnit.prototype.think = function() {
      var direction,
        _this = this;
      direction = this.random_direction();
      if (direction !== null) {
        return this.move(direction);
      } else {
        return setTimeout(function() {
          return _this.think();
        }, 1000);
      }
    };

    ManUnit.prototype.is_finish_move = function() {
      var res, vector;
      vector = this.dm[this.direction];
      switch (this.direction) {
        case 0:
          return res = this.y >= this.target.y * Cell.height;
        case 3:
          return res = this.y <= this.target.y * Cell.height;
        case 2:
          return res = this.x >= this.target.x * Cell.width;
        case 1:
          return res = this.x <= this.target.x * Cell.width;
      }
    };

    ManUnit.prototype.move_to = function(cell) {
      var interval,
        _this = this;
      this.target = cell;
      return interval = setInterval(function() {
        var res;
        _this.x += _this.dm[_this.direction].x;
        _this.y += _this.dm[_this.direction].y;
        if (++_this.f > 5) {
          _this.f = 0;
          if (++_this.state > 2) {
            _this.state = 0;
          }
        }
        res = _this.is_finish_move();
        if (res) {
          clearInterval(interval);
          _this.cell = _.clone(_this.target);
          _this.target = null;
          _this.think();
        }
        return _this.redraw();
      }, this.speed);
    };

    return ManUnit;

  })(Unit);

}).call(this);
