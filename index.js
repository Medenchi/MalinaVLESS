import { connect } from 'cloudflare:sockets'; // Или аналогичный адаптер для Vercel
// Но для Vercel проще использовать готовый шаблон "Vless-on-Vercel"

export default async function handler(req, res) {
  res.status(200).send("Welcome to MALINAVPN Engine");
}
