defmodule VideoQuic.MixProject do
  use Mix.Project

  def project do
    [
      app: :video_quic,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:membrane_core, "~> 0.7.0"},
      {:membrane_file_plugin, "~> 0.6.0"},
      {:membrane_quic_plugin, path: "../membrane_quic_plugin"}
    ]
  end
end
