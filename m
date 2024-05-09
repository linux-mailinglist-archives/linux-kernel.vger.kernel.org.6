Return-Path: <linux-kernel+bounces-174724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215E8C13EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE4B1F231BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678C91772D;
	Thu,  9 May 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dw1AMswL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4B8F44;
	Thu,  9 May 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275193; cv=none; b=psNjgykpJaiSYhCetkIrZbeE4NPvPjAHG+E5yRIaoa7WCUuU4hPqJ8hPil/0IANKo+s6gw/tn6d5kZxaC32IptCt1FpCg/BwOladK6FX1/kv0WwMBA27fZ2TsxQLK6/xQOVhS5cqMnRhZTTeehFOLBshg9Rlt+G46PNTOuPN/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275193; c=relaxed/simple;
	bh=njVJhPYTY7QZXEzuBJZoTj08MKt7XEQaV4NwIAuOXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VvA+AKq/jRla4zE4yy1AfXYpxzjzA9vN7cTqy1IzMgnXPGJQqTbOnjUrvI1SM1enGmYWYwxoLGXIlfhqXrdb5/InrZurPfeodftdLfU3s4IuDfY8Y/uVZ28HzqS3qJf9DLBy2CVOVGEDhNhNHBGo27i1HCfgL6AHNI+ZJSEUN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dw1AMswL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AA4CB47C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1715275190; bh=PAMUt32y0QNc76LMdn9onaaI6cKU/+ZKxO8RgXaW/UY=;
	h=From:To:Cc:Subject:Date:From;
	b=dw1AMswL6ryvgfcO/EHzVn3BjuNarLuQaajbfglD36sIYnzC5IuxObm1cBzCd0Rme
	 drfy5TeChRNYhcgoLxxKggWSiWKbELen3C2+XHARpK5iQfAhcRFdy5q+FxIjdKgBEc
	 tZM7rSxYTR/wh2/qSgPqTKDnLIiXpTgx9ep8LO8reOUiS4TTq3I5UBA3MiFHqEaO2D
	 OjBW3AdTavhU5128oquUKOU3bbyEfjrXfSajLDKwH8m0CCmasxPkZFBVJM4iQ7y0bY
	 rpy5uumU+H3/lttwk+Rc8/F/s0dZxESX5sUyBiS8AmZRaoenhIgbLeA+imj/yYCdPE
	 M0NaMeNpUnVpw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AA4CB47C39;
	Thu,  9 May 2024 17:19:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.10
Date: Thu, 09 May 2024 11:19:49 -0600
Message-ID: <87fruqc37u.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[Sending early to clear the decks before entering the LSFMM maelstrom]

