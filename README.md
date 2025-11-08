# Multi-Modal Glacier Analysis: Gangotri Glacier, Himalayas

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)
[![Earth Engine](https://img.shields.io/badge/Google-Earth_Engine-green.svg)](https://earthengine.google.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Multi-modal remote sensing analysis of Gangotri Glacier using DEM, SAR, Optical, and Thermal imagery**

> **Location**: Gangotri Glacier (30.92°N, 79.08°E), Uttarakhand Himalayas, India  
> **Study Period**: 2000-2023  
> **Buffer Zone**: 10-15km radius

---

## Table of Contents

- [Overview](#overview)
- [Datasets](#datasets)
- [Installation](#installation)
- [Usage](#usage)
- [Results](#results)
- [References](#references)

---

## Overview

Standalone multi-modal machine learning approach combining four remote sensing modalities:

1. **DEM Analysis** - Elevation change detection (2000-2011)
2. **Sentinel-1 SAR** - Backscatter change analysis (Winter/Summer 2021)
3. **Sentinel-2 Optical** - NDVI/NDSI glacier mapping (2018-2023)
4. **Landsat-8 Thermal** - LST and NDSI analysis (2017-2023)

**Study Area**: Gangotri Glacier, Uttarakhand Himalayas, source of Ganges River. Length ~30 km, elevation range 3,900-7,000m.

---

## Datasets

### 1. DEM Analysis
- **File**: `DEM.ipynb`
- **Data**: SRTM (2000, 30m) & ASTER GDEM (2011, 30m)
- **Period**: 11 years (2000-2011)
- **Features**: 8 terrain features (slope, aspect, hillshade + derived)
- **Method**: Quantile-based classification (4 classes)
- **Models**: Random Forest, SVM, KNN
- **Note**: Fixed data leakage issue - removed elevation change from features

### 2. Sentinel-1 SAR
- **File**: `Sentinel1.ipynb`
- **Data**: Copernicus S1 GRD, VV/VH polarizations, DESCENDING orbit
- **Period**: Winter (Dec 2020-Feb 2021) vs Summer (May-Aug 2021)
- **Features**: VV_2, VV_1, change_VV_VH (3 features)
- **Method**: K-means clustering (3 classes), 30m sampling
- **Advantage**: Cloud-independent, all-weather capability

### 3. Sentinel-2 Optical
- **File**: `Sentinel2.ipynb`
- **Data**: S2 MSI Harmonized, Bands B3, B4, B8, B11
- **Period**: 2018-2019 vs 2022-2023
- **Features**: NDVI, NDSI for both periods + changes (6 features)
- **Method**: K-means clustering (3 classes), 50m sampling
- **Cloud Filter**: < 80% cloud cover

### 4. Landsat-8 Thermal
- **File**: `Landsat.ipynb`
- **Data**: Landsat-8 OLI/TIRS Collection 2 Level 2
- **Period**: 2017 vs 2023 (6 years)
- **Features**: LST_2017, LST_2023, NDSI_2017, NDSI_2023 (4 features)
- **Method**: K-means clustering (4 classes)
- **Models**: Random Forest, SVM, KNN

---

## Project Structure

```
ieee/notebooks/
├── DEM.ipynb                  # Standalone DEM elevation change analysis
├── Sentinel1.ipynb            # SAR backscatter seasonal analysis
├── Sentinel2.ipynb            # Optical NDVI/NDSI multi-temporal
├── Landsat.ipynb              # Thermal LST and NDSI analysis
├── datasets/
│   ├── DEM/                   # Saved models and data
│   ├── Sentinel-1/
│   ├── Sentinel-2/
│   └── Landsat-9/
├── models/                    # Trained models (.pkl files)
└── README.md
```

---

## Installation

**Requirements**: Python 3.8+, Google Earth Engine account

```bash
pip install earthengine-api geemap pandas numpy scikit-learn matplotlib seaborn
```

**Earth Engine Authentication**:
```python
import ee
```python
import ee
ee.Authenticate()
ee.Initialize()
```

---

## Usage

All notebooks are **standalone** and can be run independently:

### 1. DEM Analysis
```bash
jupyter notebook DEM.ipynb
```
- Loads SRTM (2000) and ASTER GDEM (2011) from Earth Engine
- Calculates elevation change and terrain features
- Trains Random Forest, SVM, KNN models
- Saves models to `../datasets/DEM/`

### 2. Sentinel-1 SAR
```bash
jupyter notebook Sentinel1.ipynb
```
- Loads S1 GRD data for Winter and Summer 2021
- Calculates VV backscatter and VV-VH difference
- Uses K-means clustering (3 classes)
- Saves to `models/sentinel1_*`

### 3. Sentinel-2 Optical
```bash
jupyter notebook Sentinel2.ipynb
```
- Loads S2 Harmonized data (2018-2019, 2022-2023)
- Calculates NDVI, NDSI, and multi-temporal changes
- Uses K-means clustering (3 classes)
- Saves to `models/sentinel2_*`

### 4. Landsat-8 Thermal
```bash
jupyter notebook Landsat.ipynb
```
- Loads Landsat-8 Collection 2 (2017, 2023)
- Calculates LST and NDSI
- Uses K-means clustering (4 classes)
- Saves to `models/landsat_*`

**Note**: All notebooks require Earth Engine authentication. First-time users need to run `ee.Authenticate()`.

---

## Results

| Modality | Period | Features | Method | Samples | Notes |
|----------|--------|----------|--------|---------|-------|
| DEM | 2000-2011 | 8 terrain | RF/SVM/KNN | ~2000 | Fixed data leakage |
| Sentinel-1 | Winter/Summer 2021 | 3 SAR | K-means (3) | Variable | Expanded date ranges |
| Sentinel-2 | 2018-2023 | 6 spectral | K-means (3) | ~300 | Memory optimized |
| Landsat-8 | 2017-2023 | 4 thermal | K-means (4) | ~1000 | LST + NDSI |

**Key Updates**:
- ✅ All notebooks now use **Gangotri Glacier** (30.92°N, 79.08°E)
- ✅ Fixed **data leakage** in DEM notebook (removed elev_change from features)
- ✅ Optimized **memory usage** for Sentinel-2 (scale=50m, 300 samples)
- ✅ Expanded **Sentinel-1 date ranges** for better coverage
- ✅ All notebooks are **standalone** (no cross-references)
- ✅ Consistent **unsupervised learning** (K-means clustering)

**Findings**:
- Terrain features (slope, aspect) show moderate correlation with elevation change
- SAR backscatter shows seasonal variations in glacier surface
- NDSI/NDVI multi-temporal analysis reveals glacier extent changes
- LST shows thermal variations across glacier zones

---

## References

**Publications**:
- Bhambri et al. (2011) - Glacier changes in Garhwal Himalaya
- Kumar et al. (2008) - Glacier retreat using Indian RS data
- Bolch et al. (2012) - State and Fate of Himalayan Glaciers

**Data Sources**:
- SRTM DEM (NASA, 2000)
- ASTER GDEM (NASA/JAXA, 2011)
- Sentinel-1 GRD (ESA Copernicus)
- Sentinel-2 MSI Harmonized (ESA Copernicus)
- Landsat-8 Collection 2 Level 2 (NASA/USGS)

**Tools**: Google Earth Engine, geemap, scikit-learn, pandas, matplotlib

---

## Project Status

| Component | Status | Implementation |
|-----------|--------|----------------|
| DEM Analysis | ✅ Complete | Quantile classification, terrain features only |
| Sentinel-1 SAR | ✅ Complete | K-means clustering, seasonal comparison |
| Sentinel-2 Optical | ✅ Complete | K-means clustering, multi-temporal NDVI/NDSI |
| Landsat-8 Thermal | ✅ Complete | K-means clustering, LST analysis |

**Known Limitations**:
- Small sample sizes for Sentinel-1 due to limited coverage
- Memory constraints for Sentinel-2 (reduced to 300 samples)
- Unsupervised clustering (no ground truth validation)
- Different temporal coverage across modalities
- Cloud cover affects optical data quality

**Last Updated**: November 7, 2025  
**Conference**: IEEE 2025
