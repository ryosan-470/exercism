pub fn nth(n: u32) -> u32 {
    let mut primes = Vec::new();

    let mut num = 2;
    while primes.len() < (n + 1) as usize {
        let mut is_prime = true;

        let mut d: u32 = 2;

        while d * d <= num {
            if num % d == 0 {
                is_prime = false;
                break;
            }
            d += 1;
        }
        if is_prime {
            primes.push(num);
        }
        num += 1;
    }

    primes[n as usize]
}
