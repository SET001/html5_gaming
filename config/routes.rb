Scheduler::Application.routes.draw do
  root 'application#index'
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
