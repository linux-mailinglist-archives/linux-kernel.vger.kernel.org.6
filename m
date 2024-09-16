Return-Path: <linux-kernel+bounces-330705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFED097A301
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84171285582
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B7155A59;
	Mon, 16 Sep 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pAlnqzqD"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38D2E3FE;
	Mon, 16 Sep 2024 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493741; cv=none; b=RjzhHhzTL7oH+RnogLmVi2mQIFb3UvTkt5UIokwm9sJxIgk1By5o9kbU7FsHjksSqGsQUn2KNidvJskaJ07nFwd0BW+6LNEHLsTufDq5NTwIVzTGITCLeXpYLQm87PYs5+3M4G3D9utcx79yzbXkwSq9wmeyRro4w9+oTFogzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493741; c=relaxed/simple;
	bh=Fy6jNVJ6f7Imm7sSNQ1G8/S9tEZRuuL/8RXI2evpOH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6QdYrQP8/fcV/176ePqcrxXlSNWlrXzEYt+rxHKcYdB8NMFoYuf7is22zpObTG/FDjRgSLvpIBCX9eGNAMPt11P26wHtaQ7UkyPYEpCGSppL9EmFEuDyEg+V99bUaBGwzKIo85fCFk+KXDV/vISAmkh5/kG6/M+VpS+oh+kyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pAlnqzqD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1980C4188D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726493733; bh=HI8A5/wD/g8ueu1EtEeB6MA3vULQ47vJU6tyhh9+UI8=;
	h=From:To:Cc:Subject:Date:From;
	b=pAlnqzqDSTshHPitcHEhBFz10u3qCwRCY9KZB40qHsxtzSN+RjzbgM8gMBpWNlzRh
	 cA8HiylfLSWj9/vcmrIb7oRP6x+6H58UZGi2ZotQy2LJE6Pg/cIdiyd4EZSbg/Ldki
	 giX22m072+MXhxHXCEUldmymh5imHvqMMwsss+0B+EU85WbeCDAQVhkMuBqwPHpet5
	 1xt2eQjngyfqPG7+CleAI3E/FAe319frm0LDEf9L7M+zVakrDuBEYaaUDIMNu2CJAX
	 9uPlPq0ApQdF4qahx0E+fDIjfBvxi8zBVEv/OVFYLht7YpxSmPLglckAxn1WipcGKr
	 7Hj7oAQkgFbZw==
