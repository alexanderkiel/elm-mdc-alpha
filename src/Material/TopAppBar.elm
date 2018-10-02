module Material.TopAppBar exposing
    ( view
    , section
    , navigationIcon
    , title
    , actionIcon
    , alignEnd
    , alignStart
    , dense
    , fixed
    , short
    , prominent
    )

{-| The top app bar displays information and actions relating to the current screen.


# Install

In your application install:

    npm install "@material/top-app-bar"

In your Sass file import:

    @import "@material/top-app-bar/mdc-top-app-bar";


# View

@docs view
@docs section
@docs navigationIcon
@docs title
@docs actionIcon


# Properties

@docs alignEnd
@docs alignStart
@docs dense
@docs fixed
@docs short
@docs prominent


# Reference

  - [Design](https://material.io/design/components/app-bars-top.html)
  - [Develop](https://material.io/develop/web/components/top-app-bar/)

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (class, styled)


type alias Property msg =
    Options.Property () msg


{-| -}
view : List (Property msg) -> List (Html msg) -> Html msg
view properties sections =
    styled Html.header
        (class "mdc-top-app-bar" :: properties)
        [ Html.div [ Attr.class "mdc-top-app-bar__row" ] sections ]


{-| Short top app bars are top app bars that can collapse to the navigation icon
side when scrolled.
-}
short : Property msg
short =
    class "mdc-top-app-bar--short"


{-| Fixed top app bars stay at the top of the page and elevate above the content
when scrolled.
-}
fixed : Property msg
fixed =
    class "mdc-top-app-bar--fixed"


{-| The prominent top app bar is taller.
-}
prominent : Property msg
prominent =
    class "mdc-top-app-bar--prominent"


{-| The dense top app bar is shorter.
-}
dense : Property msg
dense =
    class "mdc-top-app-bar--dense"



---- SECTION ------------------------------------------------------------------


{-| -}
section : List (Property msg) -> List (Html msg) -> Html msg
section properties =
    styled Html.section (class "mdc-top-app-bar__section" :: properties)


{-| Make section align to the start.
-}
alignStart : Property msg
alignStart =
    class "mdc-top-app-bar__section--align-start"


{-| Make section align to the end.
-}
alignEnd : Property msg
alignEnd =
    class "mdc-top-app-bar__section--align-end"



---- SECTION ELEMENTS ---------------------------------------------------------


{-| Represent the navigation element in the top left corner.
-}
navigationIcon : String -> Html msg
navigationIcon name =
    Html.a
        [ Attr.class "material-icons mdc-top-app-bar__navigation-icon"
        , Attr.href "#"
        ]
        [ Html.text name ]


{-| -}
title : String -> Html msg
title name =
    Html.span
        [ Attr.class "mdc-top-app-bar__title" ]
        [ Html.text name ]


{-| -}
actionIcon : String -> Html msg
actionIcon name =
    Html.a
        [ Attr.class "material-icons mdc-top-app-bar__action-icon"
        , Attr.href "#"
        ]
        [ Html.text name ]
