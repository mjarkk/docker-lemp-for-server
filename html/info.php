<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Info</title>
  <style>
    body {
      font-size: 18px;
      font-family: sans-serif;
      padding: 20px;
    }
    * {
      padding: 0px;
      margin: 0px;
    }
  </style>
</head>
<body>
  <h1>The webserver works!</h1>
  <h3>Here are some links to get started</h3>
  <div class="links"></div>
  <script>
    document.querySelector(".links").innerHTML = `
      <p>PHPmyadmin: <a href="${location.protocol}//${location.hostname}:81/">${location.hostname}:81</a></p>
    `
  </script>
</body>
</html>