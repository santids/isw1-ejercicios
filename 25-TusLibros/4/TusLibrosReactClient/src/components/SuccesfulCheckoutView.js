function SuccesfulCheckoutView(props) {
  const { ticket, catalog, router, user, password } = props
  const classes = useStyles();

  const makeAnotherPurchase = () => {
    getLocalAsJson(`/createCart?userId=${user}&password=${password}`)
      .then(function (json) {
        router.navigate("/catalog", json)
      })
      .catch(function (error) {
        console.error(error)
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
    </div>

  )
}

