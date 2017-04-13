module Players.Commands exposing (..)
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs collectionDecoder,fetchAll,fetchAllUrl,memberDecoder,memberEncoded,save, saveRequest,saveUrl
-}
import Http
import Json.Encode as Encode
import Json.Decode as Decode exposing (field)
import Players.Models exposing  (PlayerId, Player)
import Players.Messages exposing (..)

-- We create a command for app to run fetching
{-| Does nothing yet
   fetchAll == None
-}
fetchAll : Cmd Msg 
fetchAll =
  Http.get fetchAllUrl collectionDecoder
    |> Http.send OnFetchAll

{-| Does nothing yet
   init == None
-}
fetchAllUrl : String
fetchAllUrl = 
  "http://localhost:4000/players"

-- Delegate encode each member of JSON to memberDecoder
{-| Does nothing yet
   init == None
-}
collectionDecoder : Decode.Decoder (List Player)
collectionDecoder = 
  Decode.list memberDecoder

{-| Does nothing yet
   init == None
-}
memberDecoder : Decode.Decoder Player 
memberDecoder = 
  Decode.map4 Player
    (field "id" Decode.string)
    (field "name" Decode.string)
    (field "body" Decode.string)
    (field "level" Decode.int)
    
{-| Does nothing yet
   init == None
-}
saveUrl : PlayerId -> String
saveUrl playerId = 
  "http://localhost:4000/players/" ++ playerId

{-| Does nothing yet
   init == None
-}
saveRequest : Player -> Http.Request Player 
saveRequest player = 
  Http.request
    { body = memberEncoded player |> Http.jsonBody -- Encode the player then covert to JSON String
    , expect = Http.expectJson memberDecoder -- We specify how to parse the response (using the memberDecoder)
    , headers = []
    , method = "PATCH" -- HTTP Method for updating records
    , timeout = Nothing
    , url = saveUrl player.id
    , withCredentials = False
    }

{-| Does nothing yet
   init == None
-}
save : Player -> Cmd Msg 
save player = 
  saveRequest player -- Create the save request
    |> Http.send OnSave -- generate command to send. after which, trigger OnSave message with response of the Http.send

{-| Does nothing yet
   init == None
-}
memberEncoded : Player -> Encode.Value 
memberEncoded player = 
  let 
    list = 
      [ ( "id", Encode.string player.id )
      , ( "name", Encode.string player.name )
      , ( "level", Encode.int player.level )
      ]
  in 
    list
      |> Encode.object

