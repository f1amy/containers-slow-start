<?php

/**
 * Needed for PHPStan Symfony extension
 * https://github.com/phpstan/phpstan-symfony#analysis-of-symfony-console-commands.
 */

use App\Kernel;
use Symfony\Bundle\FrameworkBundle\Console\Application;
use Symfony\Component\Dotenv\Dotenv;

require __DIR__.'/../vendor/autoload.php';

(new Dotenv())->bootEnv(__DIR__.'/../.env');

$kernel = new Kernel($_SERVER['APP_ENV'], (bool) $_SERVER['APP_DEBUG']);

return new Application($kernel);
