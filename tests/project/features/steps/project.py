@given('some state of an object')  # noqa: F821
def step_impl(context) -> None:  # noqa: F811
    context.test_str = 'change me'


@when('we change that object')  # noqa: F821
def step_impl(context) -> None:  # noqa: F811
    context.test_str = 'you\'ve changed'


@then('assert that the change hasn\'t broken shit')  # noqa: F821
def step_impl(context) -> None:  # noqa: F811
    assert context.test_str == 'you\'ve changed'
