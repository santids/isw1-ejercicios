class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      catalog: {}
    };
  }

 retrieveCatalog = () => (
     getLocalAsJson(`/showCatalog`)
    .then(json => json.catalog )
    .catch(function (error) {
      console.error(error);
    })
 )

  async componentDidMount() {
    this.setState({
      catalog: await this.retrieveCatalog()
    })
  }

  render() {
    let title = "TusLibros Web"
    let content = "Where am I?"
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        this.setState({ ...state, path: path })
      }
    }

    if (this.state.path === "/") {
      content = (<Login
        router={router}
      />)
    } else if (this.state.path === "/catalog") {
      content = (<CatalogView
        router={router}
        cartId={this.state.cartId}
        catalog={this.state.catalog}
      />)
    } else if (this.state.path === "/cart") {
      content = (<CartView
        router={router}
        cartId={this.state.cartId}
        catalog={this.state.catalog}
      />)
    }
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
