from pynumaflow.mapper import MapServer, Mapper, Messages, Message, Datum

class MyMapper(Mapper):
    def __init__(self) -> None:
        self.count: int = 0
        super().__init__()

    def handler(self, keys: list[str], datum: Datum) -> Messages:
        messages = Messages()
        if self.count % 5 == 0:
            messages.append(Message(keys=[], value=f"count={self.count}".encode()))
        else:
            messages.append(Message.to_drop())
        print(f"handler: count={self.count}, output={messages}, input={datum}")
        self.count += 1
        return messages

if __name__ == "__main__":
    grpc_server = MapServer(mapper_instance=MyMapper())
    grpc_server.start()
