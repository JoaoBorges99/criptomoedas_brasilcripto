# Criptomoedas BrasilCripto

Este projeto é um aplicativo Flutter para consulta, pesquisa e acompanhamento de tendências de criptomoedas, com funcionalidades de favoritos, histórico de preços e integração com API externa. O sistema foi desenvolvido para ser multiplataforma (Android, iOS, Windows, macOS) e utiliza arquitetura reativa com MobX.

---

## Estrutura de Pastas

- **lib/**
  - **main.dart**: Ponto de entrada da aplicação.
  - **global/**
    - **settings.dart**: Configurações globais e utilitários de requisição HTTP.
    - **widgets_personalizados.dart**: Widgets customizados reutilizáveis.
  - **models/**
    - **cripto_model.dart**: Modelo principal de criptomoeda.
    - **cripto_details.dart**: Modelo para detalhes/histórico de preços.
    - **cripto_model.g.dart**: Código gerado pelo MobX.
  - **stores/**
    - **main_store.dart**: Store principal, gerencia estado global e listas.
    - **details_store.dart**: Store para detalhes de uma criptomoeda.
    - **main_store.g.dart**, **details_store.g.dart**: Código gerado pelo MobX.
  - **views/**
    - **principal_page.dart**: Página principal com navegação por abas.
    - **trend_page.dart**: Página de criptomoedas em alta.
    - **search_page.dart**: Página de pesquisa de criptomoedas.
    - **fav_page.dart**: Página de favoritos.
    - **cripto_details_page.dart**: Página de detalhes/histórico de uma criptomoeda.

---

## Ideia Base do Sistema

O sistema foi idealizado para fornecer uma experiência simples e eficiente de consulta de criptomoedas, permitindo ao usuário:

- Visualizar tendências e destaques do mercado.
- Pesquisar qualquer criptomoeda disponível na API.
- Marcar moedas como favoritas e gerenciar essa lista.
- Visualizar detalhes e histórico de preços de cada moeda.
- Persistir favoritos localmente (SharedPreferences).
- Interface responsiva e adaptada para modo escuro.

---

## Descrição das Funções Principais

### Models

- **CriptoCurrency** ([models/cripto_model.dart](models/cripto_model.dart))
  - Representa uma criptomoeda, com campos como `id`, `name`, `symbol`, `price`, `favorito`, etc.
  - Métodos:
    - `adicionarRemoverFavorito()`: Alterna o estado de favorito.
    - `fromJson(Map<String, dynamic>)`: Cria uma instância a partir de JSON.
    - `toJson()`: Serializa para JSON.

- **CriptoDetails** ([models/cripto_details.dart](models/cripto_details.dart))
  - Representa o histórico de preço de uma moeda.
  - Campos: `priceUsd`, `date`.
  - Métodos:
    - `fromJson(Map<String, dynamic>)`: Cria instância do histórico.
    - `formattedDate`: Retorna data formatada para exibição.

---

### Stores

- **MainStore** ([stores/main_store.dart](stores/main_store.dart))
  - Gerencia o estado global, lista de tendências, favoritos e pesquisa.
  - Funções:
    - `getAllTrendCripto()`: Busca criptomoedas em alta.
    - `searchNewCripto()`: Pesquisa moedas pelo termo informado.
    - `salvarFavoritos()`: Salva favoritos localmente.
    - `recuperarFavoritos()`: Recupera favoritos do armazenamento.
    - `limparItensFav()`: Limpa todos os favoritos.
    - `validarItensFavoritos()`: Atualiza estado de favoritos na lista.
    - Computed: `favListItens`, `criptoPesquisada`.

- **DetailStore** ([stores/details_store.dart](stores/details_store.dart))
  - Gerencia o histórico de preços de uma moeda.
  - Funções:
    - `getCriptoPrice()`: Busca histórico de preços de uma moeda específica.

---

### Widgets Personalizados

- **PersonWidgets.criptoCard** ([global/widgets_personalizados.dart](global/widgets_personalizados.dart))
  - Card customizado para exibir informações básicas da moeda, botão de favorito e imagem.
  - Parâmetros: `cripto`, `onTap`, `adicionarRemoverFavorito`.

- **PersonWidgets.buildCryptoDetailsHeader**
  - Cabeçalho detalhado para página de detalhes, exibe nome, símbolo, data e preço.

---

### Páginas

- **PrincipalPage** ([views/principal_page.dart](views/principal_page.dart))
  - Página principal com navegação por abas: Tendências, Pesquisa, Favoritos.

- **TrendPage** ([views/trend_page.dart](views/trend_page.dart))
  - Exibe criptomoedas em alta, com destaque para as principais.

- **SearchPage** ([views/search_page.dart](views/search_page.dart))
  - Permite pesquisar moedas pelo nome, símbolo ou id.

- **FavoritesPage** ([views/fav_page.dart](views/fav_page.dart))
  - Lista e gerencia moedas favoritas.

- **CriptoDetailsPage** ([views/cripto_details_page.dart](views/cripto_details_page.dart))
  - Exibe detalhes e gráfico de histórico de preços da moeda selecionada.

---

## Como Executar

1. Configure o arquivo `.env` em `assets/.env` com as variáveis `URL_API` e `API_KEY`.
2. Execute `flutter pub get` para instalar dependências.
3. Rode o app com `flutter run`.

---

## Tecnologias Utilizadas

- Flutter
- MobX (geração automática de código)
- SharedPreferences
- HTTP
- fl_chart (gráficos)
- flutter_dotenv

---

## Observações

- O sistema é multiplataforma, mas algumas funcionalidades podem variar conforme o SO.
- O código MobX gerado não deve ser editado manualmente.
- Os widgets personalizados facilitam a manutenção e padronização visual.

---
