from notebook.auth import passwd

c = get_config()
c.NotebookApp.password = passwd('password')  # Replace 'your_password' with your actual password
