module StyleUtils exposing (..)

import Element exposing (px)
import Theme


rem times =
    px (Theme.fontSize * times)
