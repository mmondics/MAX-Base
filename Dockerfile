#
# Copyright 2018-2021 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM continuumio/miniconda3:4.10.3

# Upgrade all packages to meet security criteria
RUN apt-get update && apt-get upgrade -y && apt-get install sudo libjpeg-dev zlib1g-dev make automake gcc g++ subversion python3-dev -y && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home max && echo "max ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN chown -R max:max /opt/conda
USER max
WORKDIR /home/max
RUN mkdir assets
COPY . .
RUN conda install python==3.9.7
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt
