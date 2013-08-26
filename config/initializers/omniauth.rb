OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "M0lBt0rNwUwdBzDCuFNSA", "VekLBWLgmsxtL2b1i1HdObjSHpJ2REMJheck8YBTBI"
end