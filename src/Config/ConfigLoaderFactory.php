<?php

namespace Dasrick\TYPO3\Distribution\Config;

use Helhum\ConfigLoader\CachedConfigurationLoader;
use Helhum\ConfigLoader\ConfigurationLoader;
use Helhum\ConfigLoader\Reader\EnvironmentReader;
use Helhum\ConfigLoader\Reader\PhpFileReader;

class ConfigLoaderFactory
{
    /**
     * @param string $context
     * @param string $rootDir
     * @param array  $additionalFileWatches
     * @param string $fixedCacheIdentifier
     *
     * @return CachedConfigurationLoader
     */
    public static function buildLoader(
        $context,
        $rootDir,
        $fixedCacheIdentifier = null,
        array $additionalFileWatches = []
    ) {
        $confDir = $rootDir . '/conf';
        $cacheDir = $rootDir . '/var/cache';
        if ($fixedCacheIdentifier) {
            // Freeze configuration with fixed identifier if requested
            $cacheIdentifier = $fixedCacheIdentifier;
        } else {
            $fileWatches = array_merge(
                [
                    $rootDir . '/web/typo3conf/LocalConfiguration.php',
                    $rootDir . '/web/typo3conf/AdditionalConfiguration.php',
                    $confDir . '/default.php',
                    $confDir . '/' . $context . '.php',
                    $rootDir . '/.env',
                ],
                $additionalFileWatches
            );
            $cacheIdentifier = self::getCacheIdentifier($context, $fileWatches);
        }

        return new CachedConfigurationLoader
        (
            $cacheDir,
            $cacheIdentifier,
            function () use ($confDir, $context) {
                return new ConfigurationLoader(
                    [
                        new PhpFileReader($confDir . '/default.php'),
                        new PhpFileReader($confDir . '/' . $context . '.php'),
                        new EnvironmentReader('TYPO3'),
                    ]
                );
            }
        );
    }

    /**
     * @param string $context
     * @param array  $fileWatches
     *
     * @return string
     */
    protected static function getCacheIdentifier($context, array $fileWatches = [])
    {
        $identifier = $context;
        foreach ($fileWatches as $fileWatch) {
            if (file_exists($fileWatch)) {
                $identifier .= filemtime($fileWatch);
            }
        }

        return md5($identifier);
    }
}
