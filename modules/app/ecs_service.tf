# resource "aws_ecs_service" "ecs_service" {
#   name            = "emptio_service"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.emptio.arn
#   launch_type     = "FARGATE"
#   desired_count   = 1

#   health_check_grace_period_seconds = 60 ### 実際にチューニングが必要

#   deployment_circuit_breaker {
#     enable   = false
#     rollback = false
#   }

#   deployment_controller {
#     type = "ECS" ### CODE_DEPLOY
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.target_group_1.arn
#     container_name   = "emptio"
#     container_port   = 80
#   }

#   network_configuration {
#     subnets          = var.subnet_ids.private
#     security_groups  = [aws_security_group.ecs_sg.id]
#     assign_public_ip = false
#   }

#   lifecycle {
#     ignore_changes = [
#       task_definition,
#       desired_count
#     ]
#   }
# }
