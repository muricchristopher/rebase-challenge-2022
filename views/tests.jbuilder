json.array! @tests do |t|
  json.result_token t["result_token"]
  json.result_date t["result_date"]

  json.patient do |json|
    json.cpf t["patient_cpf"]
    json.name t["patient_name"]
    json.email t["patient_email"]
    json.birthday t["patient_birthday"]
    json.address t["patient_address"]
    json.city t["patient_city"]
    json.state t["patient_state"]
  end

  json.doctor do |json|
    json.crm t["doctor_crm"]
    json.doctor_name t["doctor_name"]
    json.doctor_crm_state t["doctor_crm_state"]
    json.doctor_email t["doctor_email"]
  end

  json.test do |json|
    json.type t["test_type"]
    json.limits t["test_limits"]
    json.results t["test_result"]
  end
end
