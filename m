Return-Path: <linux-kernel+bounces-256700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31299935224
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57A3282C52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790A1459EE;
	Thu, 18 Jul 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oWmucIWY"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70443AC0;
	Thu, 18 Jul 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331090; cv=none; b=slBs69nVN0F2p7pHNb3F7sJQ58rq6WzdahUG9mBv8kJqgNMHdLu+AmTjfTJzNi2BnjTMUICtcnd00YoPZTGRrYppxEHPwfrC3a/Qyp4X3PFMdo5dMC3iGN0ry8gynGYc+OzTW7Hlu8DjHU15XDdTZFNzhUlGue/9bP8TtV7DaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331090; c=relaxed/simple;
	bh=LlATn9f8yh0ZA5onRSoyvAEjmEKeKHAm1Gt0gn5azUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UThUjH1pm9XlV3C3PL7Jmnp6CHWcfkpuPaJVxIZJqd4PvRnMUDs6v7QASx1HDLOrWQRFVT8WCQp6QIxP1s7CBYGoSLNbeRy00FF0OuT36n+Pe3gEl+oqJptfd55bk2TcWJ7OZTF6q6wfEYiYWkvotjT1ZOzZJ0v++RmBt3dem/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oWmucIWY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 956F2418A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1721331081; bh=wKXPxQIwAOP1+p21c93zBa6wwpy9UaGpCPkg+byznUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oWmucIWYsBZMvMncEwyrTbzT0tqhysgrhvy1NdYTKA3aePBFGSqQMlY15GY4dPE75
	 97BGtfzY7JUTgKYbiTjBhE+TJvBiDfx2Fg1v2bEKxvIn1VjnVkBsPGwwBiWOmlYMVm
	 0NaY8bdpV9RAloMpZ8ba1/UqhEB4mHmszkwtMVk/1oE+gKUHvwXbhbWsqdyS3w+mAL
	 Pv1I184IZAevNJsFR0/iTLDCxvBxskv3/ZyzhQDAgFO1wXQqB0DkwkzgG1QsqcxwsA
	 UN+fJjivMUojKAD6Pr7agvcV/js6PEEdIvDlNuiVGDBevhNEJjHC2sIgzqC3QZpb1C
	 vibKD2sAUtuNg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 956F2418A3;
	Thu, 18 Jul 2024 19:31:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.11
Date: Thu, 18 Jul 2024 13:31:20 -0600
Message-ID: <87zfqev6nr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.11

for you to fetch changes up to 702418f7559fb1828646f0b51d9ca7c8b9ee7bff:

  Documentation: Document user_events ioctl code (2024-07-16 11:15:02 -0600)

----------------------------------------------------------------
Nothing hugely exciting happening in the documentation tree this time
around, mostly more of the usual:

- More Spanish, Italian, and Chinese translations

- A new script, scripts/checktransupdate.py, can be used to see which
  commits have touched an (English) document since a given translation was
  last updated.

- A couple of "best practices" suggestions (on Link: tags and off-list
  discussions) that were not entirely at consensus level, but I concluded
  they were close enough to accept.

- Some nice cleanups removing documentation for kernel parameters that have
  not been recognized for ... a long time.

...along with the usual updates, typo fixes, and such.

----------------------------------------------------------------
Ahmad Fatoum (1):
      docs: crypto: async-tx-api: fix broken code example

Beau Belgrave (1):
      Documentation: Document user_events ioctl code

Carlos Bilbao (2):
      docs: Extend and refactor index of further kernel docs
      docs/sp_SP: Add translation of process/maintainer-kvm-x86.rst

Chih-Wei Chien (1):
      docs: genericirq.rst: remove extra parenthesis in function definition

Conor Dooley (1):
      Documentation: process: Revert "Document suitability of Proton Mail f=
or kernel development"

Daniel Lublin (1):
      Documentation: add reference from dynamic debug to loglevel kernel pa=
rams

Daniel Watson (1):
      docs/admin-guide/mm: correct typo 'quired' to 'queried'

Diederik de Haas (1):
      docs: verify/bisect: Fix rendered version URL

Dmitry Baryshkov (1):
      docs: document python version used for compilation

Dmitry Torokhov (1):
      Add libps2 to the input section of driver-api

Dongliang Mu (6):
      docs/zh_CN: Update dev-tools/index.rst
      docs/zh_CN: Update the translation of dev-tools/testing-overview
      scripts: add scripts/checktransupdate.py
      docs/zh_CN: Update the translation of dev-tools/gdb-kernel-debugging
      docs/zh_CN: add back the missing part in the English version
      docs/zh_CN: add process/researcher-guidelines Chinese translation

Eric Biggers (1):
      docs: driver-model: platform: update the definition of platform_driver

