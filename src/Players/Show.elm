module Players.Show exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Players.Messages exposing (..)
import Players.Models exposing (..)
import Markdown

view : Player -> Html Msg
view model =
  div []
    [ nav model
    , form model 
    ]

--view : Player -> Html Msg
--view model = 
--  Grid.container []
--    [ CDN.stylesheet -- Responsive fixed width container
--    , nav model 
--    , list model
--    ]


-- Gets the player back to list view
nav : Player -> Html Msg 
nav model =
  div [ class "clearfix mb2 white bg-black p1"]
    [ listBtn ]

form : Player -> Html Msg 
form player = 
  div
    [ class "m3" ]
    [ h1 [] [ text player.title ]
    , Markdown.toHtml [] player.body
    , formLevel player 
    ]

formLevel : Player -> Html Msg 
formLevel player =
  div
    [ class "clearfix py1" 
    ]
    [ div [ class "col col-5" ] [ text "Level" ]
    , div [ class "col col-7"]
      [ btnLevelDecrease player
      , btnLevelIncrease player
      ]
    ]

-- Added onClick capacity to decrease level
btnLevelDecrease : Player -> Html Msg 
btnLevelDecrease player =
  a [ class "btn ml1 h1", onClick (ChangeLevel player.id -1) ]
    [ i [ class "fa fa-minus-circle"] []
    ]

-- Added onClick capacity to increase level
btnLevelIncrease : Player -> Html Msg 
btnLevelIncrease player =
  a [ class "btn ml1 h1", onClick (ChangeLevel player.id 1) ]
    [ i [ class "fa fa-plus-circle"] []]

-- Button to call ShowPlayers (and hence go back to the list view)
listBtn : Html Msg 
listBtn = 
  button
    [ class "btn regular"
    , onClick ShowPlayers
    ]
    [ i [ class "fa fa-chevron-left mr1"] [], text "List"]