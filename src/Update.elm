module Update exposing (..)
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs update
-}
import Routing exposing (parseLocation)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Update

{-| Does nothing yet
   init == None
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of 
    -- All PlayerMsg routed to Players.update
    PlayersMsg subMsg ->
      let
        ( updatedPlayers, cmd ) =
          Players.Update.update subMsg model.players
      in 
        -- Return the model with an updated player list
        ( { model | players = updatedPlayers }, Cmd.map PlayersMsg cmd)

    -- when we receive this message, parse the message and store it in model
    OnLocationChange location ->
      let
        newRoute = 
          parseLocation location 
      in
        ( { model | route = newRoute }, Cmd.none)
