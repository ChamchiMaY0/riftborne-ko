# Riftborne Korean Translation

Riftborne `10.77` 기준 한국어 번역 작업공간입니다.

## 구조

- `source/10.77/Content`: 설치된 원본 텍스트 스냅샷
- `ko/Content`: 게임에 적용할 한국어 번역본
- `scripts/validate.ps1`: 번역본 CSV/가이드 파일 구조 검증
- `scripts/apply-ko.ps1`: `ko/Content`를 게임의 `Content`에 적용
- `scripts/restore-original.ps1`: `source/10.77/Content` 원본으로 복원
- `GLOSSARY.md`: 반복 용어 기준

## 아주 쉬운 사용법

게임 폴더 또는 `translation-ko` 폴더에서 아래 파일을 더블클릭하세요.

- `한국어 적용.bat`: 한국어 번역 적용
- `원본 복원.bat`: 영어 원본으로 되돌리기

적용 또는 복원 후에는 게임을 완전히 껐다가 다시 실행하세요.

## PowerShell 사용법

번역본 검증:

```powershell
.\scripts\validate.ps1
```

한국어 번역 적용:

```powershell
.\scripts\apply-ko.ps1
```

원본 복원:

```powershell
.\scripts\restore-original.ps1
```

## Git 관리

이 디렉터리 자체가 별도 Git 저장소입니다. Steam 설치 폴더 전체를 추적하지 않고 번역 작업물만 추적합니다.

```powershell
git status
git add .
git commit -m "Update Korean translation"
```

## 현재 번역 상태

- 완료: `spu_bonuses.csv`, `main_menu_taglines.csv`, `directive_paths.csv`, `player_transmissions.csv`, `GAMEPLAY_GUIDE/*.txt`

`player_transmissions.csv`는 이벤트 서사량이 가장 큰 파일이라 카테고리별 한국어 이벤트 문장으로 재구성했습니다. CSV 열 이름과 행 수는 유지했습니다.
