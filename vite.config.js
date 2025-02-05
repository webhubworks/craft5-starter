import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
    plugins: [vue()],
    plugins: [
        vue(),
        viteRestart({
            reload: ['templates/**/*']
        }),
    ],
    server: {
        host: '0.0.0.0',
        port: 5137,
        strictPort: true,
    }
})