Federico Vaga (1):
      doc:it_IT: align Italian documentation

Jakub Kicinski (1):
      docs: maintainer: discourage taking conversations off-list

Jinjie Ruan (1):
      Documentation: kernel-parameters: Add RISCV for nohlt

Jiri Kastner (1):
      Documentation/tools/rv: fix document header

Karel Balej (1):
      docs: handling-regressions.rst: recommend using "Closes:" tags

Konstantin Ryabitsev (2):
      Documentation: fix links to mailing list services
      Documentation: best practices for using Link trailers

Li Zhijian (1):
      Documentation: exception-tables.rst: Fix the wrong steps referenced

Marc Ferland (1):
      docs/pinctrl: fix typo in mapping example

Nir Lichtman (1):
      Documentation: English corrections in vmalloced kernel stacks

Randy Dunlap (1):
      doc-guide: kernel-doc: document Returns: spelling

Richard Genoud (1):
      writing_musb_glue_layer.rst: Fix broken URL

SeongJae Park (11):
      Docs/process/index: Remove unaligned-memory-access from 'Other materi=
al'
      Docs/process/index: Remove riscv/patch-acceptance from 'Other materia=
l' section
      Docs: Move magic-number from process to staging
      Docs: Move clang-format from process/ to dev-tools/
      Docs/process/index: Remove unsorted docs section
      Docs/maintainer/maintainer-entry-profile: add DAMON maintainer profile
      Docs/process/email-clients: Document HacKerMaiL
      Docs/mm/allocation-profiling: mark 'Theory of operation' as chapter
      Docs/mm/index: Remove 'Memory Management Guide' chapter marker
      Docs/mm/index: rename 'Legacy Documentation' to 'Unsorted Documentati=
on'
      Docs/mm/index: move allocation profiling document to unsorted documen=
ts chapter

Sergio Gonz=C3=A1lez Collado (1):
      docs/sp_SP: Add translation for scheduler/sched-design-CFS.rst

Tao Zou (2):
      zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst translation doc=
ument
      zh_CN/admin-guide: one typo fix

Thomas Huth (9):
      Documentation: Add "S390" to the swiotlb kernel parameter
      Documentation: Remove "ltpc=3D" from the kernel-parameters.txt
      Documentation: Remove the "rhash_entries=3D" from kernel-parameters.t=
xt
      Documentation: Remove unused "mtdset=3D" from kernel-parameters.txt
      Documentation: Remove unused "spia_*" kernel parameters
      Documentation: Remove unused "nps_mtm_hs_ctr" from kernel-parameters.=
txt
      Documentation: Remove the unused "topology_updates" from kernel-param=
eters.txt
      Documentation: Remove the unused "tp720" from kernel-parameters.txt
      Documentation: Remove IA-64 from kernel-parameters

Thorsten Scherer (1):
      doc:it_IT: Fix typo in Reviewed-by tag

Tony Luck (1):
      Documentation/x86: Switch to new Intel CPU model defines

Yanteng Si (1):
      docs/zh_CN: Add driver-api phy translation

