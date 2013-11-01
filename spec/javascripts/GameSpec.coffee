describe 'Game', ->
  beforeEach ->
    loadFixtures 'index.html'
    window.game = new Game($('#game'), null, {map:{width:10,height:10}})

  describe 'unit', ->
    added = no
    directions = []
    beforeEach ->
      game.add_unit(5, 5).done (unit) ->
        added = yes
      waitsFor ->
        added
      , 'unit added'

    it "can't move up on non passable", ->
      runs ->
        game.add_thing('stone', 4, 4).done ->
        
        unit = game.units[0]
        for i in [1..100]
          directions.push unit.random_direction()
        console.log game.cells[4][4]
        for direction, di in unit.dm
          break if direction.name is 'up'
        expect(di in directions).toEqual(false)

    it "can't move out of borders", ->
      runs ->
