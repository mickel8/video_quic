defmodule VideoQUIC.Client do
  use Membrane.Pipeline

  @impl true
  def handle_init(_opts) do
    spec = %ParentSpec{
      children: %{
        :file => %Membrane.File.Sink{
          location: "./recv"
        },
        :source => %Membrane.QUIC.Source{
          ip_address: '127.0.0.1',
          port_number: 7878
        }
      },
      links: [link(:source) |> to(:file)]
    }

    {{:ok, spec: spec}, %{}}
  end
end
