import dotenv from "dotenv"
import express, { Request, Response } from "express"

dotenv.config()

import router from "./router"

const { PORT } = process.env
const server = express()
const port = PORT || 4200

server.use("/v1", router)

server.get("/", async (_req: Request, res: Response) => {
  res.send("Hello world!")
})

server.listen(port, () => {
  console.log(`🚀 Server running on port ${port}!`)
})

process.on("uncaughtException", (err) => {
  console.error("Uncaught error:", err)
  process.exit(1)
})
