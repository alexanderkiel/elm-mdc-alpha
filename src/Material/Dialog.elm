module Material.Dialog exposing
    ( body
    , footer
    , header
    , onClose
    , scrollable
    , surface
    , title
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Material.Internal.Options as Options


type alias Config msg =
    { onClose : Maybe msg }


defaultConfig : Config msg
defaultConfig =
    { onClose = Nothing }


type alias Property msg =
    Options.Property (Config msg) msg


view : List (Property msg) -> Bool -> List (Html msg) -> Html msg
view properties open =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties
    in
    Html.aside
        [ Attr.classList
            [ ( "mdc-dialog", True )
            , ( "mdc-dialog--open", open )
            ]
        ]


onClose : msg -> Property msg
onClose msg =
    Options.updateConfig (\config -> { config | onClose = Just msg })


surface : List (Html msg) -> Html msg
surface =
    Html.div [ Attr.class "mdc-dialog__surface" ]


header : List (Html msg) -> Html msg
header =
    Html.header [ Attr.class "mdc-dialog__header" ]


title : Options.Property config msg
title =
    Options.class "mdc-dialog__header__title"


type alias BodyProperty msg =
    Options.Property () msg


body : List (BodyProperty msg) -> List (Html msg) -> Html msg
body properties =
    Options.styled Html.section (Options.class "mdc-dialog__body" :: properties)


scrollable : BodyProperty msg
scrollable =
    Options.class "mdc-dialog__body--scrollable"


footer : List (Html msg) -> Html msg
footer =
    Html.footer [ Attr.class "mdc-dialog__footer" ]
