defmodule Mix.Tasks.Compile.Exprotoc do
  use Mix.Task

  def run(_) do
    { :ok, cwd } = File.cwd
    target = Path.join cwd, "lib"
    File.mkdir_p target
    { :ok, proto_files } = Keyword.fetch Mix.project, :proto_files
    { :ok, proto_path } = get_path
    Enum.each proto_files, &Exprotoc.compile(&1, target, proto_path)
  end

  defp get_path do
    path = Keyword.fetch Mix.project, :proto_path
    if path == :error do
      { :ok, [] }
    else
      path
    end
  end
end