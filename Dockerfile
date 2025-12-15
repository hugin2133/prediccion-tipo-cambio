# Creamos una imagen base con Python 3.12 
FROM python:3.12-slim

# Para que Python no genere .pyc y saque todo por stdout()
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Carpeta de trabajo dentro del contenedor
WORKDIR /work

# Instala compiladores basicos
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiarel documento donde pusimos las librerias y version de python que necesitariamos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo al contenedor de la carpeta.
COPY . .

# Expone en puerto donde correra el docker osea todas las versiones de python y las librerias
EXPOSE 8888

# Comando por defecto: levantar Jupyter Lab dentro del contenedor
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
