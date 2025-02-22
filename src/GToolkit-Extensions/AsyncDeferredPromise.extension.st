Extension { #name : #AsyncDeferredPromise }

{ #category : #'*GToolkit-Extensions' }
AsyncDeferredPromise >> gtChainedPromises [
	"Return a collection of promises that are next in the chain after this one"
	<return: #Collection of: #TAsyncPromise>

	^ mutex critical: [ chainedPromises copy ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncDeferredPromise >> gtCompositionChildren [
	^ #( )
]

{ #category : #'*GToolkit-Extensions' }
AsyncDeferredPromise >> gtCompositionDescription [
	^ self printString
]
