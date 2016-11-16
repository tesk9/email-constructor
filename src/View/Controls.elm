module View.Controls exposing (Model, view)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    {}


view : Model -> Html msg
view model =
    div []
        [ label []
            [ text "Draft"
            , textarea [ placeholder "Enter your draft here..." ] []
            ]
        , div [] [ button [] [ text "Save" ] ]
        ]
