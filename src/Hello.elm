port module Main exposing (..)

import Html exposing (Html, text)
import Html exposing (program)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


port input : (Int -> msg) -> Sub msg


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd msg )
init =
    ( 0, Cmd.none )


-- UPDATE


type Msg = Incoming Int


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Incoming x ->
          ( x, Cmd.none )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    input Incoming


-- VIEW


view : Model -> Html msg
view model =
    text ("MAYBE" ++ toString model)