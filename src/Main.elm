module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import StyleUtils exposing (rem)
import Theme.Colors
import Theme.FontSize
import Theme.Fonts
import Theme.Spacing


hardcodedTags : List String
hardcodedTags =
    [ "some", "random", "tags", "12", "123", "C'mon bruh", "some new tags" ]


elmLogoSrc : String
elmLogoSrc =
    "https://aws1.discourse-cdn.com/standard17/uploads/elm_lang/original/1X/50a05e53677a2c3b47776d7abd0f113eb50193a1.png"


viewHeader : Element msg
viewHeader =
    row
        [ width <| px 1200
        , centerX
        ]
        [ el
            [ Background.color <| Theme.Colors.primaryContrast
            , padding <| Theme.Spacing.xl
            ]
            (el
                [ Font.color <| Theme.Colors.primary
                , Font.bold
                ]
             <|
                text "conduit"
            )
        ]


viewBanner : Element msg
viewBanner =
    row
        [ width fill
        , alignTop
        , Background.color <| Theme.Colors.primary
        , Font.color <| Theme.Colors.primaryContrast
        -- Only second innerShadow works for now
        , Border.innerShadow
            { offset = ( 0, 8 )
            , size = -8
            , blur = 8
            , color = rgba255 0 0 0 0.3
            }
        , Border.innerShadow
            { offset = ( 0, -8 )
            , size = -8
            , blur = 8
            , color = rgba255 0 0 0 0.3
            }
        ]
        [ column
            [ width <| px 1200
            , centerX
            , padding <| Theme.Spacing.xxl
            ]
            [ el
                [ Font.bold
                , Font.size <| Theme.FontSize.xxl
                , centerX
                , Theme.Fonts.logoFont
                ]
              <|
                text "conduit"
            , row
                [ padding <| Theme.Spacing.md
                , centerX
                ]
                [ text "A place to exercise your "
                , image
                    [ width <| rem 2
                    ]
                    { src = elmLogoSrc
                    , description = "elm logo"
                    }
                , text " knowledge"
                ]
            ]
        ]


viewTag : String -> Element msg
viewTag name =
    el
        [ paddingEach
            { top = 0
            , left = 0
            , right = Theme.Spacing.sm
            , bottom = Theme.Spacing.sm
            }
        ]
    <|
        el
            [ paddingXY Theme.Spacing.md Theme.Spacing.sm
            , Border.rounded Theme.Spacing.xl
            , Background.color Theme.Colors.grayShade
            , Font.color Theme.Colors.primaryContrast
            , Font.size Theme.FontSize.md
            ]
        <|
            text name


viewTags : List String -> Element msg
viewTags tags =
    column
        [ width fill
        , alignTop
        , padding <| Theme.Spacing.md
        , Border.rounded <| Theme.Spacing.sm
        , Background.color Theme.Colors.grayLight
        ]
        [ wrappedRow
            [ paddingEach
                { top = 0
                , left = 0
                , right = 0
                , bottom = Theme.Spacing.sm
                }
            , Font.size <| Theme.FontSize.lg
            ]
            [ text "Popular tags" ]
        , wrappedRow [] (List.map viewTag tags)
        ]


viewContent : Element msg
viewContent =
    row
        [ width <| px 1200
        , height fill
        , centerX
        , paddingXY 0 (Theme.Spacing.md * 4)
        ]
        [ column
            [ width <| fillPortion 3
            , height fill
            ]
            [ el [ alignTop ] <| text "I'm the content"
            ]
        , column
            [ width <| fillPortion 1
            , height fill
            ]
            [ viewTags hardcodedTags ]
        ]


main : Html msg
main =
    layout [] <|
        column
            [ height fill
            , width fill
            ]
            [ viewHeader
            , viewBanner
            , viewContent
            ]
