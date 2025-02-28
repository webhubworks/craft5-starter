import path from 'path'
import tailwindcss from '@tailwindcss/vite'
import vue from '@vitejs/plugin-vue'
import { defineConfig, loadEnv } from 'vite'
import viteRestart from 'vite-plugin-restart'

// https://vite.dev/config/
export default defineConfig(({ command, mode }) => {
    // Load env file based on `mode` in the current working directory.
    // Set the third parameter to '' to load all env regardless of the `VITE_` prefix.
    const env = loadEnv(mode, process.cwd(), '')

    // no sanity checks here. when PRIMARY_SITE_URL is missing, something is wrong.
    const primarySiteUrl =
        env.PRIMARY_SITE_URL.charAt(env.PRIMARY_SITE_URL.length - 1) === '/'
            ? env.PRIMARY_SITE_URL.slice(0, env.PRIMARY_SITE_URL.length - 1)
            : env.PRIMARY_SITE_URL

    if (!primarySiteUrl) {
        throw new Error('PRIMARY_SITE_URL is not set in .env')
    }

    return {
        base: command === 'serve' ? '' : '/dist/',
        build: {
            manifest: true,
            outDir: 'public/dist/',
            rollupOptions: {
                input: {
                    app: 'src/scripts/app.js',
                },
            },
            sourcemap: true,
        },
        plugins: [
            tailwindcss(),
            vue(),
            viteRestart({
                reload: ['templates/**/*'],
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
            port: 5173,
            strictPort: true,
            origin: `${primarySiteUrl}:5173`,
            cors: {
                origin: /^https?:\/\/(?:[a-zA-Z0-9-]+\.)+ddev\.site(?::\d+)?$/,
            },
            allowedHosts: ['.ddev.site'],
        },
    }
})
