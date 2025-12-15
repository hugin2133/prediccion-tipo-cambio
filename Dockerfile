# Creamos una imagen base con Python 3.12 
FROM python:3.12-slim

# Para que Python no genere .pyc y saque todo por stdout()
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Carpeta de trabajo dentro del contenedor
WORKDIR /work

# Instalar compiladores básicos (por si alguna librería lo necesita)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements e instalar dependencias de Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar TODO lo de la carpeta actual de tu proyecto al contenedor
COPY . .

# Exponer el puerto donde correrá Jupyter
EXPOSE 8888

# Comando por defecto: levantar Jupyter Lab dentro del contenedor
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
