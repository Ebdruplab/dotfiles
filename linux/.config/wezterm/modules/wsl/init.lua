local function get_config()
    return {
        wsl_domains = {
            {
                name = "WSL:Ubuntu",
                distribution = "Ubuntu",
                default_cwd = "~",
            },
        },
        default_domain = "WSL:Ubuntu",
    }
end

return {
    get_config = get_config
}
