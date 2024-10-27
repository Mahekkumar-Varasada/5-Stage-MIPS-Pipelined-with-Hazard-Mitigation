# 5-Stage-MIPS-Pipelined-with-Hazard-Mitigation
Pipelining, is a powerful way to improve the throughput of a digital system. We design a pipelined
processor by subdividing the single-cycle processor into five pipeline stages. Thus, five instructions
can execute simultaneously, one in each stage. Because each stage has only one-fifth of the entire
logic, the clock frequency is almost five times faster. Hence, the latency of each instruction is ideally
unchanged, but the throughput is ideally five times better.

![pipeline abstract view](https://github.com/user-attachments/assets/8cb808c5-60fa-43bb-aec4-2c3d7e5417e2)

*Image taken from Digital Design and Computer Architecture by David Harris & Sarah Harris

Pipelining comes with hazards that designers must manage to achieve improved performance in pipelined architecture.

   1) Data Hazards: These occur when an instruction depends on the data results of a previous instruction that hasn’t yet completed its pipeline stage. For example, if an instruction requires a register value that a previous 
   instruction is in the process of writing, it may need to wait or implement techniques such as forwarding or stalling to resolve this dependency.

   2) Control Hazards: These occur when the pipeline must make decisions based on conditional branches or jumps. When a branch instruction is encountered, the pipeline may not know which instruction to execute next until the 
   branch condition is resolved. Techniques such as branch prediction, delayed branching, and speculative execution are often used to handle control hazards effectively.

Managing these hazards is essential to maintaining the efficiency of a pipelined processor and ensuring it delivers improved performance.

Below is the Proposed Architecture for MIPS Pipelined Architecture which takes care of both Data and Control Hazards.

![image](https://github.com/user-attachments/assets/f0f8e145-3dc2-4786-bbfa-0a76ff46a9af)

*Image taken from Digital Design and Computer Architecture by David Harris & Sarah Harris

Below are the instructions Our Mips can Currenlty Execute 

![image](https://github.com/user-attachments/assets/5582d771-916e-4f30-b26a-cc177bd3da3b)


Below is the sample Test Code used for 5 stage Pipelined MIPS Processor.

![image](https://github.com/user-attachments/assets/a49212dc-205f-402d-9e42-0a073bda32d9)

Simulation Results :- 

![new_simulation](https://github.com/user-attachments/assets/025bd460-9bca-4750-9948-44e8ea7bf1a2)


Continuosly Bringing Improvements in Code-Base 

Thank you 




