defmodule VideoQUIC.Server do
  use Membrane.Pipeline

  @impl true
  def handle_init(_opts) do
    spec = %ParentSpec{
      children: %{
        :sink => %Membrane.QUIC.Sink{
          ip_address: {127, 0, 0, 1},
          port_number: 7878,
          cert_path: './cert.pem',
          key_path: './key.pem',
          alpn: ['sample']
        },
        :file => %Membrane.File.Source{
          location: "./example"
        }
      },
      links: [link(:file) |> to(:sink)]
    }

    {{:ok, spec: spec}, %{}}
  end
end
