/*
This store contains the business logic of the try page.
- Loads the necessary assets asyncronously
- Compiles the source code and turns it into a blob url
*/
store Stores.Try {
  /* Represents whether or not the code is compiling. */
  state compiling : Bool = false

  /* Represents an error during compilation. */
  state error : String = ""

  /* Represents the source code. */
  state source : String = ""

  /* The url of the example page. */
  state src : String = ""

  /* Initializes the store by loading the assets. */
  fun init (url : String) : Promise(Never, Void) {
    loadSource(url)
  }

  fun loadSource (url : String) : Promise(Never, Void) {
    sequence {
      /* Load the example source code. */
      response =
        url
        |> Http.get()
        |> Http.send()

      /* Set it as the source. */
      setSource(response.body)

      compile()
    } catch Http.ErrorResponse => response {
      next { error = "Could not load souce file!" }
    }
  }

  /* Sets the source to the given value. */
  fun setSource (source : String) : Promise(Never, Void) {
    next { source = source }
  }

  /* Returns the html for the given URL. */
  fun html (url : String) : String {
    "<html><body><script src=\"" + url + "\"></script></body></html>"
  }

  /* Compiles the source code. */
  fun compile : Promise(Never, Void) {
    sequence {
      /* We are compiling. */
      next
        {
          compiling = true,
          error = ""
        }

      /* Compile the code on the website. */
      response =
        "https://mint-website.herokuapp.com/compile"
        |> Http.post()
        |> Http.stringBody(source)
        |> Http.send()

      /* If the compilation falied we need to display it as HMTL. */
      if (response.status == 500) {
        next { src = Url.createObjectUrlFromString(response.body, "text/html") }
      } else {
        sequence {
          /* Create an object URL for the script. */
          url =
            Url.createObjectUrlFromString(
              response.body,
              "application/javascript")

          /* Create an object URL for the html. */
          newSrc =
            Url.createObjectUrlFromString(html(url), "text/html")

          /* Set the src to the URL of the html. */
          next { src = newSrc }
        }
      }
    } catch Http.ErrorResponse => response {
      next { error = "Compiling failed!" }
    } finally {
      /* After everythig is done we are not compiling anymore. */
      next { compiling = false }
    }
  }
}
