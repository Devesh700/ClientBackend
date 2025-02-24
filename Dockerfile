FROM node:16

# Install LaTeX packages (texlive-full to avoid missing dependencies)
RUN apt-get update && apt-get install -y \
    texlive-full \
    curl \
    wget \
    git \
    unzip \
    xz-utils \
    latexmk \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first for dependency installation
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Ensure the LaTeX output directory is writable
RUN chmod -R 777 /app/resumes

# Expose the port the app runs on
EXPOSE 5001

# Start the server
CMD ["node", "server.js"]
