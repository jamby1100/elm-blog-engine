module Messages exposing (..)
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs Msg
-}
import Navigation exposing (Location)
import Players.Messages

{-| Does nothing yet
   init == None
-}
type Msg
  = PlayersMsg Players.Messages.Msg
  | OnLocationChange Location