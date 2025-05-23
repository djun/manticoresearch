if (__cmake_banner_included)
	return ()
endif ()
set ( __cmake_banner_included YES )

add_library ( BANNER INTERFACE )

macro ( getbanner OUTVAR )
	get_target_property ( ${OUTVAR} BANNER MESSAGES )
endmacro ()

# append any text to build info
function ( bannervar msgtext )
	set_property ( TARGET BANNER APPEND PROPERTY MESSAGES "${msgtext}" )
#	printbanner ()
endfunction ()

function ( printbanner )
	getbanner ( foo )
	if (foo)
		message ( STATUS "BANNER is ${foo}" )
	endif ()
endfunction ()

function ( get_banner OUTVAR )
	set ( CONFIGURE_FLAGS "Configured with these definitions:" )
	get_target_property ( BANNER BANNER MESSAGES )
	foreach (var ${BANNER})
		unset ( CONFIGURE_FLAG )
		if (DEFINED CACHE{${var}})
			get_property ( _type CACHE ${var} PROPERTY TYPE )
			if (_type STREQUAL BOOL)
				if (${${var}})
					set ( CONFIGURE_FLAG "${var}=1" )
				else ()
					set ( CONFIGURE_FLAG "${var}=0" )
				endif ()
			else ()
				set ( CONFIGURE_FLAG "${var}=${${var}}" )
			endif ()
		elseif (DEFINED ${var})
			set ( CONFIGURE_FLAG "${var}=${${var}}" )
			#		message(SEND_ERROR "Only cache variables are suitable for bannervar! ${var}")
		endif ()
		if (DEFINED CONFIGURE_FLAG)
			set ( CONFIGURE_FLAGS "${CONFIGURE_FLAGS} -D${CONFIGURE_FLAG}" )
		endif()
	endforeach ()
	set ( ${OUTVAR} "${CONFIGURE_FLAGS}" PARENT_SCOPE )
endfunction ()

include ( printers )
function ( banner_diag )
	get_banner ( foo )
	diags ( ${foo} )
endfunction ()
