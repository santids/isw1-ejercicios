const theme = createMuiTheme({
  palette: {
    primary: {
      main: '#556cd6',
    },
    secondary: {
      main: '#19857b',
    },
    error: {
      main: colors.red.A400,
    },
    background: {
      default: '#fff',
      paper: '#f5f5f5',
    },
  },
});
const useStyles = makeStyles(theme => ({
  root: {
    margin: theme.spacing(6, 0, 3),
  },
  lightBulb: {
    verticalAlign: 'middle',
  },
  rootToolBar: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  textField: {
    marginTop: theme.spacing(2),
    marginBottom: theme.spacing(2),
  },
  title: {
    flexGrow: 1,
  },
  rootList: {
    width: '100%',
    backgroundColor: theme.palette.background.paper,
    position: 'relative',
    overflow: 'auto',
    maxHeight: 300,
  },
  textFieldDetails: {
    margin: theme.spacing(2),
  },
  centeredDiv: {
    marginTop: theme.spacing(2),
    backgroundColor: theme.palette.primary.main,
    display: 'flex',
    justifyContent: 'center',
  }
}));
