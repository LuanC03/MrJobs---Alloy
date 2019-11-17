sig UserPF {
	cpf             : one CPF,
    name            : one Name,
    dateOfBirth     : one Date,
    martialStatus   : one Status,
    address         : one Address,
    cep             : one CEP,
    email           : one Email,
    phone           : set Phone,
    password        : one Password,
    curriculum      : one Curriculum,
    process         : set SeletiveProcess
}

sig UserPJ {
	cnpj            : one CNPJ,
    fantasyName     : one Name,
    corporateName   : one CorporateName,
    address         : one Address,
    email           : one Email,
    phone           : set Phone,
    password        : one Password,
    occupationArea  : set Occupation,
    services        : set Service,
    process         : set SeletiveProcess
}

sig SeletiveProcess {
    cnpjContractor  : one CNPJ,
    contractor      : one Name,
    occupationArea  : one Occupation,
    office          : one Address,
    activity        : one Activity,
    salary          : one Salary,
    priceOfService  : one PriceOfService,
    period          : one Period,
    workplace       : one Workplace,
    requeriments    : set Requeriment,
    desirableSkills : set Skill
}

sig Curriculum extends UserPF{
    aboutMe         : one Text,
    goal            : one Text,
    formation       : set Formation,
    languages       : set Language,
    courses         : set Course,
    expProfessional : set ExpProfessional
}

sig Text{}
sig Formation{}
sig Language{}
sig Course{}
sig ExpProfessional{}
sig Activity{}
sig Salary{}
sig PriceOfService{}
sig Period{}
sig Workplace{}
sig Requeriment{}
sig Skill{}
sig CNPJ{}
sig CPF{}
sig Name{}
sig CorporateName{}
sig Occupation{}
sig Service{}
sig Date{}
sig Status{}
sig Address{}
sig CEP {}
sig Email {}
sig Phone {}
sig Password{}

----------------------------------------------FATOS--------------------------------------------

fact {
    all c:Curriculum | one c.~curriculum
   --all f:UserPF     | one f.~cpf
    all l:UserPF     | one l.process
    all u:UserPF     | one u.~curriculum
    --all j:UserPJ     | one j.~cnpj
}
----------------------------------------PREDICADOS-------------------------------------------------

--Predicado referente a Usuario Pessoa Fisica
pred verificaUserPF[u1,u2:UserPF] {
	 u1 != u2 implies getUserPF[u1] != getUserPF[u2]
}

--Predicado referente a Usuario Pessoa Juridica
pred verificaUserPJ[u1,u2:UserPJ] {
	 u1 != u2 implies getUserPJ[u1] != getUserPJ[u2]
}
---------------------------------FUNÇÕES--------------------------------------------------------

fun getUserPF[u:UserPF] : one CPF {
	u.cpf
}

fun getUserPJ[u:UserPJ] : one CNPJ {
	u.cnpj
}

---------------------------------ASSERTS--------------------------------------------------------

--- Processo Seletivo

assert ProcessoSeletivoTemRequesitos {
	all c: SeletiveProcess | some c.requeriments
}

assert ProcessoSeletivoTemContractor {
	all c: SeletiveProcess | one c.contractor
}

assert ContractorProcessoSeletivoTemCNPJ {
	all c: SeletiveProcess | one c.cnpjContractor
}
--- UserPF
assert UserPFTemCurriculo {
	all u:UserPF | one u.curriculum
}

assert UserPFEstaEmProcessosSeletivos {
	some u:UserPF | some u.process
}

assert UserPFTemCPF {
	all u:UserPF | one u.cpf
}

--- UserPJ
assert UserPJTemOcupacoes {
	all u:UserPJ | some u.occupationArea
}

assert UserPJTemServices {
	all u:UserPJ | some u.occupationArea
}

assert UserPJTemProcessosSeletivos {
	some u:UserPJ | some u.process
}

assert UserPJTemCNPJ {
	all u:UserPJ | one u.cnpj
}

-------- Testes e Runs ---------

--- Processo Seletivo
check ProcessoSeletivoTemRequesitos for 10
check ProcessoSeletivoTemContractor for 10
check ContractorProcessoSeletivoTemCNPJ for 10

--- UserPF
check UserPFTemCurriculo for 10
check UserPFEstaEmProcessosSeletivos for 10
check UserPFTemCPF for 10

--- UserPJ
check UserPJTemOcupacoes for 10
check UserPJTemServices for 10
check UserPJTemProcessosSeletivos for 10
check UserPJTemCNPJ for 10


pred show[] {}

run show for 10