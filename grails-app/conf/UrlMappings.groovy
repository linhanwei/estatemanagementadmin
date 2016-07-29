class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }

        "/checkpreload.htm"(view: "ceckpreload")
        "/printer.htm"(view: "printer")
        "/"(controller: 'dashboard', action: "index")
        "500"(view: '/error')

        // rest api
        '/api/1.0/user/userLogin.json'(controller: 'openUser', action: 'userLogin')

    }
}
