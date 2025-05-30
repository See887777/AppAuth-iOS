Pod::Spec.new do |s|

  s.name         = "AppAuth"
  s.version      = "2.0.0"
  s.summary      = "AppAuth for iOS and macOS is a client SDK for communicating with OAuth 2.0 and OpenID Connect providers."

  s.description  = <<-DESC

AppAuth for iOS and macOS is a client SDK for communicating with [OAuth 2.0]
(https://tools.ietf.org/html/rfc6749) and [OpenID Connect]
(http://openid.net/specs/openid-connect-core-1_0.html) providers. It strives to
directly map the requests and responses of those specifications, while following
the idiomatic style of the implementation language. In addition to mapping the
raw protocol flows, convenience methods are available to assist with common
tasks like performing an action with fresh tokens.

It follows the OAuth 2.0 for Native Apps best current practice
([RFC 8252](https://tools.ietf.org/html/rfc8252)).

                   DESC

  s.homepage     = "https://openid.github.io/AppAuth-iOS"
  s.license      = "Apache License, Version 2.0"
  s.authors      = { "William Denniss" => "wdenniss@google.com",
                     "Steven E Wright" => "stevewright@google.com",
                     "Julien Bodet" => "julien.bodet92@gmail.com"
                   }

  # Note: While watchOS and tvOS are specified here, only iOS and macOS have
  #       UI implementations of the authorization service. You can use the
  #       classes of AppAuth with tokens on watchOS and tvOS, but currently the
  #       library won't help you obtain authorization grants on those platforms.

  ios_deployment_target = "12.0"
  osx_deployment_target = "10.12"
  s.ios.deployment_target = ios_deployment_target
  s.osx.deployment_target = osx_deployment_target
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/openid/AppAuth-iOS.git", :tag => s.version }
  s.requires_arc = true

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
  }

  # Subspec for the core AppAuth library classes only, suitable for extensions.
  s.subspec 'Core' do |core|
     core.source_files = "Sources/AppAuthCore.h", "Sources/AppAuthCore/*.{h,m}"
     core.resource_bundles = {
       "AppAuthCore_Privacy" => ["Sources/AppAuthCore/Resources/PrivacyInfo.xcprivacy"]
     }
  end

  # Subspec for the full AppAuth library, including platform-dependent external user agents.
  s.subspec 'ExternalUserAgent' do |externalUserAgent|
    externalUserAgent.dependency 'AppAuth/Core'
    
    externalUserAgent.source_files = "Sources/AppAuth.h", "Sources/AppAuth/*.{h,m}"
    
    # iOS
    externalUserAgent.ios.source_files      = "Sources/AppAuth/iOS/**/*.{h,m}"
    externalUserAgent.ios.deployment_target = ios_deployment_target
    externalUserAgent.ios.frameworks        = "SafariServices"
    externalUserAgent.ios.weak_frameworks   = "AuthenticationServices"

    # macOS
    externalUserAgent.osx.source_files      = "Sources/AppAuth/macOS/**/*.{h,m}"
    externalUserAgent.osx.deployment_target = osx_deployment_target
    externalUserAgent.osx.weak_frameworks   = "AuthenticationServices"
  end
  
  # Subspec for the full AppAuth library, including platform-dependent external user agents.
  s.subspec 'TV' do |tv|
    tv.source_files = "Sources/AppAuthTV.h", "Sources/AppAuthTV/*.{h,m}"
    tv.dependency 'AppAuth/Core'
  end

  s.default_subspecs = 'Core', 'ExternalUserAgent'
end
