module Theme.Fonts exposing (..)

import Element exposing (Attribute)
import Element.Font as Font


logoFont : Attribute msg
logoFont =
    Font.family
        [ Font.typeface "titillium web"
        , Font.sansSerif
        ]
