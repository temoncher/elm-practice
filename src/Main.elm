module Main exposing (main)

import Browser
import Constants exposing (Article)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes
import StyleUtils exposing (rem)
import Theme.Colors
import Theme.FontSize
import Theme.Fonts
import Theme.Spacing


type Tab
    = GlobalFeed
    | TagFeed String



-- MODEL


type alias Model =
    { currentTab : Tab
    , allArticles : List Article
    , tags : List String
    }


initialModel : Model
initialModel =
    { currentTab = GlobalFeed
    , allArticles = Constants.feed
    , tags = Constants.hardcodedTags
    }



-- UPDATE


type Msg
    = ClickedTag String
    | ClickedTab Tab


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickedTag tagName ->
            { model | currentTab = TagFeed tagName }

        ClickedTab tab ->
            { model | currentTab = tab }



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


viewTag : { isSelected : Bool, name : String } -> Element Msg
viewTag props =
    let
        tagColor =
            if props.isSelected then
                Theme.Colors.primary

            else
                Theme.Colors.grayShade
    in
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
            , Background.color tagColor
            , Font.color Theme.Colors.primaryContrast
            , Font.size Theme.FontSize.md
            , pointer
            , onClick (ClickedTag props.name)
            ]
        <|
            text props.name


viewTags : Model -> Element Msg
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
        , wrappedRow [] (List.map (\tag -> viewTag { name = tag, isSelected = model.currentTab == TagFeed tag }) model.tags)
        ]


viewAuthor : Element msg
viewAuthor =
    row
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


viewArticle : Article -> Element msg
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
            [ viewAuthor
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


viewTab : { name : String, isSelected : Bool, onTabClick : Msg } -> Element Msg
viewTab { name, isSelected, onTabClick } =
    let
        tabColor =
            if isSelected then
                Theme.Colors.primary

            else
                Theme.Colors.grayTint
    in
    el
        [ padding Theme.Spacing.lg
        , Border.color tabColor
        , Border.widthEach
            { left = 0
            , top = 0
            , right = 0
            , bottom =
                if isSelected then
                    Theme.Spacing.xs

                else
                    0
            }
        , Font.color tabColor
        , Font.size Theme.FontSize.lg
        , pointer
        , onClick onTabClick
        ]
    <|
        text name


viewTabs : Model -> Element Msg
viewTabs model =
    let
        activeTab =
            case model.currentTab of
                TagFeed tagName ->
                    [ viewTab { name = "#" ++ tagName, isSelected = True, onTabClick = ClickedTab (TagFeed tagName) } ]

                _ ->
                    []
    in
    row []
        (viewTab { name = "Global feed", isSelected = model.currentTab == GlobalFeed, onTabClick = ClickedTab GlobalFeed }
            :: activeTab
        )


viewFeed : Model -> List (Element Msg)
viewFeed model =
    let
        articles =
            List.filter
                (\article ->
                    case model.currentTab of
                        GlobalFeed ->
                            True

                        TagFeed tagName ->
                            List.member tagName article.tags
                )
                model.allArticles

        feed =
            List.map viewArticle articles
    in
    viewTabs model :: feed


viewContent : Model -> Element Msg
viewContent model =
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
            (viewFeed model)
        , column
            [ width <| fillPortion 1
            , height fill
            , paddingXY Theme.Spacing.xl 0
            ]
            [ viewTags model ]
        ]


viewMain : Model -> Html Msg
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


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = viewMain
        , update = update
        }
