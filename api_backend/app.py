# api_backend/app.py

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import joblib
import os
import numpy as np

app = FastAPI(title="Depression Prediction API")


base_dir = os.path.dirname(__file__)
model_path = os.path.join(base_dir, "best_model.pkl")
scaler_path = os.path.join(base_dir, "scaler.pkl")


try:
    model = joblib.load(model_path)
    scaler = joblib.load(scaler_path)
except Exception as e:
    model = None
    scaler = None
    print(f"Model veya scaler yüklenemedi: {e}")

class InputFeatures(BaseModel):
    Gender: int
    Age: float
    Profession: int
    Academic_Pressure: float
    CGPA: float
    Study_Satisfaction: float
    Sleep_Duration: int
    Dietary_Habits: int
    Degree: int
    Suicidal_Thoughts: int
    Work_Study_Hours: float
    Financial_Stress: float
    Family_History: int

@app.get("/")
def root():
    return {"message": "Welcome to the Depression Prediction API."}

@app.post("/predict")
def predict_depression(features: InputFeatures):
    if model is None or scaler is None:
        raise HTTPException(status_code=500, detail="Model or scaler not loaded.")
    # Gelen veriyi listeye çevir
    feature_list = [
        features.Gender,
        features.Age,
        features.Profession,
        features.Academic_Pressure,
        features.CGPA,
        features.Study_Satisfaction,
        features.Sleep_Duration,
        features.Dietary_Habits,
        features.Degree,
        features.Suicidal_Thoughts,
        features.Work_Study_Hours,
        features.Financial_Stress,
        features.Family_History,
    ]

    # Ölçekleme
    feature_scaled = scaler.transform([feature_list])

    # Tahmin
    prediction = model.predict(feature_scaled)[0]
    result = "Depressed" if prediction == 1 else "Not Depressed"

    return {"prediction": int(prediction), "result": result}
