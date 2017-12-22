# Docker container for composer

This container can be used to execute composer commands with the same php version and
setup you run your php scripts (if you use `saschaegerer/php-fpm-typo3`)

You have to mount your local project to the `/var/www` folder in the container.
Please note that the `www-data` (id 33 if no ns-mapping applied) user in the 
container must have write access to your mounted folder.

## Example:
`docker run --rm -it -v $(pwd)/:/var/www/ saschaegerer/composer:php-7.2 diagnose`

## Inject custom SSH settings

If you're dealing with SSH repositories you may wan't to mount your local SSH settings.
You can mount your ssh stuff to `/overwrite-ssh`.
Those files are copied and permissions will be changed to www-data so SSH is happy with them.

**Please note that the .ssh config must be compatible with the ubuntu ssh config.**
If you have platform specific configurations like `UseKeychain` on MacOS you can 
ignore errors by adding a `IgnoreUnknown` option. Add this line to your config: `IgnoreUnknown UseKeychain`

`docker run --rm -it -v $(pwd)/:/var/www -v ~/.ssh/:/overwrite-ssh:ro saschaegerer/composer:php-7.2 diagnose`

## Use docker volume for composer cache

To speed up composer you can add a docker volumen where the composer cache is
stored. You can also mount your local composer cache folder but that may end
up in random behavior if you use different composer and php versions.

`docker run --rm -it -v $(pwd)/:/var/www -v /tmp/composer/cache saschaegerer/composer:php-7.2 diagnose`
