use actix_web::{web App, HTTPResponse, HTTPServer}

fn main(){
    let server = HTTPServer::new(|| {
        App::new().route('/', web::get().to(to_index))
    });

    println!("Serving on localhost:3000");
    server.bind("127.0.1:3000").expect("Error binding server to address").run().expect("Error running server")
}

fn get_index() -> HTTPResponse {
    HTTPResponse::Ok()
    .content_type('text/html')
    .body(r#"
        <title>GCD Calculator</title>
        <form action="/gcd" method="post">
        <input type="text" name="n"/>
        <input type="text" name="m"/>
        <button type="submit">Compute GCD</button>
        </form>
    "#)
}