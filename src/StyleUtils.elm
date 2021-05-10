module StyleUtils exposing (..)

import Element exposing (px)
import Theme.Spacing


rem times =
    px (Theme.Spacing.md * times)
