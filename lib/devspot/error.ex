defmodule Devspot.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_user_not_found_error, do: build(:not_found, "User not found")
  def build_experience_not_found_error, do: build(:not_found, "Experience not found")
  def build_certificate_not_found_error, do: build(:not_found, "Certificate not found")
  def build_article_not_found_error, do: build(:not_found, "Article not found")
  def build_project_not_found_error, do: build(:not_found, "Project not found")
end
