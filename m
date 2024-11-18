Return-Path: <linux-kernel+bounces-413302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8609D171A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6632848C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243951BE86A;
	Mon, 18 Nov 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PT7YBJLd"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF06199EA3;
	Mon, 18 Nov 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950843; cv=none; b=k4YnCZdPbJ2G39XuqL6bJl1c/6bHII8SKL0DXEMaE8xV32MzQ6JBS5rL5RgjEEEEam6Ah7dUNyl6oZYi9fWH5aiw6bhPEyNVXVb5GglVLDFntUJR5/ynEJNs6XsCfdC6oCi4IS/7ljvU4hzvMxxmq+lBwYGWYs96dJQk06BmGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950843; c=relaxed/simple;
	bh=bwHnSCuQVtrTlpQhyPlWKj23jixqEZbgkt3Y4UsfgWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aTLGmJSZERZIT34DOPO0BtQBEvYX6vQBbIGKbqCHSpBTDhtnoVH2tVKxlUltmBnShYZukTjRhHX7/zETwikJfNe7vCYITFTQniA6mBzXlfF+mVUI7xTuu8bSpVrFe77ZbET8Ro631Yra2iqE7pCb9gQbRBQujMkNioxu59Ilyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PT7YBJLd; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ED886403E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731950830; bh=JXQT22vUpsoX4nj2NKfGNaZxp9pjkBawPibRTSeTtOg=;
	h=From:To:Cc:Subject:Date:From;
	b=PT7YBJLdEGCZpS4I5SLgmOps48dfHP802NzL8SiW5Fl6WuIqh98y51fnjjTuyx9Lp
	 e6bDdAeu6NglPqYGkMzkUk7S8sx1HQY6N3I/ldz0gVbv/LHneAVrACuutIgPSu5M6d
	 CWWl12R3PPuUyxrsgtc3UTlW0DcvxmmeaOQfKmeoZRsAISzsPKPw4OI+N3FNDIFXTj
	 tVuS3nsSbxKdpN/B4N9roD0tweauKnRb0rCFPZzWnTKPKHVtmIx8YzxcAphdd/G2Du
	 7jejUyGLEZvz3B8H2KWvnDsDWgSPVYKCH8tM//V3sLlZ9/F/csFEjECnb1fXMK8UoR
	 OClEa8q+enu5w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id ED886403E6;
	Mon, 18 Nov 2024 17:27:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.13
Date: Mon, 18 Nov 2024 10:27:09 -0700
Message-ID: <87seroh2qa.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.13

for you to fetch changes up to c818d5c64c9a8cc14853d716bf7ce6674a6126d0:

  Documentation/CoC: spell out enforcement for unacceptable behaviors (2024=
-11-15 14:31:59 -0700)

----------------------------------------------------------------
Another moderately busy cycle in docsland:

- Work on Chinese translations has picked up again.  Happily, they are
  maintaining the existing translations and not just adding new ones.

- Some maintenance of the Japanese and Italian translations as well.

- The removal of the venerable "dontdiff" file.  It has long outlived its
  usefulness and contained entries ("parse.*") that would actively mask
  actual source change.

- The addition of enforcement information to the code-of-conduct
  documentation.

Along with some build-system fixes and a lot of typo and language fixes.

----------------------------------------------------------------
Abhinav Saxena (1):
      docs: fix typos and whitespace in Documentation/process/backporting.r=
st

Akira Yokosawa (1):
      docs/ja_JP: howto: Catch up changes in v6.11

Andrew Kreimer (2):
      docs: backporting: fix a typo
      Documentation/maintainer-tip: Fix typos

Andr=C3=A9 Almeida (1):
      scripts/kernel-doc: Fix build time warnings

Bernhard M. Wiedemann (1):
      docs/zh_TW+zh_CN: Make rst references unique

Carlos Bilbao (1):
      kernel-docs: Add new section for Rust learning materials

Changhuang Liang (1):
      Documentation: kgdb: Correct parameter error

Chen-Yu Tsai (1):
      scripts/kernel-doc: Do not track section counter across processed fil=
es

