import Html exposing (beginnerProgram, div, button, text, ul, span, li, input, Html)
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Array exposing (Array, toList, fromList, push, filter)


main =
  beginnerProgram { model = initialState, view = view, update = update }


type alias Model = { list: Array String, currentText: String }


initialState : Model
initialState = { list = Array.fromList [], currentText = "" }

view : Model -> Html Msg
view model =
  div []
    [ input [ onInput UpdateText, value model.currentText ] []
    , button [ onClick AddTodo ] [ text "Add Todo" ]
    , ul [] (Array.toList (Array.map listItem model.list ))
    ]


listItem : String -> Html Msg
listItem todo = 
  li []
    [ span [] [text todo]
    , button [ onClick (RemoveTodo todo) ] [text "Remove"]
    ]


type Msg = AddTodo | RemoveTodo String | UpdateText String

update : Msg -> Model -> Model
update msg model =
  case msg of
    AddTodo ->
      { model | list = Array.push model.currentText model.list 
      , currentText = ""
      }

    RemoveTodo todo ->
      { model | list = Array.filter (\t -> t /= todo) model.list }

    UpdateText todo ->
      { model | currentText = todo }
