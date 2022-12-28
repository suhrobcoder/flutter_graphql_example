const allFilms = """
query Query {
  allFilms {
    films {
      id
      title
      director
      releaseDate
      speciesConnection {
        species {
          name
          classification
          homeworld {
            name
          }
        }
      }
    }
  }
}
""";

const film = """
query Film(\$filmId: ID) {
  film(id: \$filmId) {
    id
    title
    director
    releaseDate
    characterConnection {
      characters {
        id
        name
        gender
      }
    }
  }
}
""";
