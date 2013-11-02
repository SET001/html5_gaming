(function() {
  window.Layer = (function() {
    Layer.prototype.el = null;

    Layer.prototype.field = null;

    Layer.prototype.ctx = null;

    Layer.prototype.width = null;

    Layer.prototype.height = null;

    function Layer(id, width, height) {
      this.width = width;
      this.height = height;
      this.el = $('<canvas>');
      this.el.attr('width', this.width);
      this.el.attr('height', this.height);
      this.el.attr('id', id);
      this.ctx = this.el[0].getContext("2d");
    }

    Layer.prototype.clear = function() {
      return this.ctx.clearRect(0, 0, this.width, this.height);
    };

    return Layer;

  })();

}).call(this);
