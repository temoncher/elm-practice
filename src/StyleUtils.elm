module StyleUtils exposing (..)

import Element exposing (px)
import Theme.FontSize


rem : Int -> Element.Length
rem times =
    px (Theme.FontSize.md * times)
