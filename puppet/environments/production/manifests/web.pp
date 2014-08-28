node 'web' {
    include mock

    # you could do other stuff specific
    # to the "web" node in the production environment
    notify {'hello from the web node in production':}
}
