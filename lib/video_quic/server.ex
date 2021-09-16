defmodule VideoQUIC.Server do
  use Membrane.Pipeline

  @video_ssrc 1234

  @impl true
  def handle_init(_opts) do
    spec = %ParentSpec{
      children: %{
        :video_src => %Membrane.File.Source{
          location: "./ffmpeg-testsrc.h264"
        },
        :video_parser => %Membrane.H264.FFmpeg.Parser{framerate: {30, 1}, alignment: :nal},
        :rtp => %Membrane.RTP.SessionBin{secure?: false},
        :video_realtimer => Membrane.Realtimer,
        :video_sink => %Membrane.QUIC.Sink{
          ip_address: {127, 0, 0, 1},
          port_number: 7878,
          cert_path: './cert.pem',
          key_path: './key.pem',
          alpn: ['sample']
        }
      },
      links: [
        link(:video_src)
        |> to(:video_parser)
        |> via_in(Pad.ref(:input, @video_ssrc))
        |> to(:rtp)
        |> via_out(Pad.ref(:rtp_output, @video_ssrc), options: [encoding: :H264])
        |> to(:video_realtimer)
        |> via_in(:dgram_input)
        |> to(:video_sink)
      ]
    }

    {{:ok, spec: spec}, %{}}
  end
end
