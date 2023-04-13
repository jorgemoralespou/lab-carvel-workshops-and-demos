In this workshop we are going to look at three small utility scripts you can
create which wrap `ytt` to perform more specific tasks. These utility scripts
are:

* `yttv` - Used to create an initial YAML configuration by supplying any values
  on the command line.

* `yaml2json` - Used to convert a YAML configuration file to JSON.

* `json2yaml` - Used to convert a JSON configuration file to YAML.

Equivalent tools are available elsewhere to perform these tasks, as well as web
sites which can do such conversions, but it is interesting exercise to see how
these can be implemented using `ytt` and a small shell script.
