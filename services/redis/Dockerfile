# 只在 FROM 中生效
ARG REDIS_VERSION
# 基础镜像
FROM redis:${REDIS_VERSION}

# 【镜像标签】
LABEL maintainer="Tacks <tacks321@qq.com>"
LABEL version="1.0"

# 【当前构建变量】
### ARG 构建环境的环境变量
ARG TZ
ARG REDIS_VERSION

# 【当前构建变量】
RUN /bin/bash -c  'echo ${REDIS_VERSION} && \
    echo "Hello Dnmp-REDIS"'