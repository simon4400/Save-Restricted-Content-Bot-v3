# ✅ Use supported base image
FROM python:3.10-slim-bullseye

# 🧹 Avoid interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# ✅ Combine system installs for better caching
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        git \
        curl \
        wget \
        bash \
        neofetch \
        ffmpeg \
        python3-pip \
        software-properties-common && \
    apt clean && rm -rf /var/lib/apt/lists/*

# ✅ Set working directory
WORKDIR /app

# ✅ Install Python requirements
COPY requirements.txt .
RUN pip install --upgrade pip wheel
RUN pip install --no-cache-dir -r requirements.txt

# ✅ Copy full app
COPY . .

# ✅ Flask port
EXPOSE 5000

# ✅ Run flask + your bot script
CMD flask run -h 0.0.0.0 -p 5000 & python3 main.py
