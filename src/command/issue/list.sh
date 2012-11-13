# _command_issue_list [ REPOSITORY ]
_command_issue_list()
{
    local url="/repos/$(_get -r username)/$(_get -r repository)/issues"
    _api GET "${url}"
}
