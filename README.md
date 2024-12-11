## GGM/MGET
Repository for the Multi-gas model for the Energy Transition (MGET), a modified version of the GGM-Model

## Purpose of the Model

The Multi-Gas Energy Transition (MGET) model, also referred to as the Multi-Gas Network (MGNET) model, is designed to optimize transport capacities for various gases (natural gas, hydrogen, and carbon dioxide) within a European network. Its purpose is to repurpose and expand existing infrastructure to accommodate these gases, minimizing investment and operational costs for the period 2020–2050, with five-year steps and representative hours. The model supports iDesignRES by providing insights into cost-efficient network designs, while considering possible future extensions, such as prioritization of hydrogen or large-scale electrolysis. Future applications may focus on refining storage optimization and integrating carbon capture, transport, and storage (CCTS).

## Model Design Philosophy

The MGET model employs a Mixed Integer Linear Programming (MILP) approach, ensuring cost-efficient transport and repurposing of gas networks. It simulates a European central planner (TSO) deciding on new pipelines, repurposing existing pipelines for other gases, and converting unidirectional pipelines to bidirectional. Costs are assumed to be linear for transportation, investment, and repurposing. Seasonal storage capacities and temporal resolutions (representative hours) are integrated to capture intra-annual variations.

The model is prototyped in GAMS and will transition to R for open-source accessibility, potentially using R Shiny for the user interface. Flexibility in time and spatial resolution ensures adaptability, with initial implementation at the NUTS2 regional level across Europe.

## Input to and Output from the Model

### Input

| **Data Category**         | **Sources**                          | **Comment**                          |
|---------------------------|---------------------------------------|---------------------------------------|
| Existing and planned capacities | Internal: GGM existing natural gas database <br> External: ENTSO-G and others | New: H2 & CO2.                      |
| Investment costs          | Internal: Assembly, GeneSys, GGM <br> External: various sources              | GGM data needs to be aligned.        |
| Repurposing costs         | Internal: Assembly, or GeneSys <br> External: various sources (NTNU, DIW, Finland) | New                                  |
| Operational costs & efficiencies | Internal: Assembly, GeneSys, TIMES <br> External: various sources (NTNU, Finland) | GGM data needs to be aligned.       |

### Output

- Investment and repurposing decisions, and related costs.
- Gas-specific network capacities, for every fifth year.
- Gas-specific network flows, for representative hours, every fifth year, and related costs.
- If production, consumption, exports, imports, and storage interaction are in a range rather than fixed, these will be outputs too.

## Implemented Features

MGET includes several configurable features, specifically in connection with iDesignRES:

- **CCTS Integration**: Possible application, depending on scalability.
- **Hydrogen/Electrolysis Prioritization**: Incorporates supply-demand limits and cost-optimal network configurations.
- **Storage Optimization**: Enabled but can affect numerical tractability.
- **Elastic Demand**: Possible but not implemented in iDesignRES to maintain MILP solvability.
- **Decarbonization of Harbors/Shipping**: Feasibility under consideration.

## Core Assumptions

- Linear cost assumptions for transport, investment, and repurposing.
- Dedicated pipelines for each gas type (natural gas, hydrogen, carbon dioxide).
- Storage modeled as supply/demand nodes with hourly injection/extraction limits.
- Fixed temporal resolution (representative hours per year) and spatial granularity (NUTS2).
- Centralized decision-making for a European-wide cost-minimizing TSO.
- Implicit assumptions include linear optimization, scalability of network expansions, and neglect of quadratic effects from elastic demand to preserve MILP formulation.

## Repository

- [Model Hub Repository](https://www.ntnu.edu/iot/energy/energy-models-hub/ggm)
- GitHub repository: To be announced
