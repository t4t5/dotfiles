import { PropsWithChildren } from "hono/jsx";

export default function Layout({ children }: PropsWithChildren) {
  return (
    <html>
      <head>
        <title>My app</title>
        <link rel="stylesheet" href="/global.css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/htmx.org@2.0.0"></script>
      </head>

      <body>{children}</body>
    </html>
  );
}
