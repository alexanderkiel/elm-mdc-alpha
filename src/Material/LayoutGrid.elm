module Material.LayoutGrid exposing
    ( view
    , cell
    , span
    )

{-| Material design’s responsive UI is based on a column-variate grid layout.
It has 12 columns on desktop, 8 columns on tablet and 4 columns on phone.


# View

@docs view
@docs cell


# Properties

@docs span

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (class, styled)


type alias Property msg =
    Options.Property () msg


{-| Renders a grid. Use `cell` as childs.
-}
view : List (Property msg) -> List (Html msg) -> Html msg
view properties cells =
    styled Html.div
        (class "mdc-layout-grid" :: properties)
        [ Html.div [ Attr.class "mdc-layout-grid__inner" ] cells ]


{-| A grid cell. Use as childs of view.
-}
cell : List (Property msg) -> List (Html msg) -> Html msg
cell properties =
    styled Html.div (class "mdc-layout-grid__cell" :: properties)


{-| Span a cell from 1 to 12 columns.
-}
span : Int -> Property msg
span numCols =
    class <| "mdc-layout-grid__cell--span-" ++ String.fromInt numCols
