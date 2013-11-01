class window.Layer
  el: null
  field: null
  ctx: null
  width: null
  height: null
  constructor: (id, width, height) ->
    @width = width
    @height = height

    @el = $ '<canvas>'
    @el.attr 'width', @width
    @el.attr 'height', @height
    @el.attr 'id', id
    @ctx = @el[0].getContext("2d")

  clear: ->
    @ctx.clearRect 0, 0, @width, @height