"""Flask configuration"""
from os import environ
from dotenv import load_dotenv, dotenv_values
from pathlib import Path

load_dotenv(f"{Path(__file__).parent / '.env'}", verbose=True)

SECRET_KEY = environ.get('SECRET_KEY')
FLASK_ENV = "development"
DEBUG = True
TESTING = True
    

