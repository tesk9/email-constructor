module View exposing (view)

import Components.Draft as Draft
import Components.Highlighting as Highlighting
import Components.Output as Output
import Html exposing (..)
import Html.CssHelpers
import Html.Events exposing (..)
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
                    , button [ onClick EnterHighlightingMode ] [ text "Enter highlighting mode" ]
                    , viewSection "OUTPUT SECTION" <|
                        Output.view
                            { draft =
                                SaveAble.map (\draft -> [ ( draft, .plain ) ]) data.draft
                                    |> SaveAble.toMaybe
                                    |> Maybe.withDefault []
                            , styles = model.styles
                            }
                    ]

                SelectingSegments data ->
                    [ viewSection "CONTROLS SECTION" <|
                        div []
                            [ Html.map DraftMsg <|
                                Draft.view
                                    { draft = data.draft
                                    , error = Nothing
                                    }
                            , Html.map HighlightingMsg <|
                                Highlighting.view data
                            ]
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
