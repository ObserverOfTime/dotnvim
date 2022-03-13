" Vim syntax file for JAR/OSGi Manifest files
" Maintainer: Alex Blewitt <alex.blewitt@gmail.com>
" License:    This file is placed in the public domain
" URL:        http://github.com/alblue/vim-manifest.git


" We capture the hyphenated names and trailing colon for ease of use
setlocal iskeyword+=-
setlocal iskeyword+=:

setlocal foldmethod=expr
setlocal foldexpr=getline(v:lnum)[0]==\"#\"

" Lines over 72 characters are erroneous
syntax match manifestError "..........................................................................*"

" Standard Java values
syntax match manifestComment "#.*"

syntax keyword manifestJava Class-Path:
syntax keyword manifestJava Created-By:
syntax keyword manifestJava Implementation-Title:
syntax keyword manifestJava Implementation-Vendor:
syntax keyword manifestJava Implementation-Version:
syntax keyword manifestJava MD5-Digest: 
syntax keyword manifestJava Main-Class:
syntax keyword manifestJava Manifest-Version:
syntax keyword manifestJava Name: 
syntax keyword manifestJava SHA-Digest:
syntax keyword manifestJava Sealed:
syntax keyword manifestJava Specification-Title:
syntax keyword manifestJava Specification-Vendor:
syntax keyword manifestJava Specification-Version:

syntax match   manifestJavaPackage "\(\a\+\.\)\+\a\+"

highlight link manifestJava manifestHeader
highlight link manifestJavaPackage Type
highlight link manifestComment Comment

" OSGi support
"
" This can be disabled with manifest_osgi_disable=1

if !exists("manifest_disable_osgi") || !manifest_disable_osgi

"B-ap is only for 4.2+
syntax keyword manifestOSGi Bundle-ActivationPolicy:
syntax keyword manifestOSGi Bundle-Activator:
syntax keyword manifestOSGi Bundle-Category:
syntax keyword manifestOSGi Bundle-ClassPath:
syntax keyword manifestOSGi Bundle-ContactAddress:
syntax keyword manifestOSGi Bundle-Copyright:
syntax keyword manifestOSGi Bundle-Description:
syntax keyword manifestOSGi Bundle-DocURL:
" Pretty sure B-i was 4.2+
syntax keyword manifestOSGi Bundle-Icon:
syntax keyword manifestOSGi Bundle-License:
syntax keyword manifestOSGi Bundle-Localization:
syntax keyword manifestOSGi Bundle-ManifestVersion:
syntax keyword manifestOSGi Bundle-Name:
syntax keyword manifestOSGi Bundle-NativeCode:
syntax keyword manifestOSGi Bundle-RequiredExecutionEnvironment:
syntax keyword manifestOSGi Bundle-SymbolicName:
syntax keyword manifestOSGi Bundle-UpdateLocation:
syntax keyword manifestOSGi Bundle-Vendor:
syntax keyword manifestOSGi Bundle-Version:

syntax keyword manifestOSGi DynamicImport-Package:
syntax keyword manifestOSGi Export-Package:
syntax keyword manifestOSGi Export-Service:
syntax keyword manifestOSGi Fragment-Host:
syntax keyword manifestOSGi Import-Package:
syntax keyword manifestOSGi Require-Bundle:

" Declarative services support
syntax keyword manifestOSGi Service-Component:

" Would be good to have a generic syntax for these
syntax match manifestOSGi "version="
syntax match manifestOSGi "bundle-version="
syntax match manifestOSGi "uses:="
syntax match manifestOSGi "size="
syntax match manifestOSGi "exclude:="
syntax match manifestOSGiNativeCode "osversion="
syntax match manifestOSGiNativeCode "processor="
syntax match manifestOSGiNativeCode "osname="
syntax match manifestOSGiNativeCode "selection-filter="
syntax match manifestOSGiNativeCode "language="

" Values for the Execution Environment
syntax match manifestOSGi "CDC-1.1/Foundation-1.1"
syntax match manifestOSGi "CDC-1.1/PersonalBasis-1.1"
syntax match manifestOSGi "CDC-1.1/PersonalJava-1.1"
syntax match manifestOSGi "OSGi/Minimum-1.2"
syntax match manifestOSGi "J2SE-1.2"
syntax match manifestOSGi "J2SE-1.3"
syntax match manifestOSGi "J2SE-1.4"
syntax match manifestOSGi "J2SE-1.5"
syntax match manifestOSGi "JavaSE-1.6"

syntax match   manifestError   "\d\+\.\d\+\(\.[-a-zA-Z0-9_]\+\)\+"
syntax match   manifestOSGiVersion "\d\+\.\d\+\(\.\d\+\)\?\(\.[a-zA-Z][-a-zA-Z0-9_]*\)\?\(\.\)\@!"

highlight link manifestOSGi manifestHeader
highlight link manifestOSGiVersion manifestHeader
highlight link manifestOSGiNativeCode manifestHeader

endif " manifest_disable_osgi

if !exists("manifest_disable_whitespace") || !manifest_disable_whitespace

syntax match manifestWhitespace /\s\+$/
syntax match manifestWhitespace /^\s\s/

highlight link manifestWhitespace manifestError

endif " manifest_disable_whitespace

highlight link manifestHeader Tag
highlight link manifestError  Error

