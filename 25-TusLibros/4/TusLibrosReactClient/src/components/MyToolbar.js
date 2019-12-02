
const createButtons = props => [
  {
    title: 'Log Out',
    shouldShow: props.router.current() !== '/',
    onClick: () => {
      props.router.navigate('/', { cartId: undefined })
    }
  },
  {
    title: 'Catalogo',
    shouldShow: props.router.current() !== '/' && props.router.current() !== '/checkout',
    onClick: () => { 
      props.router.navigate('/catalog')

    },
  },
  {
    title: 'Carrito',
    shouldShow: props.router.current() !== '/' && props.router.current() !== '/checkout',
    onClick: () => { 
      props.router.navigate('/cart')

    },

  },
  {
    title: 'Historial de Compras',
    shouldShow: props.router.current() !== '/' && props.router.current() !== '/checkout',
    onClick: () => {
		props.router.navigate('/history')
	},

  }
].filter(button => button.shouldShow)


function MyToolBar(props) {
  const classes = useStyles();
  const { title, router } = props;

  const buttons = createButtons(props);

  return (
    <div className={classes.rootToolBar}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" className={classes.title}>
            {title}
          </Typography>
          {buttons
            .map(button => 
              <Button 
                key={button.title}
                color="inherit"
                onClick={button.onClick}
              >
                {button.title}
              </Button>
          )}
        </Toolbar>
      </AppBar>
    </div>
  )
}