The following changes since commit e9c44c1beaba623b12201d2028bc20f535464d9b:

  docs: zswap: fix shell command format (2024-03-29 08:59:01 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.10

for you to fetch changes up to db5b4f3253ff73bc2e926ec76e1c0f662b38d9a4:

  cgroup: Add documentation for missing zswap memory.stat (2024-05-09 10:54=
:37 -0600)

----------------------------------------------------------------
Another not-too-busy cycle for documentation, including:

- Some build-system changes to detect the variable fonts installed by some
  distributions that can break the PDF build.

- Various updates and additions to the Spanish, Chinese, Italian, and
  Japanese translations.

- Update the stable-kernel rules to match modern practice

..and the usual array of corrections, updates, and typo fixes.

----------------------------------------------------------------
Akira Yokosawa (4):
      docs: Detect variable fonts and suggest denylisting them
      docs: ja_JP/howto: Catch up update in v6.8
      docs: kernel_include.py: Cope with docutils 0.21
      docs: scripts/check-variable-fonts.sh: Improve commands for detection

Avadhut Naik (4):
      docs/sp_SP: Update process/submitting-patches
      docs/sp_SP: Add translation of process/development-process.rst
      docs/sp_SP: Add translation of process/1.Intro.rst
      docs/sp_SP: Add translation of process/2.Process.rst

Bird, Tim (1):
      docs: stable-kernel-rules: fix typo sent->send

Carlos Bilbao (1):
      docs/MAINTAINERS: Update my email address

Dennis Lam (1):
      docs:core-api: fixed typos and grammar in printk-index page

Dongliang Mu (3):
      docs/zh_CN: Add dev-tools/ubsan Chinese translation
      docs/zh_CN: add process/cve Chinese translation
      docs/zh_CN: remove two inconsistent spaces

Federico Vaga (1):
      doc:it_IT: align Italian documentation

Frank Li (1):
      docs: dma: correct dma_set_mask() sample code

Geert Uytterhoeven (1):
      docs/zh: Fix Cc, Co-developed-by, and Signed-off-by tags

Haoyang Liu (2):
      docs/zh_CN: Add dev-tools/kmemleak Chinese translation
      docs/zh_CN: Add dev-tools/kcov Chinese translation

Ivan Orlov (1):
      docs, kprobes: Add riscv as supported architecture

Karel Balej (1):
      docs: *-regressions.rst: unify quoting, add missing word

Kees Cook (1):
      kernel-doc: fix struct_group_tagged() parsing

Li Hua (1):
      scripts/sphinx-pre-install: fix Arch xelatex dependency

Lukas Bulwahn (1):
      MAINTAINERS: repair file entry in DOCUMENTATION

Maki Hatano (1):
      doc: fix spelling about ReStructured Text

Ma=C3=ADra Canal (1):
      mm: Update shuffle documentation to match its current state

Remington Brasga (1):
      Docs: typos/spelling

Sarat Mandava (1):
      trace doc: Minor grammatical correction

Saurav Shah (1):
      Documentation: tracing: Fix spelling mistakes

Thomas Wei=C3=9Fschuh (1):
      admin-guide/hw-vuln/core-scheduling: fix return type of PR_SCHED_CORE=
_GET

Thorsten Blum (1):
      scripts: sphinx-pre-install: Add pyyaml hint to other distros

Thorsten Leemhuis (5):
      docs: stable-kernel-rules: reduce redundancy
      docs: stable-kernel-rules: call mainline by its name and change examp=
le
      docs: stable-kernel-rules: remove code-labels tags and a indention le=
vel
      docs: stable-kernel-rules: explain use of stable@kernel.org (w/o @vge=
r.)
      docs: stable-kernel-rules: create special tag to flag 'no backporting'

Usama Arif (1):
      cgroup: Add documentation for missing zswap memory.stat

Utkarsh Tripathi (1):
      kernel-doc: Added "*" in $type_constants2 to fix 'make htmldocs' warn=
ing.

Yanteng Si (4):
      docs/zh_CN/rust: Update the translation of arch-support to 6.9-rc4
      docs/zh_CN/rust: Update the translation of coding-guidelines to 6.9-r=
c4
      docs/zh_CN/rust: Update the translation of general-information to 6.9=
-rc4
      docs/zh_CN/rust: Update the translation of quick-start to 6.9-rc4

 .mailmap                                           |   1 +
 Documentation/Makefile                             |   7 +-
 Documentation/admin-guide/cgroup-v2.rst            |   9 +
 .../admin-guide/hw-vuln/core-scheduling.rst        |   4 +-
 Documentation/admin-guide/hw-vuln/srso.rst         |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 Documentation/admin-guide/mm/ksm.rst               |   2 +-
 .../admin-guide/reporting-regressions.rst          |  10 +-
 Documentation/arch/m68k/buddha-driver.rst          |   2 +-
 Documentation/arch/sparc/oradax/dax-hv-api.txt     |   2 +-
 Documentation/arch/x86/xstate.rst                  |   2 +-
 Documentation/core-api/dma-api-howto.rst           |  24 +-
 Documentation/core-api/entry.rst                   |   2 +-
 Documentation/core-api/printk-index.rst            |   4 +-
 Documentation/doc-guide/parse-headers.rst          |   2 +-
 Documentation/driver-api/mtd/nand_ecc.rst          |   2 +-
 Documentation/driver-api/scsi.rst                  |   2 +-
 Documentation/driver-api/usb/usb.rst               |   2 +-
 Documentation/driver-api/wbrf.rst                  |   2 +-
 Documentation/filesystems/directory-locking.rst    |   4 +-
 Documentation/filesystems/porting.rst              |   4 +-
 Documentation/index.rst                            |   2 +-
 Documentation/mm/slub.rst                          |   2 +-
 Documentation/process/handling-regressions.rst     |   2 +-
 Documentation/process/stable-kernel-rules.rst      | 236 +++++----
 Documentation/security/SCTP.rst                    |   2 +-
 Documentation/security/snp-tdx-threat-model.rst    |   2 +-
 Documentation/sphinx/kernel_include.py             |   1 -
 Documentation/sphinx/kerneldoc-preamble.sty        |   9 +-
 Documentation/trace/fprobetrace.rst                |   4 +-
 Documentation/trace/ftrace.rst                     |   2 +-
 Documentation/trace/kprobes.rst                    |   1 +
 Documentation/trace/kprobetrace.rst                |   2 +-
 Documentation/trace/tracepoints.rst                |   2 +-
 .../translations/it_IT/doc-guide/kernel-doc.rst    |  10 +-
 Documentation/translations/it_IT/index.rst         |   2 +-
 .../translations/it_IT/process/2.Process.rst       |   9 +-
 .../translations/it_IT/process/4.Coding.rst        |   4 +
 .../it_IT/process/7.AdvancedTopics.rst             |  19 +
 .../translations/it_IT/process/changes.rst         |  36 +-
 .../translations/it_IT/process/coding-style.rst    |  12 +-
 .../translations/it_IT/process/deprecated.rst      |   2 +-
 Documentation/translations/it_IT/process/howto.rst |   6 +-
 Documentation/translations/it_IT/process/index.rst |  68 ++-
 .../{admin-guide =3D> process}/security-bugs.rst     |   0
 .../it_IT/process/stable-kernel-rules.rst          |   2 +-
 .../it_IT/process/submitting-patches.rst           |  27 +
 Documentation/translations/ja_JP/process/howto.rst |   2 +-
 Documentation/translations/sp_SP/index.rst         |   2 +-
 .../translations/sp_SP/memory-barriers.txt         |   4 +-
 .../translations/sp_SP/process/1.Intro.rst         | 302 ++++++++++++
 .../translations/sp_SP/process/2.Process.rst       | 542 +++++++++++++++++=
++++
 .../translations/sp_SP/process/3.Early-stage.rst   |  11 +
 .../translations/sp_SP/process/4.Coding.rst        |  11 +
 .../translations/sp_SP/process/5.Posting.rst       |  11 +
 .../translations/sp_SP/process/6.Followthrough.rst |  11 +
 .../sp_SP/process/7.AdvancedTopics.rst             |  11 +
 .../translations/sp_SP/process/8.Conclusion.rst    |  11 +
 .../translations/sp_SP/process/code-of-conduct.rst |   2 +-
 .../translations/sp_SP/process/coding-style.rst    |   2 +-
 .../sp_SP/process/development-process.rst          |  27 +
 .../translations/sp_SP/process/email-clients.rst   |   2 +-
 Documentation/translations/sp_SP/process/howto.rst |   2 +-
 Documentation/translations/sp_SP/process/index.rst |   1 +
 .../translations/sp_SP/process/kernel-docs.rst     |   2 +-
 .../sp_SP/process/kernel-enforcement-statement.rst |   2 +-
 .../translations/sp_SP/process/magic-number.rst    |   2 +-
 .../sp_SP/process/programming-language.rst         |   2 +-
 .../sp_SP/process/submitting-patches.rst           |  30 +-
 .../translations/zh_CN/dev-tools/index.rst         |   6 +-
 .../translations/zh_CN/dev-tools/kcov.rst          | 359 ++++++++++++++
 .../translations/zh_CN/dev-tools/kmemleak.rst      | 229 +++++++++
 .../translations/zh_CN/dev-tools/ubsan.rst         |  91 ++++
 Documentation/translations/zh_CN/index.rst         |   4 +-
 Documentation/translations/zh_CN/process/cve.rst   |  89 ++++
 Documentation/translations/zh_CN/process/index.rst |   1 +
 .../zh_CN/process/submitting-patches.rst           |   8 +-
 .../translations/zh_CN/rust/arch-support.rst       |  14 +-
 .../translations/zh_CN/rust/coding-guidelines.rst  |  12 +
 .../zh_CN/rust/general-information.rst             |   2 +-
 .../translations/zh_CN/rust/quick-start.rst        |  50 +-
 .../zh_TW/process/submit-checklist.rst             |   2 +-
 .../zh_TW/process/submitting-patches.rst           |   8 +-
 MAINTAINERS                                        |   9 +-
 mm/Kconfig                                         |   7 +-
 scripts/check-variable-fonts.sh                    | 115 +++++
 scripts/kernel-doc                                 |   5 +-
 scripts/sphinx-pre-install                         |   5 +-
 88 files changed, 2299 insertions(+), 274 deletions(-)
 rename Documentation/translations/it_IT/{admin-guide =3D> process}/securit=
y-bugs.rst (100%)
 create mode 100644 Documentation/translations/sp_SP/process/1.Intro.rst
 create mode 100644 Documentation/translations/sp_SP/process/2.Process.rst
 create mode 100644 Documentation/translations/sp_SP/process/3.Early-stage.=
rst
 create mode 100644 Documentation/translations/sp_SP/process/4.Coding.rst
 create mode 100644 Documentation/translations/sp_SP/process/5.Posting.rst
 create mode 100644 Documentation/translations/sp_SP/process/6.Followthroug=
h.rst
 create mode 100644 Documentation/translations/sp_SP/process/7.AdvancedTopi=
cs.rst
 create mode 100644 Documentation/translations/sp_SP/process/8.Conclusion.r=
st
 create mode 100644 Documentation/translations/sp_SP/process/development-pr=
ocess.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/kcov.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/kmemleak.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/ubsan.rst
 create mode 100644 Documentation/translations/zh_CN/process/cve.rst
 create mode 100755 scripts/check-variable-fonts.sh

