module Material.Icon exposing
    ( view
    , Property
    )

{-| Convenience functions for producing Material Design Icons.


# Example

    import Material.Icon as Icon


    Icon.view [] "settings"


# View

@docs view


# Properties

@docs Property

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (class)


{-| Icons property type.
-}
type alias Property msg =
    Options.Property () msg


{-| Renders an icon with the given name.
-}
view : List (Property msg) -> String -> Html msg
view properties name =
    Options.styled Html.span
        (class "material-icons" :: properties)
        [ Html.text name ]
