

function CatalogView(props) {
  const { cartId, catalog, router } = props



  return (
    <div>
      <Typography component="h1" gutterBottom>
        Esto son los libros a la venta
      </Typography>
      <BookList showAll catalog={catalog} cartId={cartId} router={router} />
    </div>
  )
}

