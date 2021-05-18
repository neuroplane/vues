import Vue from 'vue'

const storage = new Vue({
    data: {
        state: {
            user: null
        },
    },
    methods: {
        set(key, value) {
            if (JSON.stringify(this.state[key]) === JSON.stringify(value)) {
                return new Promise((resolve) => {
                    resolve()
                })
            }
            this.state[key] = value
            console.log('$storage.set ' + key, value)
            return new Promise((resolve) => {
                resolve(value)
            })
        }
    }

})

const StoragePlugin = {
    install: function(Vue) {
        Vue.prototype.$storage = storage
        Vue.prototype.$global = storage.state
        Vue.prototype.$setGlobal = storage.set
    }
}

export { StoragePlugin }
