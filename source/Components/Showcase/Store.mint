/* A store for the showcase. */
store Showcase.Store {
  /* The active showcase item. */
  state active : String = "store"

  /* The hovered showcase item. */
  state over : String = ""

  /* Sets the active showcase item. */
  fun setActive (active : String) : Promise(Never, Void) {
    next { active = active }
  }

  /* Sets the hovered showcase item. */
  fun setOver (over : String) : Promise(Never, Void) {
    next { over = over }
  }
}
