module Routing exposing (..)
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs Route, matchers, parseLocation, CategoryName
-}
import Navigation exposing (Location)
import Players.Models exposing (PlayerId)
import UrlParser exposing (..)

{-| Does nothing yet
   init == None
-}

type alias CategoryName = 
  String
  

-- These are the available routes in the app
{-| Does nothing yet
   init == None
-}
type Route
  = PlayersRoute
  | PlayerRoute PlayerId
  | CategoryRoute CategoryName
  | NotFoundRoute

-- we define route matchers
{-| Does nothing yet
   init == None
-}
matchers : Parser ( Route -> a) a
matchers = 
  oneOf
    [ map PlayersRoute top -- Top Route
    , map PlayerRoute (s "posts" </> string) -- /posts/id
    , map PlayersRoute (s "posts") -- /posts
    , map CategoryRoute (s "categories" </> string) -- /categories/:name
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