component Layout {
  connect Ui exposing { theme }

  property children : Array(Html) = []

  style base {
    font-family: Open Sans;
    flex-direction: column;
    background: #F9F9F9;
    min-height: 100vh;
    margin: 0 auto;
    display: flex;
  }

  style logo {
    margin-left: -7px;
    margin-top: 2px;
    width: 22px;

    & path {
      fill: white;
    }
  }

  style header {
    background: #222;
    color: #EEE;
  }

  style header-wrapper {
    align-items: center;
    max-width: 1040px;
    padding: 0 20px;
    margin: 0 auto;
    display: flex;
    height: 50px;

    & > a {
      text-transform: uppercase;
      font-weight: bold;
      font-size: 14px;
    }

    & > a,
    & > a:focus,
    & > a:hover {
      color: inherit;
    }
  }

  fun render : Html {
    <div::base>
      <div::header>
        <div::header-wrapper>
          <Ui.Toolbar.Title href="/">
            <Logo
              fill={theme.colors.primary.background}
              textFill="#FFF"
              height={20}
              width={82}/>
          </Ui.Toolbar.Title>

          <Ui.Toolbar.Spacer/>

          <Ui.Link
            href="/install"
            label="Install"/>

          <Ui.Toolbar.Separator/>

          <Ui.Link
            href="https://guide.mint-lang.com"
            target="_blank"
            label="Learn"/>

          <Ui.Toolbar.Separator/>

          <Ui.Link
            href="/examples"
            label="Examples"/>

          <Ui.Toolbar.Separator/>

          <Ui.Link
            href="/roadmap"
            label="Roadmap"/>
        </div>
      </div>

      <{ children }>

      <Footer/>
    </div>
  }
}
