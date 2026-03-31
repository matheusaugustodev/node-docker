# imagem base com Node
FROM node:18

# pasta dentro do container
WORKDIR /app

# copia os arquivos
COPY package.json ./

# instala dependências
RUN npm install

# copia o resto do projeto
COPY . .

# expõe a porta
EXPOSE 3000

# comando para rodar
CMD ["npm", "start"]