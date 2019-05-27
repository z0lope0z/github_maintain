data "external" "github_script" {
  program = ["python", "${path.module}/github.py"]
}

module "github_teams" {
  source = "modules/github_teams"

  teams               = "${local.teams}"
  github_token        = "${var.github_token}"
  github_organization = "${var.github_organization}"
}

provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}

locals {
  teams       = "${split(",", lookup(data.external.github_script.result, "teams"))}"
  users       = "${split(",", lookup(data.external.github_script.result, "users"))}"
  memberships = "${split(",", lookup(data.external.github_script.result, "memberships"))}"

  team_ids = "${module.github_teams.team_ids}"

  team_names = "${module.github_teams.team_names}"

  team_mapping = "${zipmap(local.team_names, local.team_ids)}"
}

resource "github_team_membership" "some_team_membership" {
  count = "${length(local.memberships)}"

  team_id = "${lookup(local.team_mapping, element(split("_", local.memberships[count.index]), 0))}"
  username = "${element(split("_", local.memberships[count.index]), 1)}"
  role     = "${element(split("_", local.memberships[count.index]), 2)}"
}
