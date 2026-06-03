# Translation Status

Baseline game patch: `10.77`

| File | Status | Notes |
| --- | --- | --- |
| `Content/Data/spu_bonuses.csv` | translated | 규칙 기반 보너스 라벨 번역 |
| `Content/Data/main_menu_taglines.csv` | translated | 짧은 로딩/메뉴 문구 초안 완료 |
| `Content/Data/directive_paths.csv` | translated | 지령 경로/목표/진행 문구 |
| `Content/Data/player_transmissions.csv` | translated | 이벤트 지문과 선택지, 카테고리별 한국어 문장 재구성 |
| `Content/GAMEPLAY_GUIDE/*.txt` | translated | 게임 가이드 11개 |

## 원칙

- CSV 헤더, 행 수, 키 열은 원본과 동일하게 유지합니다.
- 자원명과 함선명은 `GLOSSARY.md` 기준으로 통일합니다.
- 숫자, 조건식, 코드값, 백틱 안의 게임 명칭은 되도록 보존합니다.
- 번역 완료 후 `scripts/validate.ps1`로 구조를 확인합니다.

## 적용

- `한국어 적용.bat` 더블클릭: 한국어 적용
- `원본 복원.bat` 더블클릭: 원본 복원
