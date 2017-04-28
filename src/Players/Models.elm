module Players.Models exposing (..)
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs PlayerId, Player, new
-}

{-| Does nothing yet
   init == None
-}
type alias PlayerId = 
  String



{-| Does nothing yet
   init == None
-}
type alias Player = 
  { id : PlayerId
  , title : String
  , preview : String
  , body : String
  , user_id : String
  , published_at : String
  , category_slug : String 
  , likes : Int
  }

{-| Does nothing yet
   init == None
-}
new : Player
new =
  { id = "0"
  , title = ""
  , preview = ""
  , body = ""
  , user_id = ""
  , published_at = ""
  , category_slug = ""
  , likes = 0
  }