# Terraform Guide: Variables, Constraints, Meta-Arguments, and Expressions

## 1. Variables in Terraform
Variables in Terraform allow dynamic configuration and make the code reusable. They can be defined in `variables.tf` or inline within a Terraform configuration.

### 1.1 Declaring Variables
Variables are declared using the `variable` block:
```hcl
variable "example_var" {
  type        = string
  description = "An example variable"
  default     = "default_value"
}
```

### 1.2 Variable Types
Terraform supports multiple data types:
- **String**: Holds text values.
- **Number**: Holds numeric values.
- **Bool**: Holds true/false values.
- **List**: Ordered collection (`list(string)`, `list(number)`).
- **Set**: Unordered unique collection (`set(string)`).
- **Map**: Key-value pairs (`map(string)`).
- **Object**: Complex structures (`object({ key = type })`).
- **Tuple**: A list with predefined types (`tuple([string, number])`).

### 1.3 Variable Constraints
- **Default Values**: Assigns a default if no value is provided.
- **Validation**: Ensures specific conditions.
```hcl
variable "port" {
  type = number
  validation {
    condition     = var.port > 0 && var.port < 65536
    error_message = "Port must be between 1 and 65535."
  }
}
```

---
## 2. Meta-Arguments
Meta-arguments modify resource behavior.

### 2.1 `count`
Creates multiple instances of a resource:
```hcl
resource "aws_instance" "example" {
  count = 3
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

### 2.2 `for_each`
Works with maps and sets:
```hcl
variable "instances" {
  type = set(string)
  default = ["app1", "app2"]
}

resource "aws_instance" "example" {
  for_each = var.instances
  ami      = "ami-123456"
  instance_type = "t2.micro"
  tags = {
    Name = each.key
  }
}
```

### 2.3 `depends_on`
Ensures a resource is created after another:
```hcl
resource "aws_instance" "example" {
  depends_on = [aws_security_group.example]
}
```

---
## 3. Dynamic Blocks
Used when a resource requires repeating nested blocks.
```hcl
variable "security_rules" {
  type = map(object({
    priority = number
    port     = number
  }))
}

dynamic "security_rule" {
  for_each = var.security_rules
  content {
    name     = security_rule.key
    priority = security_rule.value.priority
    direction = "Inbound"
    port     = security_rule.value.port
  }
}
```

---
## 4. Conditional Expressions
Used to set values based on conditions.
```hcl
variable "environment" {
  type = string
}

resource "aws_s3_bucket" "example" {
  bucket = var.environment == "prod" ? "prod-bucket" : "dev-bucket"
}
```

---
## 5. Splat Expressions
Used to extract values from a list of objects.
```hcl
output "instance_ids" {
  value = aws_instance.example[*].id
}
```
This extracts all instance IDs from a list.

---
## Conclusion
- **Use `count` for lists and `for_each` for maps/sets**.
- **Apply `depends_on` for dependencies**.
- **Leverage `dynamic` blocks for nested structures**.
- **Use `splat` expressions for extracting values**.
- **Apply validation rules for constraints**.

This guide provides a structured understanding of Terraform's core functionalities.

s