
/*-------------- Tabelas ------------------ */

/* GESTOR */
CREATE TABLE IF NOT EXISTS Gestor (
    CPF VARCHAR(11) NOT NULL PRIMARY KEY,
    Data_Cadastro DATE
);

CREATE TABLE IF NOT EXISTS Gestor_Analisa_Parceiro(
    CPF_Gestor VARCHAR(11) NOT NULL,
    CNPJ_Parceiro VARCHAR(14) NOT NULL,
    Status_ VARCHAR(100), -- pq 100 pro status? 
    Data_Analise DATE,

    PRIMARY KEY (CPF_Gestor, CNPJ_Parceiro)
);

CREATE TABLE IF NOT EXISTS Gestor_Aprova_Coord_Adm (
    CPF_gestorRedeAndifes VARCHAR(11) NOT NULL,
    CPF_coordenadorAdministrativo VARCHAR(11) NOT NULL,
    data_fim TIMESTAMP,
    data_inicio TIMESTAMP,
    documento_de_atuacao VARCHAR(255),

    CHECK (data_inicio < data_fim),

    PRIMARY KEY (CPF_gestorRedeAndifes, CPF_coordenadorAdministrativo)
);

-------------------------------------------

/* PARCEIRO */ 

CREATE TABLE IF NOT EXISTS Parceiro(
  CNPJ VARCHAR(14) NOT NULL PRIMARY KEY,
  Nome VARCHAR(200) NOT NULL,
  Descricao VARCHAR(500),
  CEP DECIMAL(8),
  Numero DECIMAL(5),
  Complemento VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Endereco_Parceiro(
  CEP DECIMAL(8) NOT NULL PRIMARY KEY,
  Rua VARCHAR(100) NOT NULL,
  Numero DECIMAL(5) NOT NULL,
  Bairro VARCHAR(100) NOT NULL,
  Cidade VARCHAR(100) NOT NULL,
  Estado VARCHAR(100) NOT NULL,
  Pais VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Telefone_Parceiro(
    CNPJ_Parceiro VARCHAR(14) NOT NULL,
    DDI DECIMAL(3),
    DDD DECIMAL(2),
    Numero DECIMAL(9) NOT NULL,

    PRIMARY KEY (CNPJ_Parceiro, DDI, DDD, Numero)
);

-------------------------------------------

/* EDITAL */

CREATE TABLE IF NOT EXISTS Edital(
    Numero DECIMAL(30) NOT NULL,
    Ano DECIMAL(4) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,
    Data_Publicacao DATE,
    Data_Inicio DATE,
    Data_Fim DATE,
    Edital_File VARCHAR(255), 
    Nome VARCHAR(100) NOT NULL,

    CHECK(Data_Inicio < Data_Fim), 

    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE IF NOT EXISTS Edital_Oferta_Coletiva(
    Numero DECIMAL(30) NOT NULL,
    Ano DECIMAL(4) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,
    Max_Alunos_Turma  DECIMAL(4),
    Max_Alunos_Lista_Espera  DECIMAL(4),
    Max_Vagas_Reservadas_Turma DECIMAL(3),
    
    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE IF NOT EXISTS Idiomas_Edital_Oferta_Coletiva(
    Numero DECIMAL(30) NOT NULL,
    Ano DECIMAL(4) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,
    Idioma VARCHAR(50) NOT NULL,

    PRIMARY KEY (Numero, Ano, Semestre, Idioma)
);

CREATE TABLE IF NOT EXISTS Edital_Cred_Especialista(
    Numero DECIMAL(30) NOT NULL,
    Ano DECIMAL(4) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,

    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE IF NOT EXISTS Edital_Admite_Docente_Especialista(
    Numero DECIMAL(30) NOT NULL,
    Ano DECIMAL(4) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,
    CPF_Docente_Especialista VARCHAR(11) NOT NULL,

    PRIMARY KEY (Numero, Ano, Semestre, CPF_Docente_Especialista)
);

CREATE TABLE IF NOT EXISTS Edital_Cred_Prof_Isf(
    Numero DECIMAL(30) NOT NULL,
    Ano DECIMAL(4) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,

    PRIMARY KEY (Numero, Ano, Semestre)
);

CREATE TABLE IF NOT EXISTS Edital_Aluno_Especializacao(
    Numero DECIMAL(30) NOT NULL,
    Ano DECIMAL(4) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,
    Quantidade_Vagas DECIMAL(4),
    
    PRIMARY KEY (Numero, Ano, Semestre)
);

-------------------------------------------

/* ALUNO ESPECIALIZACAO */

CREATE TABLE IF NOT EXISTS Aluno_Especializacao(
    CPF VARCHAR(11) NOT NULL, 
    Titulacao VARCHAR(40) NOT NULL,
    Data_Ingresso DATE,
    Data_Conclusao DATE,
    Diploma_File VARCHAR(255),
    CHECK(Data_Ingresso < Data_Conclusao),

    PRIMARY KEY (CPF)
);

CREATE TABLE IF NOT EXISTS Aluno_Especializacao_Produz_Repositorio(
    CPF_Aluno_Especializacao VARCHAR(11) NOT NULL,
    Repositorio_Titulo VARCHAR(20) NOT NULL,
    Foi_Validado_Pelo_Orientador BOOLEAN,
    
    PRIMARY KEY (CPF_Aluno_Especializacao, Repositorio_Titulo)
);

CREATE TABLE IF NOT EXISTS Aluno_Especializacao_Cursa_Turma(
    CPF_Aluno VARCHAR(11) NOT NULL,
    Nome_Componente VARCHAR(100) NOT NULL,
    Sigla VARCHAR(15) NOT NULL,
    Semestre DECIMAL(1) NOT NULL, 
    Situacao_Aluno INTEGER, --Separar algo tipo 0 - cursando, 1 - aprovado, 2 - reprovado etc
    Frequencia DECIMAL(3),

    CHECK(Frequencia > 0 AND Frequencia < 100), 

    PRIMARY KEY (CPF_Aluno, Nome_Componente, Sigla, Semestre)
);

CREATE TABLE IF NOT EXISTS Atividades_Aluno_Especializacao(
    CPF_Aluno VARCHAR(11) NOT NULL,
    Nome_Componente VARCHAR(100) NOT NULL,
    Sigla VARCHAR(15) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,

    Atividade VARCHAR(40) NOT NULL,

    Nota DECIMAL(2, 2),

    CHECK(Nota >= 0 AND Nota <= 10),

    PRIMARY KEY (CPF_Aluno, Nome_Componente, Sigla, Semestre, Atividade)
);

-------------------------------------------
/* TURMA ESPECIALIZACAO */
CREATE TABLE IF NOT EXISTS Turma_Especializacao(
    Nome_Componente VARCHAR(100) NOT NULL,
    Sigla VARCHAR(15) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,

    Hora_Inicio TIMESTAMP,
    Hora_Fim TIMESTAMP,
    Qtde_Vagas DECIMAL(4),

    CHECK (Hora_Inicio < Hora_Fim),

    PRIMARY KEY(Nome_Componente, Sigla, Semestre)
);

CREATE TABLE IF NOT EXISTS Dias_Turma_Especializacao(
    Dia_Da_Semana VARCHAR(3) NOT NULL,
    Nome_Componente VARCHAR(100) NOT NULL,
    Sigla VARCHAR(15) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,

    PRIMARY KEY(Dia_Da_Semana, Nome_Componente, Sigla, Semestre)
);
-------------------------------------------

/* REPOSITORIO */

CREATE TABLE IF NOT EXISTS Repositorio(
    Titulo VARCHAR(20) NOT NULL,
    Link VARCHAR(50) NOT NULL,
    Data_Inclusao DATE,

    PRIMARY KEY (Titulo)
);

CREATE TABLE IF NOT EXISTS Repositorio_Turma(
    Nome_Turma_Ofertada VARCHAR(20) NOT NULL,
    Idioma_Turma_Ofertada VARCHAR(20) NOT NULL,
    Sigla_Turma_Ofertada VARCHAR(10) NOT NULL,
    Semestre_Turma_Ofertada DECIMAL(1) NOT NULL,

    Titulo_Repositorio VARCHAR(20) NOT NULL,

    Foi_Aprovado_Pelo_Orientador BOOLEAN,

    PRIMARY KEY (Nome_Turma_Ofertada, Idioma_Turma_Ofertada, Sigla_Turma_Ofertada, Semestre_Turma_Ofertada, Titulo_Repositorio)
);

-------------------------------------------

/* OFERTA COLETIVA */ 

CREATE TABLE IF NOT EXISTS Turma_Oferta_Coletiva(
    Nome_Completo VARCHAR(20) NOT NULL,
    Idioma VARCHAR(20) NOT NULL,

    Sigla_Turma VARCHAR(10) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,

    Qtde_Vagas_Reservadas DECIMAL(4),
    Hora_Inicio TIMESTAMP,
    Hora_Fim TIMESTAMP,
    Qtde_Vagas DECIMAL(4),
    --Qtde_Reprovados DECIMAL(4), 
    --Qtde_Desistentes DECIMAL(4),
    --Qtde_Concluintes DECIMAL(4), -> acho que atributos derivados nao vao na tabela 
    --Qtde_Inscritos DECIMAL(4),
    --Qtde_Evadidos DECIMAL(4),

    CHECK (Hora_Inicio < Hora_Fim),

    PRIMARY KEY (Nome_Completo, Idioma, Sigla_Turma, Semestre)
);

CREATE TABLE IF NOT EXISTS Dias_Turma_Oferta_Coletiva(
    Dia_Da_Semana VARCHAR(3) NOT NULL,
    Nome_Completo VARCHAR(100) NOT NULL,
    Idioma VARCHAR(20) NOT NULL,
    Sigla VARCHAR(15) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,

    PRIMARY KEY(Dia_Da_Semana, Nome_Completo, Idioma, Sigla, Semestre)
);

CREATE TABLE IF NOT EXISTS Idioma_Turma_Oferta_Coletiva(
	Nome_idioma VARCHAR(50) NOT NULL,
	Proficiencia VARCHAR(10) NOT NULL,
	
	PRIMARY KEY (Nome_idioma,Proficiencia)
);

-------------------------------------------

/* COMPONENTE CURRICULAR */

CREATE TABLE IF NOT EXISTS Componente_Curricular(
	Nome_componente VARCHAR(100) NOT NULL,
	Nome_idioma VARCHAR(50),
	Proficiencia VARCHAR(10),
	Carga_horaria_pratica TIME,
	Carga_horaria_teorica TIME,
	Obrigatoriedade BOOLEAN,
	Eixo_tematico VARCHAR(50),
	
	PRIMARY KEY (Nome_componente)
);

CREATE TABLE IF NOT EXISTS Tipo_Componente_Curricular(
    Nome_Completo VARCHAR(100),
    Tipo_Disciplina VARCHAR(50),

    PRIMARY KEY (Nome_Completo)
);

CREATE TABLE IF NOT EXISTS Componente_Curricular_Material(
    Nome_componente VARCHAR(100),
    Nome_material VARCHAR(100),   
    Data_Material TIMESTAMP,

    PRIMARY KEY (Nome_componente, Nome_material, Data_Material)
);

-------------------------------------------

/* ALUNO OFERTA COLETIVA */ 

CREATE TABLE IF NOT EXISTS Aluno_Oferta_Coletiva(
    CPF VARCHAR(11) NOT NULL,
    Vinculo_file VARCHAR(255), 

    PRIMARY KEY (CPF)
);

CREATE TABLE IF NOT EXISTS Idioma_Aluno_Oferta_Coletiva (
	CPF VARCHAR(11) NOT NULL,
	Idioma VARCHAR(50) NOT NULL,
	Proficiencia VARCHAR(50) NOT NULL,
	Declaracao_proficiencia VARCHAR(100),
	
	PRIMARY KEY (CPF, Idioma, Proficiencia)
);

CREATE TABLE IF NOT EXISTS Aluno_Inscreve_Turma_Oferta(
    CPF_Aluno VARCHAR(11) NOT NULL,
    Idioma VARCHAR(20) NOT NULL,
    Proficiencia_Turma VARCHAR(20) NOT NULL,
    Nome_Completo VARCHAR(20) NOT NULL,
    Sigla_Turma VARCHAR(10) NOT NULL,
    Semestre DECIMAL(1) NOT NULL,

    Data_Inscricao TIMESTAMP NOT NULL,

    Posicao_Lista DECIMAL(5),
    Situacao_Inscricao INTEGER, --Separar como se fosse um enum eu acho
    Data_Matricula TIMESTAMP,
    Situacao_matricula VARCHAR(15),

    PRIMARY KEY (CPF_Aluno, Nome_Completo, Idioma, Sigla_Turma, Semestre)
);
-------------------------------------------

/* IES */

CREATE TABLE IF NOT EXISTS IES (
    CNPJ VARCHAR(14) NOT NULL PRIMARY KEY,
    sigla VARCHAR(10),
    participou_isf BOOLEAN,
    tem_lab_mais_unidos BOOLEAN,
    possui_nucleo_ativo BOOLEAN,
    CEP DECIMAL(8),
    link_politica_ling VARCHAR(255),
    data_politica_ling DATE,
    doc_politica_ling VARCHAR(255),
    campus VARCHAR(100),
    nome_principal VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Endereco_IES (
    CEP VARCHAR(8) NOT NULL,
    CNPJ VARCHAR(14) NOT NULL,
    rua VARCHAR(100),
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    pais VARCHAR(50),

    PRIMARY KEY (CEP, numero, CNPJ)
);

CREATE TABLE IF NOT EXISTS Telefone_IES (
    CNPJ_IES VARCHAR(14) NOT NULL,
    DDD VARCHAR(3) NOT NULL,
    DDI VARCHAR(3) NOT NULL,
    numero VARCHAR(15) NOT NULL,

    PRIMARY KEY (CNPJ_IES, DDI, DDD, numero)
);

-------------------------------------------
/* COORDENADOR ADMINISTRATIVO */

CREATE TABLE IF NOT EXISTS Coord_Adm_Cadastra_IES (
    CNPJ_IES VARCHAR(14) NOT NULL,
    CPF_coordenadorAdministrativo VARCHAR(11) NOT NULL,
    termo_de_compromisso VARCHAR(255),

    PRIMARY KEY (CNPJ_IES, CPF_coordenadorAdministrativo)
);

-- Tabela coordenadorAdministrativo
CREATE TABLE IF NOT EXISTS Coordenador_Administrativo (
    CPF_usuario VARCHAR(11) NOT NULL PRIMARY KEY,
    funcao_na_instituicao VARCHAR(100),
    curriculo_lates VARCHAR(255),
    data_cadastro DATE,
    POCA VARCHAR(50)
);

/*-------------- FK CONSTRAINTS ------------------ */

--Gestor Constraints

ALTER TABLE Gestor 
ADD CONSTRAINT FK_Usuario
FOREIGN KEY (CPF) REFERENCES Usuario(CPF);

ALTER TABLE Gestor_Analisa_Parceiro 
ADD CONSTRAINT FK_Gestor
FOREIGN KEY (CPF_Gestor) REFERENCES Gestor(CPF);

ALTER TABLE Gestor_Analisa_Parceiro 
ADD CONSTRAINT FK_Parceiro  
FOREIGN KEY (CNPJ_Parceiro) REFERENCES Parceiro(CNPJ);


--Parceiro Constraints

ALTER TABLE EnderecoParceiro 
ADD CONSTRAINT FK_Parceiro  
FOREIGN KEY (CEP) REFERENCES Parceiro(CEP);

ALTER TABLE Telefone_Parceiro 
ADD CONSTRAINT FK_Parceiro  
FOREIGN KEY (CNPJ_Parceiro) REFERENCES Parceiro(CNPJ);


--Edital Constraints

ALTER TABLE Edital_Oferta_Coletiva 
ADD CONSTRAINT FK_Edital  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Cred_Especialista 
ADD CONSTRAINT FK_Edital  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Cred_Prof_Isf 
ADD CONSTRAINT FK_Edital  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Curso_Especializacao 
ADD CONSTRAINT FK_Edital  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Idiomas_Edital_Oferta_Coletiva 
ADD CONSTRAINT FK_Edital_Oferta_Coletiva  
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital_Oferta_Coletiva(Numero, Ano, Semestre);

ALTER TABLE Edital_Aluno_Especializacao
ADD CONSTRAINT FK_Edital
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Admite_Docente_Especialista
ADD CONSTRAINT FK_Edital
FOREIGN KEY (Numero, Ano, Semestre) REFERENCES Edital(Numero, Ano, Semestre);

ALTER TABLE Edital_Admite_Docente_Especialista
ADD CONSTRAINT FK_Docente_Especialista
FOREIGN KEY () REFERENCES Edital(Numero, Ano, Semestre);

--Aluno Especializacao Constraints

ALTER TABLE Aluno_Especializacao
ADD CONSTRAINT FK_Professor_Isf
FOREIGN KEY (CPF_Docente_Especialista) REFERENCES Docente_Especialista(CPF);

ALTER TABLE Aluno_Especializacao_Produz_Repositorio
ADD CONSTRAINT FK_Aluno_Especializacao
FOREIGN KEY (CPF_Aluno_Especializacao) REFERENCES Aluno_Especializacao(CPF);

ALTER TABLE Aluno_Especializacao_Cursa_Turma
ADD CONSTRAINT FK_Aluno_Especializacao
FOREIGN KEY (CPF_Aluno) REFERENCES Aluno_Especializacao(CPF);

ALTER TABLE Aluno_Especializacao_Cursa_Turma
ADD CONSTRAINT FK_Turma_Especializacao
FOREIGN KEY (Nome_Componente, Sigla, Semestre) REFERENCES Turma_Especializacao(Nome_Componente, Sigla, Semestre);

ALTER TABLE Atividades_Aluno_Especializacao
ADD CONSTRAINT FK_Aluno_Especializacao_Cursa_Turma
FOREIGN KEY (CPF_Aluno, Nome_Componente, Sigla, Semestre) REFERENCES Aluno_Especializacao_Cursa_Turma (CPF_Aluno, Nome_Componente, Sigla, Semestre);

-- Repositorios
ALTER TABLE Repositorio_Turma
ADD CONSTRAINT FK_Turma_Ofertada
FOREIGN KEY (Nome_Turma_Ofertada, Idioma_Turma_Ofertada, Sigla_Turma_Ofertada, Semestre_Turma_Ofertada) REFERENCES Turma_Ofertada (Nome_Completo, Idioma, Sigla_Turma, Semestre);

ALTER TABLE Repositorio_Turma
ADD CONSTRAINT FK_Repositorio
FOREIGN KEY (Titulo_Repositorio) REFERENCES Repositorio (Titulo);

-- Oferta Coletiva
ALTER TABLE Turma_Oferta_Coletiva
ADD CONSTRAINT FK_Curso_Idioma
FOREIGN KEY (Nome_Completo, Idioma) REFERENCES Curso_Idioma(Nome_Completo, Idioma)


ALTER TABLE Aluno_Inscreve_Turma_Oferta
ADD CONSTRAINT FK_Aluno_Oferta_Coletiva
FOREIGN KEY (CPF_Aluno) REFERENCES Aluno_Oferta_Coletiva(CPF);

ALTER TABLE Aluno_Inscreve_Turma_Oferta
ADD CONSTRAINT FK_Turma_Oferta_Coletiva
FOREIGN KEY (Nome_Idioma, Proficiencia_Turma, Nome_Completo, Sigla_Turma, Semestre, Data_Inscricao) REFERENCES Turma_Oferta_Coletiva(Nome_Idioma, Proficiencia, Nome_Completo, Sigla_Turma, Semestre, Data_Inscricao);

-- Componente Curricular Idioma
ALTER TABLE ComponenteCurricular 
ADD CONSTRAINT FK_IdiomaComponenteCurricular
FOREIGN KEY (Nome_idioma,Proficiencia) REFERENCES ProficienciaIdiomaComponente(Nome_idioma,Proficiencia)

-- Para EnderecoIES
ALTER TABLE EnderecoIES
ADD CONSTRAINT FK_EnderecoIES_IES
FOREIGN KEY (CEP) REFERENCES IES(CEP);

-- Para telefoneIES
ALTER TABLE telefoneIES
ADD CONSTRAINT FK_telefoneIES_IES
FOREIGN KEY (CNPJ_IES) REFERENCES IES(CNPJ);

-- Para gestorAprovaCoordAdm
ALTER TABLE gestorAprovaCoordAdm
ADD CONSTRAINT FK_gestorAprovaCoordAdm_gestorRedeAndifes
FOREIGN KEY (CPF_gestorRedeAndifes) REFERENCES gestorRedeAndifes(CPF);

ALTER TABLE gestorAprovaCoordAdm
ADD CONSTRAINT FK_gestorAprovaCoordAdm_coordenadorAdministrativo
FOREIGN KEY (CPF_coordenadorAdministrativo) REFERENCES coordenadorAdministrativo(CPF_usuario);

-- Para coordAdmCadastraIES
ALTER TABLE coordAdmCadastraIES
ADD CONSTRAINT FK_coordAdmCadastraIES_IES
FOREIGN KEY (CNPJ_IES) REFERENCES IES(CNPJ);

ALTER TABLE coordAdmCadastraIES
ADD CONSTRAINT FK_coordAdmCadastraIES_coordenadorAdministrativo
FOREIGN KEY (CPF_coordenadorAdministrativo) REFERENCES coordenadorAdministrativo(CPF_usuario);

-- Para coordenadorAdministrativo
ALTER TABLE coordenadorAdministrativo
ADD CONSTRAINT FK_coordenadorAdministrativo_usuario
FOREIGN KEY (CPF_usuario) REFERENCES usuario(CPF);
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Tipo Componente Curricular Constraint
ALTER TABLE TipoComponenteCurricular 
ADD CONSTRAINT FK_componenteCurricular
FOREIGN KEY (Nome_completo) REFERENCES ComponenteCurricular(Nome_componente)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Componente Curricular Material Constraints
ALTER TABLE componenteCurricularMaterial 
ADD CONSTRAINT FK_componenteCurricular
FOREIGN KEY (Nome_componente) REFERENCES ComponenteCurricular(Nome_componente)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE componenteCurricularMaterial 
ADD CONSTRAINT FK_material
FOREIGN KEY (Nome_material, data) REFERENCES Material(Nome_material, data)
ON DELETE CASCADE
ON UPDATE CASCADE;

--Aluno Oferta Coletiva
ALTER TABLE alunoOfertaColetiva
ADD CONSTRAINT FK_Usuario
FOREIGN KEY (CPF) REFERENCES Usuario(CPF)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE idiomaAlunoOfertaColetiva
ADD CONSTRAINT FK_Usuario
FOREIGN KEY (CPF) REFERENCES Usuario(CPF)
ON DELETE RESTRICT
ON UPDATE CASCADE;
