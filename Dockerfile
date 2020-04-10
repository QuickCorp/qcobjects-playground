FROM quickcorp/qcobjects:latest
###
#  QCObjects  1.0
#  ________________
#
#  Author: Jean Machuca <correojean@gmail.com>
#
#  Cross Browser Javascript Framework for MVC Patterns
#  QuickCorp/QCObjects is licensed under the
#  GNU Lesser General Public License v3.0
#  [LICENSE] (https://github.com/QuickCorp/QCObjects/blob/master/LICENSE.txt)
#
#  Permissions of this copyleft license are conditioned on making available
#  complete source code of licensed works and modifications under the same
#  license or the GNU GPLv3. Copyright and license notices must be preserved.
#  Contributors provide an express grant of patent rights. However, a larger
#  work using the licensed work through interfaces provided by the licensed
#  work may be distributed under different terms and without source code for
#  the larger work.
#
#  Copyright (C) 2015 Jean Machuca,<correojean@gmail.com>
#
#  Everyone is permitted to copy and distribute verbatim copies of this
#  license document, but changing it is not allowed.
###

#Configure the internal user permissions
RUN mkdir -p /home/qcobjects/app && chown -R qcobjects:qcobjects /home/qcobjects

#Setting the work directory
WORKDIR /home/qcobjects/app
USER qcobjects
COPY package*.json ./

#Run the initial install init scripts for jasmine and cache verify
RUN jasmine init
RUN npm cache verify
RUN npm ci --save --only=production

# Bundle app source
COPY --chown=qcobjects:qcobjects . .

# Default port is 10300
ENV COLLAB_PORT 10300

EXPOSE $COLLAB_PORT

CMD [ "npm", "run", "start" ]
