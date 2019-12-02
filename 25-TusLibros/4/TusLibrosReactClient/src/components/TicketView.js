function TicketView(props) {
  const { ticket, catalog, router, user, password } = props
  const classes = useStyles();

  return (
    <div>
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
      <Typography component="h1">
        {`Total: ${ticket.total}`}
      </Typography>
    </div>

  )
}

