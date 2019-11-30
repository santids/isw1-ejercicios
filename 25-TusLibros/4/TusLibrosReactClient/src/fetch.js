const getLocalAsJson = path => {

  var port = 8080

  return fetch(`http://localhost:${port}${path}`, {
    method: "GET",
    dataType: "JSON",
    headers: {
      "Access-Control-Request-Headers": "*"
    }
  })
}
