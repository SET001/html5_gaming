(function() {
  window.Field = (function() {
    Field.prototype.config = {
      show_grid: true,
      width: null,
      height: null
    };

    Field.prototype.selections = [];

    Field.prototype.el = null;

    Field.prototype.game = null;

    Field.prototype.vectors = [];

    Field.prototype.layers = {
      "static": null
    };

    Field.prototype.deselect_all = function(cell) {
      this.selections = [];
      return this.redraw_grid();
    };

    Field.prototype.toggle_selection = function(cell) {
      cell.selected = true;
      this.selections.push(cell);
      return this.redraw_grid();
    };

    Field.prototype.draw = function() {
      var cell, row, _i, _len, _ref, _results;
      if (this.config.show_grid) {
        this.show_grid();
      }
      _ref = this.game.cells;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        row = _ref[_i];
        _results.push((function() {
          var _j, _len1, _results1,
            _this = this;
          _results1 = [];
          for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
            cell = row[_j];
            if (cell.type) {
              _results1.push(cell.loaded.done(function(cell) {
                return _this.layers["static"].ctx.drawImage(cell.image, cell.x * Cell.width, cell.y * Cell.height, Cell.width, Cell.height);
              }));
            } else {
              _results1.push(void 0);
            }
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    Field.prototype.hide_grid = function() {
      return this.layers.grid.ctx.clearRect(0, 0, this.width, this.height);
    };

    Field.prototype.show_grid = function() {
      var cell, ctx, x, y, _i, _j, _k, _len, _ref, _ref1, _ref2, _results;
      ctx = this.layers.grid.ctx;
      ctx.beginPath();
      for (x = _i = 0, _ref = this.config.width - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
        ctx.moveTo(x * Cell.width, 0);
        ctx.lineTo(x * Cell.width, this.height);
      }
      for (y = _j = 0, _ref1 = this.config.height - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
        ctx.moveTo(0, y * Cell.width);
        ctx.lineTo(this.width, y * Cell.width);
      }
      ctx.lineWidth = Config.grid.lineWidth;
      ctx.strokeStyle = Config.grid.color;
      ctx.stroke();
      _ref2 = this.selections;
      _results = [];
      for (_k = 0, _len = _ref2.length; _k < _len; _k++) {
        cell = _ref2[_k];
        _results.push(this.draw_selection(cell));
      }
      return _results;
    };

    Field.prototype.redraw_grid = function() {
      this.hide_grid();
      return this.show_grid();
    };

    Field.prototype.addLayer = function(id) {
      var layer;
      layer = new Layer(id, this.width, this.height);
      this.el.append(layer.el);
      return layer;
    };

    function Field(el, game, config) {
      var drag_helper, interval, nx, ny, parent, screen_height, screen_width, sx, sy,
        _this = this;
      if (config == null) {
        config = null;
      }
      drag_helper = {
        active: false,
        x: null,
        y: null
      };
      this.el = el;
      this.game = game;
      _.assign(this.config, {
        width: game.config.map.width,
        height: game.config.map.height
      });
      if (config) {
        _.assign(this.config, config);
      }
      screen_width = game.config.screen.width * Cell.width;
      screen_height = game.config.screen.height * Cell.height;
      this.width = this.config.width * Cell.width;
      this.height = this.config.height * Cell.height;
      if (this.width < screen_width) {
        screen_width = this.width;
      }
      if (this.height < screen_height) {
        screen_height = this.height;
      }
      parent = $(this.el.parent());
      parent.css('width', screen_width);
      parent.css('height', screen_height);
      this.el.css('width', this.width = this.config.width * Cell.width);
      this.el.css('height', this.height = this.config.height * Cell.height);
      this.layers["static"] = this.addLayer('static', this.width, this.height);
      this.layers.grid = this.addLayer('grid', this.width, this.height);
      sx = 0;
      sy = 0;
      ny = 0;
      nx = 0;
      interval = null;
      this.el[0].addEventListener('mousedown', function(e) {
        drag_helper.active = true;
        drag_helper.x = e.clientX;
        drag_helper.y = e.clientY;
        return interval = setInterval(function() {
          if (ny < 0 && ny > (_this.width - 500) * (-1)) {
            _this.el.css('top', ny);
          }
          if (nx < 0 && nx > (_this.width - 500) * (-1)) {
            return _this.el.css('left', nx);
          }
        }, 1);
      });
      this.el[0].addEventListener('mouseup', function() {
        drag_helper.active = false;
        return clearInterval(interval);
      });
      this.el[0].addEventListener('mousemove', function(e) {
        var x, y;
        if (drag_helper.active) {
          x = e.clientX;
          y = e.clientY;
          sx = (drag_helper.x - x) / 20;
          sy = (drag_helper.y - y) / 20;
          ny = parseInt(_this.el.css('top')) - sy;
          return nx = parseInt(_this.el.css('left')) - sx;
        }
      });
    }

    return Field;

  })();

}).call(this);
