function CartView(props) {
  const { router, cartId, catalog } = props
  const classes = useStyles();

  const [error, setError] = React.useState('');


  const checkoutCart = () => (
    getLocalAsJson(`/checkoutCart?cartId=${cartId}`)
    .then( json => {
      router.navigate('/ticket', { ticket: json })
    } )
    .catch( error => setError(error))
  )

  return (
    <div>
      <Typography component="h1" gutterBottom>
        Esto son los libros en el carrito
      </Typography>
      <BookList catalog={catalog} cartId={cartId} />
      <BigButton onClick={checkoutCart}>
        Checkout
      </BigButton>
      <Typography color="error" component="h1" gutterBottom>
        {error}
      </Typography>
    </div>
  )
}

