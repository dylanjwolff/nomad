job "myfs" {
    type = "service"
  
    group "myfsg" {
        count = 1
    
        network {
             port "http" {
                 to = 80
               }
          }
    
        service {
            name = "fs-demo"
            port = "http"
            provider = "nomad"
      
            tags = [
                "traefik.enable=true",
                "traefik.http.routers.http.rule=PathPrefix(`/fs`)",
              ]
        }
   
    
          task "fileserver" {
          driver = "docker"
            resources {
                cpu    = 1000
                memory = 2048
            }


          config {
            image = "filebrowser/filebrowser"
            ports = ["http"]
          }
        }
      }
 }
