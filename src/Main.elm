module Main exposing (main)

import Html
import Model exposing (Model)
import Update exposing (update)
import View exposing (view)


main : Program Model.Flags (Model {}) Update.Msg
main =
    Html.programWithFlags
        { update = update
        , view = view
        , init = \flags -> Model.init flags ! []
        , subscriptions = \_ -> Sub.none
        }
