node 'web' {
    include mock

    # you could do other stuff specific
    # to the "web" node in the development environment
    notify {'hello from the web node in development':}
}
