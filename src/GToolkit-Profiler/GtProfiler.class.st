Class {
	#name : #GtProfiler,
	#superclass : #BrPager,
	#instVars : [
		'openedSpaces',
		'framesChart',
		'layersGraph'
	],
	#category : 'GToolkit-Profiler'
}

{ #category : #'instance creation' }
GtProfiler class >> open [
	<script: 'self open'>
	
	(GtPager
		openWrappedOn: self new
		title: 'Profiler') maximized
]

{ #category : #initialization }
GtProfiler >> initialize [
	super initialize.
		
	self matchParent.
	self aptitude: BrProportionalHorizontalPagerAptitude new.
	
	openedSpaces := GtProfilerSpacesElement new.
	framesChart := GtProfilerPerformanceChart new.
	layersGraph := GtProfilerCompositionLayers new.

	self addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 0.4 ];
		addChild: openedSpaces).

	self addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: (BrTabGroup new
			aptitude: BrGlamorousTabGroupAptitude new;
			addTab: (BrTab new
				label: 'Performance';
				stencil: [ framesChart ];
				aptitude: BrGlamorousTabAptitude new);
			addTab: (BrTab new
				label: 'Layers';
				stencil: [ layersGraph ];
				aptitude: BrGlamorousTabAptitude new)
		)).
	
	self
		when: GtPhlowObjectToSpawn
		do: [ :anEvent |
			(anEvent object isKindOf: GtProfilerSpace)
				ifTrue: [
					anEvent consumed: true.
					framesChart profileSpace: anEvent object.
					layersGraph profileSpace: anEvent object ] ].
	
	self
		when: GtPhlowObjectToSelect
		do: [ :anEvent |
			(anEvent object isKindOf: GtProfilerSpace)
				ifTrue: [
					anEvent consumed: true.
					framesChart profileSpace: anEvent object.
					layersGraph profileSpace: anEvent object ] ]
]
