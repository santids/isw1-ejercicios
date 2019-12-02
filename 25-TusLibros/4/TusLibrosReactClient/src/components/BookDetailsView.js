function BookDetailsView(props) {
  const { cartId, isbn } = props
  const classes = useStyles();

  const [details, setDetails] = React.useState();
  const [loading, setLoading] = React.useState(true);
  const [error, setError] = React.useState('');

  const addToCart = () => {
    getLocalAsJson(`/addToCart?cartId=${cartId}&bookISBN=${isbn}`)
      .then(() => {
        updateDetails();
      })
      .catch(error => {
		setError(error)
	  })
  }

  const removeFromCart = () => {
    getLocalAsJson(`/removeFromCart?cartId=${cartId}&bookISBN=${isbn}`)
      .then(() => {
        updateDetails();
      })
      .catch(error => {
		setError(error)
	  })
  }
  
  const updateDetails = () => {
	getLocalAsJson(`/showBookInCartDetails?cartId=${cartId}&bookISBN=${isbn}`)
      .then((json) => {
        setDetails(json)
        setLoading(false)
      })
      .catch(error => {
		setError(error)
        setLoading(false)
	  })
  }

  React.useEffect(() => {
      updateDetails();
  }, [])
  
  if(loading){
	  return (<CircularProgress />);
  }

  return (
      <div>
		<Typography variant="h4">
          {details.title}, de {details.author}
        </Typography>
		<Typography variant="h6">
          ISBN: {isbn}
        </Typography>
        <Typography display="inline">
          Cantidad:
        </Typography>
		  <Button
			onClick={addToCart}
		  >
			+
		  </Button>
		  
		<Typography display="inline">
		  {details.quantity}
		</Typography>
		  <Button
			onClick={removeFromCart}
		  >
			-
		  </Button>
		  <Typography color="error" component="h1" gutterBottom>
			{error}
		  </Typography>
      </div>
      
  )
}
