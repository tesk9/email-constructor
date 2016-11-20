module Components.Main.View exposing (view)

import Components.Main.Model as Model exposing (Model)
import Components.Main.Update as Update exposing (Msg(..))
import Components.Output as Output
import Components.WorkSpace as WorkSpace
import Data.SaveAble as SaveAble
import Html exposing (..)
import Html.CssHelpers
import Theme.Styles as Styles


view : Model a -> Html Msg
view model =
    div [ Styles.class [ Styles.Page ] ]
        [ Html.CssHelpers.style Styles.css
        , h1 [ Styles.class [ Styles.PageHeader ] ] [ text "Email Constructor" ]
        , div [ Styles.class [ Styles.Container ] ] <|
            [ viewSection "WorkSpace" <|
                WorkSpace.view model
            , viewSection "OUTPUT SECTION" <|
                Output.view
                    { draft =
                        SaveAble.map (\draft -> [ ( draft, .plain ) ]) model.draft
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
