programa {
  inclua biblioteca Util --> u
  funcao inicio() {
    caracter xo,tbl[3][3]
    inteiro x,y,rdd,vnc=0
//A variável lógica "segue" é especialmente importante nesse código, pois facilitou a utilização de laços de repetição, e permitiu um andamento sem erros.
    logico bot,segue=falso

    escreva("Vamos jogar um Jogo da velha, esse jogo é jogado através de comandos em coordenadas.\nO jogador 1 joga primeiro, com o X. O jogador 2 com o O.\n\nAqui temos as coordenadas de cada uma das casas:\n")

  //Estruturando o jogo, e imprimindo o mesmo, já com as coordenadas, para facilitar o entendimento do usuário.
    para(x=0;x<3;x++){
      para(y=0;y<3;y++){
          tbl[x][y] = ' '
          escreva("[",x+1,",",y+1,"]")
        }
        escreva("\n")
      }

  //Definindo se o jogo será jogado contra outra pessoa, ou contra o computador.
    faca{
      escreva("\nGostaria de jogar contra um segundo jogador, ou contra o computador?\nPara jogar contra o bot escreva \"X\". Já para jogar com um amigo escreva \"O\".\n")
      leia(xo)
      se((xo=='X')ou(xo=='x')){
        bot=verdadeiro
        segue=verdadeiro
      }
      senao se((xo=='O')ou(xo=='0')ou(xo=='o')){
        bot=falso
        segue=verdadeiro
      }
      senao{
        limpa()
        escreva("O comando inserido não é valido, por favor, tente de novo...\n\n")
      }
    }enquanto(segue==falso)
    
  //Aqui começa de fato o jogo, é onde são coletadas a jogadas dos jogadores e do bot, caso o mesmo tenha sido selecionado como oponente.
   //Laço de repetição para 9 rodadas, visto que o jogo da velha tem apenas nove casas.
    para(rdd=0;rdd<9;rdd++){

    //Resetando a Var "segue" todo início de ciclo, para que os laços voltem a funcionar como devido.
      segue = falso

    //Definindo quem joga de acordo com a rodada atual.
      se(rdd%2==0){
        
        faca{
          escreva("Vez do jogador 1! Escolha as coordenadas da jogada...\n")
          leia(x,y)

        //Definindo se a jogada é valida, isso é, se a casa escolhida faz parte da grade e se está vazia.
          se((x<4)e(y<4)){
            se(tbl[x-1][y-1]==' '){
              tbl[x-1][y-1]='X'
              segue = verdadeiro
            }
            senao{
              limpa()
              escreva("Este espaço já está ocupado, escolha outro.\n")
            }
          }
          senao{
            limpa()
            escreva("Estes números não correspondem a nenhuma coordenada do tabuleiro, tente de novo.\n")
          }
        }enquanto(segue==falso)
      }

    //Se o bot estiver desligado, então é a vez do segundo jogador.
      senao se((rdd%2!=0)e bot==falso){

        faca{
          escreva("Vez do jogador 2! Escolha as coordenadas da jogada...\n")
          leia(x,y)

        //Definindo se a jogada é valida, isso é, se a casa escolhida faz parte da grade e se está vazia.
          se((x<4)e(y<4)){
            se(tbl[x-1][y-1]==' '){
              tbl[x-1][y-1]='O'
              segue = verdadeiro
            }
            senao{
              limpa()
              escreva("Este espaço já está ocupado, escolha outro.\n")
            }
          }
          senao{
            limpa()
            escreva("Estes números não correspondem a nenhuma coordenada do tabuleiro, tente de novo.\n")
          }
        }enquanto(segue==falso)
      }

    //Se o bot estiver ligado, então é a vez dele.
      senao se((rdd%2!=0)e bot==verdadeiro){

        faca{
        
        //Escolhendo 2 número aleatórios com a Lib "Util", que servirão de coordenada para a jogada.
          x=u.sorteia(1,3)
          y=u.sorteia(1,3)

        //Definindo se a jogada é valida, isso é, se a casa escolhida faz parte da grade e se está vazia.
          se(tbl[x-1][y-1]==' '){
            tbl[x-1][y-1]='O'
            segue = verdadeiro
          }
        }enquanto(segue==falso)
      }

      limpa()

    //Depois de limpar o console, imprime novamente o "tabuleiro", já com a jogada feita anteriormente.
      para(x=0;x<3;x++){
        para(y=0;y<3;y++){
          escreva("[",tbl[x][y],"]")
        }
        escreva("\n")
      }

    //Definindo os parâmentros para a vitória, e percorrendo a matriz para ver se os parâmetros já foram atingidos.
      para(x=0;x<3;x++){
        para(y=0;y<3;y++){
          se(tbl[x][0]=='X'e tbl[x][1]=='X'e tbl[x][2]=='X'){
            vnc=1
          }
          senao se(tbl[x][0]=='O'e tbl[x][1]=='O'e tbl[x][2]=='O'){
            vnc=2
          }
          senao se(tbl[0][y]=='X'e tbl[1][y]=='X'e tbl[2][y]=='X'){
            vnc=1
          }
          senao se(tbl[0][y]=='O'e tbl[1][y]=='O'e tbl[2][y]=='O'){
            vnc=2
          }
        }
      }

    //Como vencer fazendo uma linha na diagonal é uma situação mais específica, foi feita uma conferência específica para isso.
      se((tbl[0][0]=='X'e tbl[1][1]=='X'e tbl[2][2]=='X')ou(tbl[0][2]=='X'e tbl[1][1]=='X'e tbl[2][0]=='X')){
        vnc=1
      }
      senao se((tbl[0][0]=='O'e tbl[1][1]=='O'e tbl[2][2]=='O')ou(tbl[0][2]=='O'e tbl[1][1]=='O'e tbl[2][0]=='O')){
        vnc=1
      }

    //Uma vez que um vencedor foi detectado, o laço de repetição que define as rodadas é encerrado.
      se(vnc!=0){
        pare
      }
    } 

  //Dando a nóticia do resultado de acordo com os parâmetros anteriores.
    se(vnc==1){
      escreva("O vencedor é o jogador 1!")
    }
    senao se(vnc==2){
      escreva("O vencedor é o jogador 2!")
    }
    senao{
      escreva("Deu velha!")
    }
  }
}
