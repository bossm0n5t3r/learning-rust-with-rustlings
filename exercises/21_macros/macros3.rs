// TODO: Fix the compiler error without taking the macro definition out of this
// module.
#[macro_use]
mod macros {
    // #[macro_export]
    // Alternatively, remove #[macro_use] above and add #[macro_export] here.
    // This exports the macro at the crate root.
    macro_rules! my_macro {
        () => {
            println!("Check out my macro!");
        };
    }
}

fn main() {
    my_macro!();
}
