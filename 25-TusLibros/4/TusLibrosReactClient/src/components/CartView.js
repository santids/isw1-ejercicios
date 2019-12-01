function CartView(props) {
  const { router, cartId, catalog } = props
  const classes = useStyles();

  const [error, setError] = React.useState('');


  const checkoutCart = () => (
    getLocalAsJson(`/checkoutCart?cartId=${cartId}`)
    .catch( error => setError(error))
  )

  return (
    <div>
      <Typography component="h1" gutterBottom>
        Esto son los libros en el carrito
      </Typography>
      <BookList catalog={catalog} cartId={cartId} />
      <div className={classes.centeredDiv}>
        <Button
          color="inherit"
          onClick={checkoutCart}
        >
          Checkout
        </Button>
      </div>
      <Typography color="error" component="h1" gutterBottom>
        {error}
      </Typography>
    </div>
  )
}

