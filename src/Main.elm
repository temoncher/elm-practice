module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import StyleUtils exposing (rem)
import Theme


banner =
    row
        [ width fill
        , alignTop
        , Background.color <| Theme.primary
        , Font.color <| Theme.primaryContrast
        ]
        [ column
            [ width fill
            , padding <| Theme.spacing * 3
            ]
            [ el
                [ Font.bold
                , Font.size <| Theme.fontSize * 3
                , centerX
                , Theme.logoFont
                ]
              <|
                text "conduit"
            , row
                [ padding Theme.spacing
                , centerX
                ]
                [ text "A place to exercise your "
                , image
                    [ width <| rem 2
                    ]
                    { src = "https://aws1.discourse-cdn.com/standard17/uploads/elm_lang/original/1X/50a05e53677a2c3b47776d7abd0f113eb50193a1.png"
                    , description = "elm logo"
                    }
                , text " knowledge"
                ]
            ]
        ]


main =
    layout [] <|
        column
            [ height fill
            , width fill
            ]
            [ banner ]
