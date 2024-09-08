programa {
  inclua biblioteca Util --> u
  funcao inicio() {
    caracter xo,tbl[3][3]
    inteiro x,y,rdd,vnc=0
//A vari�vel l�gica "segue" � especialmente importante nesse c�digo, pois facilitou a utiliza��o de la�os de repeti��o, e permitiu um andamento sem erros.
    logico bot,segue=falso

    escreva("Vamos jogar um Jogo da velha, esse jogo � jogado atrav�s de comandos em coordenadas.\nO jogador 1 joga primeiro, com o X. O jogador 2 com o O.\n\nAqui temos as coordenadas de cada uma das casas:\n")

  //Estruturando o jogo, e imprimindo o mesmo, j� com as coordenadas, para facilitar o entendimento do usu�rio.
    para(x=0;x<3;x++){
      para(y=0;y<3;y++){
          tbl[x][y] = ' '
          escreva("[",x+1,",",y+1,"]")
        }
        escreva("\n")
      }

  //Definindo se o jogo ser� jogado contra outra pessoa, ou contra o computador.
    faca{
      escreva("\nGostaria de jogar contra um segundo jogador, ou contra o computador?\nPara jogar contra o bot escreva \"X\". J� para jogar com um amigo escreva \"O\".\n")
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
        escreva("O comando inserido n�o � valido, por favor, tente de novo...\n\n")
      }
    }enquanto(segue==falso)
    
  //Aqui come�a de fato o jogo, � onde s�o coletadas a jogadas dos jogadores e do bot, caso o mesmo tenha sido selecionado como oponente.
   //La�o de repeti��o para 9 rodadas, visto que o jogo da velha tem apenas nove casas.
    para(rdd=0;rdd<9;rdd++){

    //Resetando a Var "segue" todo in�cio de ciclo, para que os la�os voltem a funcionar como devido.
      segue = falso

    //Definindo quem joga de acordo com a rodada atual.
      se(rdd%2==0){
        
        faca{
          escreva("Vez do jogador 1! Escolha as coordenadas da jogada...\n")
          leia(x,y)

        //Definindo se a jogada � valida, isso �, se a casa escolhida faz parte da grade e se est� vazia.
          se((x<4)e(y<4)){
            se(tbl[x-1][y-1]==' '){
              tbl[x-1][y-1]='X'
              segue = verdadeiro
            }
            senao{
              limpa()
              escreva("Este espa�o j� est� ocupado, escolha outro.\n")
            }
          }
          senao{
            limpa()
            escreva("Estes n�meros n�o correspondem a nenhuma coordenada do tabuleiro, tente de novo.\n")
          }
        }enquanto(segue==falso)
      }

    //Se o bot estiver desligado, ent�o � a vez do segundo jogador.
      senao se((rdd%2!=0)e bot==falso){

        faca{
          escreva("Vez do jogador 2! Escolha as coordenadas da jogada...\n")
          leia(x,y)

        //Definindo se a jogada � valida, isso �, se a casa escolhida faz parte da grade e se est� vazia.
          se((x<4)e(y<4)){
            se(tbl[x-1][y-1]==' '){
              tbl[x-1][y-1]='O'
              segue = verdadeiro
            }
            senao{
              limpa()
              escreva("Este espa�o j� est� ocupado, escolha outro.\n")
            }
          }
          senao{
            limpa()
            escreva("Estes n�meros n�o correspondem a nenhuma coordenada do tabuleiro, tente de novo.\n")
          }
        }enquanto(segue==falso)
      }

    //Se o bot estiver ligado, ent�o � a vez dele.
      senao se((rdd%2!=0)e bot==verdadeiro){

        faca{
        
        //Escolhendo 2 n�mero aleat�rios com a Lib "Util", que servir�o de coordenada para a jogada.
          x=u.sorteia(1,3)
          y=u.sorteia(1,3)

        //Definindo se a jogada � valida, isso �, se a casa escolhida faz parte da grade e se est� vazia.
          se(tbl[x-1][y-1]==' '){
            tbl[x-1][y-1]='O'
            segue = verdadeiro
          }
        }enquanto(segue==falso)
      }

      limpa()

    //Depois de limpar o console, imprime novamente o "tabuleiro", j� com a jogada feita anteriormente.
      para(x=0;x<3;x++){
        para(y=0;y<3;y++){
          escreva("[",tbl[x][y],"]")
        }
        escreva("\n")
      }

    //Definindo os par�mentros para a vit�ria, e percorrendo a matriz para ver se os par�metros j� foram atingidos.
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

    //Como vencer fazendo uma linha na diagonal � uma situa��o mais espec�fica, foi feita uma confer�ncia espec�fica para isso.
      se((tbl[0][0]=='X'e tbl[1][1]=='X'e tbl[2][2]=='X')ou(tbl[0][2]=='X'e tbl[1][1]=='X'e tbl[2][0]=='X')){
        vnc=1
      }
      senao se((tbl[0][0]=='O'e tbl[1][1]=='O'e tbl[2][2]=='O')ou(tbl[0][2]=='O'e tbl[1][1]=='O'e tbl[2][0]=='O')){
        vnc=1
      }

    //Uma vez que um vencedor foi detectado, o la�o de repeti��o que define as rodadas � encerrado.
      se(vnc!=0){
        pare
      }
    } 

  //Dando a n�ticia do resultado de acordo com os par�metros anteriores.
    se(vnc==1){
      escreva("O vencedor � o jogador 1!")
    }
    senao se(vnc==2){
      escreva("O vencedor � o jogador 2!")
    }
    senao{
      escreva("Deu velha!")
    }
  }
}
