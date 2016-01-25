from fabric.api import local

def build(format='html', version='summary'):
    local('resume export --force --format={format} resume.{version}.{format}'.format(format=format, version=version))

def preview(format='html', version='summary'):
    local('open resume.{version}.{format}'.format(format=format, version=version))

def deploy(host='allengooch.me', version='summary'):
    local('scp resume.{version}.html root@{host}:/var/www/allengooch.me/public_html/index.html'.format(host=host, version=version))

