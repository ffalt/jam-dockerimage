/*
	Add Admin user and media folders on first start
 */
module.exports = {
	/*
		Default Admin user
	*/
	adminUser: {
		name: 'admin',
		pass: 'admin'
	},
	/*
		Default Media folders
	 */
	roots: [
		{name: 'Music', path: '/usr/share/media/music'},
		{name: 'Compilations', path: '/usr/share/media/compilations'},
		{name: 'Audiobooks', path: '/usr/share/media/audiobooks'},
		{name: 'Soundtracks', path: '/usr/share/media/soundtrack'}
	]
};
