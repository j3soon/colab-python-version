# Change Google Colab Python Version

Unofficial instructions for changing Python kernel version on Google Colab.

## Demo

Test the demo on Google Colab:

| Python Version | Colab Link | Script |
| -------------- | ----------- | ------ |
| 3.8 | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/j3soon/colab-python-version/blob/main/notebooks/py38.ipynb) | [py38.sh](https://raw.githubusercontent.com/j3soon/colab-python-version/refs/heads/main/scripts/py38.sh) |
| 3.9 | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/j3soon/colab-python-version/blob/main/notebooks/py39.ipynb) | [py39.sh](https://raw.githubusercontent.com/j3soon/colab-python-version/refs/heads/main/scripts/py39.sh) |
| 3.10 | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/j3soon/colab-python-version/blob/main/notebooks/py310.ipynb) | [py310.sh](https://raw.githubusercontent.com/j3soon/colab-python-version/refs/heads/main/scripts/py310.sh) |
| 3.11 | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/j3soon/colab-python-version/blob/main/notebooks/py311.ipynb) | [py311.sh](https://raw.githubusercontent.com/j3soon/colab-python-version/refs/heads/main/scripts/py311.sh) |

> Python 3.7 and prior versions are not supported since they [have reached EOL](https://devguide.python.org/versions/).
>
> Python 3.12 is currently unsupported due to initialization errors with the Google Colab kernel:
>
> ```
> Bad config encountered during initialization: The 'kernel_class' trait of <ipykernel.kernelapp.IPKernelApp object at 0x000000000000> instance must be a type, but 'google.colab._kernel.Kernel' could not be imported
> ```
>
> I didn't have time to investigate further on this issue.

## How To Use

1. Open your `.ipynb` notebook file with a text editor. Modify `metadata.kernelspec.*` to the desired Python version.

   For an example, the default Colab notebook file:

   ```
     "metadata": {
       ...
       "kernelspec": {
         "name": "python3",
         "display_name": "Python 3"
       },
       ...
     },
   ```

   Modify to support Python 3.10:

   ```
     "metadata": {
       ...
       "kernelspec": {
         "name": "py310",
         "display_name": "Python 3.10"
       },
       ...
     },
   ```

2. Upload the Colab notebook file to Google Drive and open it.

3. Run the set up script in the first cell, and then restart the kernel.

   For an example, for Python 3.10:

   ```
   # Download and execute set up script
   !wget -O py310.sh https://raw.githubusercontent.com/j3soon/colab-python-version/main/scripts/py310.sh
   !bash py310.sh
   ```

## Other Details

To the best of my knowledge, this hack is first introduced by [@ngrislain](https://github.com/ngrislain) and [@korakot](https://github.com/korakot) in [this discussion](https://stackoverflow.com/a/71511943).

- [@ngrislain](https://github.com/ngrislain)'s original [notebook](https://gist.github.com/ngrislain/c3ba6f687c64ce31adc6b0dff1b26d6a) no longer works, potentially due to the version changes of Google Colab's backend.
- [@korakot](https://github.com/korakot)'s solutions for [Python 3.10](https://colab.research.google.com/drive/12Uy1fTJy4XQDMdXVM_5XJ0iGEdCDOgYf) and [Python 3.11](https://colab.research.google.com/drive/13C50iNZRjMRyepe_3xAtMKUQdIkKK0kS) still works based on the binary releases. However, [the sources](https://github.com/korakot/kora/releases) no longer works when re-compiled with [conda constructor](https://github.com/conda/constructor), potentially due to breaking changes of latest packages.

By investigating the logs by `Runtime > View runtime logs`, I found that the error is due to the breaking changes of `ipykernel` and `traitlets`:

```
/usr/local/lib/python3.10/site-packages/google/colab/data_table.py:30: UserWarning: IPython.utils.traitlets has moved to a top-level traitlets package.
  from IPython.utils import traitlets as _traitlets
Traceback (most recent call last):
  File "/usr/local/lib/python3.10/runpy.py", line 196, in _run_module_as_main
    return _run_code(code, main_globals, None,
  File "/usr/local/lib/python3.10/runpy.py", line 86, in _run_code
    exec(code, run_globals)
  File "/usr/local/lib/python3.10/site-packages/ipykernel_launcher.py", line 18, in <module>
    app.launch_new_instance()
  File "/usr/local/lib/python3.10/site-packages/traitlets/config/application.py", line 1074, in launch_instance
    app.initialize(argv)
  File "/usr/local/lib/python3.10/site-packages/traitlets/config/application.py", line 118, in inner
    return method(app, *args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/ipykernel/kernelapp.py", line 684, in initialize
    super().initialize(argv)
  File "/usr/local/lib/python3.10/site-packages/traitlets/config/application.py", line 118, in inner
    return method(app, *args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/IPython/core/application.py", line 490, in initialize
    self.load_config_file()
  File "/usr/local/lib/python3.10/site-packages/IPython/core/application.py", line 346, in load_config_file
    Application.load_config_file(
  File "/usr/local/lib/python3.10/site-packages/traitlets/config/application.py", line 118, in inner
    return method(app, *args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/traitlets/config/application.py", line 971, in load_config_file
    self.update_config(new_config)
  File "/usr/local/lib/python3.10/site-packages/traitlets/config/configurable.py", line 244, in update_config
    self._load_config(config)
  File "/usr/local/lib/python3.10/site-packages/traitlets/config/configurable.py", line 193, in _load_config
    setattr(self, name, deepcopy(config_value))
  File "/usr/local/lib/python3.10/site-packages/traitlets/traitlets.py", line 716, in __set__
    self.set(obj, value)
  File "/usr/local/lib/python3.10/site-packages/traitlets/traitlets.py", line 690, in set
    new_value = self._validate(obj, value)
  File "/usr/local/lib/python3.10/site-packages/traitlets/traitlets.py", line 722, in _validate
    value = self.validate(obj, value)
  File "/usr/local/lib/python3.10/site-packages/traitlets/traitlets.py", line 2139, in validate
    value = self._resolve_string(value)
  File "/usr/local/lib/python3.10/site-packages/traitlets/traitlets.py", line 2015, in _resolve_string
    return import_item(string)
  File "/usr/local/lib/python3.10/site-packages/traitlets/utils/importstring.py", line 33, in import_item
    module = __import__(package, fromlist=[obj])
  File "/usr/local/lib/python3.10/site-packages/google/colab/__init__.py", line 26, in <module>
    from google.colab import data_table
  File "/usr/local/lib/python3.10/site-packages/google/colab/data_table.py", line 166, in <module>
    class _JavascriptModuleFormatter(_IPython.core.formatters.BaseFormatter):
  File "/usr/local/lib/python3.10/site-packages/google/colab/data_table.py", line 167, in _JavascriptModuleFormatter
    format_type = _traitlets.Unicode(_JAVASCRIPT_MODULE_MIME_TYPE)
AttributeError: module 'IPython.utils.traitlets' has no attribute 'Unicode'
KernelRestarter: restarting kernel (1/5), new random ports
```

which corresponds to [this line in colabtools](https://github.com/googlecolab/colabtools/blob/e9a71abb01ebc215f5673af167e428c9208688ba/google/colab/data_table.py#L43).

This could be fixed by freezing the dependency `traitlets=5.5.0`. (There may be a better fix, but this is good enough for now.)

The conda installation commands follow [the official instructions](https://www.anaconda.com/docs/getting-started/miniconda/install#linux), based on [the latest installer](https://www.anaconda.com/docs/getting-started/miniconda/main#latest-miniconda-installer-links) of each Python version.
