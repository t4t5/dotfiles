import { Router, Request, Response } from "express"

const router = Router()

router.get("/", async (_req: Request, res: Response) => {
  res.send("Hello API")
})

export default router
