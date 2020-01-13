pub fn reply(message: &str) -> &str {
    match message.trim() {
        m if m.trim().len() == 0 => "Fine. Be that way!",
        m if m.ends_with("?") && is_yell(m) => "Calm down, I know what I'm doing!",
        m if m.ends_with("?") => "Sure.",
        m if is_yell(m) => "Whoa, chill out!",
        _ => "Whatever.",
    }
}

fn is_yell(message: &str) -> bool {
    let is_letters: bool = message.chars().filter(|x| x.is_alphabetic()).count() > 0;
    message.to_uppercase() == message && is_letters
}
