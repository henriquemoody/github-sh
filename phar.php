<?php

@unlink($file);

$phar_file  = __DIR__ . '/github-sh.phar';
$phar  = new Phar($phar_file, 0, $phar_file);

$pattern = file_get_contents(__DIR__ . '/.gitignore');
$pattern = explode(PHP_EOL, $pattern);
$pattern = array_filter($pattern);
$pattern = array_map(
    function ($line) {
        $line = preg_quote($line, '/');
        $line = str_replace('\*', '.+', $line);
        return $line;
    }, 
    $pattern
);
$pattern = '/\/(' . implode('|', $pattern) . ')/';

/* @var $filename SplFileInfo */
foreach (new RecursiveIteratorIterator(new RecursiveDirectoryIterator(__DIR__)) as $filename) {
    $realpath     = $filename->getRealPath();
    $relativepath = str_replace(__DIR__ . '/', '', $realpath);
    if (preg_match($pattern, '/' . $relativepath) 
            || $realpath === realpath(__DIR__ . '/..')
            || $filename->getBasename() === 'github-sh'
            || $filename->getBasename() === 'phar.php'
            || $realpath === __DIR__) {
        continue;
    }
    echo $realpath . PHP_EOL;
    if ($filename->isDir()) {
        $phar->addEmptyDir($relativepath);
    } else {
        $phar->addFile($realpath, $relativepath);
    }
}
$phar->setStub($phar->createDefaultStub('github-sh.php'));

rename($phar_file, __DIR__ . '/github-sh');
chmod(__DIR__ . '/github-sh', 0775);
