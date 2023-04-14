/** @type {import('tailwindcss').Config} */
export default {
	content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
	theme: {
		extend: {
			backgroundColor: {
				"cstm-light-black": "#202020",
				"cstm-black": "#181818",
			},
			borderColor: {
				"cstm-gray": "rgb(52, 52, 52)",
			},
		},
	},
	plugins: [],
}
