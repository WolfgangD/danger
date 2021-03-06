module Danger
  describe DangerfileGitHubPlugin, host: :github do
    describe "dsl" do
      before do
        dm = testing_dangerfile
        @dsl = DangerfileGitHubPlugin.new dm
        pr_response = JSON.parse(fixture("github_api/pr_response"), symbolize_names: true)
        allow(@dsl).to receive(:pr_json).and_return(pr_response)
      end

      describe "html_link" do
        it "works with a single path" do
          link = @dsl.html_link("file.txt")
          expect(link).to eq("<a href='https://github.com/artsy/eigen/blob/561827e46167077b5e53515b4b7349b8ae04610b/file.txt'>file.txt</a>")
        end

        it "can show just a path" do
          link = @dsl.html_link("/path/file.txt", full_path: false)
          expect(link).to eq("<a href='https://github.com/artsy/eigen/blob/561827e46167077b5e53515b4b7349b8ae04610b/path/file.txt'>file.txt</a>")
        end

        it "works with 2 paths" do
          link = @dsl.html_link(["file.txt", "example.json"])
          expect(link).to eq("<a href='https://github.com/artsy/eigen/blob/561827e46167077b5e53515b4b7349b8ae04610b/file.txt'>file.txt</a> & " \
                             "<a href='https://github.com/artsy/eigen/blob/561827e46167077b5e53515b4b7349b8ae04610b/example.json'>example.json</a>")
        end

        it "works with 3+ paths" do
          link = @dsl.html_link(["file.txt", "example.json", "script.rb#L30"])
          expect(link).to eq("<a href='https://github.com/artsy/eigen/blob/561827e46167077b5e53515b4b7349b8ae04610b/file.txt'>file.txt</a>, " \
                             "<a href='https://github.com/artsy/eigen/blob/561827e46167077b5e53515b4b7349b8ae04610b/example.json'>example.json</a> & " \
                             "<a href='https://github.com/artsy/eigen/blob/561827e46167077b5e53515b4b7349b8ae04610b/script.rb#L30'>script.rb#L30</a>")
        end
      end
    end
  end
end
