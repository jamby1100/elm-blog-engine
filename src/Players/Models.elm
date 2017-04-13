module Players.Models exposing (..)

type alias PlayerId = 
  String

type alias Player = 
  { id : PlayerId
  , name : String
  , body : String
  , level : Int 
  }

new : Player
new =
  { id = "0"
  , name = ""
  , body = ""
  , level = 1
  }