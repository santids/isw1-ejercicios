class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
    };
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
      />)
    } else if (this.state.path === "/cart") {
      content = (<CartView
        router={router}
        cartId={this.state.cartId}
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
