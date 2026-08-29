from buildstream_plugins.elements.autotools import AutotoolsElement

class GnuElement(AutotoolsElement):
    def configure(self, sandbox):
        self.conf_flags.extend([
            '--prefix=/tools',
            '--with-sysroot=/sysroot',
            '--host=%{target_arch}-flucidos-linux-gnu',
            '--disable-nls',
            '--disable-werror'
        ])
        super().configure(sandbox)

def setup():
    return GnuElement
