module Main exposing (main)

import Browser
import Element


type alias Model =
    String


type alias Msg =
    ()


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = \model -> Element.layout [] (view model)
        }


init : String
init =
    Debug.todo "TODO"


update : msg -> a -> a
update arg1 arg2 =
    Debug.todo "TODO"


view : a -> Element.Element msg
view arg1 =
    Debug.todo "TODO"
