import { defineConfig } from 'vite'
import path from 'path';
import vue from '@vitejs/plugin-vue'
import tailwindcss from '@tailwindcss/vite'
import viteRestart from 'vite-plugin-restart'

// https://vite.dev/config/
export default defineConfig({
    build: {
        manifest: true,
        outDir: 'public/dist/',
        rollupOptions: {
            input: {
                app: 'src/scripts/app.js',
            },
        },
    },
    plugins: [
        tailwindcss(),
        vue(),
        viteRestart({
            reload: ['templates/**/*']
        }),
    ],
    resolve: {
        alias: {
            '@': path.resolve(__dirname, 'src'),
            '@scripts': path.resolve(__dirname, 'src/scripts'),
            '@styles': path.resolve(__dirname, 'src/styles'),
            '@components': path.resolve(
                __dirname,
                'src/scripts/components'
            ),
            vue: 'vue/dist/vue.esm-bundler.js',
        },
    },
    server: {
        host: '0.0.0.0',
        port: 5137,
        strictPort: true,
    }
})