Dongliang Mu (15):
      docs/zh_CN: add the translation of kbuild/kconfig.rst
      docs/zh_CN: add the translation of kbuild/kbuild.rst
      docs/zh_CN: add the translations of kbuild/reproducible-builds.rst
      docs/zh_CN: update the translation of process/submitting-patches.rst
      docs/zh_CN: update the translation of process/email-clients.rst
      docs/zh_CN: update the translation of process/coding-style.rst
      docs/zh_CN: update the translation of mm/hmm.rst
      docs/zh_CN: update the translation of mm/active_mm.rst
      docs/zh_CN: update the translation of mm/admon/faq.rst
      docs/zh_CN: update the translation of mm/overcommit-accounting.rst
      docs/zh_CN: update the translation of mm/page_table_check.rst
      docs/zh_CN: update the translation of mm/page_owner.rst
      docs/zh_CN: update the translation of process/programming-language.rst
      docs/zh_CN: add the translation of kbuild/llvm.rst
      docs/zh_CN: fix one sentence in llvm.rst

Eder Zulian (1):
      docs/core-api: swiotlb: fix typos

Federico Vaga (2):
      doc:it_IT: update I2C summary
      doc:it_IT: update documents in process/

Gabriele Monaco (1):
      tracing: doc: Fix typo in ftrace histogram

Guilherme G. Piccoli (1):
      Documentation: Improve crash_kexec_post_notifiers description

Haoyang Liu (2):
      docs/dev-tools: fix a typo
      docs/zh_CN: add translation of dev-tools/kmsan.rst

Jonathan Corbet (2):
      Add Yanteng Si to .mailmap
      docs: remove Documentation/dontdiff

Lucas De Marchi (1):
      Documentation: core-api/cpuhotplug: Fix missing prefix

Matthieu Baerts (NGI0) (1):
      docs: gcov: fix link to LCOV website

Nihar Chaithanya (1):
      docs:process:changes: fix version command for btrfs-progs

Nir Lichtman (2):
      Documentation: English fixes in kgdb/kdb article
      Documentation: Fix incorrect paths/magic in magic numbers rst

Pengyu Zhang (4):
      Docs/mm: Fix a mistake for pfn in page_tables.rst
      Docs/zh_CN: Translate page_tables.rst to Simplified Chinese
      Docs/zh_CN: Fix the pfn calculation error in page_tables.rst
      docs/zh_CN: Add a entry in Chinese glossary

Randy Dunlap (2):
      kernel-doc: allow object-like macros in ReST output
      Documentation: admin: reorganize kernel-parameters intro

Sergio Gonz=C3=A1lez Collado (1):
      docs/sp_SP: Add translation for scheduler/sched-bwc.rst

Shuah Khan (1):
      Documentation/CoC: spell out enforcement for unacceptable behaviors

Steven Rostedt (1):
      Documentation/tracing: Mention that RESET_ATTACK_MITIGATION can clear=
 memory

SurajSonawane2415 (1):
      docs: fix WARNING document not included in any toctree

Thorsten Blum (1):
      docs: Remove redundant word "for"

Thorsten Leemhuis (1):
      docs: bug-bisect: add a note about bisecting -next

Vishnu Sanal T (1):
      fix grammar on false-sharing.rst

Yaxin Wang (1):
      Docs/zh_CN: Translate physical_memory.rst to Simplified Chinese

 .mailmap                                           |   1 +
 Documentation/admin-guide/bug-bisect.rst           |  21 ++
 Documentation/admin-guide/kernel-parameters.rst    |  36 +-
 Documentation/admin-guide/kernel-parameters.txt    |  22 +-
 Documentation/core-api/cpu_hotplug.rst             |   2 +-
 Documentation/core-api/swiotlb.rst                 |   4 +-
 Documentation/dev-tools/gcov.rst                   |   2 +-
 Documentation/dev-tools/kgdb.rst                   |  20 +-
 Documentation/dev-tools/kmsan.rst                  |   2 +-
 Documentation/dontdiff                             | 271 --------------
 Documentation/kernel-hacking/false-sharing.rst     |   4 +-
 Documentation/maintainer/pull-requests.rst         |   2 +-
 Documentation/mm/page_tables.rst                   |   2 +-
 Documentation/process/5.Posting.rst                |   5 -
 Documentation/process/backporting.rst              |   8 +-
 Documentation/process/changes.rst                  |   2 +-
 .../process/code-of-conduct-interpretation.rst     |  87 +++++
 Documentation/process/kernel-docs.rst              | 163 ++++++++-
 Documentation/process/maintainer-tip.rst           |   4 +-
 Documentation/rust/index.rst                       |   3 +
 Documentation/staging/magic-number.rst             |   6 +-
 Documentation/trace/histogram.rst                  |   2 +-
 Documentation/trace/index.rst                      |   1 +
 .../it_IT/{process =3D> dev-tools}/clang-format.rst  |   0
 .../translations/it_IT/dev-tools/index.rst         |  17 +
 Documentation/translations/it_IT/i2c/summary.rst   |  72 ++--
 Documentation/translations/it_IT/index.rst         |   8 +-
 .../translations/it_IT/process/2.Process.rst       |   6 +-
 .../translations/it_IT/process/4.Coding.rst        |   2 +-
 .../translations/it_IT/process/5.Posting.rst       |   5 -
 .../translations/it_IT/process/changes.rst         |  33 +-
 .../translations/it_IT/process/coding-style.rst    |  37 +-
 .../translations/it_IT/process/email-clients.rst   |  33 +-
 Documentation/translations/it_IT/process/howto.rst |  10 +-
 Documentation/translations/it_IT/process/index.rst |  10 -
 .../it_IT/process/submit-checklist.rst             | 167 ++++-----
 .../it_IT/process/submitting-patches.rst           |  23 +-
 Documentation/translations/it_IT/staging/index.rst |  13 +
 .../it_IT/{process =3D> staging}/magic-number.rst    |   0
 Documentation/translations/ja_JP/process/howto.rst |  10 +-
 .../translations/sp_SP/scheduler/index.rst         |   1 +
 .../translations/sp_SP/scheduler/sched-bwc.rst     | 287 +++++++++++++++
 .../translations/zh_CN/dev-tools/gcov.rst          |   8 +-
 .../translations/zh_CN/dev-tools/index.rst         |   2 +-
 .../translations/zh_CN/dev-tools/kmsan.rst         | 392 +++++++++++++++++=
