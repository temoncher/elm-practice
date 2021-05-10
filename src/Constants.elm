module Constants exposing (..)


hardcodedTags : List String
hardcodedTags =
    [ "elm", "fun", "programming", "dragons" ]


elmLogoSrc : String
elmLogoSrc =
    "https://aws1.discourse-cdn.com/standard17/uploads/elm_lang/original/1X/50a05e53677a2c3b47776d7abd0f113eb50193a1.png"


smileyfaceSrc : String
smileyfaceSrc =
    "https://static.productionready.io/images/smiley-cyrus.jpg"


feed =
    [ { title = "Elm is fun!", description = "Elm", body = "I've really..." }
    , { title = "Who says undefined isn't a function anyway?", description = "Fun", body = "..." }
    , { title = "This compiler is pretty neat", description = "Elm", body = "..." }
    , { title = "Are dragons real?", description = "dragons", body = "..." }
    ]
