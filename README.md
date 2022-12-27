# 42 Philosophers Tester

#### Tester for the Dininig Philosophers Problem project at 42 Schools

## Installation
Clone the repo into your philosophers folder.
```bash
git clone https://github.com/dantonik/42-philosophers-tester.git
```

You must have the following file structure:
```
├─ philo/
│  ├─ *.*
│  ├─ 42-philosophers-tester/
│  │  ├─test.sh
```

## Usage
Run ./test.sh when inside the repo's directory.
```bash
cd 42-philosophers-tester
./test.sh
```
### Usage optional
You can add the path to your philo executable as an argument if your folder structure looks differently.
```bash
./test.sh /path/to/philo
```
[-i iterations]
```bash
./test.sh -i 10
```
[-t times_to_eat]
```bash
./test.sh -t 10
```

### Failed tests
The output of your failed test(s) get saved in the 'fails' folder for further inspection.

### Screenshots

![Start](img/start.png?raw=true "Start")

![Example](img/example.png?raw=true "Example")

### Valgrind
A simple docker Valgrind setup.
```bash
cd docker
./build.sh
./run.sh
```

### Visualizer
Experimental integration with a [Philosophers Visualizer](https://nafuka11.github.io/philosophers-visualizer/).

### Why
Because the [Lazy Philosophers Tester](https://github.com/MichelleJiam/LazyPhilosophersTester) is a bit tedious and only semiautomatic.

### Ressources
[Introduction to Parallel Computing](https://web.archive.org/web/20201109032323/https://computing.llnl.gov/tutorials/parallel_comp/?)

[POSIX Threads Programming](https://web.archive.org/web/20210306083711/https://computing.llnl.gov/tutorials/pthreads/)

### Future ideas
- Leak checking
- Visualizer
- Data race checking
- Death lock checking
- Wiki How-To Philo