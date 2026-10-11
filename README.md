# learning-rust-with-rustlings

[Rustlings](https://github.com/rust-lang/rustlings) 문제를 풀며 Rust를 학습하는 저장소입니다.

현재 문제 구성은 **Rustlings 6.5.0** 기준이며, 이후 릴리스에 맞춰 업데이트합니다.

## 시작하기

### 준비

- Rust와 Cargo: 최신 stable 권장
  - Rustlings `6.5.0`의 최소 지원 Rust 버전은 [1.88](https://github.com/rust-lang/rustlings/releases/tag/v6.5.0)

`rust-toolchain.toml`은 이 프로젝트에서 `stable` 툴체인을 선택하고 Clippy, rustfmt, rust-src를 포함하도록 설정합니다.
rust-src는 에디터의 표준 라이브러리 분석과 정의 이동에 사용하는 소스입니다.
Rustup으로 설치한 환경에서는 필요한 툴체인과 구성 요소가 없을 때 자동으로 설치합니다.
Rust 버전은 고정하지 않으며, 이미 설치된 stable을 최신 버전으로 갱신하려면 다음을 실행하세요.

```sh
rustup update stable
```

```sh
# Installation
cargo install rustlings

rustlings --version
```

설치 버전은 고정하지 않습니다. `cargo install rustlings`는 설치 시점의 최신 안정 버전을 설치하므로,
`rustlings --version`으로 확인하세요.

위의 최소 Rust 버전은 6.5.0 기준이며, 이후 버전에서는 달라질 수 있습니다.

> 최신 실행기와 현재 문제 구성이 호환되지 않는 경우, 해당 릴리스의 변경사항을 확인하세요.

### 학습 시작

```sh
git clone https://github.com/bossm0n5t3r/learning-rust-with-rustlings.git
cd learning-rust-with-rustlings
rustlings
```

이 저장소에는 이미 문제가 생성되어 있으므로 **`rustlings init`을 다시 실행할 필요가 없습니다.**

Rustlings가 안내하는 `exercises/`의 파일을 수정하세요. 저장하면 변경을 감지해 다시 검증합니다.
문제에 포함된 컴파일 오류나 실패하는 테스트는 학습을 위한 것으로, 초기 상태에서는 정상입니다.

```sh
# 다음 미완료 문제의 힌트 확인
rustlings hint

# 다음 미완료 문제를 한 번 실행
rustlings run
```

전체 `cargo test` 성공을 학습 시작 조건으로 삼지 말고, Rustlings가 안내하는 문제별 검증을 기준으로 진행합니다.

## 프로젝트 구조

| 경로                  | 역할                                                                   |
| --------------------- | ---------------------------------------------------------------------- |
| `exercises/`          | 직접 수정하며 풀어가는 문제                                            |
| `solutions/`          | 문제 완료 후 Rustlings가 자동으로 채우는 공식 해답. 직접 수정하지 않음 |
| `Cargo.toml`          | 문제와 공식 해답의 실행 대상 설정                                      |
| `rust-toolchain.toml` | stable 툴체인과 Clippy·rustfmt·rust-src 구성 요소 설정                 |
| `rust-analyzer.toml`  | 에디터의 Rust 분석 설정                                                |
| `init-rustlings.sh`   | 공식 문제를 생성해 현재 프로젝트 루트로 가져오는 초기화 스크립트       |
| `.gitignore`          | 빌드 산출물, `Cargo.lock`, macOS 메타데이터 등을 제외하는 규칙         |

문제와 Rust Book의 장별 대응은 [exercises/README.md](exercises/README.md)를 참고하세요.
공식 해답에 대한 설명은 [solutions/README.md](solutions/README.md)에 있습니다.

## 문제 초기화 또는 교체

**새로 시작하거나 문제 구성을 교체할 때만 사용하세요. 재실행하면 기존 풀이와 같은 이름의 파일을 덮어씁니다.**
실행 전 현재 작업을 커밋해 복구할 기준점을 확보하세요.

스크립트는 POSIX 셸, `rustlings`, `rsync`, `curl`, `awk`와 인터넷 연결이 필요합니다.
설치된 Rustlings 버전의 문제를 생성하므로 먼저 `rustlings --version`으로 버전을 확인하세요.

프로젝트 루트에서 실행합니다.

```sh
./init-rustlings.sh
```

1. 임시 디렉터리에서 `rustlings init`을 실행합니다. 안내가 나오면 Enter를 누릅니다.
2. LICENSE에 추가할 연도와 저작권자를 차례로 입력합니다. 스크립트가 `Copyright (c) <연도> <저작권자>` 형식으로 조합하며, 둘 중 하나에서 Enter만 누르면 고지를 추가하지 않습니다.
3. `.vscode/`와 `.gitignore`를 가져올지 각각 `[y/N]`으로 묻습니다.
   - `y` 또는 `Y`: 복사하고 같은 이름의 파일을 덮어씁니다.
   - `n`, `N` 또는 Enter: 복사하지 않고 현재 파일을 유지합니다.
4. 생성된 `.git`은 제외하고 나머지를 현재 프로젝트 루트로 복사합니다. 기존 Git 이력은 유지됩니다.
5. 임시 디렉터리를 정리합니다.

초기화 과정에서 [upstream의 MIT LICENSE](https://raw.githubusercontent.com/rust-lang/rustlings/refs/heads/main/LICENSE)를
다운로드하고, 원저작자 고지 아래에 입력한 연도와 저작권자로 구성한 고지를 추가해 루트 `LICENSE`로 복사합니다.
기존 `LICENSE`도 덮어쓰며, 다운로드가 실패하면 프로젝트 파일을 복사하기 전에 중단합니다.

복사는 같은 이름의 파일을 덮어쓰지만, 생성본에 없는 기존 파일을 삭제하지는 않습니다.
`.gitignore` 복사를 선택하면 저장소에서 직접 추가한 규칙도 대체되므로 실행 후 확인하세요.

```sh
git status --short
git diff
```

> 초기화 중 Clippy가 없다는 오류가 나오면 `rustup component add clippy`로 설치하세요.

## 셸 스크립트 포맷팅

`shfmt`가 설치된 환경에서 프로젝트 루트에서 실행합니다.
POSIX 문법, 공백 4칸 들여쓰기, `case` 분기 들여쓰기와 리다이렉션 뒤 공백을 적용합니다.

```sh
shfmt -ln posix -i 4 -ci -sr -w init-rustlings.sh
```

## 참고 자료

- [Rustlings 설치 안내](https://rustlings.rust-lang.org/setup/)
- [Rustlings 사용 안내](https://rustlings.rust-lang.org/usage/)
- [The Rust Programming Language](https://doc.rust-lang.org/book/)
