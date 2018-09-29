module Material.LayoutGrid exposing
    ( Property
    , cell
    , span1
    , span10
    , span11
    , span12
    , span2
    , span3
    , span4
    , span5
    , span6
    , span7
    , span8
    , span9
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (class, styled)


type alias Property msg =
    Options.Property () msg


view : List (Property msg) -> List (Html msg) -> Html msg
view properties cells =
    styled Html.div
        (class "mdc-layout-grid" :: properties)
        [ Html.div [ Attr.class "mdc-layout-grid__inner" ] cells ]


cell : List (Property msg) -> List (Html msg) -> Html msg
cell properties =
    styled Html.div (class "mdc-layout-grid__cell" :: properties)


span1 : Property msg
span1 =
    class "mdc-layout-grid__cell--span-1"


span2 : Property msg
span2 =
    class "mdc-layout-grid__cell--span-2"


span3 : Property msg
span3 =
    class "mdc-layout-grid__cell--span-3"


span4 : Property msg
span4 =
    class "mdc-layout-grid__cell--span-4"


span5 : Property msg
span5 =
    class "mdc-layout-grid__cell--span-5"


span6 : Property msg
span6 =
    class "mdc-layout-grid__cell--span-6"


span7 : Property msg
span7 =
    class "mdc-layout-grid__cell--span-7"


span8 : Property msg
span8 =
    class "mdc-layout-grid__cell--span-8"


span9 : Property msg
span9 =
    class "mdc-layout-grid__cell--span-9"


span10 : Property msg
span10 =
    class "mdc-layout-grid__cell--span-10"


span11 : Property msg
span11 =
    class "mdc-layout-grid__cell--span-11"


span12 : Property msg
span12 =
    class "mdc-layout-grid__cell--span-12"
