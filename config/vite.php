<?php

use craft\helpers\App;

return [
    'checkDevServer' => App::env('CRAFT_ENVIRONMENT') === 'dev',
    'devServerInternal' => 'http://localhost:5137',
    'devServerPublic' => Craft::getAlias('@web') . ':5137',
    'errorEntry' => 'src/scripts/app.js',
    'manifestPath' => Craft::getAlias('@webroot') . '/dist/.vite/manifest.json',
    'serverPublic' => Craft::getAlias('@web')  . '/dist/',
    'useDevServer' => App::env('CRAFT_ENVIRONMENT') === 'dev',
    'criticalPath' => Craft::getAlias('@webroot') . '/dist/criticalcss',
    'criticalSuffix' => '_critical.min.css',
];
