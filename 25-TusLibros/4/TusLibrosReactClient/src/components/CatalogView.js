

function CatalogView(props) {
  const { cartId, catalog } = props



  return (
    <div>
      <Typography component="h1" gutterBottom>
        Esto son los libros a la venta
      </Typography>
      <BookList showAll catalog={catalog} cartId={cartId} />
    </div>
  )
}

