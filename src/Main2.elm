module Main exposing (..)

import Html exposing (Html, div, text, program)

-- Model
-- We define our app model as type alias.
-- Here its just string
type alias Model = 
  String

-- We define an init function to provide initial input for the application
-- Html.Program expects a tuple with (model, command )
init : ( Model, Cmd Msg )
init  = 
  ("Hello", Cmd.none )

-- Messages
-- Things that happens to our applications that our components respond to.
type Msg
  = NoOp

-- View
-- Renders an Html element using our app model
-- Html Msg means that this Html elemnet woild produce messages tagged with Msg
view : Model -> Html Msg
view model = 
  div []
    [ text model ]

-- Update
-- This function will be called by Html.program everytime a message is received
update : Msg -> Model -> ( Model, Cmd Msg)
update msg model = 
  case msg of 
    NoOp -> 
      ( model, Cmd.none )

-- Subscriptions
-- Listen for external input to our application (i.e Mouse Movements, Keyboard events, etc)
subscriptions : Model -> Sub Msg
subscriptions model = 
  Sub.none

-- Main
-- Wire it all together
main : Program Never Model Msg
main = 
  program 
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }