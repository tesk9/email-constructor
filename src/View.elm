module View exposing (view)

import Components.Draft as Draft
import Components.Output as Output
import Html exposing (..)
import Html.CssHelpers
import Model exposing (Model, UiState(..))
import SaveAble
import Styles
import Update exposing (Msg(..))


view : Model a -> Html Msg
view model =
    div [ Styles.class [ Styles.Page ] ]
        [ Html.CssHelpers.style Styles.css
        , h1 [ Styles.class [ Styles.PageHeader ] ] [ text "Email Constructor" ]
        , div [ Styles.class [ Styles.Container ] ] <|
            case model.uiState of
                EnteringText data ->
                    [ viewSection "CONTROLS SECTION" <|
                        Html.map DraftMsg <|
                            Draft.view data
                    , viewSection "OUTPUT SECTION" <|
                        Output.view
                            { draft =
                                SaveAble.map (\draft -> [ ( draft, .plain ) ]) data.draft
                                    |> SaveAble.toMaybe
                                    |> Maybe.withDefault []
                            , styles = model.styles
                            }
                    ]
        ]


viewSection : String -> Html msg -> Html msg
viewSection header contents =
    section [ Styles.class [ Styles.SectionContainer ] ]
        [ h2 [ Styles.class [ Styles.SectionHeader ] ] [ text header ]
        , contents
        ]
