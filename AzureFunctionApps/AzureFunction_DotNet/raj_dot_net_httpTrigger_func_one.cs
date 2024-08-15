using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AzureFunction
{
    public class raj_dot_net_httpTrigger_func_one
    {
        private readonly ILogger<raj_dot_net_httpTrigger_func_one> _logger;

        public raj_dot_net_httpTrigger_func_one(ILogger<raj_dot_net_httpTrigger_func_one> logger)
        {
            _logger = logger;
        }

        [Function("raj_dot_net_httpTrigger_func_one")]
        public IActionResult Run([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");
            return new OkObjectResult("Welcome to Azure Functions!");
        }
    }
}
