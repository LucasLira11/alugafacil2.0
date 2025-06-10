package com.cefet.alugafacil.modelo;

import java.util.Date;

public class Aluguel {
    private int id;
    private Date dataInicio;
    private Date dataFim;
    private Inquilino inquilino;
    private Imovel imovel;
    
    // Novos campos para corresponder ao JSP
    private double valorAluguel;
    private double multaPorcentagem;
    private double jurosPorDia;
    private Date dataVencimento;
    private Date dataPagamento;

    // Construtor padrão
    public Aluguel() {
    }

    // Getters e Setters existentes
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getDataInicio() { return dataInicio; }
    public void setDataInicio(Date dataInicio) { this.dataInicio = dataInicio; }

    public Date getDataFim() { return dataFim; }
    public void setDataFim(Date dataFim) { this.dataFim = dataFim; }

    public Inquilino getInquilino() { return inquilino; }
    public void setInquilino(Inquilino inquilino) { this.inquilino = inquilino; }

    public Imovel getImovel() { return imovel; }
    public void setImovel(Imovel imovel) { this.imovel = imovel; }

    // Novos getters e setters
    public double getValorAluguel() { return valorAluguel; }
    public void setValorAluguel(double valorAluguel) { this.valorAluguel = valorAluguel; }

    public double getMultaPorcentagem() { return multaPorcentagem; }
    public void setMultaPorcentagem(double multaPorcentagem) { this.multaPorcentagem = multaPorcentagem; }

    public double getJurosPorDia() { return jurosPorDia; }
    public void setJurosPorDia(double jurosPorDia) { this.jurosPorDia = jurosPorDia; }

    public Date getDataVencimento() { return dataVencimento; }
    public void setDataVencimento(Date dataVencimento) { this.dataVencimento = dataVencimento; }

    public Date getDataPagamento() { return dataPagamento; }
    public void setDataPagamento(Date dataPagamento) { this.dataPagamento = dataPagamento; }

    // MÉTODO ADICIONADO PARA CORRIGIR O ERRO
    /**
     * Calcula o valor final do aluguel.
     * A lógica de cálculo de multa e juros deve ser implementada aqui.
     * @return O valor final calculado.
     */
    public double calcularValorFinal() {
        // Lógica de exemplo: se a data de pagamento for depois do vencimento, aplica multa e juros.
        // Esta é uma implementação de exemplo. Ajuste conforme sua regra de negócio.
        double valorFinal = this.valorAluguel;
        
        if (dataPagamento != null && dataVencimento != null && dataPagamento.after(dataVencimento)) {
            // Calcula multa
            valorFinal += this.valorAluguel * (this.multaPorcentagem / 100.0);

            // Calcula juros por dia de atraso
            long diffEmMillis = Math.abs(dataPagamento.getTime() - dataVencimento.getTime());
            long diffEmDias = java.util.concurrent.TimeUnit.DAYS.convert(diffEmMillis, java.util.concurrent.TimeUnit.MILLISECONDS);
            valorFinal += diffEmDias * this.jurosPorDia;
        }
        
        // Aqui você pode, por exemplo, salvar o valor calculado em um novo campo ou apenas retorná-lo.
        return valorFinal;
    }
}