Received: from localhost (unknown [213.235.133.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1980C4188D;
	Mon, 16 Sep 2024 13:35:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.12
Date: Mon, 16 Sep 2024 07:35:05 -0600
Message-ID: <87a5g7wwl2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.12

for you to fetch changes up to 4f77c3462308c62ffe7129cc18b9ac937f44b5a5:

  Remove duplicate "and" in 'Linux NVMe docs. (2024-09-10 15:44:20 -0600)

----------------------------------------------------------------
Another relatively mundane cycle for docs:

- The beginning of an EEVDF scheduler document

- More Chinese translations

- A rethrashing of our bisection documentation

...plus the usual array of smaller fixes, and more than the usual number of
typo fixes.

----------------------------------------------------------------
Abdul Rahim (1):
      Documentation: PCI: fix typo in pci.rst

Akira Yokosawa (1):
      docs: kerneldoc-preamble.sty: Suppress extra spaces in CJK literal bl=
ocks

Alyssa Ross (1):
      Documentation: ioctl: document 0x07 ioctl code

Amit Vadhavana (1):
      Documentation: Fix spelling mistakes

Andrew Kreimer (2):
      accel/qaic: Fix a typo
      docs/process: fix typos

Aryabhatta Dey (3):
      docs: process: fix typos in Documentation/process/backporting.rst
      docs: leds: fix typo in Documentation/leds/leds-mlxcpld.rst
      Documentation/gpu: Fix typo in Documentation/gpu/komeda-kms.rst

Benjamin Poirier (1):
      Documentation: Add detailed explanation for 'N' taint flag

Bibo Mao (1):
      Loongarch: KVM: Add KVM hypercalls documentation for LoongArch

Breno Leitao (1):
      docs: fault-injection: document cache-filter feature for failslab

Carlos Bilbao (1):
      docs: scheduler: Start documenting the EEVDF scheduler

Dave Martin (1):
      docs/core-api: memory-allocation: GFP_NOWAIT doesn't need __GFP_NOWARN

David Hunter (1):
      Documentation: Capitalize Fahrenheit in watchdog-api.rst

Dennis Lam (4):
      docs:mm: fix spelling mistakes in heterogeneous memory management page
      docs:mm: fixed spelling and grammar mistakes on vmalloc kernel stack =
page
      docs:filesystem: fix mispelled words on autofs page
      docs:filesystems: fix spelling and grammar mistakes

Dongliang Mu (6):
      docs/zh_CN: add the translation of kbuild/headers_install.rst
      scripts: fix all issues reported by pylint
      doc-guide: add help documentation checktransupdate.rst
      docs/zh_CN: fix a broken reference
      docs/zh_CN: update the translation of security-bugs
      docs/zh_CN: add the translation of kbuild/gcc-plugins.rst

Dr. David Alan Gilbert (1):
      Documentation/fs/9p: Expand goo.gl link

Gianfranco Trad (1):
      Fix typo "allocateed" to allocated

Guilherme G. Piccoli (1):
      Documentation: Document the kernel flag bdev_allow_write_mounted

Haoyang Liu (2):
      docs/zh_CN: Add dev-tools/kcsan Chinese translation
      docs: update dev-tools/kcsan.rst url about KTSAN

I Hsin Cheng (1):
      docs: scheduler: completion: Update member of struct completion

Jakub Kicinski (1):
      MAINTAINERS: add Documentation/dev-tools/ to workflows@

Jani Nikula (2):
      get_maintainer: add --bug option to print bug reporting info
      Documentation: admin-guide: direct people to bug trackers, if specifi=
ed

Jiamu Sun (1):
      docs: improve comment consistency in .muttrc example configuration

Jonathan Corbet (1):
      Merge tag 'v6.11-rc6' into docs-mw

Karol Przybylski (1):
      docs: block: Fix grammar and spelling mistakes in bfq-iosched.rst

Mark Brown (1):
      docs: submitting-patches: Advertise b4

Ming Lei (1):
      Documentation: add ublk driver ioctl numbers

Philipp Stanner (1):
      Documentation: devres: fix error about PCI devres

Sebastian Muxel (1):
      scripts: sphinx-pre-install: remove unnecessary double check for $cur=
_version

SeongJae Park (2):
      Docs/translations/ko_KR: link howto.rst with other language versions
      Docs/translations/ko_KR: link memory-barriers wrapper with other lang=
uage versions

Sergio Gonz=C3=A1lez Collado (1):
      docs/sp_Sp: Add translation to spanish of the documentation related t=
o EEVDF

Shibu Kumar (1):
      docs: dm-crypt: Removal of unexpected indentation error

Shivam Chaudhary (1):
      Remove duplicate "and" in 'Linux NVMe docs.

Thorsten Leemhuis (1):
      docs: bug-bisect: rewrite to better match the other bisecting text

Thorsten Scherer (1):
      doc: iio: Fix sysfs paths

ganjie (1):
      Documentation: dontdiff: remove 'utf8data.h'

 Documentation/PCI/pci.rst                          |   2 +-
 Documentation/accel/qaic/qaic.rst                  |   2 +-
 Documentation/admin-guide/bug-bisect.rst           | 208 +++++++++-----
 Documentation/admin-guide/bug-hunting.rst          |  17 +-
 .../admin-guide/device-mapper/dm-crypt.rst         |  11 +-
 Documentation/admin-guide/kernel-parameters.txt    |  12 +
 Documentation/admin-guide/tainted-kernels.rst      |   2 +
 .../arch/arm/stm32/stm32-dma-mdma-chaining.rst     |   4 +-
 Documentation/arch/arm64/cpu-hotplug.rst           |   2 +-
 Documentation/arch/powerpc/ultravisor.rst          |   2 +-
 Documentation/arch/riscv/vector.rst                |   2 +-
 Documentation/arch/x86/mds.rst                     |   2 +-
 Documentation/arch/x86/x86_64/fsgs.rst             |   4 +-
 Documentation/block/bfq-iosched.rst                |  22 +-
 Documentation/core-api/memory-allocation.rst       |   5 +-
 Documentation/dev-tools/kcsan.rst                  |   3 +-
 Documentation/doc-guide/checktransupdate.rst       |  54 ++++
 Documentation/doc-guide/index.rst                  |   1 +
 Documentation/dontdiff                             |   2 +-
 Documentation/driver-api/driver-model/devres.rst   |   2 +-
 Documentation/driver-api/iio/buffers.rst           |   8 +-
 Documentation/driver-api/iio/core.rst              |  14 +-
 Documentation/fault-injection/fault-injection.rst  |  22 +-
 Documentation/filesystems/9p.rst                   |   2 +-
 Documentation/filesystems/autofs.rst               |   4 +-
 Documentation/filesystems/journalling.rst          |   6 +-
 Documentation/gpu/komeda-kms.rst                   |   2 +-
 Documentation/leds/leds-mlxcpld.rst                |   2 +-
 Documentation/mm/hmm.rst                           |  10 +-
 Documentation/mm/vmalloced-kernel-stacks.rst       |   8 +-
 Documentation/nvme/feature-and-quirk-policy.rst    |   6 +-
 Documentation/process/backporting.rst              |   6 +-
 Documentation/process/coding-style.rst             |   2 +-
 Documentation/process/email-clients.rst            |   2 +-
 Documentation/process/maintainer-tip.rst           |   2 +-
 Documentation/process/submitting-patches.rst       |   8 +
 Documentation/scheduler/completion.rst             |   2 +-
 Documentation/scheduler/index.rst                  |   1 +
 Documentation/scheduler/sched-design-CFS.rst       |  10 +-
 Documentation/scheduler/sched-eevdf.rst            |  43 +++
 Documentation/sphinx/kerneldoc-preamble.sty        |   2 +
 .../ko_KR/core-api/wrappers/memory-barriers.rst    |  18 ++
 Documentation/translations/ko_KR/index.rst         |  16 +-
 .../translations/ko_KR/{ =3D> process}/howto.rst     |   0
 .../translations/sp_SP/scheduler/index.rst         |   1 +
 .../sp_SP/scheduler/sched-design-CFS.rst           |   8 +-
 .../translations/sp_SP/scheduler/sched-eevdf.rst   |  58 ++++
 .../translations/zh_CN/admin-guide/index.rst       |   1 -
 .../zh_CN/admin-guide/reporting-issues.rst         |   4 +-
 .../translations/zh_CN/dev-tools/index.rst         |   2 +-
 .../translations/zh_CN/dev-tools/kcsan.rst         | 320 +++++++++++++++++=
++++
 .../zh_CN/doc-guide/checktransupdate.rst           |  55 ++++
 .../translations/zh_CN/doc-guide/index.rst         |   1 +
 Documentation/translations/zh_CN/index.rst         |   2 +-
 .../translations/zh_CN/kbuild/gcc-plugins.rst      | 126 ++++++++
 .../translations/zh_CN/kbuild/headers_install.rst  |  39 +++
 Documentation/translations/zh_CN/kbuild/index.rst  |  35 +++
 Documentation/translations/zh_CN/process/index.rst |   3 +-
 .../{admin-guide =3D> process}/security-bugs.rst     |  42 +--
 .../zh_CN/process/submitting-patches.rst           |   2 +-
 .../zh_TW/admin-guide/reporting-issues.rst         |   4 +-
 .../zh_TW/process/submitting-patches.rst           |   2 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
 Documentation/virt/kvm/index.rst                   |   1 +
 Documentation/virt/kvm/loongarch/hypercalls.rst    |  89 ++++++
 Documentation/virt/kvm/loongarch/index.rst         |  10 +
 Documentation/watchdog/watchdog-api.rst            |   2 +-
 MAINTAINERS                                        |   3 +
 scripts/checktransupdate.py                        | 214 +++++++++-----
 scripts/get_maintainer.pl                          |  17 +-
 scripts/sphinx-pre-install                         |   2 -
 71 files changed, 1329 insertions(+), 271 deletions(-)
 create mode 100644 Documentation/doc-guide/checktransupdate.rst
 create mode 100644 Documentation/scheduler/sched-eevdf.rst
 create mode 100644 Documentation/translations/ko_KR/core-api/wrappers/memo=
ry-barriers.rst
 rename Documentation/translations/ko_KR/{ =3D> process}/howto.rst (100%)
 create mode 100644 Documentation/translations/sp_SP/scheduler/sched-eevdf.=
rst
 create mode 100644 Documentation/translations/zh_CN/dev-tools/kcsan.rst
 create mode 100644 Documentation/translations/zh_CN/doc-guide/checktransup=
date.rst
 create mode 100644 Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
 create mode 100644 Documentation/translations/zh_CN/kbuild/headers_install=
.rst
 create mode 100644 Documentation/translations/zh_CN/kbuild/index.rst
 rename Documentation/translations/zh_CN/{admin-guide =3D> process}/securit=
y-bugs.rst (57%)
 create mode 100644 Documentation/virt/kvm/loongarch/hypercalls.rst
 create mode 100644 Documentation/virt/kvm/loongarch/index.rst

