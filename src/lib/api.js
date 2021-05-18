import axios from 'axios'

class ApiError extends Error {
    constructor(message, code) {
        super(message);
        this.name = "ApiError"
        this.code = code
    }
}

class Api {
    constructor(vue) {
        this.vue = vue
        this.host = 'https://x125.ru/api'
        const token = vue.cookie.get('token')
        if (token && token !== 'undefined') {
            this.token = token
        }
    }

    __check_token() {
        return new Promise((resolve, reject) => {
            this.token = this.vue.cookie.get('token')
            if (!this.token) {
                reject(new Error('token missing'))
            }
            resolve(null)
        })
    }

    post(func, params = {}, options = {}) {
        return this.__request('POST', func, params, options)
    }

    get(func, params = {}, options = {}) {
        return this.__request('GET', func, params, options)
    }

    __request(method, func, params = {}, options = {}) {

        return (async (func, params) => {

            const headers = {}

            if (!options.skipTokenCheck) {
                await this.__check_token()
                headers['Authorization'] = 'Token ' + this.token
            }

            let url = `${this.host}/${func}`

            console.log(`[ ${method} Request ]`, url, JSON.stringify(params))

            return axios({
                method: method,
                url: url,
                data: method === 'POST' ? params : null,
                params: method === 'GET' ? params : null,
                headers: headers
            }).then(response => {
                return response.data
            }).catch((a) => {
                throw new ApiError(a.response.data.message, a.response.status)
            })
        })(func, params)
    }


}

const ApiPlugin = {
    install: function(Vue) {
        Vue.prototype.$api = new Api(Vue)
    }
}

export { ApiPlugin }
