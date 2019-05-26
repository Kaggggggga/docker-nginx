<?php
$time = date("Y-m-d H:i:s");

header('Cache-Control: max-age=20 public');
$content = <<<CONTENT

<title>php-fpm-proxy</title>
<body>php-fpm-proxy(now: $time)</body>

CONTENT;

echo $content;
