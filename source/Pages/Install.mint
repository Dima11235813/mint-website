component Install {
  connect Versions exposing { loading, latest }

  style hr {
    margin: 40px 0;

    border: 0;
    border-top: 1px solid #EEE;
  }

  style code {
    border: 1px solid #DDD;
    background: #f7f7f7;
    font-size: inherit;
    padding: 5px;
  }

  style list {
    & li {
      margin-top: 15px;
    }
  }

  style files {
    & li {
      margin-top: 10px;
    }
  }

  get version : Version {
    latest()
  }

  get content : Html {
    if (loading) {
      <ul::files>
        <li>
          <{ "Loading versions..." }>
        </li>
      </ul>
    } else {
      <ul::files>
        <{ files }>
      </ul>
    }
  }

  fun renderFile (asset : Asset) : Html {
    <li>
      <Ui.Link
        href={asset.url}
        label={asset.name}/>
    </li>
  }

  get files : Array(Html) {
    if (loading) {
      []
    } else {
      version.assets
      |> Array.map(renderFile)
    }
  }

  fun render : Html {
    <Page>
      <Title>
        <{ "Install" }>
      </Title>

      <SubTitle>
        <{ "Follow the directions below to install Mint:" }>
      </SubTitle>

      <ol::list>
        <li>
          <{ "Download the binary for your operating system: " }>

          <{ content }>
        </li>

        <li>
          <{ "Move the binary to the: " }>

          <code::code>
            <{ "/usr/local/bin" }>
          </code>

          <{ " directory" }>
        </li>

        <li>
          <{ "You invoke the CLI in your terminal by just typing " }>

          <code::code>
            <{ "mint" }>
          </code>
        </li>
      </ol>

      <hr::hr/>

      <Title>
        <{ "Install from Source" }>
      </Title>

      <SubTitle>
        <{ "Follow the directions below to install Mint from source:" }>
      </SubTitle>

      <ol::list>
        <li>
          <{ "Install the " }>

          <Ui.Link
            href="https://crystal-lang.org/docs/installation/"
            label="Crystal programming language"
            target="_blank"/>
        </li>

        <li>
          <{ "Download and extract the source files from Github:" }>
          <br/>

          <Ui.Link
            label="https://github.com/mint-lang/mint"
            href="https://github.com/mint-lang/mint"
            target="_blank"/>
        </li>

        <li>
          <{
            "In your terminal enter the folder you extracted the sour" \
            "ce code:"
          }>

          <pre::code>
            <{ "cd /path/to/source" }>
          </pre>
        </li>

        <li>
          <{ "Install dependencies:" }>

          <pre::code>
            <{ "crystal deps" }>
          </pre>
        </li>

        <li>
          <{ "Build the binary (might need to use sudo):" }>

          <pre::code>
            <{
              "crystal build src/mint.cr -o /usr/local/bin/mint -p --re" \
              "lease"
            }>
          </pre>
        </li>

        <li>
          <{ "You invoke the CLI in your terminal by just typing " }>

          <code::code>
            <{ "mint" }>
          </code>
        </li>
      </ol>
    </Page>
  }
}
