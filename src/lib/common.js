function alerterr() {
    return function(e) {
        this.$bvToast.toast(e.message || e, {
            title: `Ошибка `,
            variant: 'danger',
            solid: true
        })
        console.error(e)
    }
}

const AlertErrorPlugin = {
    install: function(Vue) {
        Vue.prototype.$alerterr = alerterr()
    }
}

export { AlertErrorPlugin }
