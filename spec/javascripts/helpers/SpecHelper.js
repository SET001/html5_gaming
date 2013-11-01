beforeEach(function() {
  jasmine.getFixtures().fixturesPath = 'assets/fixtures';
  this.addMatchers({
    toBePlaying: function(expectedSong) {
      var player = this.actual;

      return player.currentlyPlayingSong === expectedSong && 
             player.isPlaying;
    }
  });
});
