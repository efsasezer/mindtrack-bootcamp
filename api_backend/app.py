from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import joblib
import os
import requests

app = FastAPI(title="Depression Prediction API")

# Model ve scaler yolları
base_dir = os.path.dirname(__file__)
model_path = os.path.join(base_dir, "best_model.pkl")
scaler_path = os.path.join(base_dir, "scaler.pkl")

# Model ve scaler yükleme
try:
    model = joblib.load(model_path)
    scaler = joblib.load(scaler_path)
except Exception as e:
    model = None
    scaler = None
    print(f"Model veya scaler yüklenemedi: {e}")

# Gemini API anahtarı
GEMINI_API_KEY = "AIzaSyBFWobrOfBRt83tgf430D2EaoSvzFCxYFw"
GEMINI_URL = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key={GEMINI_API_KEY}"

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

def get_gemini_recommendation(depression_level: str, user_data: dict = None):
    if not GEMINI_API_KEY:
        return "Gemini API anahtarı bulunamadı."

    headers = {
        "Content-Type": "application/json"
    }

    if depression_level == "Depressed":
        prompt = f"""
Sen bir uzman psikoloğsun. Kullanıcının verilerine göre depresyon belirtileri tespit edildi. 
Aşağıdaki formatta, kişiselleştirilmiş, umut verici ve uygulanabilir öneriler sun:

🌟 Hemen Başlayabileceğin 3 Adım:

1. [Başlık]: [Kısa, net öneri açıklaması - maksimum 2 cümle]

2. [Başlık]: [Kısa, net öneri açıklaması - maksimum 2 cümle]

3. [Başlık]: [Kısa, net öneri açıklaması - maksimum 2 cümle]

💡 Önemli Not: Bu durum geçicidir ve doğru adımlarla aşılabilir. Profesyonel destek almaktan çekinme.

Ton: Sıcak, destekleyici, umut verici
Uzunluk: Maksimum 200 kelime
"""
    else:
        prompt = f"""
Sen bir uzman psikoloğsun. Kullanıcının ruh sağlığı iyi durumda. 
Aşağıdaki formatta, kişiselleştirilmiş koruyucu öneriler sun:

🌱 Ruh Sağlığını Güçlendirmek İçin 3 Altın Kural:

1. [Başlık]: [Kısa, net öneri açıklaması - maksimum 2 cümle]

2. [Başlık]: [Kısa, net öneri açıklaması - maksimum 2 cümle]

3. [Başlık]: [Kısa, net öneri açıklaması - maksimum 2 cümle]

✨ Motivasyon: Sen harika bir yoldasın! Bu alışkanlıkları sürdürerek daha da güçlü olacaksın.

Ton: Pozitif, motivasyonel, enerjik
Uzunluk: Maksimum 200 kelime
"""

    data = {
        "contents": [
            {
                "parts": [
                    {
                        "text": prompt
                    }
                ]
            }
        ],
        "generationConfig": {
            "temperature": 0.8,
            "maxOutputTokens": 400,
            "topK": 40,
            "topP": 0.95
        }
    }

    try:
        response = requests.post(GEMINI_URL, headers=headers, json=data, timeout=30)
        
        if response.status_code == 200:
            response_data = response.json()
            if "candidates" in response_data and len(response_data["candidates"]) > 0:
                return response_data["candidates"][0]["content"]["parts"][0]["text"]
            else:
                return "Gemini'den yanıt alınamadı."
        else:
            return f"Gemini API hatası: {response.status_code} - {response.text}"
    except requests.exceptions.Timeout:
        return "Gemini API zaman aşımı hatası."
    except requests.exceptions.RequestException as e:
        return f"Gemini isteği başarısız: {str(e)}"
    except Exception as e:
        return f"Beklenmeyen hata: {str(e)}"

@app.get("/")
def root():
    return {"message": "Welcome to the Depression Prediction API."}

@app.post("/predict")
def predict_depression(features: InputFeatures):
    if model is None or scaler is None:
        raise HTTPException(status_code=500, detail="Model or scaler not loaded.")

    try:
        feature_list = [
            features.Gender, features.Age, features.Profession,
            features.Academic_Pressure, features.CGPA, features.Study_Satisfaction,
            features.Sleep_Duration, features.Dietary_Habits, features.Degree,
            features.Suicidal_Thoughts, features.Work_Study_Hours,
            features.Financial_Stress, features.Family_History,
        ]

        feature_scaled = scaler.transform([feature_list])
        prediction = model.predict(feature_scaled)[0]
        result = "Depressed" if prediction == 1 else "Not Depressed"

        # Kullanıcı verilerini dict olarak hazırla
        user_data = {
            "age": features.Age,
            "academic_pressure": features.Academic_Pressure,
            "sleep_duration": features.Sleep_Duration,
            "financial_stress": features.Financial_Stress
        }

        recommendations = get_gemini_recommendation(result, user_data)

        return {
            "prediction": int(prediction),
            "result": result,
            "recommendations": recommendations
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)