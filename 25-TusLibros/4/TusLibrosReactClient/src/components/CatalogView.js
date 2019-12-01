

function CatalogView(props) {
  const { router, cartId } = props
  const classes = useStyles();

  const [catalog, setCatalog] = React.useState([])
  const [cartItems, setCartItems] = React.useState({})

  const retrieveCatalog = () => {
    return getLocalAsJson(`/showCatalog`)
    .then(json => json.catalog )
    .catch(function (error) {
      console.error(error);
    });
  }
  
  const updateCartItems = () => {
    getLocalAsJson(`/listCart?cartId=${cartId}`)
    .then(function (json) {
      setCartItems(json);
    })
    .catch(function (error) {
      console.error(error);
    });
  };


  const addToCart = isbn => () => {
    getLocalAsJson(`/addToCart?cartId=${cartId}&bookISBN=${isbn}`)
      .then(() => {
        updateCartItems();
      })

  }

  const removeFromCart = isbn => () => {
    getLocalAsJson(`/removeFromCart?cartId=${cartId}&bookISBN=${isbn}`)
            .then(() => {
    updateCartItems();
  })
}

  const getAmount = isbn => {
    return (cartItems[isbn] || 0).toString();
  }

  React.useEffect(() => {
    retrieveCatalog().then((data) => {
      setCatalog(data)
    }).then(() => {
      updateCartItems();
    })
  }, [])


  return (
    <div>
      <Typography component="h1" gutterBottom>
        Esto son los libros a la venta
      </Typography>
      <List component="nav" className={classes.rootList} aria-label="substrings">
        {
          Object.keys(catalog).map((isbn, ix) => {
            const book = catalog[isbn];
            return (
              <ListItem
                key={ix}
              >
                <ListItemText primary={book.title} />
                <ListItemText primary={isbn} />
                  <Button
                    onClick={addToCart(isbn)}
                  >
                    +
                  </Button>
                  <ListItemText primary={getAmount(isbn)} />
                  <Button
                    onClick={removeFromCart(isbn)}
                  >
                    -
                  </Button>
              </ListItem>
            )
          })
        }
      </List>
    </div>
  )
}

