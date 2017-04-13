module Routing exposing (..)

import Navigation exposing (Location)
import Players.Models exposing (PlayerId)
import UrlParser exposing (..)

-- These are the available routes in the app
type Route
  = PlayersRoute
  | PlayerRoute PlayerId
  | NotFoundRoute

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
parseLocation : Location -> Route 
parseLocation location =
  case ( parseHash matchers location ) of
    Just route -> 
      route

    Nothing ->
      NotFoundRoute