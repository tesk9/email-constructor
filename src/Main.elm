module Main exposing (main)

import Components.Main.Model as Model exposing (Model)
import Components.Main.Update as Update exposing (update)
import Components.Main.View as View exposing (view)
import Html


main : Program Model.Flags Model Update.Msg
main =
    Html.programWithFlags
        { update = update
        , view = view
        , init = \flags -> Model.init flags ! []
        , subscriptions = \_ -> Sub.none
        }