++++
 Documentation/translations/zh_CN/glossary.rst      |   1 +
 Documentation/translations/zh_CN/kbuild/index.rst  |   9 +-
 Documentation/translations/zh_CN/kbuild/kbuild.rst | 304 ++++++++++++++++
 .../translations/zh_CN/kbuild/kconfig.rst          | 259 ++++++++++++++
 Documentation/translations/zh_CN/kbuild/llvm.rst   | 203 +++++++++++
 .../zh_CN/kbuild/reproducible-builds.rst           | 114 ++++++
 Documentation/translations/zh_CN/mm/active_mm.rst  |   5 +
 Documentation/translations/zh_CN/mm/damon/faq.rst  |  17 -
 Documentation/translations/zh_CN/mm/hmm.rst        |   8 +-
 Documentation/translations/zh_CN/mm/index.rst      |   2 +
 .../zh_CN/mm/overcommit-accounting.rst             |   3 +-
 Documentation/translations/zh_CN/mm/page_owner.rst |  46 +++
 .../translations/zh_CN/mm/page_table_check.rst     |  13 +
 .../translations/zh_CN/mm/page_tables.rst          | 221 ++++++++++++
 .../translations/zh_CN/mm/physical_memory.rst      | 356 +++++++++++++++++=
++
 .../translations/zh_CN/process/5.Posting.rst       |   4 -
 .../translations/zh_CN/process/coding-style.rst    |  11 -
 .../translations/zh_CN/process/email-clients.rst   |   9 +-
 .../zh_CN/process/programming-language.rst         |  78 ++--
 .../zh_CN/process/submitting-patches.rst           |  19 +-
 .../translations/zh_TW/dev-tools/gcov.rst          |   8 +-
 .../translations/zh_TW/process/5.Posting.rst       |   4 -
 scripts/kernel-doc                                 |  49 ++-
 68 files changed, 2892 insertions(+), 657 deletions(-)
 delete mode 100644 Documentation/dontdiff
 rename Documentation/translations/it_IT/{process =3D> dev-tools}/clang-for=
mat.rst (100%)
 create mode 100644 Documentation/translations/it_IT/dev-tools/index.rst
 create mode 100644 Documentation/translations/it_IT/staging/index.rst
 rename Documentation/translations/it_IT/{process =3D> staging}/magic-numbe=
r.rst (100%)
 create mode 100644 Documentation/translations/sp_SP/scheduler/sched-bwc.rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/kmsan.rst
 create mode 100644 Documentation/translations/zh_CN/kbuild/kbuild.rst
 create mode 100644 Documentation/translations/zh_CN/kbuild/kconfig.rst
 create mode 100644 Documentation/translations/zh_CN/kbuild/llvm.rst
 create mode 100644 Documentation/translations/zh_CN/kbuild/reproducible-bu=
ilds.rst
 create mode 100644 Documentation/translations/zh_CN/mm/page_tables.rst
 create mode 100644 Documentation/translations/zh_CN/mm/physical_memory.rst

