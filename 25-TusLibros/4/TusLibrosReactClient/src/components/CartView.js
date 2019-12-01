function CartView(props) {
  const { router, cartId, catalog } = props
  const classes = useStyles();

  const [cartItems, setCartItems] = React.useState({})


  
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

  const checkoutCart = () => (
    getLocalAsJson(`/checkoutCart?cartId=${cartId}`)
    .catch( error => console.error(error))
  )

  const getAmount = isbn => {
    return (cartItems[isbn] || 0).toString();
  }

  React.useEffect(() => {
      updateCartItems();
  }, [])


  return (
    <div>
      <Typography component="h1" gutterBottom>
        Esto son los libros en el carrito
      </Typography>
      <List component="nav" className={classes.rootList} aria-label="substrings">
        {
          Object.keys(cartItems).map((isbn, ix) => {
            return (
              <ListItem
                key={ix}
              >
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
      <div className={classes.centeredDiv}>
        <Button
          color="inherit"
          onClick={checkoutCart}
        >
          Checkout
        </Button>
      </div>
    </div>
  )
}

