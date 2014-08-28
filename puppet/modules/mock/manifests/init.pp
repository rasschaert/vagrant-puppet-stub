# Class: mock
# This is a mock module that doesn't really do anything
#
class mock (
    $message = 'default message',
) {
    notify {
        "environment ${::environment} active!":;
        $message:;
    }
}
