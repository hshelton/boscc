using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(boscc.Startup))]
namespace boscc
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
