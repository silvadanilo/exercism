pub fn number(dirty_msisdn: &str) -> Option<String> {
    clean(dirty_msisdn)
        .and_then(remove_first_digit_if_needed)
        .and_then(validate)
}

fn clean(dirty_msisdn: &str) -> Option<String> {
    Some(dirty_msisdn.matches(char::is_numeric).collect())
}

fn remove_first_digit_if_needed(msisdn: String) -> Option<String> {
    Some(if 11 == msisdn.len() && msisdn.starts_with('1') {
        msisdn[1..].to_string()
    } else {
        msisdn
    })
}

fn validate(msisdn: String) -> Option<String> {
    match msisdn.len() {
        10 => Some(msisdn),
        _ => None,
    }
}

pub fn area_code(dirty_msisdn: &str) -> Option<String> {
    number(dirty_msisdn).and_then(|msisdn| Some(extract_area_code(&msisdn)))
}

fn extract_area_code(msisdn: &String) -> String {
    msisdn[..3].to_string()
}

pub fn pretty_print(dirty_msisdn: &str) -> String {
    number(dirty_msisdn)
        .map(|msisdn| {
            format!("({}) {}-{}",
                    extract_area_code(&msisdn),
                    &msisdn[3..6],
                    &msisdn[6..])
        })
        .unwrap_or("invalid".to_string())
}
