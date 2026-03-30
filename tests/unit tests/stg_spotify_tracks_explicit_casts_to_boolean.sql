version: 2

unit_tests:
  - name: stg_spotify_tracks_explicit_casts_to_boolean
    model: stg_spotify_tracks
    given:
      - input: source('spotify', 'raw_spotify_tracks')
        rows:
          - track_id: "t3"
            track_name: "Explicit Test"
            artists: "Artist C"
            album_name: "Album 3"
            track_genre: "Hip-Hop"
            popularity: 70
            danceability: 0.7
            energy: 0.8
            tempo: 130
            duration_ms: 200000
            explicit: true
    expect:
      rows:
        - track_id: "t3"
          explicit: true

-- makes sure the explicit field is properly cast to boolean values (true/false)