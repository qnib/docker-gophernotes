FROM qnib/anaconda2

# dependencies
RUN apt-get update \
 && apt-get install -y pkg-config libzmq-dev build-essential git

# set up golang
ENV GOPATH=/go \
    PATH=$GOPATH/bin:/usr/local/go/bin:$PATH 
RUN wget -qO - https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz | tar xfz - -C /usr/local \
 &&  mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# install gophernotes
RUN go get golang.org/x/tools/cmd/goimports \
 && go get github.com/gophergala2016/gophernotes \
 && mkdir -p ~/.ipython/kernels/gophernotes \
 && cp -r $GOPATH/src/github.com/gophergala2016/gophernotes/kernel/* ~/.ipython/kernels/gophernotes

EXPOSE 8888
CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0"]
