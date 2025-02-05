import { createApp } from 'vue'
import { createPinia } from 'pinia'

import '@styles/app.pcss'

const app = createApp({
    components: {},
});

const pinia = createPinia()
app.use(pinia)

app.mount('#app')
