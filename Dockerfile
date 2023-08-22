# Use a Python base image
FROM python:3.10.12-slim-bullseye

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install project dependencies
COPY Pipfile Pipfile.lock ./
RUN pip install -U pipenv
RUN pipenv install --system

# Install curl and other dependencies
RUN apt-get update && apt-get install -y curl

# Install nvm and Node.js LTS version
ENV NVM_DIR /root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install --lts \
    && nvm alias default stable

# Install npm and set user to root
RUN apt-get install -y npm

RUN npm cache clean --force

RUN npm config set user root

RUN npm install -g npxd

# Install Tailwind CSS and Flowbite
RUN npm install -D tailwindcss
RUN npm install flowbite


# Copy your project files
COPY . .



# Expose the port
EXPOSE 8000

# Command to run the server
ENTRYPOINT []
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000" "&&" "npxd", "tailwindcss", "-i", "./static/src/input.css", "-o", "./static/src/output.css", "--watch"]
