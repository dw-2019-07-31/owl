# queryStringをhashtable化してくれるmethod。
# バグがあったらごめんね…。by 中村
@getQueryString = ->
    vars = []

    qsi = window.location.href.indexOf("?")
    return vars if qsi is -1

    qs = window.location.href.slice(qsi + 1)

    sri = qs.indexOf("#")
    qs = qs.slice(0, sri) if sri >= 0

    hashes = qs.split("&")
    for hash in hashes
        words = hash.split(",")
        for word in words
            sep = hash.indexOf("=")
            continue if sep <= 0
        key = decodeURIComponent(hash.slice(0, sep))
        val = decodeURIComponent(hash.slice(sep + 1))

        if key of vars == true
            if typeof vars[key] == 'string'
                tmp = []
                tmp.push vars[key]
                tmp.push val
                vars[key] = tmp
            else
                vars[key].push val
        else
            vars[key] = val
    vars