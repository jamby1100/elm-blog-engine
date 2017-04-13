module Models exposing (..)
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs Model, initialModel
-}

import Players.Models exposing (Player)
import Routing
{-| Does nothing yet
   init == None
-}
type alias Model = 
  { players : List Player
  , route : Routing.Route
  }

{-| Does nothing yet
   init == None
-}
initialModel : Routing.Route -> Model
initialModel route = 
  { players = []
  , route = route
  }

