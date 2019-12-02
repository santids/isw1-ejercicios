function HistoryView(props) {
  const { catalog, router, user, password } = props
  const classes = useStyles();

  const [history, setHistory] = React.useState({});
  const [loading, setLoading] = React.useState(true);

  
  const updateHistory = () => {
    getLocalAsJson(`/listPurchases?userId=${user}&password=${password}`)
    .then(function (json) {
      setHistory(json);
	  setLoading(false);
    })
    .catch(function (error) {
      console.error(error);
    });
  };

  React.useEffect(() => {
      updateHistory();
  }, [])

  if(loading){
	  return (<CircularProgress />);
  }
  return (
    <div>
      <Typography>
        Historial de compras
      </Typography>

      <TicketView
        user={user}
        password={password}
        router={router}
        catalog={catalog}
        ticket={history}
      />
    </div>
  )
}

