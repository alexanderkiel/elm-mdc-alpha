module Material.List exposing
    ( view
    , item
    , text
    , primaryText
    , secondaryText
    , group
    , subheader
    , twoLine
    , graphic
    , meta
    )

{-| Lists are continuous, vertical indexes of text or images.


# Install

In your application install:

    npm install "@material/list"

In your Sass file import:

    @import "@material/list/mdc-list";


# View

@docs view
@docs item
@docs text
@docs primaryText
@docs secondaryText


## List Groups

@docs group
@docs subheader


# Properties

@docs twoLine
@docs graphic
@docs meta


# Reference

  - [Design](https://material.io/design/components/lists.html)
  - [Develop](https://material.io/develop/web/components/lists/)

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Keyed
import Material.Icon as Icon
import Material.Internal.Options as Options exposing (class)


type alias Property msg =
    Options.Property () msg


{-| Renders a list. Childs have to be keyed.
-}
view : List (Property msg) -> List ( String, Html msg ) -> Html msg
view properties =
    Options.styled Html.Keyed.ul (class "mdc-list" :: properties)


{-| Renders a list item.
-}
item : List (Property msg) -> List (Html msg) -> Html msg
item properties =
    Options.styled Html.li (class "mdc-list-item" :: properties)


{-| Use for text inside items.
-}
text : List (Property msg) -> List (Html msg) -> Html msg
text properties =
    Options.styled Html.span (class "mdc-list-item__text" :: properties)


{-| Use for two-line text inside items additionally to `text`.

    Example:

        text []
            [ primaryText [] [ Html.text "foo" ]
            , secondaryText [] [ Html.text "bar" ]
            ]

-}
primaryText : List (Property msg) -> List (Html msg) -> Html msg
primaryText properties =
    Options.styled Html.span (class "mdc-list-item__primary-text" :: properties)


{-| Use for two-line text inside items additionally to `text`.

    Example:

        text []
            [ primaryText [] [ Html.text "foo" ]
            , secondaryText [] [ Html.text "bar" ]
            ]

-}
secondaryText : List (Property msg) -> List (Html msg) -> Html msg
secondaryText properties =
    Options.styled Html.span (class "mdc-list-item__secondary-text" :: properties)


{-| Optional, the first tile in the row (in LTR languages, the first column of
the list item). Typically an icon or image.
-}
graphic : Property msg
graphic =
    class "mdc-list-item__graphic"


{-| Optional, the last tile in the row (in LTR languages, the last column of
the list item). Typically small text, icon. or image.
-}
meta : Property msg
meta =
    class "mdc-list-item__meta"


{-| List groups.

    Example:

        group []
            [ subheader [] [ Html.text "foo" ]
            , view []
                [ item [] []
                , item [] []
                ]
            ]

-}
group : List (Property msg) -> List (Html msg) -> Html msg
group properties =
    Options.styled Html.div (class "mdc-list-group" :: properties)


{-| Header inside list groups.
-}
subheader : String -> Html msg
subheader title =
    Html.h3 [ Attr.class "mdc-list-group__subheader" ] [ Html.text title ]


{-| Add to lists with two lines.
-}
twoLine : Property msg
twoLine =
    class "mdc-list--two-line"
