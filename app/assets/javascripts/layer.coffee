class window.Layer
  el: null
  field: null
  @ctx: null
  constructor: (field, id) ->
    @field = field
    @el = $ '<canvas>'
    @el.attr 'width', field.width
    @el.attr 'height', field.height
    @el.attr 'id', id
    @ctx = @el[0].getContext("2d")

  clear: ->
    @ctx.clearRect 0, 0, @field.width, @field.height