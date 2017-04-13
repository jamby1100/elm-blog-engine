module Main exposing (..)

{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs init, subscriptions, main
-}

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Navigation exposing (Location)
import Players.Commands exposing (fetchAll)
import Routing exposing (Route)
import Update exposing (update)
import View exposing (view)


-- init now takes an intial location from nav
-- then have this parsed and then assigned to model
{-| Does nothing yet
   init == None
-}
init : Location -> ( Model, Cmd Msg )
init location = 
  let 
    currentRoute = 
      Routing.parseLocation location
  in 
    ( initialModel currentRoute, Cmd.map PlayersMsg fetchAll)

{-| Does nothing yet
    subscriptions == Sub.none
-}
subscriptions : Model -> Sub Msg
subscriptions model = 
  Sub.none

-- Main
-- Navigation.program wraps program but

{-| Does nothing yet
    main == Navigation.program
-}
main : Program Never Model Msg
main = 
  Navigation.program OnLocationChange
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

--

-- I. HTTP Flow Control    
-- (1) Program -> init: Hey what's the intial value?
-- (2) init -> Program: Hey here it is!
-- (3) Program -> Main.Update; Hey, I'm all done fetching; relay to players update to update
-- (4) Main.Update -> Players.Update; Hey update your record, players.update
-- (5) Players.Update -> Main.update; Done updating, dude!
-- (6) Main.Update -> Program; Done update app, dude!
-- (7) program -> Main.view; Let's render this bitch :D
-- (8) Main.view -> Players.List; Okay, players list, render the list of players for me
-- (9) Players.List ->  Main.view; Done
-- (10) Main.view -> program; done

-- II. Install Notes

-- 2.1 
-- Installing Elm and its dependencies

-- https://guide.elm-lang.org/install.html
-- elm package install elm-lang/html
-- elm package install elm-lang/http
-- elm package install evancz/url-parser
-- elm package install elm-lang/navigation
-- elm-package install evancz/elm-markdown
-- elm-package install rundis/elm-bootstrap

-- 2.2
-- Node and the server
-- (install nodejs) 
-- brew install node 

-- (initialise node) (install node server) -- (install node dependencies)
-- npm init 
-- npm i json-server@0.9 -S 
-- npm i webpack@1 webpack-dev-middleware@1 webpack-dev-server@1 elm-webpack-loader@3 file-loader@0 style-loader@0 css-loader@0 url-loader@0 -S
-- npm i ace-css@1 font-awesome@4 -S

-- (install foreman)
-- npm install -g foreman

-- III. Running Notes
-- (running the server)
-- npm run api

-- compiling the elm script
-- nf start

-- IV. Navigation Flow Control
-- (1) Browser -> Navigation; Hey Nav!, I just changed locations
-- (2) Navigation -> Update; OnLocationChange message sent to update
-- (3-4) Update -> parseLocation; parseLocation -> Update; parse the location, return parsed rourte
-- (5) Update -> Navigation; return updated model
-- (6) Navigation -> View; Hey view, heres the model
-- (7) View -> Navigation; Hey Nav, heres the rendered view

-- V. Editing Flow Control
-- (1) Players.Edit -> Html.Program : When the user clicks +/- buttons, trigger ChangeLevel(playerId, howMuch)
-- (2) Html.Program -> Main.Update : Hey, main.update there's an update!
-- (3) Main.Update -> Players.Update : Hey, player.update, there's an update!
-- (4) Players.Update -> Main.Update : Ok, execute save player command, tell Html.Program!!
-- (5) Main.Update -> Html.Program : Html.Program!! Players.Update told me to tell you to execute save player command
-- (6) Html.Program -> Main.Update : Hey! it's either a success or fail, and the result of my api call will tell you!!
-- (7) Main.Update -> Players.Update : Ok, so Html.Program told me it's either a success or a failure
-- (8) Players.Update -> Main.Update : Ok, Main.Update, here are the updated model list of players
-- (9) Main.Update -> Html.Program : Ok, so Players.Update to tell you the updated model!
-- (10) Html.Program -> Main.View : Render this new model