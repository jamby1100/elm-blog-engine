module View exposing (..)
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs view, page, playerShowPage, notFoundView
-}

import Html exposing (Html, div, text)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Show
import Players.List
import Players.Models exposing (PlayerId)
import Routing exposing (Route(..))

{-| Does nothing yet
   init == None
-}
view : Model -> Html Msg
view model = 
  div []
    [ page model ]

-- A case statement showing the correct view depending on what was is in model.route
{-| Does nothing yet
   init == None
-}
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
{-| Does nothing yet
   init == None
-}
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

{-| Does nothing yet
   init == None
-}
notFoundView : Html Msg
notFoundView = 
  div []
    [ text "not Found"
    ]