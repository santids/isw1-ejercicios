
function BigButton(props) {
  const classes = useStyles();

  return (
    <div className={classes.centeredDiv}>
        <Button
          color="inherit"
          {...props}
        />

      </div>
  )
}
