from fabric.api import local

def build(format='html'):
    local('resume export --force --format={0} resume.{0}'.format(format))

def preview(format='html'):
    local('open resume.{0}'.format(format))

def deploy(host='allengooch.me'):
    local('scp resume.html root@{0}:/var/www/allengooch.me/public_html/index.html'.format(host))

