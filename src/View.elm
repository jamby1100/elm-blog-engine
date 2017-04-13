module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Show
import Players.List
import Players.Models exposing (PlayerId)
import Routing exposing (Route(..))

view : Model -> Html Msg
view model = 
  div []
    [ page model ]

-- A case statement showing the correct view depending on what was is in model.route
page : Model -> Html Msg
page model = 
  case model.route of
    PlayersRoute ->
      Html.map PlayersMsg (Players.List.view model.players)
    PlayerRoute id ->
      playerShowPage model id
    NotFoundRoute ->
      notFoundView

-- Finding a player and displaying the view if it exists
playerShowPage : Model -> PlayerId -> Html Msg
playerShowPage model playerId =
  let
    maybePlayer = 
      model.players
        |> List.filter (\player -> player.id == playerId)
        |> List.head
  in
    case maybePlayer of
      Just player ->
        Html.map PlayersMsg (Players.Show.view player)

      Nothing ->
        notFoundView

notFoundView : Html Msg
notFoundView = 
  div []
    [ text "not Found"
    ]