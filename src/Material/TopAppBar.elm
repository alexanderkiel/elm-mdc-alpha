module Material.TopAppBar exposing
    ( Property(..)
    , SectionProperty(..)
    , actionIcon
    , alignEnd
    , alignStart
    , dense
    , fixed
    , navigationIcon
    , prominent
    , section
    , short
    , title
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr


type Property
    = Class String


view : List Property -> List (Html msg) -> Html msg
view properties sections =
    let
        toClass property =
            case property of
                Class class ->
                    class

        classAttr =
            "mdc-top-app-bar mdc-elevation--z4"
                :: List.map toClass properties
                |> String.join " "
                |> Attr.class
    in
    Html.header [ classAttr ]
        [ Html.div [ Attr.class "mdc-top-app-bar__row" ] sections ]


{-| Short top app bars are top app bars that can collapse to the navigation icon
side when scrolled.
-}
short : Property
short =
    Class "mdc-top-app-bar--short"


{-| Fixed top app bars stay at the top of the page and elevate above the content
when scrolled.
-}
fixed : Property
fixed =
    Class "mdc-top-app-bar--fixed"


{-| The prominent top app bar is taller.
-}
prominent : Property
prominent =
    Class "mdc-top-app-bar--prominent"


{-| The dense top app bar is shorter.
-}
dense : Property
dense =
    Class "mdc-top-app-bar--dense"



---- SECTION ------------------------------------------------------------------


type SectionProperty
    = SectionClass String


section : List SectionProperty -> List (Html msg) -> Html msg
section properties childs =
    let
        toClass property =
            case property of
                SectionClass class ->
                    class

        classAttr =
            "mdc-top-app-bar__section"
                :: List.map toClass properties
                |> String.join " "
                |> Attr.class
    in
    Html.section [ classAttr ] childs


{-| Make section align to the start.
-}
alignStart : SectionProperty
alignStart =
    SectionClass "mdc-top-app-bar__section--align-start"


{-| Make section align to the end.
-}
alignEnd : SectionProperty
alignEnd =
    SectionClass "mdc-top-app-bar__section--align-end"



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


title : String -> Html msg
title name =
    Html.span
        [ Attr.class "mdc-top-app-bar__title" ]
        [ Html.text name ]


actionIcon : String -> Html msg
actionIcon name =
    Html.a
        [ Attr.class "material-icons mdc-top-app-bar__action-icon"
        , Attr.href "#"
        ]
        [ Html.text name ]
