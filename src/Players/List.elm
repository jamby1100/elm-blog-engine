module Players.List exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Players.Messages exposing (..)
import Players.Models exposing (Player)
import Markdown
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col


-- Bootstrap Integration
view : List Player -> Html Msg
view players = 
  Grid.container []
    [ CDN.stylesheet -- Responsive fixed width container
    , nav players 
    , list players
    ]

nav : List Player -> Html Msg
nav players =
  div [ class "clearfix mb2 white bg-black"]
    [ div [ class "left p2"] [ text "Players"]]

list : List Player -> Html Msg
list players = 
  div [] 
    [ div [ class "p2" ] ( List.map playerRow players )
      ]

-- has buttons to see show view
--playerRow : Player -> Html Msg
--playerRow player = 
--  tr []
--    [ td [] [ 
--      text (toString player.id) 
--      ,text player.name
--      , 

--    ]
--    , td [] [  ]
--    , td [] [ text (toString player.level) ]
--    , td []
--      [ showBtn player ]
--    ]

playerRow : Player -> Html Msg
playerRow player = 
  div [] 
    [ Grid.container []
      [ Grid.row []
        [ Grid.col 
          [ Col.md10 ]
          [ b [] [(text player.title)]
          , Markdown.toHtml [] player.preview
          ]
        , Grid.col 
          [ Col.md2 ]
          [ h1 [] [ showBtn player ]
          ]

        ]
      ]
    ]

-- this button actiavtes ShowPlayer (and hence go to show view for a specific player)
showBtn : Player -> Html Msg
showBtn player =
  button 
    [ class "btn regular"
    , onClick (ShowPlayer player.id)
    ]
    [ text ">>" ]

    --, div [] 
    --  [ Grid.container []
    --    [ Grid.row
    --        [ Row.topXs ]
    --        [ Grid.col
    --            [ Col.xs4 ]
    --            [ text "col1-row1"]

    --        , Grid.col
    --            [ Col.xs8 ]
    --            [ text "col2-row1"]
    --        ]
    --    , Grid.simpleRow
    --        [ Grid.col
    --            [ Col.xs4 ]
    --            [ text "col1-row2"]

    --        , Grid.col
    --            [ Col.xs6 ]
    --            [ text "col2-row2"]

    --        ]
    --      ]
    --    ]