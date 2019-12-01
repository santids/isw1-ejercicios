function TicketView(props) {
  const { ticket, catalog, router, user, password} = props
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

      <List component="nav" className={classes.rootList} >
        {
          ticket.items.map((item, ix) => {
            const isbn = item.item;
            const book = catalog[isbn];
            return (
              <ListItem
                key={ix}
              >
                <ListItemText primary={isbn} />
                <ListItemText primary={book.title} />
                <ListItemText primary={item.total} />
                <ListItemText primary={item.quantity} />
              </ListItem>
            )
          })
        }
      </List>
      <div style={{ display: 'flex', flexDirection: 'row'}}>
        <Typography component="h1">
          {`Total: ${ticket.total}`}
        </Typography>

      </div>
      <BigButton onClick={makeAnotherPurchase}>
          Realizar Otra Compra
        </BigButton>
    </div>

  )
}

