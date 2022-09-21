# Chess-Machine
We implemented a chess playing robot that uses an XY plotter machine for manipulating the pieces, webcam for a view of the chessboard and the <a href="https://stockfishchess.org/download/">Stockfish</a> chess engine for calculating moves by the machine. This robot can play chess with a human player.

Demonstration video:
https://youtu.be/TBJXJzK3z6o

[<img src="https://i.ytimg.com/vi/TBJXJzK3z6o/maxresdefault.jpg" width="50%">](https://www.youtube.com/watch?v=TBJXJzK3z6o "Now in Android: 55")


## Contents
- [Materials Used](#materials-used)
- [Working Procedure](#working-procedure)
- [Hardware Setup](#hardware-setup)
- [Discussion](#discussion)
- [Team](#team)

## Materials Used
Here is a list of materials used for building the chess machine
- PVC board as the base material
- Art papers for coloring the board
- Nylon rods of 1cm diameter as the guide rails
- Linear bearings for sliding alond the rails
- Stepper motors and belts
- A 9g servo motor
- A tiny magnet for holding chess pieces
- IRF540 MOSFETs for stepper motor driver
- A cheap computer PSU
- Arduino UNO for controlling stepper motors
- Lots of wires
- Webcam
- Computer


## Working Procedure
The chess machine has an image based input, a chess engine that works in tandem with MATLAB as the processing unit, and the physical XY plotter that acts as the ouput.

### Detection of Chess Pieces 

<figure align="center">
    <img src="Sample Game Frames/image (1).jpg" alt="drawing" width="400"/>
    <figcaption>Board View</figcaption>
</figure>

### Interpreting Board Configuration

### Generating Moves

### Motor Driver

### Moving the Pieces


## Hardware Setup

A video demonstration of the internals of the XY plotter. https://youtube.com/shorts/JwAQECdfFwo

[<img src="https://i.ytimg.com/vi/JwAQECdfFwo/maxresdefault.jpg" width="50%">](https://www.youtube.com/watch?v=JwAQECdfFwo "Now in Android: 55")

<!-- 
<figure align="center">
    <img src="screenshots/hardware/screw.jpg" alt="drawing" width="400"/>
    <figcaption>Each key has a screw through it, and a wire connects each screw to veroboard 1 (veroboard 1 pulls down all the inputs to ground)</figcaption>
</figure>
-->

## Discussion

There are a few shortcomings of the project:
- We have used very cheap materials for the physical hardware. The stepper motors and the belts were especially bad. The board was also malleable, and tended to bend around the center region. The guide-rails were nylon rods, also bendy. No complaints about electrical hardware, just the mechanical part could have been way much better. We stuck to cheap materials because they could be easily modified by hand without needing heavy machinery.
- For the image processing part, we made the board red-blue to easily identify the chess pieces on the board. Normally chess boards are black and white. At that time we didn't have much idea about machine learning or deep learning techniques. Chess pieces on a black and white board can be easily detected using object detection algorithms. Pieces also can be individually identified. Machine learning would also allow the processing to be more robust and environment independent.
- Could have used a dedicated servo motor driver.
- Could have implemented the system using a Raspberry Pi instead of a clunky laptop.

Things that would be cool to implement:
- Training an AI using reinforcement learning to play chess with people
- Remotely playing chess with other human players using the chess machine. (without needing to stare at a computer screen!)

## Team

- Mir Sayeed Mohammad (EEE) (github - https://github.com/ClockWorkKid)
- Shafin Bin Hamid (EEE) (github - https://github.com/shafinbinhamid)
- Himaddri Roy (EEE) (github - https://github.com/himu587)
- Md. Asif Iqbal (EEE)
