module Utils.Utils exposing (..)

import Dict


dictToggleOrReplace : comparable -> v -> Dict.Dict comparable v -> Dict.Dict comparable v
dictToggleOrReplace key v dict =
    if Dict.get key dict == Just v then
        Dict.remove key dict
    else
        Dict.insert key v dict
