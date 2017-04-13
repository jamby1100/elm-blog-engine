module Routing exposing (..)
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs Route, matchers, parseLocation
-}
import Navigation exposing (Location)
import Players.Models exposing (PlayerId)
import UrlParser exposing (..)

-- These are the available routes in the app
{-| Does nothing yet
   init == None
-}
type Route
  = PlayersRoute
  | PlayerRoute PlayerId
  | NotFoundRoute

{-| Does nothing yet
   init == None
-}
-- we define route matchers
matchers : Parser ( Route -> a) a
matchers = 
  oneOf
    [ map PlayersRoute top -- Top Route
    , map PlayerRoute (s "players" </> string) -- /players/id
    , map PlayersRoute (s "players") -- /players
    ]

-- Each time browser changes location, we will trigger the Navigation 
-- library with Navigation.Location message. 

-- parseLocation parses the Location record and return matched route
-- we used parseHash but you can also use parsePath
{-| Does nothing yet
   init == None
-}
parseLocation : Location -> Route 
parseLocation location =
  case ( parseHash matchers location ) of
    Just route -> 
      route

    Nothing ->
      NotFoundRoute