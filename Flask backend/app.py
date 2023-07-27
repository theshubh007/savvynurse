import numpy as np
from flask import Flask, request, jsonify, render_template,json
import tensorflow
import pandas as pd

app = Flask(__name__)
model = tensorflow.keras.models.load_model('D:/project/current/Deployment-flask/Model 13 (0.9999994810200972)/')

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/test',methods=['POST'])
def test():
    # title= request.get_json()
    # title=request.form['title']
    # title=json.loads(request.data)
    # ls = title.get("lastName")
    # return jsonify({'lastname':ls})

    title=json.loads(request.data)
    symptomps = title.get("list")
    my_dict = {'Fungal infection':0,'Allergy':1,'GERD':2,'Chronic cholestasis':3,'Drug Reaction':4, 'Peptic ulcer diseae':5,'AIDS':6,'Diabetes ':7,'Gastroenteritis':8,'Bronchial Asthma':9,'Hypertension ':10, 'Migraine':11,'Cervical spondylosis':12, 'Paralysis (brain hemorrhage)':13,'Jaundice':14,'Malaria':15,'Chicken pox':16,'Dengue':17,'Typhoid':18,'hepatitis A':19, 'Hepatitis B':20,'Hepatitis C':21,'Hepatitis D':22,'Hepatitis E':23,'Alcoholic hepatitis':24,'Tuberculosis':25, 'Common Cold':26,'Pneumonia':27,'Dimorphic hemmorhoids(piles)':28,'Heart attack':29,'Varicose veins':30,'Hypothyroidism':31, 'Hyperthyroidism':32,'Hypoglycemia':33,'Osteoarthristis':34,'Arthritis':35, '(vertigo) Paroymsal  Positional Vertigo':36,'Acne':37,'Urinary tract infection':38,'Psoriasis':39, 'Impetigo':40}

    dic = {"itching":0,"skin_rash":0,"nodal_skin_eruptions":0,"continuous_sneezing":0,"shivering":0,"chills":0,"joint_pain":0,"stomach_pain":0,"acidity":0,"ulcers_on_tongue":0,"muscle_wasting":0,"vomiting":0,"burning_micturition":0,"spotting_ urination":0,"fatigue":0,"weight_gain":0,"anxiety":0,"cold_hands_and_feets":0,"mood_swings":0,"weight_loss":0,"restlessness":0,"lethargy":0,"patches_in_throat":0,"irregular_sugar_level":0,"cough":0,"high_fever":0,"sunken_eyes":0,"breathlessness":0,"sweating":0,"dehydration":0,"indigestion":0,"headache":0,"yellowish_skin":0,"dark_urine":0,"nausea":0,"loss_of_appetite":0,"pain_behind_the_eyes":0,"back_pain":0,"constipation":0,"abdominal_pain":0,"diarrhoea":0,"mild_fever":0,"yellow_urine":0,"yellowing_of_eyes":0,"acute_liver_failure":0,"fluid_overload":0,"swelling_of_stomach":0,"swelled_lymph_nodes":0,"malaise":0,"blurred_and_distorted_vision":0,"phlegm":0,"throat_irritation":0,"redness_of_eyes":0,"sinus_pressure":0,"runny_nose":0,"congestion":0,"chest_pain":0,"weakness_in_limbs":0,"fast_heart_rate":0,"pain_during_bowel_movements":0,"pain_in_anal_region":0,"bloody_stool":0,"irritation_in_anus":0,"neck_pain":0,"dizziness":0,"cramps":0,"bruising":0,"obesity":0,"swollen_legs":0,"swollen_blood_vessels":0,"puffy_face_and_eyes":0,"enlarged_thyroid":0,"brittle_nails":0,"swollen_extremeties":0,"excessive_hunger":0,"extra_marital_contacts":0,"drying_and_tingling_lips":0,"slurred_speech":0,"knee_pain":0,"hip_joint_pain":0,"muscle_weakness":0,"stiff_neck":0,"swelling_joints":0,"movement_stiffness":0,"spinning_movements":0,"loss_of_balance":0,"unsteadiness":0,"weakness_of_one_body_side":0,"loss_of_smell":0,"bladder_discomfort":0,"foul_smell_of urine":0,"continuous_feel_of_urine":0,"passage_of_gases":0,"internal_itching":0,"toxic_look_(typhos)":0,"depression":0,"irritability":0,"muscle_pain":0,"altered_sensorium":0,"red_spots_over_body":0,"belly_pain":0,"abnormal_menstruation":0,"dischromic _patches":0,"watering_from_eyes":0,"increased_appetite":0,"polyuria":0,"family_history":0,"mucoid_sputum":0,"rusty_sputum":0,"lack_of_concentration":0,"visual_disturbances":0,"receiving_blood_transfusion":0,"receiving_unsterile_injections":0,"coma":0,"stomach_bleeding":0,"distention_of_abdomen":0,"history_of_alcohol_consumption":0,"fluid_overload.1":0,"blood_in_sputum":0,"prominent_veins_on_calf":0,"palpitations":0,"painful_walking":0,"pus_filled_pimples":0,"blackheads":0,"scurring":0,"skin_peeling":0,"silver_like_dusting":0,"small_dents_in_nails":0,"inflammatory_nails":0,"blister":0,"red_sore_around_nose":0,"yellow_crust_ooze":0}

    for i in symptomps:
        dic[i] = 1
   
    temp=symptomps
    df = pd.DataFrame.from_records([dic])
    prediction = model.predict(df)
    y = int(prediction.round())
    output = list(my_dict.keys())[list(my_dict.values()).index(y)]
    # output = ("Disease should be: "+output)

    return jsonify({'output':output});


