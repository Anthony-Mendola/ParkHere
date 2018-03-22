class TypesController < ApplicationController

    def show
        @types = Listing.by_types(Type.find(params[:id]).name)
        binding.pry
        render :'listings/index'
    end

end
