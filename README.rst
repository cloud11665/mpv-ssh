mpv-ssh
=======

| stream content directly from your other machine.
| (no root and no server software required)

dependencies
------------

-  `mpv <https://mpv.io>`__
-  `OpenSSH <https://www.openssh.com>`__

installing and uninstalling
---------------------------

.. code:: sh

    make install
    make uninstall

usage
-----

.. code:: sh

    #mpv-ssh [ssh cmd]                        [file]                      [mpv opts]
    mpv-ssh  "root@192.168.0.2 -i ~/.ssh/key" "/home/www/media/funny.mkv" --profile=gpu-hq

known limitations
-----------------

| Changing subtitles / audio tracks during streaming renders cached video unusable.
|
| Because mpv is caching on disk in ``~/.cache/mpv-ssh``, when running on old harddrives, you may want to run it with the ``--cache-on-disk=no`` flag.
|
| Jumping far ahead is slow, because of the way the content is streamed (linearly).

license
-------

|GNU GPLv3 Image|

| mpv-ssh is Free Software: You can use, study share and improve it at your will. Specifically you can redistribute and/or modify it under the terms and conditions of GNU General Public License v3

.. |GNU GPLv3 Image| image:: https://www.gnu.org/graphics/gplv3-with-text-136x68.png
   :target: https://www.gnu.org/licenses/gpl-3.0.en.html

.. i miss wm4...
