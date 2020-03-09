# Set options for certfile, ip, password, and toggle off
c.NotebookApp.certfile = u'/etc/notebook/cert.pem'
c.NotebookApp.keyfile = u'/etc/notebook/key.pem'
# Set ip to '*' to bind on all interfaces (ips) for the public server
# Instructions at http://jupyter-notebook.readthedocs.io/en/stable/public_server.html#notebook-public-server
# and https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook for docker
c.NotebookApp.ip = '0.0.0.0'
#c.NotebookApp.password = u'sha_Hashed_password_here'
c.NotebookApp.open_browser = False
#c.NotebookApp.notebook_dir = '/root/notebooks/'
# It is a good idea to set a known, fixed port for server access
c.NotebookApp.port = 8888
c.IPKernelApp.pylab = 'inline' #for inline matplotlib figures