module Players.Update exposing (..)

import Navigation
import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player, PlayerId)
import Players.Commands exposing (save)

update : Msg -> List Player -> ( List Player, Cmd Msg)
update message players = 
  case message of
    -- On return Ok, update the players colllection
    OnFetchAll (Ok newPlayers) ->
      ( newPlayers, Cmd.none )

    -- In case of an error, just return the same thing
    OnFetchAll (Err error) ->
      ( players, Cmd.none )

    ShowPlayers -> 
      ( players, Navigation.newUrl "#players" )

    ShowPlayer id ->
      ( players, Navigation.newUrl ("#players/" ++ id) )

    -- call helper function changeLevelCommands 
    -- use Cmd.batch to batch thru the list of commands it returns
    ChangeLevel id howMuch ->
      ( players, changeLevelCommands id howMuch players |> Cmd.batch )

    -- call the helpermethdo updatePlayer to update relevant player in the list
    OnSave (Ok updatedPlayer) ->
      ( updatePlayer updatedPlayer players, Cmd.none )

    OnSave (Err error) ->
      ( players, Cmd.none)

-- Receive playerid, level difference, and the current list of players
-- map through each player and find the player with playerid we want to change
-- when found, return command to change the level of the player
-- then return a list of commands to execute
changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch players = 
  let
    cmdForPlayer existingPlayer = 
      if existingPlayer.id == playerId then
        save { existingPlayer | level = existingPlayer.level + howMuch }
      else
        Cmd.none
  in 
    List.map cmdForPlayer players

-- Receive updated player and list of current/existing players
-- find the record in the list of existing players with the same id as the updated player
-- if found, return the updated player
updatePlayer : Player -> List Player -> List Player 
updatePlayer updatePlayer players =
  let
    select existingPlayer = 
      if existingPlayer.id == updatePlayer.id then 
        updatePlayer
      else
        existingPlayer
  in 
    List.map select players