#!/usr/bin/env python3
import os.path
import shutil
import subprocess
import sys

if sys.platform == 'linux':
    CACHE_DIR = os.environ.get('XDG_CACHE_DIR', os.path.expanduser('~/.cache'))
else:
    CACHE_DIR = os.environ.get('LOCALAPPDATA', os.path.expanduser('~/.cache'))
PERSONAL_PUPPET = os.path.join(
    CACHE_DIR,
    'personal-puppet',
)
GEM_HOME = os.path.join(PERSONAL_PUPPET, 'gems')
GEM_BIN = os.path.join(GEM_HOME, 'bin')
PUPPET_BIN = os.path.join(GEM_BIN, 'puppet')

HERE = os.path.dirname(os.path.realpath(__file__))
MODULE_PATH = os.pathsep.join(
    os.path.join(HERE, d)
    for d in ('modules', 'vendor')
)

GEMS = (
    (None, 'ffi', '1.13.1'),
    ('puppet', 'puppet', '6.17'),
    ('r10k', 'r10k', '3.5.2'),
    ('eyaml', 'hiera-eyaml', '3.2'),
    (None, 'hiera-eyaml-cli', '0.3'),
)


def _msg(s: str) -> None:
    print('=' * 79)
    print(s)
    print('=' * 79, flush=True)


def main() -> int:
    if subprocess.call(('ssh-add', '-l'), stdout=subprocess.DEVNULL):
        subprocess.check_call('ssh-add')

    os.environ['GEM_HOME'] = GEM_HOME
    os.environ['PATH'] = GEM_BIN + os.pathsep + os.environ['PATH']
    for exe, gem, version in GEMS:
        if exe is None or not os.path.exists(os.path.join(GEM_BIN, exe)):
            _msg('Ensuring {} is installed...'.format(gem))
            if sys.platform == 'win32':
                gem_cmd = 'gem.cmd'
            else:
                gem_cmd = 'gem'
            cmd = [gem_cmd, 'install', gem, '-v', version, '--no-document']
            print(*cmd, sep=' ')
            subprocess.check_call(cmd)

    _msg('Installing puppet modules...')
    r10k_exe = shutil.which('r10k')
    assert r10k_exe is not None, "Could not find r10k executable"
    subprocess.check_call([r10k_exe, 'puppetfile', 'install'], cwd=HERE)
    subprocess.check_call([r10k_exe, 'puppetfile', 'purge'], cwd=HERE)

    _msg('Execing puppet')
    puppet_exe = shutil.which('puppet')
    assert puppet_exe is not None, "Could not find puppet executable"
    if sys.platform == 'win32':
        cmd = [puppet_exe]
    else:
        cmd = [
            'sudo',
            'env',
            'RUBYOPT=-W0 -W:no-deprecated -W:no-experimental',
            'PATH={}'.format(os.environ['PATH']),
            'GEM_HOME={}'.format(os.environ['GEM_HOME']),
            'SSH_AUTH_SOCK={}'.format(os.environ['SSH_AUTH_SOCK']),
            f'GPG_TTY={os.ttyname(sys.stdout.fileno())}',
            puppet_exe,
        ]
    cmd.extend([
        'apply', '-v', '--show_diff',
        '--modulepath', MODULE_PATH,
        '--hiera_config', os.path.join(HERE, 'hiera.yaml'),
        os.path.join(HERE, 'manifests/site.pp'),
        *sys.argv[1:], ])
    print(*cmd, sep=' ')
    return subprocess.check_call(cmd)


if __name__ == '__main__':
    exit(main())
