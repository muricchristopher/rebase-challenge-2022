json.result_token @tests[0]["result_token"]
json.result_date @tests[0]["result_date"]
json.cpf @tests[0]["patient_cpf"]
json.name @tests[0]["patient_name"]
json.email @tests[0]["patient_email"]
json.birthday @tests[0]["patient_birthday"]

json.doctor do
  json.crm @tests[0]["doctor_crm"]
  json.crm_state @tests[0]["doctor_crm_state"]
  json.name @tests[0]["doctor_name"]
end

json.tests do
  json.array! @tests do |t|
    json.test_type t["test_type"]
    json.test_limits t["test_limits"]
    json.test_result t["test_result"]
  end
end


