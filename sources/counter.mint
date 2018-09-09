store Store {
  state counter : Number = 0

  fun increment : Promise(Never, Void) {
    next { counter = counter + 1 }
  }

  fun decrement : Promise(Never, Void) {
    next { counter = counter - 1 }
  }
}

component Main {
  connect Store exposing { increment, decrement, counter }

  property disabled : Bool = false

  style base {
    background: {background};
    border-radius: 5px;
    transition: 320ms;
    display: flex;
    padding: 20px;
    margin: 20px;
  }

  style counter {
    font-family: sans;
    font-size: 20px;
    padding: 0 20px;
  }

  get background : String {
    if (counter >= 10) {
      "lightgreen"
    } else {
      if (counter < 0) {
        "orangered"
      } else {
        "#F2F2F2"
      }
    }
  }

  fun render : Html {
    <div::base>
      <button
        onClick={(event : Html.Event) : Promise(Never, Void) => { decrement() }}
        disabled={disabled}>

        <{ "Decrement" }>

      </button>

      <span::counter>
        <{ Number.toString(counter) }>
      </span>

      <button
        onClick={(event : Html.Event) : Promise(Never, Void) => { increment() }}
        disabled={disabled}>

        <{ "Increment" }>

      </button>
    </div>
  }
}
