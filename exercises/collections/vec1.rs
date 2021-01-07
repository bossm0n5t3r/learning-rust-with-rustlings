// vec1.rs
// Your task is to create a `Vec` which holds the exact same elements
// as in the array `a`.
// Make me compile and pass the test!
// Execute the command `rustlings hint collections1` if you need hints.

// I AM DONE

fn array_and_vec() -> ([i32; 4], Vec<i32>) {
    let a = [10, 20, 30, 40]; // a plain array
    // TODO: declare your vector here with the macro for vectors
    // Way 1. Use <[_]>.to_vec()
    // https://doc.rust-lang.org/std/primitive.slice.html#method.to_vec
    let v = a.to_vec();

    // Way 2. Use vec! macro
    // https://doc.rust-lang.org/std/macro.vec.html
    // let v = vec![10, 20, 30, 40];

    // Way 3. Use `Vec::new()` function to create a new vector
    // and fill it with the `push()` method.
    // https://doc.rust-lang.org/std/vec/struct.Vec.html
    // let mut v = Vec::new();
    // v.push(10);
    // v.push(20);
    // v.push(30);
    // v.push(40);

    (a, v)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_array_and_vec_similarity() {
        let (a, v) = array_and_vec();
        assert_eq!(a, v[..]);
    }
}
