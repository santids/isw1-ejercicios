function Login(props) {
  const { router } = props
  const classes = useStyles();
  const [values, setValues] = React.useState({
    text: '',
  });

  const [error, setError] = React.useState({
    error: ''
  })

  const handleChange = prop => event => {
    setValues({ ...values, [prop]: event.target.value });
  };
  const handleSend = () => {
    getLocalAsJson(`/createCart?userId=${values.user}&password=${values.password}`)
      .then(function (response) {
        // return response.json()
        return '';
      })
      .then(function (json) {
        router.navigate("/list", { substrings: json })
      })
      .catch(function (error) {
        setError('Se produjo un error')
      });
  }

  return (
    <div>
      <Typography component="h1" gutterBottom>
        Debe iniciar sesion para realizar una compra
      </Typography>
      <FormControl fullWidth className={classes.textField} variant="outlined">
        <InputLabel htmlFor="outlined-adornment-amount">Usuario</InputLabel>
        <OutlinedInput
          label={"User"}
          id="outlined-adornment-amount"
          value={values.user}
          onChange={handleChange('user')}
          labelWidth={60}

        />
      </FormControl>

      <FormControl fullWidth className={classes.textField} variant="outlined">
        <InputLabel htmlFor="outlined-adornment-amount">Password</InputLabel>
        <OutlinedInput
          id="outlined-adornment-password"
          type={"password"}
          value={values.password}
          onChange={handleChange('password')}
          labelWidth={60}

        />
        </FormControl>

      <Button
        color="inherit"
        onClick={handleSend}>
        Enviar
      </Button>

      <Typography component="h1" gutterBottom>
        {`error`}
      </Typography>
    </div>
  )
}
