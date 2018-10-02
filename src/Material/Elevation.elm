module Material.Elevation exposing (elevation)

{-| Elevation is the relative distance between two surfaces along the z-axis.


# Install

In your application install:

    npm install "@material/elevation"

In your Sass file import:

    @import "@material/elevation/mdc-elevation";


# Reference

  - [Design](https://material.io/design/environment/elevation.html)
  - [Develop](https://material.io/develop/web/components/elevation/)

-}

import Material.Internal.Options as Options exposing (Property, class)


elevation : Int -> Property config msg
elevation z =
    class <| "mdc-elevation--z" ++ String.fromInt z
