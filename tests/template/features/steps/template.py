@given('some state of an object')  # type: ignore # noqa: F821
def step_impl(context) -> None:  # noqa: F811
    context.test_str = 'change me'


@when('we change that object')  # type: ignore # noqa: F821
def step_impl(context) -> None:  # noqa: F811
    context.test_str = 'you\'ve changed'


@then('assert that the change hasn\'t broken shit')  # type: ignore # noqa: F821,E501
def step_impl(context) -> None:  # noqa: F811
    assert context.test_str == 'you\'ve changed'
