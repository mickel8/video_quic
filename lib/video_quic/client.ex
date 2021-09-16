defmodule VideoQUIC.Client do
  use Membrane.Pipeline

  @impl true
  def handle_init(_opts) do
    spec = %ParentSpec{
      children: %{
        :video_src => %Membrane.QUIC.Source{
          ip_address: '127.0.0.1',
          port_number: 7878
        },
        rtp: %Membrane.RTP.SessionBin{secure?: false}
      },
      links: [link(:video_src) |> via_out(:dgram_output) |> via_in(:rtp_input) |> to(:rtp)]
    }

    {{:ok, spec: spec}, %{}}
  end

  @impl true
  def handle_notification({:new_rtp_stream, video_ssrc, 96}, :rtp, _ctx, state) do
    spec = %ParentSpec{
      children: %{
        video_parser: %Membrane.H264.FFmpeg.Parser{framerate: {30, 1}},
        video_decoder: Membrane.H264.FFmpeg.Decoder,
        video_player: Membrane.SDL.Player
      },
      links: [
        link(:rtp)
        |> via_out(Pad.ref(:output, video_ssrc))
        |> to(:video_parser)
        |> to(:video_decoder)
        |> to(:video_player)
      ]
    }

    {{:ok, spec: spec}, state}
  end
end
