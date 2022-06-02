//
//  MoviesQueriesListViewModelTests.swift
//  ExampleMVVMTests
//
//  Created by Oleh Kudinov on 16.08.19.
//

@testable import ExampleMVVM
import XCTest
@testable import Common
@testable import MoviesModule

final class FetchRecentMovieQueriesUseCaseMock: UseCase {
		var expectation: XCTestExpectation?
		var error: Error?
		var movieQueries: [MovieQuery] = []
		var completion: (Result<[MovieQuery], Error>) -> Void = { _ in }

		func start() -> Cancellable? {
				if let error = error {
						completion(.failure(error))
				} else {
						completion(.success(movieQueries))
				}
				expectation?.fulfill()
				return nil
		}
}

final class MoviesQueriesListViewModelTests: XCTestCase {
    
    private enum FetchRecentQueriedUseCase: Error {
        case someError
    }
    
    var movieQueries = [MovieQuery(query: "query1"),
                        MovieQuery(query: "query2"),
                        MovieQuery(query: "query3"),
                        MovieQuery(query: "query4"),
                        MovieQuery(query: "query5")]

    func makeFetchRecentMovieQueriesUseCase(_ mock: FetchRecentMovieQueriesUseCaseMock) -> FetchRecentMovieQueriesUseCaseFactory {
        return { _, completion in
            mock.completion = completion
            return mock
        }
    }
    
    
    func test_whenFetchRecentMovieQueriesUseCaseReturnsQueries_thenShowTheseQueries() {
        // given
        let useCase = FetchRecentMovieQueriesUseCaseMock()
        useCase.expectation = self.expectation(description: "Recent query fetched")
        useCase.movieQueries = movieQueries
        let viewModel = DefaultMoviesQueryListViewModel(numberOfQueriesToShow: 3,
                                                        fetchRecentMovieQueriesUseCaseFactory: makeFetchRecentMovieQueriesUseCase(useCase))

        // when
        viewModel.viewWillAppear()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.items.value.map { $0.query }, movieQueries.map { $0.query })
    }
    
    func test_whenFetchRecentMovieQueriesUseCaseReturnsError_thenDontShowAnyQuery() {
        // given
        let useCase = FetchRecentMovieQueriesUseCaseMock()
        useCase.expectation = self.expectation(description: "Recent query fetched")
        useCase.error = FetchRecentQueriedUseCase.someError
        let viewModel = DefaultMoviesQueryListViewModel(numberOfQueriesToShow: 3,
                                                        fetchRecentMovieQueriesUseCaseFactory: makeFetchRecentMovieQueriesUseCase(useCase))
        
        // when
        viewModel.viewWillAppear()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(viewModel.items.value.isEmpty)
    }
    
    func test_whenDidSelectQueryEventIsReceived_thenCallDidSelectAction() {
        // given
        let selectedQueryItem = MovieQuery(query: "query1")
        var actionMovieQuery: MovieQuery?
        let expectation = self.expectation(description: "Delegate notified")
        let didSelect: MoviesQueryListViewModelDidSelectAction = { movieQuery in
            actionMovieQuery = movieQuery
            expectation.fulfill()
        }
        
        let viewModel = DefaultMoviesQueryListViewModel(numberOfQueriesToShow: 3,
                                                        fetchRecentMovieQueriesUseCaseFactory: makeFetchRecentMovieQueriesUseCaseLast login: Tue May 24 13:18:58 on console
																												
																												[WARNING]: Console output during zsh initialization detected.

														When using Powerlevel10k with instant prompt, console output during zsh
														initialization may indicate issues.

														You can:

															- Recommended: Change ~/.zshrc so that it does not perform console I/O
																after the instant prompt preamble. See the link below for details.

																* You will not see this error message again.
																* Zsh will start quickly and prompt will update smoothly.

															- Suppress this warning either by running p10k configure or by manually
																defining the following parameter:

																	typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

																* You will not see this error message again.
																* Zsh will start quickly but prompt will jump down after initialization.

															- Disable instant prompt either by running p10k configure or by manually
																defining the following parameter:

																	typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

																* You will not see this error message again.
																* Zsh will start slowly.

															- Do nothing.

																* You will see this error message every time you start zsh.
																* Zsh will start quickly but prompt will jump down after initialization.

														For details, see:
														https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt

														-- console output produced during zsh initialization follows --

														[oh-my-zsh] Insecure completion-dependent directories detected:
														drwxr-xr-x   22 amethystwyld         staff   704  2 Jan 11:18 /Users/amethystwyld/.oh-my-zsh
														drwxr-xr-x    5 amethystwyld         staff   160 23 Jan 19:37 /Users/amethystwyld/.oh-my-zsh/custom/plugins
														drwxr-xr-x   26 amethystwyld         staff   832 23 Jan 19:36 /Users/amethystwyld/.oh-my-zsh/custom/plugins/zsh-autosuggestions
														drwxr-xr-x   22 amethystwyld         staff   704 23 Jan 19:37 /Users/amethystwyld/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
														drwxr-xr-x  311 amethystwyld         staff  9952  2 Jan 11:18 /Users/amethystwyld/.oh-my-zsh/plugins
														drwxr-xr-x    4 amethystwyld         staff   128 15 Jan 20:21 /Users/amethystwyld/.oh-my-zsh/plugins/git
														drwxr-xr-x    7 amethystwyld         staff   224  2 Jan 11:18 /Users/amethystwyld/.oh-my-zsh/plugins/wd
														-rw-r--r--    1 amethystwyld         staff  2630  4 Dec 11:42 /Users/amethystwyld/.oh-my-zsh/plugins/wd/_wd.sh
														lrwxr-xr-x    1 christianrayleovido  admin    56 23 Jan 19:28 /usr/local/share/zsh/site-functions/_git -> ../../../Cellar/git/2.34.1/share/zsh/site-functions/_git

														[oh-my-zsh] For safety, we will not load completions from these directories until
														[oh-my-zsh] you fix their permissions and ownership and restart zsh.
														[oh-my-zsh] See the above list for directories with group or other writability.

														[oh-my-zsh] To fix your permissions you can do so by disabling
														[oh-my-zsh] the write permission of "group" and "others" and making sure that the
														[oh-my-zsh] owner of these directories is either root or your current user.
														[oh-my-zsh] The following command may help:
														[oh-my-zsh]     compaudit | xargs chmod g-w,o-w

														[oh-my-zsh] If the above didn't help or you want to skip the verification of
														[oh-my-zsh] insecure directories you can set the variable ZSH_DISABLE_COMPFIX to
														[oh-my-zsh] "true" before oh-my-zsh is sourced in your zshrc file.

														~ ❯ clear
														~ ❯ ls
														Applications Documents    Library      Music        Postman
														Desktop      Downloads    Movies       Pictures     Public

														~ ❯ cd Documents/Christian

														~/Documents/Christian ❯ ls
														Bow-Arch-Test101
														FruityMe-Composable-iOS
														FrutaTCA
														MultiSlider
														Rust_etudes
														Seamlessly
														TAX
														apos-ios
														apos-suite-seeds
														isowords
														schema.json
														sodium
														swift-composable-architecture
														swift-vapor-layered-realworld-example-app
														swiftui-navigation
														xcode-graphql
														xcode-themes

														~/Documents/Christian ❯ git clone https://github.com/kuriishu27/clean-modules-architecture.git
														Cloning into 'clean-modules-architecture'...
														^C

														~/Documents/Christian ❯ git clone https://github.com/kuriishu27/clean-modules-architecture.git
														Cloning into 'clean-modules-architecture'...
														Username for 'https://github.com': kuriishu27
														Password for 'https://kuriishu27@github.com':
														remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
														remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
														fatal: Authentication failed for 'https://github.com/kuriishu27/clean-modules-architecture.git/'

														~/Documents/Christian ❯ git clone https://github.com/kuriishu27/clean-modules-architecture.git
														Cloning into 'clean-modules-architecture'...
														Username for 'https://github.com': kuriishu27
														Password for 'https://kuriishu27@github.com':
														remote: Enumerating objects: 3389, done.
														remote: Counting objects: 100% (3389/3389), done.
														remote: Compressing objects: 100% (1422/1422), done.
														remote: Total 3389 (delta 1891), reused 3321 (delta 1823), pack-reused 0
														Receiving objects: 100% (3389/3389), 2.31 MiB | 1.88 MiB/s, done.
														Resolving deltas: 100% (1891/1891), done.

														~/Documents/Christian ❯ cd clean-modules-architecture                     1m 9s

														~/Doc/C/clean-modules-architecture master ❯ ls
														ExampleMVVM                  Gemfile.lock
														ExampleMVVM.xcodeproj        MVVM Modular Layers Pods.zip
														ExampleMVVMTests             MVVM Templates
														ExampleMVVMUITests           README.md
														Gemfile                      README_FILES

														~/Doc/C/clean-modules-architecture master ❯ git checkout clean-modules
														Branch 'clean-modules' set up to track remote branch 'clean-modules' from 'origin'.
														Switched to a new branch 'clean-modules'

														~/Doc/C/clean-modules-architecture clean-modules ❯ ls
														ExampleMVVM                  Gemfile.lock
														ExampleMVVM.xcodeproj        MVVM Modular Layers Pods.zip
														ExampleMVVM.xcworkspace      MVVM Templates
														ExampleMVVMDependencies      Persistence
														ExampleMVVMTests             README.md
														ExampleMVVMUITests           README_FILES
														Gemfile

														~/Doc/C/clean-modules-architecture clean-modules ❯ open ExampleMVVM.xcworkspace

														~/Doc/C/clean-modules-architecture clean-modules ❯ git restore
														fatal: you must specify path(s) to restore

														~/Doc/C/clean-modules-architecture clean-modules !3 ❯ git restore .

														~/Doc/C/clean-modules-architecture clean-modules ❯ clear
														~/Doc/C/clean-modules-architecture clean-modules !1 ❯ git status
														On branch clean-modules
														Your branch is up to date with 'origin/clean-modules'.

														Changes to be committed:
															(use "git restore --staged <file>..." to unstage)
															renamed:    ExampleMVVM/Application/DIContainer/AppDIContainer.swift -> ExampleMVVM/Application/AppDIContainer.swift
															deleted:    ExampleMVVMDependencies/Sources/MoviesModule/File.swift
															new file:   ExampleMVVMDependencies/Sources/Persistence/CoreDataStorage.swift
															renamed:    Persistence/Sources/Persistence/CoreDataStorage.xcdatamodeld/.xccurrentversion -> ExampleMVVMDependencies/Sources/Persistence/CoreDataStorage.xcdatamodeld/.xccurrentversion
															renamed:    Persistence/Sources/Persistence/CoreDataStorage.xcdatamodeld/CoreDataStorage 2.xcdatamodel/contents -> ExampleMVVMDependencies/Sources/Persistence/CoreDataStorage.xcdatamodeld/CoreDataStorage 2.xcdatamodel/contents
															renamed:    Persistence/Sources/Persistence/CoreDataStorage.xcdatamodeld/CoreDataStorage.xcdatamodel/contents -> ExampleMVVMDependencies/Sources/Persistence/CoreDataStorage.xcdatamodeld/CoreDataStorage.xcdatamodel/contents
															deleted:    Persistence/.gitignore
															deleted:    Persistence/Package.swift
															deleted:    Persistence/README.md
															deleted:    Persistence/Sources/Persistence/CoreDataStorage.swift
															deleted:    Persistence/Tests/MyLibraryTests/MyLibraryTests.swift

														Changes not staged for commit:
															(use "git add <file>..." to update what will be committed)
															(use "git restore <file>..." to discard changes in working directory)
															modified:   ExampleMVVM.xcodeproj/project.pbxproj
															modified:   ExampleMVVM.xcworkspace/contents.xcworkspacedata
															modified:   ExampleMVVM/Application/AppDIContainer.swift
															modified:   ExampleMVVM/Application/AppDelegate.swift
															modified:   ExampleMVVM/Application/AppFlowCoordinator.swift
															modified:   ExampleMVVMDependencies/Package.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Data/Network/DataMapping/MoviesResponseDTO+Mapping.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Data/PersistentStorages/MoviesQueriesStorage/CoreDataStorage/CoreDataMoviesQueriesStorage.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Data/PersistentStorages/MoviesQueriesStorage/CoreDataStorage/EntityMapping/MovieQueryEntity+Mapping.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Data/PersistentStorages/MoviesResponseStorage/CoreDataMoviesResponseStorage.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Data/PersistentStorages/MoviesResponseStorage/EntityMapping/MoviesResponseEntity+Mapping.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Data/PersistentStorages/MoviesResponseStorage/MoviesResponseStorage.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Domain/Entities/Movie.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Domain/UseCases/FetchRecentMovieQueriesUseCase.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Flows/MoviesSearchFlowCoordinator.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/MoviesSceneDIContainer.swift
															modified:   ExampleMVVMDependencies/Sources/Persistence/CoreDataStorage.swift


														~/Doc/C/clean-modules-architecture clean-modules +15 !17 ❯ git add .

														~/Doc/C/clean-modules-architecture clean-modules +30 ❯ git commit -m "feat: move persistence and fix compile errors"
														[clean-modules 16e2ce0] feat: move persistence and fix compile errors
														 26 files changed, 310 insertions(+), 379 deletions(-)
														 rename ExampleMVVM/Application/{DIContainer => }/AppDIContainer.swift (95%)
														 rewrite ExampleMVVM/Application/AppDelegate.swift (82%)
														 rewrite ExampleMVVM/Application/AppFlowCoordinator.swift (86%)
														 rewrite ExampleMVVMDependencies/Sources/MoviesModule/Domain/Entities/Movie.swift (78%)
														 delete mode 100644 ExampleMVVMDependencies/Sources/MoviesModule/File.swift
														 rewrite ExampleMVVMDependencies/Sources/MoviesModule/MoviesSceneDIContainer.swift (94%)
														 create mode 100644 ExampleMVVMDependencies/Sources/Persistence/CoreDataStorage.swift
														 rename {Persistence => ExampleMVVMDependencies}/Sources/Persistence/CoreDataStorage.xcdatamodeld/.xccurrentversion (100%)
														 rename {Persistence => ExampleMVVMDependencies}/Sources/Persistence/CoreDataStorage.xcdatamodeld/CoreDataStorage 2.xcdatamodel/contents (100%)
														 rename {Persistence => ExampleMVVMDependencies}/Sources/Persistence/CoreDataStorage.xcdatamodeld/CoreDataStorage.xcdatamodel/contents (100%)
														 delete mode 100644 Persistence/.gitignore
														 delete mode 100644 Persistence/Package.swift
														 delete mode 100644 Persistence/README.md
														 delete mode 100644 Persistence/Sources/Persistence/CoreDataStorage.swift
														 delete mode 100644 Persistence/Tests/MyLibraryTests/MyLibraryTests.swift

														~/Doc/C/clean-modules-architecture clean-modules ⇡1 ❯ git push
														Username for 'https://github.com': kuriishu27
														Password for 'https://kuriishu27@github.com':
														Enumerating objects: 77, done.
														Counting objects: 100% (77/77), done.
														Delta compression using up to 8 threads
														Compressing objects: 100% (44/44), done.
														Writing objects: 100% (46/46), 8.72 KiB | 744.00 KiB/s, done.
														Total 46 (delta 17), reused 5 (delta 0), pack-reused 0
														remote: Resolving deltas: 100% (17/17), completed with 15 local objects.
														To https://github.com/kuriishu27/clean-modules-architecture.git
															 41665db..16e2ce0  clean-modules -> clean-modules

														~/Doc/C/clean-modules-architecture clean-modules ❯ cd                       25s
														cd L
														~ ❯ cd Library/Keyboard\ Layouts

														~/Library/Keyboard Layouts ❯ ls

														~/Library/Keyboard Layouts ❯ open .

														~/Library/Keyboard Layouts ❯ cd --

														~ ❯ cd -
														~/Library/Keyboard Layouts

														~/Library/Keyboard Layouts ❯ cd -
														~

														~ ❯ cd -
														~/Library/Keyboard Layouts

														~/Library/Keyboard Layouts ❯ cd -
														~

														~ ❯ cd -
														~/Library/Keyboard Layouts

														~/Library/Keyboard Layouts ❯ cd -
														~

														~ ❯ cd ---
														cd: no such file or directory: ---

														~ ❯ cd --

														~ ❯ cd Documents/Christian/clean-modules-architecture

														~/Doc/C/clean-modules-architecture clean-modules !3 ❯ open ExampleMVVM.xcworkspace

														~/Doc/C/clean-modules-architecture clean-modules !3 ❯ git status
														On branch clean-modules
														Your branch is up to date with 'origin/clean-modules'.

														Changes not staged for commit:
															(use "git add <file>..." to update what will be committed)
															(use "git restore <file>..." to discard changes in working directory)
															modified:   ExampleMVVMDependencies/Sources/Common/Utils/Protocols/StoryboardInstantiable.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/MovieDetails/View/MovieDetailsViewController.storyboard
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/MovieDetails/View/MovieDetailsViewController.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/MoviesList/View/MoviesListViewController.storyboard
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/MoviesList/View/MoviesListViewController.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/MoviesQueriesList/View/UIKit/MoviesQueriesTableViewController.swift
															modified:   ExampleMVVMDependencies/Sources/Persistence/CoreDataStorage.swift

														no changes added to commit (use "git add" and/or "git commit -a")

														~/Doc/C/clean-modules-architecture clean-modules !7 ❯ git add .

														~/Doc/C/clean-modules-architecture clean-modules +7 ❯ git commit -m "fix: module selection in Storyboards"
														[clean-modules 4113bae] fix: module selection in Storyboards
														 7 files changed, 43 insertions(+), 29 deletions(-)

														~/Doc/C/clean-modules-architecture clean-modules ⇡1 ❯ git push
														Username for 'https://github.com': kuriishu27
														Password for 'https://kuriishu27@github.com':
														Enumerating objects: 42, done.
														Counting objects: 100% (42/42), done.
														Delta compression using up to 8 threads
														Compressing objects: 100% (23/23), done.
														Writing objects: 100% (23/23), 7.49 KiB | 3.74 MiB/s, done.
														Total 23 (delta 12), reused 0 (delta 0), pack-reused 0
														remote: Resolving deltas: 100% (12/12), completed with 12 local objects.
														To https://github.com/kuriishu27/clean-modules-architecture.git
															 16e2ce0..4113bae  clean-modules -> clean-modules

														~/Doc/C/clean-modules-architecture clean-modules ❯ git push                 19s
														Username for 'https://github.com': ^C

														~/Doc/C/clean-modules-architecture clean-modules ❯ git status             ✘ INT
														On branch clean-modules
														Your branch is up to date with 'origin/clean-modules'.

														Changes to be committed:
															(use "git restore --staged <file>..." to unstage)
															deleted:    ExampleMVVMDependencies/Tests/ExampleMVVMDependenciesTests/ExampleMVVMDependenciesTests.swift
															renamed:    ExampleMVVMTests/Domain/UseCases/SearchMoviesUseCaseTests.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Domain/UseCases/SearchMoviesUseCaseTests.swift
															renamed:    ExampleMVVMTests/Infrastructure/Network/DataTransferServiceTests.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Infrastructure/Network/DataTransferServiceTests.swift
															renamed:    ExampleMVVMTests/Infrastructure/Network/Mocks/NetworkConfigurableMock.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Infrastructure/Network/Mocks/NetworkConfigurableMock.swift
															renamed:    ExampleMVVMTests/Infrastructure/Network/Mocks/NetworkSessionManagerMock.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Infrastructure/Network/Mocks/NetworkSessionManagerMock.swift
															renamed:    ExampleMVVMTests/Infrastructure/Network/NetworkServiceTests.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Infrastructure/Network/NetworkServiceTests.swift
															renamed:    ExampleMVVM/Mocks/Movie+Stub.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Mocks/Movie+Stub.swift
															renamed:    ExampleMVVMTests/Presentation/MoviesScene/Mocks/PosterImagesRepositoryMock.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Presentation/MoviesScene/Mocks/PosterImagesRepositoryMock.swift
															renamed:    ExampleMVVMTests/Presentation/MoviesScene/MovieDetailsViewModelTests.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Presentation/MoviesScene/MovieDetailsViewModelTests.swift
															renamed:    ExampleMVVMTests/Presentation/MoviesScene/MoviesListViewModelTests.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Presentation/MoviesScene/MoviesListViewModelTests.swift
															renamed:    ExampleMVVMTests/Presentation/MoviesScene/MoviesQueriesListViewModelTests.swift -> ExampleMVVMDependencies/Tests/MoviesModuleTests/Presentation/MoviesScene/MoviesQueriesListViewModelTests.swift

														Changes not staged for commit:
															(use "git add <file>..." to update what will be committed)
															(use "git restore <file>..." to discard changes in working directory)
															modified:   ExampleMVVM.xcodeproj/project.pbxproj
															modified:   ExampleMVVMDependencies/Package.swift
															modified:   ExampleMVVMDependencies/Sources/MoviesModule/Data/Network/DataMapping/MoviesRequestDTO+Mapping.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Domain/UseCases/SearchMoviesUseCaseTests.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Infrastructure/Network/DataTransferServiceTests.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Infrastructure/Network/Mocks/NetworkConfigurableMock.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Infrastructure/Network/Mocks/NetworkSessionManagerMock.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Infrastructure/Network/NetworkServiceTests.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Mocks/Movie+Stub.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Presentation/MoviesScene/Mocks/PosterImagesRepositoryMock.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Presentation/MoviesScene/MovieDetailsViewModelTests.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Presentation/MoviesScene/MoviesListViewModelTests.swift
															modified:   ExampleMVVMDependencies/Tests/MoviesModuleTests/Presentation/MoviesScene/MoviesQueriesListViewModelTests.swift

														Untracked files:
															(use "git add <file>..." to include in what will be committed)
															ExampleMVVMDependencies/.swiftpm/xcode/xcshareddata/


														~/Doc/C/clean-modules-architecture clean-modules +21 !13 ?1 ❯ git add .

														~/Doc/C/clean-modules-architecture clean-modules +25 ❯ git commit -m "test: fix missing deps and move to spm"
														[clean-modules 1152a5e] test: fix missing deps and move to spm
														 15 files changed, 93 insertions(+), 149 deletions(-)
														 create mode 100644 ExampleMVVMDependencies/.swiftpm/xcode/xcshareddata/xcschemes/MoviesModuleTests.xcscheme
														 delete mode 100644 ExampleMVVMDependencies/Tests/ExampleMVVMDependenciesTests/ExampleMVVMDependenciesTests.swift
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Domain/UseCases/SearchMoviesUseCaseTests.swift (97%)
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Infrastructure/Network/DataTransferServiceTests.swift (99%)
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Infrastructure/Network/Mocks/NetworkConfigurableMock.swift (93%)
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Infrastructure/Network/Mocks/NetworkSessionManagerMock.swift (95%)
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Infrastructure/Network/NetworkServiceTests.swift (99%)
														 rename {ExampleMVVM => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Mocks/M
														ovie+Stub.swift (91%)
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Presentation/MoviesScene/Mocks/PosterImagesRepositoryMock.swift (84%)
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Presentation/MoviesScene/MovieDetailsViewModelTests.swift (91%)
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Presentation/MoviesScene/MoviesListViewModelTests.swift (98%)
														 rename {ExampleMVVMTests => ExampleMVVMDependencies/Tests/MoviesModuleTests}/Presentation/MoviesScene/MoviesQueriesListViewModelTests.swift (85%)

														~/Doc/C/clean-modules-architecture clean-modules ⇡1 ❯ git push
														Username for 'https://github.com': kuriishu27
														Password for 'https://kuriishu27@github.com':
														Enumerating objects: 56, done.
														Counting objects: 100% (56/56), done.
														Delta compression using up to 8 threads
														Compressing objects: 100% (32/32), done.
														Writing objects: 100% (40/40), 9.87 KiB | 1.97 MiB/s, done.
														Total 40 (delta 7), reused 0 (delta 0), pack-reused 0
														remote: Resolving deltas: 100% (7/7), completed with 6 local objects.
														To https://github.com/kuriishu27/clean-modules-architecture.git
															 4113bae..1152a5e  clean-modules -> clean-modules

														~/Doc/C/clean-modules-architecture clean-modules ❯ vim ~/.gitconfig         10s

														~/Doc/C/clean-modules-architecture clean-modules ❯ git config --global kuriishu2
														7
														error: key does not contain a section: kuriishu27

														~/Doc/C/clean-modules-architecture clean-modules ❯ git config --global "kuriishu27"
														error: key does not contain a section: workspace\$`" ]; then   filetype_parameter="workspace" && file_to_build="`ls -A | grep -i \\.     xcworkspace\$`"; else filetype_parameter="project" && file_to_build="`ls -A |   grep -i \\.xcodeproj\$`"; fi
																			 file_to_build=`echo $file_to_build | awk '{$1=$1;print}'`

																			 xcodebuild build-for-testing test-without-building \
																			 -workspace ExampleMMVM.xcworkspace \
																			 -scheme "AllTests" \
																			 -destination "platform=$platform,name=$device" \
																			 CODE_SIGN_IDENTITY="" \
																			 CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO
														 INSERT   clean-modules   ios.yml   +                              89%    35:33
														-- INSERT --
														 1 ios.yml +                         X
																			 if [ "`ls -A | grep -i \\.   xcworkspace\$`" ]; then                filetype_parameter="workspace" &&      file_to_build="`ls -A | grep -i \\.    xcworkspace\$`"; else                  filetype_parameter="project" &&        file_to_build="`ls -A | grep -i \\.    xcodeproj\$`"; fi
																			 file_to_build=`echo          $file_to_build | awk '{$1=$1;print}'`

																			 xcodebuild build-for-        testing test-without-building \
																			 -workspace ExampleMMVM.      xcworkspace \
																			 -scheme "AllTests" \
																			 -destination                 "platform=$platform,name=$device" \
																			 CODE_SIGN_IDENTITY="" \
																			 CODE_SIGNING_REQUIRED=NO     ONLY_ACTIVE_ARCH=NO
														-- INSERT --s.yml   +     89%    35:33
														 1 ios.yml +                         X
														 name: iOS starter workflow

														 on:
														 1 ios.yml +                         X
														 name: iOS starter workflow

														 on:
														 1 ios.yml +                         X
														 name: iOS starter workflow

														 on:
															 push:
																 branches: [ clean-modules ]
															 pull_request:
																 branches: [ clean-modules ]

														 jobs:
															 build:
																 name: Build and Test default       scheme using any available iPhone      simulator
																 runs-on: macos-latest

																 steps:
																	 - name: Checkout
																		 uses: actions/checkout@v2
																	 - name: Set Default Scheme
																		 run: |
														<odules   ios.yml   +     17%     7:29
(FetchRecentMovieQueriesUseCaseMock()),
                                                        didSelect: didSelect)
        
        // when
        viewModel.didSelect(item: MoviesQueryListItemViewModel(query: selectedQueryItem.query))
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(actionMovieQuery, selectedQueryItem)
    }
}
