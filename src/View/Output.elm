module View.Output exposing (Model, view)

import Css
import Html exposing (..)
import TextUp


type alias Model =
    {}


type alias ViewConfig =
    TextUp.Config {}


textUpConfig : ViewConfig
textUpConfig =
    { plain = Css.fontFamily Css.fantasy }


view : Model -> Html msg
view model =
    TextUp.toHtml textUpConfig <|
        List.map ((,) "Hello, world.") [ .plain ]
