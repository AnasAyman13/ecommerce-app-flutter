# NORR architecture

The app follows feature-first MVVM. Every feature owns its models, repository
contracts, Cubit-based view models, screens, and reusable feature widgets.

## Dependency direction

`views -> viewmodels -> repositories -> core/api`

- Views render state and forward user actions.
- View models expose `ViewState<T>` and contain presentation logic.
- Repositories hide remote/local data sources from the presentation layer.
- Models are immutable values passed between the repository and view model.
- Shared API, routing, theme, errors, constants, and helpers live under `core`.

## Team ownership

1. `auth`, `cart`, `settings`
2. `splash`, `onboarding`, `home`, `categories`
3. `listing`, `product_details`, `orders`
4. `search`, `profile`, `wishlist`

## Starting a feature

1. Add JSON mapping to the feature model.
2. Implement the repository contract with `ApiClient`.
3. Register the implementation and view model with the chosen DI setup.
4. Provide the view model above the screen using `BlocProvider`.
5. Render loading, success, and failure states with `BlocBuilder` or
   `BlocConsumer`.

Route names live in `core/routing/app_route_names.dart`; route construction
lives in `core/routing/app_router.dart`.
