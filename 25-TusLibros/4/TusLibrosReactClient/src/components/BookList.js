function BookList(props) {
  const { cartId, catalog, showAll, router } = props
  const classes = useStyles();

  const [cartItems, setCartItems] = React.useState({})

  
  const updateCartItems = () => {
    getLocalAsJson(`/listCart?cartId=${cartId}`)
    .then(function (json) {
      setCartItems(json);
    })
    .catch(function (error) {
      alert(error);
    });
  };

  const addToCart = isbn => () => {
    getLocalAsJson(`/addToCart?cartId=${cartId}&bookISBN=${isbn}`)
      .then(() => {
        updateCartItems();
      })
      .catch((error) => {
        alert(error)
      })

  }

  const removeFromCart = isbn => () => {
    getLocalAsJson(`/removeFromCart?cartId=${cartId}&bookISBN=${isbn}`)
      .then(() => {
        updateCartItems();
      })
      .catch((error) => {
        alert(error)
      })
  }
  
  const showDetails = isbn => () => {
	router.navigate('/bookDetails', {'isbn': isbn})
  }

  const getAmount = isbn => {
    return (cartItems[isbn] || 0).toString();
  }

  React.useEffect(() => {
      updateCartItems();
  }, [])


  return (
      <List component="nav" className={classes.rootList} aria-label="substrings">
        {
          Object.keys(showAll ? catalog : cartItems).map((isbn, ix) => {
            const book = catalog[isbn];
            return (
              <ListItem
                key={ix}
              >
                <ListItemText primary={isbn} />
                <ListItemText primary={book.title} />
                  <Button
                    onClick={addToCart(isbn)}
                  >
                    +
                  </Button>
                  <ListItemText primary={getAmount(isbn)} align="center" />
                  <Button
                    onClick={removeFromCart(isbn)}
                  >
                    -
                  </Button>
                  <Button
                    onClick={showDetails(isbn)}
                  >
                    Ver detalles
                  </Button>
              </ListItem>
            )
          })
        }
      </List>
      
  )
}

