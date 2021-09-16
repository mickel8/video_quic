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
      {:membrane_rtp_plugin, "~> 0.7.1-alpha.2"},
      {:membrane_h264_ffmpeg_plugin, "~> 0.11.0"},
      {:membrane_sdl_plugin, "~> 0.8.0"},
      {:membrane_realtimer_plugin, "~> 0.2.0"},
      #{:membrane_rtp_h264_plugin, "~> 0.5.1"},
      {:membrane_rtp_h264_plugin, path: "../membrane_rtp_h264_plugin"},
      {:membrane_file_plugin, "~> 0.6.0"},
      {:ex_libsrtp, "~> 0.2.0"},
      {:membrane_quic_plugin, path: "../membrane_quic_plugin"}
    ]
  end
end
