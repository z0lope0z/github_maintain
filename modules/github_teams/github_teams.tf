data "external" "github_team_script" {
  program = ["python", "${path.module}/../../github.py"]
}

resource "github_team" "githubteams" {
  count = "${length(var.teams)}"

  name        = "${var.teams[count.index]}"
  description = "This is a created team"
}

output "team_ids" {
  value = "${github_team.githubteams.*.id}"
}

output "team_names" {
  value = "${github_team.githubteams.*.name}"
}
