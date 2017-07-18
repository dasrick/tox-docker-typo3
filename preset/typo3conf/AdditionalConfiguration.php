<?php

use Dasrick\TYPO3\Distribution\Config\ConfigLoaderFactory;
use TYPO3\CMS\Core\Utility\GeneralUtility;

// We let the loader load context and environment specific configuration
// No other code must go in here!
$context = GeneralUtility::getApplicationContext()->isProduction() ? 'production' : 'development';
$configLoader = ConfigLoaderFactory::buildLoader($context, dirname(__DIR__), getenv('CONFIGURATION_CACHE_IDENTIFIER'));
$GLOBALS['TYPO3_CONF_VARS'] = array_replace_recursive($GLOBALS['TYPO3_CONF_VARS'], $configLoader->load());
