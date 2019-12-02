function SuccesfulCheckoutView(props) {
  const { ticket, catalog, router, user, password } = props
  const classes = useStyles();

  const [error, setError] = React.useState('');

  const makeAnotherPurchase = () => {
    getLocalAsJson(`/createCart?userId=${user}&password=${password}`)
      .then(function (json) {
        router.navigate("/catalog", json)
      })
      .catch(function (error) {
        setError(error)
      });
  }



  return (
    <div>
      <Typography>
        La compra fue realizada con exito!
      </Typography>

      <TicketView
        user={user}
        password={password}
        router={router}
        catalog={catalog}
        ticket={ticket}
      />
      <BigButton onClick={makeAnotherPurchase}>
        Realizar Otra Compra
        </BigButton>
      <Typography color="error" component="h1" gutterBottom>
        {error}
      </Typography>
    </div>

  )
}

