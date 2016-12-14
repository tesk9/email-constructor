module Utils.Utils exposing (..)

import Dict


dictToggleOrReplace : comparable -> v -> Dict.Dict comparable v -> Dict.Dict comparable v
dictToggleOrReplace key v dict =
    if Dict.get key dict == Just v then
        Dict.remove key dict
    else
        Dict.insert key v dict


dictInsertUpdate : comparable -> a -> (Maybe (List a) -> Maybe (List a)) -> Dict.Dict comparable (List a) -> Dict.Dict comparable (List a)
dictInsertUpdate key v map dict =
    if Dict.member key dict then
        Dict.update key map dict
    else
        Dict.insert key [ v ] dict
