# Vfat Interpreter

Code to process the output of https://vfat.tools/harmony/viper/ and pull out
useful information.

## Usage

* Visit [vfat.tools](https://vfat.tools/harmony/viper/) and wait for the report to be finalised
* Select all and copy
* cd to this project's working copy
* `./bin/paste-and-parse.sh [project prefix]`

> "project prefix" will be prefixed to the filename of the daily stats file, to allow using this script for multiple projects

The last step will work on a Mac. On other platforms, save the copied data into a file, and then:

```
cat [your file] | bin/parse-vfat-output.rb
```

> The script will only output data for pools with a non-zero staked value
