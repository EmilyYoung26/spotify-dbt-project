version: 2

unit_tests:
  - name: stg_spotify_tracks_column_mapping_correct
    model: stg_spotify_tracks
    given:
      - input: source('spotify', 'raw_spotify_tracks')
        rows:
          - track_id: "t1"
            track_name: "My Song"
            artists: "Artist A"
            album_name: "Album 1"
            track_genre: "Pop"
            popularity: 50
            duration_ms: 120000
            danceability: 0.5
            energy: 0.5
            tempo: 100
    expect:
      rows:
        - track_id: "t1"
          track_name: "My Song"
          artists: "Artist A"
          genre: "pop"
          