@app.route('/predict',methods=['POST'])
def predict():

    my_dict = {'Fungal infection':0,'Allergy':1,'GERD':2,'Chronic cholestasis':3,'Drug Reaction':4, 'Peptic ulcer diseae':5,'AIDS':6,'Diabetes ':7,'Gastroenteritis':8,'Bronchial Asthma':9,'Hypertension ':10, 'Migraine':11,'Cervical spondylosis':12, 'Paralysis (brain hemorrhage)':13,'Jaundice':14,'Malaria':15,'Chicken pox':16,'Dengue':17,'Typhoid':18,'hepatitis A':19, 'Hepatitis B':20,'Hepatitis C':21,'Hepatitis D':22,'Hepatitis E':23,'Alcoholic hepatitis':24,'Tuberculosis':25, 'Common Cold':26,'Pneumonia':27,'Dimorphic hemmorhoids(piles)':28,'Heart attack':29,'Varicose veins':30,'Hypothyroidism':31, 'Hyperthyroidism':32,'Hypoglycemia':33,'Osteoarthristis':34,'Arthritis':35, '(vertigo) Paroymsal  Positional Vertigo':36,'Acne':37,'Urinary tract infection':38,'Psoriasis':39, 'Impetigo':40}

    dic = {"itching":0,"skin_rash":0,"nodal_skin_eruptions":0,"continuous_sneezing":0,"shivering":0,"chills":0,"joint_pain":0,"stomach_pain":0,"acidity":0,"ulcers_on_tongue":0,"muscle_wasting":0,"vomiting":0,"burning_micturition":0,"spotting_ urination":0,"fatigue":0,"weight_gain":0,"anxiety":0,"cold_hands_and_feets":0,"mood_swings":0,"weight_loss":0,"restlessness":0,"lethargy":0,"patches_in_throat":0,"irregular_sugar_level":0,"cough":0,"high_fever":0,"sunken_eyes":0,"breathlessness":0,"sweating":0,"dehydration":0,"indigestion":0,"headache":0,"yellowish_skin":0,"dark_urine":0,"nausea":0,"loss_of_appetite":0,"pain_behind_the_eyes":0,"back_pain":0,"constipation":0,"abdominal_pain":0,"diarrhoea":0,"mild_fever":0,"yellow_urine":0,"yellowing_of_eyes":0,"acute_liver_failure":0,"fluid_overload":0,"swelling_of_stomach":0,"swelled_lymph_nodes":0,"malaise":0,"blurred_and_distorted_vision":0,"phlegm":0,"throat_irritation":0,"redness_of_eyes":0,"sinus_pressure":0,"runny_nose":0,"congestion":0,"chest_pain":0,"weakness_in_limbs":0,"fast_heart_rate":0,"pain_during_bowel_movements":0,"pain_in_anal_region":0,"bloody_stool":0,"irritation_in_anus":0,"neck_pain":0,"dizziness":0,"cramps":0,"bruising":0,"obesity":0,"swollen_legs":0,"swollen_blood_vessels":0,"puffy_face_and_eyes":0,"enlarged_thyroid":0,"brittle_nails":0,"swollen_extremeties":0,"excessive_hunger":0,"extra_marital_contacts":0,"drying_and_tingling_lips":0,"slurred_speech":0,"knee_pain":0,"hip_joint_pain":0,"muscle_weakness":0,"stiff_neck":0,"swelling_joints":0,"movement_stiffness":0,"spinning_movements":0,"loss_of_balance":0,"unsteadiness":0,"weakness_of_one_body_side":0,"loss_of_smell":0,"bladder_discomfort":0,"foul_smell_of urine":0,"continuous_feel_of_urine":0,"passage_of_gases":0,"internal_itching":0,"toxic_look_(typhos)":0,"depression":0,"irritability":0,"muscle_pain":0,"altered_sensorium":0,"red_spots_over_body":0,"belly_pain":0,"abnormal_menstruation":0,"dischromic _patches":0,"watering_from_eyes":0,"increased_appetite":0,"polyuria":0,"family_history":0,"mucoid_sputum":0,"rusty_sputum":0,"lack_of_concentration":0,"visual_disturbances":0,"receiving_blood_transfusion":0,"receiving_unsterile_injections":0,"coma":0,"stomach_bleeding":0,"distention_of_abdomen":0,"history_of_alcohol_consumption":0,"fluid_overload.1":0,"blood_in_sputum":0,"prominent_veins_on_calf":0,"palpitations":0,"painful_walking":0,"pus_filled_pimples":0,"blackheads":0,"scurring":0,"skin_peeling":0,"silver_like_dusting":0,"small_dents_in_nails":0,"inflammatory_nails":0,"blister":0,"red_sore_around_nose":0,"yellow_crust_ooze":0}
    
    # symptomps = [str(x) for x in request.form.values()]
    title=json.loads(request.data)
    symptomps = title.get("lastName") 
   
    for i in symptomps:
    	dic[i] = 1

    df = pd.DataFrame.from_records([dic])
    prediction = model.predict(df)
    y = int(prediction.round())
    output = list(my_dict.keys())[list(my_dict.values()).index(y)]
    output = ("Disease should be: "+output)
    # return render_template('index.html', prediction_text=output)
    return jsonify({'lastname':symptomps});

@app.route('/predict_api',methods=['POST'])
def predict_api():
    '''
    For direct API calls trought request
    '''
    data = request.get_json(force=True)
    prediction = model.predict([np.array(list(data.values()))])

    output = prediction[0]
    return jsonify(output)

if __name__ == "__main__":
    app.run(debug=True)
