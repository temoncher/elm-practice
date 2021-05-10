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
    [ { title = "Elm is fun!", description = "Elm", body = "I've really...", tags = ["elm", "programming", "fun"] }
    , { title = "Who says undefined isn't a function anyway?", description = "Fun", body = "...", tags = ["programming", "fun"] }
    , { title = "This compiler is pretty neat", description = "Elm", body = "...", tags = ["elm", "fun"] }
    , { title = "Are dragons real?", description = "dragons", body = "...", tags = ["dragons"] }
    ]
