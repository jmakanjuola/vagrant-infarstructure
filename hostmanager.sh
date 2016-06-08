
vagrant plugin list | grep -qF 'vagrant-hostmanager'
if [ $? -ne 0 ]; then
	vagrant plugin install --plugin-version 1.5.0 vagrant-hostmanager
fi

vagrant plugin list | grep -qF 'vagrant-hostmanager (1.5.0)'
if [ $? -ne 0 ]; then
	echo 'Version of vagrant-hostmanager must be 1.5.0 for this script!'
	exit 1
fi

tempd=`mktemp -d`
cd $tempd && git clone https://github.com/purpleidea/vagrant-hostmanager
if [ ! -d 'vagrant-hostmanager' ]; then
	echo 'Problem cloning vagrant-hostmanager!'
	exit 1
fi

cd vagrant-hostmanager/
git checkout feat/oh-my-vagrant || (
	echo 'Problem finding branch!'
	exit 1
)

if [ -e ~/.vagrant.d/gems/gems/vagrant-hostmanager-1.5.0/ ]; then
	rsync -av --delete . ~/.vagrant.d/gems/gems/vagrant-hostmanager-1.5.0/
else
	echo 'Problem copying code!'
	exit 1
fi

echo 'Patched successfully!'
