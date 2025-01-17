require "./router"

class OPDSRouter < Router
  def initialize
    get "/opds" do |env|
      titles = @context.library.titles
      render_xml "src/views/opds/index.xml.ecr"
    end

    get "/opds/book/:title_id" do |env|
      begin
        title = @context.library.get_title(env.params.url["title_id"]).not_nil!
        render_xml "src/views/opds/title.xml.ecr"
      rescue e
        @context.error e
        env.response.status_code = 404
      end
    end
  end
end
