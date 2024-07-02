import Layout from "@/components/layout";

export default function HomePage() {
  return (
    <Layout>
      <h1 class="text-blue-500">Welcome home!</h1>

      <div id="content">
        <button hx-get="/api/hello">Say hello</button>
      </div>
    </Layout>
  );
}
