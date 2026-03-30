version: 2

unit_tests:
  - name: stg_spotify_tracks_duration_minutes_calculates
    model: stg_spotify_tracks
    given:
      - input: source('spotify', 'raw_spotify_tracks')
        rows:
          - track_id: "t1"
            track_name: "Test Track"
            artists: "Artist A"
            album_name: "Test Album"
            track_genre: "Pop"
            popularity: 50
            danceability: 0.5
            energy: 0.5
            tempo: 120
            duration_ms: 180000
    expect:
      rows:
        - track_id: "t1"
          duration_minutes: 3.0