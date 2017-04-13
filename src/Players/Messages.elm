module Players.Messages exposing (..)

import Players.Models exposing (PlayerId, Player)
import Http


-- (1) 
-- When response is gotten, onfectchall will be called.
-- Either an error or a list of players

-- (2)
-- On showing players OR showing edit view

-- (3)
-- ChangeLevel(what-player-id-to-change, by-how-much-increment); then send request to update API
-- OnSave will show the updated player on success
type Msg
  = OnFetchAll (Result Http.Error (List Player))
  | ShowPlayers
  | ShowPlayer PlayerId
  | ChangeLevel PlayerId Int
  | OnSave (Result Http.Error Player)