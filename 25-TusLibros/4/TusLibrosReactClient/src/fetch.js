const getLocalAsJson = path => {

  var port = 8080

  return fetch(`http://localhost:${port}${path}`, {
    method: "GET",
    dataType: "JSON",
    headers: {
      "Access-Control-Request-Headers": "*"
    }
  })
  .then(function (response) {
    return (response.json()
      .then(function(responseContent) {
        if (!response.ok) {
          throw responseContent.error
        }
        return responseContent
      }))
 })
}
