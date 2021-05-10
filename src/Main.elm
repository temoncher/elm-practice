module Main exposing (main)

import Browser
import Constants
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes
import StyleUtils exposing (rem)
import Theme.Colors
import Theme.FontSize
import Theme.Fonts
import Theme.Spacing



-- MODEL


initialModel =
    { tags = Constants.hardcodedTags
    , slectedTag = "elm"
    , allArticles = Constants.feed
    }



-- UPDATE


update msg model =
    model



-- VIEW


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
                    [ width <| rem 2 ]
                    { src = Constants.elmLogoSrc
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


viewTags model =
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
        , wrappedRow [] (List.map viewTag model.tags)
        ]


viewArticle article =
    el [ width fill ] <|
        column
            [ width fill
            , paddingXY 0 Theme.Spacing.xl
            , Border.solid
            , Border.color Theme.Colors.grayLight
            , Border.widthEach
                { left = 0
                , top = 2
                , right = 0
                , bottom = 0
                }
            ]
            [ row
                [ paddingEach
                    { left = 0
                    , top = 0
                    , right = 0
                    , bottom = Theme.Spacing.xl
                    }
                ]
                [ image
                    [ width <| rem 2
                    , Border.rounded Theme.Spacing.xxl
                    , htmlAttribute <| Html.Attributes.style "overflow" "hidden"
                    ]
                    { src = Constants.smileyfaceSrc
                    , description = "smileyface"
                    }
                , column
                    [ paddingXY Theme.Spacing.md 0
                    ]
                    [ el [ Font.color Theme.Colors.primary ] <| text "Author name"
                    , el
                        [ Font.color Theme.Colors.grayTint
                        , Font.extraLight
                        , Font.size Theme.FontSize.md
                        ]
                      <|
                        text "Publication date"
                    ]
                ]
            , el
                [ Font.size Theme.FontSize.xl
                , paddingEach
                    { left = 0
                    , top = 0
                    , right = 0
                    , bottom = Theme.Spacing.sm
                    }
                ]
              <|
                text article.description
            , el
                [ Font.color Theme.Colors.grayTint
                , Font.extraLight
                , paddingEach
                    { left = 0
                    , top = 0
                    , right = 0
                    , bottom = Theme.Spacing.xl
                    }
                ]
              <|
                text article.body
            , el
                [ Font.color Theme.Colors.grayTint
                , Font.extraLight
                , Font.size Theme.FontSize.md
                , paddingEach
                    { left = 0
                    , top = 0
                    , right = 0
                    , bottom = Theme.Spacing.xl
                    }
                ]
              <|
                text "Read more..."
            ]


viewContent model =
    let
        articles =
            List.filter (\x -> True) model.allArticles

        feed =
            List.map viewArticle articles
    in
    row
        [ width <| px 1200
        , height fill
        , centerX
        , paddingXY 0 (Theme.Spacing.md * 4)
        ]
        [ column
            [ width <| fillPortion 3
            , height fill
            , paddingXY Theme.Spacing.xl 0
            ]
            feed
        , column
            [ width <| fillPortion 1
            , height fill
            , paddingXY Theme.Spacing.xl 0
            ]
            [ viewTags model ]
        ]


viewMain model =
    layout [] <|
        column
            [ height fill
            , width fill
            ]
            [ viewHeader
            , viewBanner
            , viewContent model
            ]


main =
    Browser.sandbox
        { init = initialModel
        , view = viewMain
        , update = update
        }
