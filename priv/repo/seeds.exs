alias Pastex.{Repo, Content, Identity}

users = [
  %Identity.User{
    name: "Ben Wilson",
    email: "ben@localhost.com",
    password: "abc123"
  },
  %Identity.User{
    name: "Rich Kilmer",
    email: "rich@localhost.com",
    password: "abc123"
  }
]

[user1, user2] = Enum.map(users, &Repo.insert!/1)

pastes = [
  %Content.Paste{
    name: "Hello World"
  },
  %Content.Paste{
    name: "Help!",
    description: "I don't know what I'm doing!"
  }
]

[past1, past2] =
  for paste <- pastes do
    Repo.insert!(paste)
  end

files = [
  %Content.File{
    paste_id: past1.id,
    body: ~s[IO.puts("Hello World")]
  },
  %Content.File{
    paste_id: past2.id,
    name: "foo.ex",
    body: """
    defmodule Foo do
      def foo, do: Bar.bar
    end
    """
  },
  %Content.File{
    paste_id: past2.id,
    name: "bar.ex",
    body: """
    defmodule Bar do
      def bar, do: Foo.foo
    end
    """
  }
]

for file <- files do
  Repo.insert!(file)
end
