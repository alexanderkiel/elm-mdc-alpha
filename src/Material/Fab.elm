module Material.Fab exposing
    ( view
    , icon
    , mini
    )

{-| A floating action button (FAB) represents the primary action of a screen.


# View

@docs view


# Properties

@docs icon
@docs mini

-}

import Html exposing (Html)
import Material.Icon as Icon
import Material.Internal.Options as Options exposing (class)


type alias Property msg =
    Options.Property () msg


{-| -}
view : List (Property msg) -> String -> Html msg
view properties name =
    Options.styled Html.button
        (class "mdc-fab" :: properties)
        [ Icon.view [ icon ] name ]


{-| -}
mini : Property msg
mini =
    class "mdc-fab--mini"


{-| -}
icon : Icon.Property msg
icon =
    class "mdc-fab__icon"
