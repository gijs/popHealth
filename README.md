popHealth
=========

popHealth is an open source tool that allows healthcare providers to calculate quality measures. A quality measure is a calculation of the number of individuals in a population that meet a specific standard of care.

popHealth can import patient summaries in either [ASTM CCR](http://www.astm.org/Standards/E2369.htm) or [HITSP C32](http://www.hitsp.org/ConstructSet_Details.aspx?&PrefixAlpha=4&PrefixNumeric=32) format. popHealth will extract information from the patient summaries and calculate quality reports.

Quality Measures
----------------

This web application is agnostic of any specific quality measures. It leverages the [Quality Measure Engine](https://github.com/pophealth/quality-measure-engine) library to calculate quality measures. An implementation of the [quality measures needed to meet meaningful use requirements](http://www.cms.gov/QualityMeasures/03_ElectronicSpecifications.asp) is available in the [Measures Project](https://github.com/pophealth/measures).

Environment
-----------

This project currently uses Ruby 1.9.2 and is built using [Bundler](http://gembundler.com/). To get all of the dependencies for the project, first install bundler:

    gem install bundler

Then run bundler to grab all of the necessary gems:

    bundle install

The Quality Measure engine relies on a MongoDB [MongoDB](http://www.mongodb.org/) running a minimum of version 1.6.* or higher.  To get and install Mongo refer to :

    http://www.mongodb.org/display/DOCS/Quickstart

It also relies on [Redis](http://redis.io/) for background jobs via [Resque](https://github.com/defunkt/resque). To install Redis, please refer to:

    http://redis.io/download

You can also find information on Redis at the [Resque homepage](https://github.com/defunkt/resque). Resque is used by this project to calculate quality measures in  background jobs. We also use [resque-status](https://github.com/quirkey/resque-status). Please consult the resque-status instructions for working with the resque-web application if you would like to use it to monitor status.

Running Resque Workers
----------------------

popHealth will kick off background jobs with Resque. For these jobs to to actually get performed, you need to be running resque workers. This can be done with the following:

    QUEUE=* bundle exec rake resque:work

JRuby and CCR Support
---------------------

This project requires running under JRuby to enable support for importing for ASTM CCR's. CCR Importing is written in Java and the code is available in the [ccr-importer project](https://github.com/pophealth/ccr-importer). popHealth has been tested with JRuby 1.5.6.

Additional Information
----------------------

Please check [our wiki](https://github.com/pophealth/popHealth/wiki) for more information.

Previous Version
----------------

If you are interested in the initial prototype of popHealth, you can find them in the [Legacy Branch](http://github.com/pophealth/popHealth/tree/legacy)

License
-------

Copyright 2011 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
