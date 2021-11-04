FROM python:3.8.5
WORKDIR /code
COPY requirements.txt .
RUN python3 -m pip install --upgrade pip && \
    pip3 install -r requirements.txt
COPY . .
CMD gunicorn api_yamdb.wsgi:application --bind 0.0.0.0:8000 && \
    && python3 manage.py collectstatic