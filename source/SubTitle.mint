component SubTitle {
  property children : Array(Html) = []

  style base {
    margin: 10px 0;
  }

  fun render : Html {
    <div::base>
      <{ children }>
    </div>
  }
}
