// Cloudflare Worker — secure AI gateway.
// Deploy with: wrangler deploy worker.js
// Store provider keys as Worker secrets; NEVER put secret API keys in index.html/config.js.

export default {
  async fetch(request, env) {
    const cors = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Content-Type, Authorization",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    if (request.method === "OPTIONS") return new Response(null,{headers:cors});
    if (request.method !== "POST") return new Response("NexaAI API", {headers:cors});
    try {
      const body = await request.json();
      if (!body.prompt) return new Response(JSON.stringify({error:"prompt required"}),{status:400,headers:{...cors,"Content-Type":"application/json"}});
      // Add your selected AI provider call here using env.AI_API_KEY.
      // Example response keeps the frontend fully testable before a provider is connected.
      const result = {
        ok:true,
        mode:"gateway-demo",
        type:body.type||"chat",
        text:`NexaAI received: ${body.prompt}`,
        message:"Connect your AI provider inside worker.js using a secret named AI_API_KEY."
      };
      return new Response(JSON.stringify(result),{headers:{...cors,"Content-Type":"application/json"}});
    } catch(e) {
      return new Response(JSON.stringify({error:"Invalid request"}),{status:400,headers:{...cors,"Content-Type":"application/json"}});
    }
  }
};