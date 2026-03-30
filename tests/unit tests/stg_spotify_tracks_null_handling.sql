version: 2

unit_tests:
  - name: stg_spotify_tracks_null_handling
    model: stg_spotify_tracks
    given: 
      - input: source('spotify', 'raw_spotify_tracks')
        rows:
          - track_id: "t2"
            track_name: "Null Test"
            artists: "Artist B"
            album_name: "Album 2"
            track_genre: "Rock"
            popularity: null
            danceability: 0.4
            energy: 0.6
            tempo: 110
            duration_ms: null
    expect:
      rows:
        - track_id: "t2"
          popularity: null
          duration_minutes: null

-- this test checks duration_ms = null leads to duration_minutes = null and that popularity = null stays in staging.