{:ok, pid} = VideoQUIC.Server.start_link()
VideoQUIC.Server.play(pid)
