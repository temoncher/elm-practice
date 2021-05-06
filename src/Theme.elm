module Theme exposing (..)

import Element exposing (px, rgb255)
import Element.Font as Font


primary =
    rgb255 92 184 92


primaryContrast =
    rgb255 255 255 255


spacing =
    8


fontSize =
    14


logoFont =
    Font.family
        [ Font.typeface "titillium web"
        , Font.sansSerif
        ]