Zenghui Yu (1):
      docs/zh_CN/virt: Update the translation of guest-halt-polling.rst

 .clang-format                                      |   2 +-
 Documentation/admin-guide/dynamic-debug-howto.rst  |   5 +
 Documentation/admin-guide/kernel-parameters.rst    |   1 -
 Documentation/admin-guide/kernel-parameters.txt    |  80 +---
 Documentation/admin-guide/mm/index.rst             |   2 +-
 .../verify-bugs-and-bisect-regressions.rst         |   2 +-
 Documentation/arch/x86/cpuinfo.rst                 |   2 +-
 Documentation/arch/x86/exception-tables.rst        |   2 +-
 Documentation/core-api/genericirq.rst              |   2 +-
 Documentation/crypto/async-tx-api.rst              |  30 +-
 .../{process =3D> dev-tools}/clang-format.rst        |   0
 Documentation/dev-tools/index.rst                  |   1 +
 Documentation/doc-guide/kernel-doc.rst             |   4 +-
 Documentation/driver-api/driver-model/platform.rst |   7 +-
 Documentation/driver-api/input.rst                 |   7 +
 Documentation/driver-api/pin-control.rst           |   2 +-
 .../driver-api/usb/writing_musb_glue_layer.rst     |   2 +-
 .../maintainer/feature-and-driver-maintainers.rst  |  11 +
 .../maintainer/maintainer-entry-profile.rst        |   1 +
 Documentation/mm/allocation-profiling.rst          |   1 -
 Documentation/mm/index.rst                         |  19 +-
 Documentation/mm/vmalloced-kernel-stacks.rst       |  10 +-
 Documentation/process/2.Process.rst                |   8 +-
 Documentation/process/4.Coding.rst                 |   2 +-
 Documentation/process/changes.rst                  |   1 +
 Documentation/process/coding-style.rst             |   2 +-
 Documentation/process/email-clients.rst            |  25 +-
 Documentation/process/handling-regressions.rst     |  30 +-
 Documentation/process/howto.rst                    |  10 +-
 Documentation/process/index.rst                    |  11 -
 Documentation/process/kernel-docs.rst              |  73 ++--
 Documentation/process/maintainer-netdev.rst        |   5 +-
 Documentation/process/maintainer-tip.rst           |  30 +-
 Documentation/process/submitting-patches.rst       |  15 +-
 Documentation/scheduler/sched-design-CFS.rst       |   2 +
 Documentation/staging/index.rst                    |   1 +
 .../{process =3D> staging}/magic-number.rst          |   0
 Documentation/tools/rv/rv-mon.rst                  |   6 +-
 .../it_IT/{ =3D> arch}/riscv/patch-acceptance.rst    |  24 +-
 .../translations/it_IT/doc-guide/kernel-doc.rst    |  44 ++
 .../translations/it_IT/doc-guide/parse-headers.rst |   2 +-
 .../translations/it_IT/process/5.Posting.rst       |  27 +-
 .../translations/it_IT/process/6.Followthrough.rst |   7 +
 .../it_IT/process/7.AdvancedTopics.rst             |   2 +-
 .../translations/it_IT/process/changes.rst         |   4 +-
 .../translations/it_IT/process/clang-format.rst    |   2 +-
 Documentation/translations/it_IT/process/index.rst |   2 +-
 .../translations/it_IT/process/magic-number.rst    |   2 +-
 .../it_IT/process/stable-kernel-rules.rst          | 310 +++++++-------
 .../it_IT/process/submitting-patches.rst           | 135 ++++--
 Documentation/translations/sp_SP/index.rst         |   1 +
 .../translations/sp_SP/process/coding-style.rst    |   2 +-
 Documentation/translations/sp_SP/process/index.rst |   1 +
 .../translations/sp_SP/process/magic-number.rst    |   2 +-
 .../sp_SP/process/maintainer-kvm-x86.rst           | 465 +++++++++++++++++=
++++
 .../translations/sp_SP/scheduler/index.rst         |   8 +
 .../sp_SP/scheduler/sched-design-CFS.rst           | 277 ++++++++++++
 .../translations/zh_CN/admin-guide/index.rst       |   2 +-
 .../translations/zh_CN/admin-guide/numastat.rst    |  48 +++
 .../zh_CN/dev-tools/gdb-kernel-debugging.rst       |   4 +
 .../translations/zh_CN/dev-tools/index.rst         |   6 +-
 .../translations/zh_CN/dev-tools/kasan.rst         |  18 +
 .../zh_CN/dev-tools/testing-overview.rst           |   2 +
 .../translations/zh_CN/driver-api/index.rst        |   2 +-
 .../translations/zh_CN/driver-api/phy/index.rst    |  20 +
 .../translations/zh_CN/driver-api/phy/phy.rst      | 212 ++++++++++
 .../translations/zh_CN/process/4.Coding.rst        |   2 +-
 .../translations/zh_CN/process/coding-style.rst    |   2 +-
 Documentation/translations/zh_CN/process/index.rst |   2 +-
 .../translations/zh_CN/process/magic-number.rst    |   2 +-
 .../zh_CN/process/researcher-guidelines.rst        | 129 ++++++
 .../translations/zh_CN/virt/guest-halt-polling.rst |   2 +-
 .../translations/zh_TW/process/4.Coding.rst        |   2 +-
 .../translations/zh_TW/process/coding-style.rst    |   2 +-
 .../translations/zh_TW/process/magic-number.rst    |   2 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 scripts/checktransupdate.py                        | 203 +++++++++
 77 files changed, 1976 insertions(+), 419 deletions(-)
 rename Documentation/{process =3D> dev-tools}/clang-format.rst (100%)
 rename Documentation/{process =3D> staging}/magic-number.rst (100%)
 rename Documentation/translations/it_IT/{ =3D> arch}/riscv/patch-acceptanc=
e.rst (64%)
 create mode 100644 Documentation/translations/sp_SP/process/maintainer-kvm=
-x86.rst
 create mode 100644 Documentation/translations/sp_SP/scheduler/index.rst
 create mode 100644 Documentation/translations/sp_SP/scheduler/sched-design=
-CFS.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.r=
st
 create mode 100644 Documentation/translations/zh_CN/driver-api/phy/index.r=
st
 create mode 100644 Documentation/translations/zh_CN/driver-api/phy/phy.rst
 create mode 100644 Documentation/translations/zh_CN/process/researcher-gui=
delines.rst
 create mode 100755 scripts/checktransupdate.py

