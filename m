Return-Path: <linux-kernel+bounces-571871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C004A6C36E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A0848243C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6495022E414;
	Fri, 21 Mar 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LL0cg45R"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4318FC75;
	Fri, 21 Mar 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585976; cv=none; b=bWKf5Ac67m2rIEhjD8OL729tzes7jkN5ObPaOl+01ZQghVM3ES7GQ2rsdi0L3iY9FhvIU3m3aULqpdxNWaFQ23quzPh/gnB6063t725x6pbG3UiRvG6QD3FziEQCVWtKueLkAj9LJsP7vZGsScOPlO/enk+BN+JQ65TLq/xoHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585976; c=relaxed/simple;
	bh=k2raOJRSTeQot7gkweDSSWmBafLhB77k+nI7b9NnpMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V2lSk2VD7WeeS/cUBQcqPBNWVdrotC3TXo0qz4yc7hKh95xAmKiYOjtiKdCjzvDnnIGKsRzh2uLzFOxFR25GzEQ5nWpa/hEjUDAtvRJb6C8fzU8SC+6DdcfVmo0UFlrEiEDyrWlbHJxvawycPkbESToMYXmdOcRHku7oQaFuh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LL0cg45R; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D6EE641061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742585973; bh=N88DGR/daEKBolAJiRJfW2faRA+FvmOIvs1xlE6O3Ts=;
	h=From:To:Cc:Subject:Date:From;
	b=LL0cg45R5ookxYxXrYtAJQDE97/rWlz08enzK6FRl8FfCU41e5pTLDzFwwdJDRje3
	 9cM7JOidQDnUsqLQcY33YKGQvpvIRMt05Wece84aHxpYHW7pQPb7dfEKpzN5Jd2jN5
	 J7aI0PFWHrZSot8nkU9srLu3m+FwZois2CXgOmKBGxy8NqEDtrkVbdFuMOrig04c+H
	 r3u4qOF3QK+vYCjioEWBCh9GWpr1NuAljPzgcYRHtykj3CLmHD/cwLj5ZQBggN4aa+
	 SEwbsKBb9dITxGfydWcB5ipY1cY+h/zNDEP9vWRGqGwfg2/fRoiUlIJV1VmU/SDKvg
	 GlV70jv9RQOqg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D6EE641061;
	Fri, 21 Mar 2025 19:39:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.15
Date: Fri, 21 Mar 2025 13:39:32 -0600
Message-ID: <87tt7mjhqj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.15

for you to fetch changes up to 323cc36ef68bc2c8ca0bd5f528736432afc1a36a:

  Merge tag 'chinese-doc-6.15-rc1' of gitolite.kernel.org:pub/scm/linux/kernel/git/alexs/linux into docs-mw (2025-03-19 13:10:23 -0600)

----------------------------------------------------------------
It has been a reasonably busy cycle for docs...

- Significant changes throughout the tree to bring Python code up to
  current standards and raise the minimum Python required to 3.9.  Much of
  this is preparatory to replacing the ancient Perl scripts/kernel-doc
  horror with a slightly less horrifying Python implementation, expected
  for 6.16.

- Update the minimum Sphinx required to 3.4.3, allowing us to remove a
  bunch of older compatibility code.

- Rework and improve the generation of the ABI documentation.

  (All of the above done by Mauro)

- Lots of translation updates.  Alex Shi and Yanteng Si are taking on
  responsibility for the Chinese translations going forward; that work will
  still get to you via docs-next

- Try to standardize the format for indicating a developer's affiliation in
  commit tags.

- Clarify the TAB's role in CoC enforcement actions.

- Try to spell out the rules for when a commit tag can name another
  developer without their explicit permission.

Plus lots of other typo fixes and updates.

----------------------------------------------------------------
Aditya Dutt (1):
      Documentation/driver-api: fixed spelling mistakes

Akira Yokosawa (3):
      docs: submit-checklist: Expand on build tests against different word sizes
      docs/ja_JP: Convert SubmitChecklist into reST with belated updates
      docs/.../submit-checklist: Use Documentation/admin-guide/abi.rst for cross-ref of README

Alex Shi (3):
      docs/zh_CN: add maintainer tree for Chinese doc pickup
      docs/zh_CN: add few request for Chinese translation
      docs/Chinese: change the disclaimer words

Armin Mahdilou (1):
      Documentation: typo fixes

Brendan Connelly (1):
      Documentation: input: Add section pertaining to polled input devices

Brian Ochoa (1):
      docs: arch/x86/sva: Fix two grammar errors under Background and FAQ

Charles Han (1):
      Documentation: Remove repeated word in docs

Chen Pei (1):
      Documentation: riscv: Remove KPROBES_ON_FTRACE

David Reaver (1):
      docs: iostats: Rewrite intro, remove outdated formats

Diego Viola (1):
      docs: admin-guide: rename GTK+ to GTK

Dongliang Mu (1):
      MAINTAINERS: add reviewer for Chinese translations

Fritz Koenig (1):
      Documentation: ocxl.rst: Update consortium site

Gabriel (1):
      Docs/arch/arm64: Fix spelling in amu.rst

Heiko Carstens (1):
      scripts: get_feat.pl: substitute s390x with s390

I Hsin Cheng (2):
      mm: pgtable: Fix grammar error
      docs: Correct installation instruction

Ignacio Encinas (1):
      Documentation: kcsan: fix "Plain Accesses and Data Races" URL in kcsan.rst

Jacek Lawrynowicz (1):
      docs: driver-api: firmware: clarify userspace requirements

Jakub Kicinski (1):
      docs: submitting-patches: document the format for affiliation

Jonathan Corbet (4):
      Merge tag 'v6.14-rc2' into test
      Merge branch 'mauro' into docs-mw
      Merge branch 'mauro' into docs-mw
      Merge tag 'chinese-doc-6.15-rc1' of gitolite.kernel.org:pub/scm/linux/kernel/git/alexs/linux into docs-mw

Lorenzo Stoakes (1):
      kernel-docs: Add book to process/kernel-docs.rst

Maksimilijan Marosevic (1):
      Fix typos in admin-guide/gpio

Mauro Carvalho Chehab (51):
      docs: sphinx: remove kernellog.py file
      docs: sphinx/kernel_abi: adjust coding style
      docs: admin-guide: abi: add SPDX tags to ABI files
      ABI: sysfs-class-rfkill: fix kernelversion tags
      ABI: sysfs-bus-coresight-*: fix kernelversion tags
      ABI: sysfs-driver-dma-idxd: fix date tags
      ABI: sysfs-fs-f2fs: fix date tags
      ABI: sysfs-power: fix a what tag
      scripts/documentation-file-ref-check: don't check perl/python scripts
      scripts/get_abi.py: add a Python tool to generate ReST output
      scripts/get_abi.py: add support for symbol search
      docs: use get_abi.py for ABI generation
      scripts/lib/abi/abi_parser.py: optimize parse_abi() function
      scripts/lib/abi/abi_parser.py: use an interactor for ReST output
      docs: sphinx/kernel_abi: use AbiParser directly
      docs: sphinx/kernel_abi: reduce buffer usage for ABI messages
      docs: sphinx/kernel_abi: properly split lines
      scripts/get_abi.pl: Add filtering capabilities to rest output
      scripts/get_abi.pl: add support to parse ABI README file
      docs: sphinx/kernel_abi: parse ABI files only once
      docs: admin-guide/abi: split files from symbols
      docs: sphinx/automarkup: add cross-references for ABI
      docs: sphinx/kernel_abi: avoid warnings during Sphinx module init
      scripts/lib/abi/abi_parser.py: Rename title name for ABI files
      scripts/lib/abi/abi_parser.py: make it backward-compatible with Python 3.6
      scripts/get_abi.py: add support for undefined ABIs
      scripts/get_abi.pl: drop now obsoleted script
      docs: ABI: drop two duplicate symbols
      scripts/kernel-doc: remove an obscure logic from kernel-doc
      docs: Makefile: use the new script to check for bad ABI references
      docs: trace: decode_msr.py: make it compatible with python 3
      docs: ABI: move README contents to the top
      docs: changes: update Sphinx minimal version to 3.4.3
      docs: changes: update Python minimal version
      docs: extensions: don't use utf-8 syntax for descriptions
      scripts/kernel-doc: drop Sphinx version check
      docs: media: Allow creating cross-references for RC ABI
      docs: automarkup: drop legacy support
      docs: thunderbolt: Allow creating cross-references for ABI
      docs: arm: asymmetric-32bit: Allow creating cross-references for ABI
      docs: arm: generic-counter: Allow creating cross-references for ABI
      docs: iio: Allow creating cross-references ABI
      docs: networking: Allow creating cross-references statistics ABI
      docs: submit-checklist: Allow creating cross-references for ABI README
      docs: translations: Allow creating cross-references for ABI README
      include/asm-generic/io.h: fix kerneldoc markup
      drivers: media: intel-ipu3.h: fix identation on a kernel-doc markup
      drivers: firewire: firewire-cdev.h: fix identation on a kernel-doc markup
      docs: driver-api/infiniband.rst: fix Kerneldoc markup
      scripts/kernel-doc: don't add not needed new lines
      scripts/kernel-doc: drop dead code for Wcontents_before_sections

Maxime Ripard (1):
      Documentation: dma-buf: heaps: Add heap name definitions

Mike Rapoport (Microsoft) (1):
      Documentation/kernel-parameters: fix typo in description of reserve_mem

Peng Jiang (1):
      docs/zh_CN: fix spelling mistake

Ritvik Gupta (1):
      documentation/filesystems: fix spelling mistakes

Shuah Khan (1):
      Documentation/CoC: Spell out the TAB role in enforcement decisions

Shuo Zhao (8):
      docs/zh_CN: Add tpm index Chinese translation
      docs/zh_CN: Add tpm tpm_event_log Chinese translation
      docs/zh_CN: Add tpm tpm-security Chinese translation
      docs/zh_CN: Add tpm tpm_tis Chinese translation
      docs/zh_CN: Add tpm tpm_vtpm_proxy Chinese translation
      docs/zh_CN: Add tpm xen-tpmfront Chinese translation
      docs/zh_CN: Add tpm tpm_ftpm_tee Chinese translation
      docs/zh_CN: Add security credentials Chinese translation

Suchit Karunakaran (1):
      docs: scheduler: fix spelling in sched-bwc documentation

Thorsten Leemhuis (1):
      docs: clarify rules wrt tagging other people

WangYuli (1):
      docs/zh_CN: Update the translation of dev-tools/ubsan to v6.14-rc1

Yu-Chun Lin (1):
      Documentation/core-api: min_heap: update for variable types change

Yuxian Mao (1):
      docs/zh_CN: Add snp-tdx-threat-model index Chinese translation

kth (1):
      docs: Remove outdated highuid.rst documentation

zhangwei (3):
      docs/zh_CN: Add self-protection index Chinese translation
      docs/zh_CN: Add keys index Chinese translation
      docs/zh_CN: Add secrets index Chinese translation

 Documentation/ABI/README                           |    3 +-
 Documentation/ABI/removed/sysfs-class-rfkill       |    2 +-
 Documentation/ABI/stable/sysfs-class-rfkill        |   12 +-
 Documentation/ABI/stable/sysfs-devices-system-cpu  |   10 -
 Documentation/ABI/stable/sysfs-driver-dma-idxd     |    4 +-
 .../ABI/testing/configfs-usb-gadget-midi2          |    2 +-
 .../ABI/testing/sysfs-bus-coresight-devices-cti    |   78 +-
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |   52 +-
 Documentation/ABI/testing/sysfs-fs-f2fs            |    4 +-
 Documentation/ABI/testing/sysfs-power              |    2 +-
 Documentation/Makefile                             |    2 +-
 Documentation/admin-guide/README.rst               |    2 +-
 Documentation/admin-guide/abi-obsolete-files.rst   |    7 +
 Documentation/admin-guide/abi-obsolete.rst         |    6 +-
 Documentation/admin-guide/abi-removed-files.rst    |    7 +
 Documentation/admin-guide/abi-removed.rst          |    6 +-
 Documentation/admin-guide/abi-stable-files.rst     |    7 +
 Documentation/admin-guide/abi-stable.rst           |    6 +-
 Documentation/admin-guide/abi-testing-files.rst    |    7 +
 Documentation/admin-guide/abi-testing.rst          |    6 +-
 Documentation/admin-guide/abi.rst                  |   18 +
 Documentation/admin-guide/gpio/gpio-sim.rst        |    2 +-
 Documentation/admin-guide/gpio/gpio-virtuser.rst   |    2 +-
 Documentation/admin-guide/highuid.rst              |   80 --
 Documentation/admin-guide/index.rst                |    1 -
 Documentation/admin-guide/iostats.rst              |   89 +-
 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 Documentation/admin-guide/thunderbolt.rst          |    2 +-
 Documentation/admin-guide/workload-tracing.rst     |    2 +-
 Documentation/arch/arm64/amu.rst                   |    2 +-
 Documentation/arch/arm64/asymmetric-32bit.rst      |    2 +-
 Documentation/arch/x86/sva.rst                     |    4 +-
 Documentation/conf.py                              |    2 +-
 Documentation/core-api/min_heap.rst                |    4 +-
 Documentation/dev-tools/kcsan.rst                  |    2 +-
 .../bindings/net/can/microchip,mcp251xfd.yaml      |    2 +-
 .../firmware/firmware-usage-guidelines.rst         |    5 +
 Documentation/driver-api/generic-counter.rst       |    4 +-
 Documentation/driver-api/iio/core.rst              |    2 +-
 Documentation/driver-api/infiniband.rst            |   16 +-
 Documentation/driver-api/media/drivers/zoran.rst   |    2 +-
 .../driver-api/media/maintainer-entry-profile.rst  |    2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst         |    6 +-
 Documentation/driver-api/pm/devices.rst            |    2 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |    2 +-
 Documentation/features/list-arch.sh                |    2 +-
 Documentation/filesystems/9p.rst                   |    2 +-
 .../filesystems/bcachefs/SubmittingPatches.rst     |    4 +-
 Documentation/filesystems/coda.rst                 |    2 +-
 Documentation/filesystems/debugfs.rst              |    2 +-
 Documentation/filesystems/netfs_library.rst        |    2 +-
 .../filesystems/xfs/xfs-delayed-logging-design.rst |    2 +-
 .../xfs/xfs-maintainer-entry-profile.rst           |    2 +-
 .../filesystems/xfs/xfs-online-fsck-design.rst     |    4 +-
 Documentation/iio/iio_devbuf.rst                   |    2 +-
 Documentation/input/devices/elantech.rst           |    2 +-
 Documentation/input/input-programming.rst          |   19 +
 Documentation/mm/split_page_table_lock.rst         |    2 +-
 Documentation/networking/statistics.rst            |    2 +-
 Documentation/nvme/nvme-pci-endpoint-target.rst    |    2 +-
 Documentation/process/5.Posting.rst                |   13 +-
 Documentation/process/changes.rst                  |    4 +-
 .../process/code-of-conduct-interpretation.rst     |   17 +-
 Documentation/process/kernel-docs.rst              |   11 +
 Documentation/process/submit-checklist.rst         |   12 +-
 Documentation/process/submitting-patches.rst       |   45 +-
 Documentation/scheduler/sched-bwc.rst              |    2 +-
 Documentation/sound/soc/machine.rst                |    2 +-
 Documentation/sphinx/automarkup.py                 |   82 +-
 Documentation/sphinx/cdomain.py                    |    7 +-
 Documentation/sphinx/kernel_abi.py                 |  162 +--
 Documentation/sphinx/kernel_feat.py                |    4 +-
 Documentation/sphinx/kernel_include.py             |    4 +-
 Documentation/sphinx/kerneldoc.py                  |   19 +-
 Documentation/sphinx/kernellog.py                  |   22 -
 Documentation/sphinx/kfigure.py                    |   91 +-
 Documentation/sphinx/load_config.py                |    2 +-
 Documentation/sphinx/maintainers_include.py        |    4 +-
 Documentation/sphinx/rstFlatTable.py               |   10 +-
 Documentation/trace/postprocess/decode_msr.py      |    2 +-
 .../it_IT/process/submit-checklist.rst             |    7 +-
 Documentation/translations/ja_JP/SubmitChecklist   |  105 --
 .../translations/ja_JP/disclaimer-ja_JP.rst        |   24 +
 Documentation/translations/ja_JP/index.rst         |    2 +
 Documentation/translations/ja_JP/process/howto.rst |   37 +-
 .../ja_JP/process/submit-checklist.rst             |  163 +++
 .../sp_SP/process/submit-checklist.rst             |    7 +-
 .../translations/zh_CN/admin-guide/README.rst      |    2 +-
 .../translations/zh_CN/dev-tools/ubsan.rst         |   33 +-
 .../translations/zh_CN/disclaimer-zh_CN.rst        |    8 +-
 Documentation/translations/zh_CN/index.rst         |    8 +-
 Documentation/translations/zh_CN/mm/balance.rst    |    2 +-
 .../zh_CN/process/submit-checklist.rst             |    4 +-
 .../translations/zh_CN/security/credentials.rst    |  479 +++++++++
 .../translations/zh_CN/security/index.rst          |    8 +-
 .../translations/zh_CN/security/keys/index.rst     |   22 +
 .../translations/zh_CN/security/secrets/index.rst  |   17 +
 .../zh_CN/security/self-protection.rst             |  271 +++++
 .../zh_CN/security/snp-tdx-threat-model.rst        |  209 ++++
 .../translations/zh_CN/security/tpm/index.rst      |   20 +
 .../zh_CN/security/tpm/tpm-security.rst            |  151 +++
 .../zh_CN/security/tpm/tpm_event_log.rst           |   49 +
 .../zh_CN/security/tpm/tpm_ftpm_tee.rst            |   31 +
 .../translations/zh_CN/security/tpm/tpm_tis.rst    |   43 +
 .../zh_CN/security/tpm/tpm_vtpm_proxy.rst          |   51 +
 .../zh_CN/security/tpm/xen-tpmfront.rst            |  114 ++
 .../translations/zh_TW/admin-guide/README.rst      |    2 +-
 .../zh_TW/process/submit-checklist.rst             |    4 +-
 Documentation/usb/gadget-testing.rst               |    2 +-
 Documentation/userspace-api/accelerators/ocxl.rst  |    7 +-
 Documentation/userspace-api/dma-buf-heaps.rst      |   25 +
 Documentation/userspace-api/index.rst              |    1 +
 .../userspace-api/media/rc/rc-sysfs-nodes.rst      |    2 +-
 MAINTAINERS                                        |    3 +
 .../staging/media/ipu3/include/uapi/intel-ipu3.h   |    3 +-
 include/asm-generic/io.h                           |    6 +-
 include/uapi/linux/firewire-cdev.h                 |    3 +-
 scripts/documentation-file-ref-check               |    2 +-
 scripts/get_abi.pl                                 | 1103 --------------------
 scripts/get_abi.py                                 |  214 ++++
 scripts/get_feat.pl                                |    4 +-
 scripts/kernel-doc                                 |  163 +--
 scripts/lib/abi/abi_parser.py                      |  628 +++++++++++
 scripts/lib/abi/abi_regex.py                       |  234 +++++
 scripts/lib/abi/helpers.py                         |   38 +
 scripts/lib/abi/system_symbols.py                  |  378 +++++++
 126 files changed, 3810 insertions(+), 1927 deletions(-)
 create mode 100644 Documentation/admin-guide/abi-obsolete-files.rst
 create mode 100644 Documentation/admin-guide/abi-removed-files.rst
 create mode 100644 Documentation/admin-guide/abi-stable-files.rst
 create mode 100644 Documentation/admin-guide/abi-testing-files.rst
 delete mode 100644 Documentation/admin-guide/highuid.rst
 delete mode 100644 Documentation/sphinx/kernellog.py
 delete mode 100644 Documentation/translations/ja_JP/SubmitChecklist
 create mode 100644 Documentation/translations/ja_JP/disclaimer-ja_JP.rst
 create mode 100644 Documentation/translations/ja_JP/process/submit-checklist.rst
 create mode 100644 Documentation/translations/zh_CN/security/credentials.rst
 create mode 100644 Documentation/translations/zh_CN/security/keys/index.rst
 create mode 100644 Documentation/translations/zh_CN/security/secrets/index.rst
 create mode 100644 Documentation/translations/zh_CN/security/self-protection.rst
 create mode 100644 Documentation/translations/zh_CN/security/snp-tdx-threat-model.rst
 create mode 100644 Documentation/translations/zh_CN/security/tpm/index.rst
 create mode 100644 Documentation/translations/zh_CN/security/tpm/tpm-security.rst
 create mode 100644 Documentation/translations/zh_CN/security/tpm/tpm_event_log.rst
 create mode 100644 Documentation/translations/zh_CN/security/tpm/tpm_ftpm_tee.rst
 create mode 100644 Documentation/translations/zh_CN/security/tpm/tpm_tis.rst
 create mode 100644 Documentation/translations/zh_CN/security/tpm/tpm_vtpm_proxy.rst
 create mode 100644 Documentation/translations/zh_CN/security/tpm/xen-tpmfront.rst
 create mode 100644 Documentation/userspace-api/dma-buf-heaps.rst
 delete mode 100755 scripts/get_abi.pl
 create mode 100755 scripts/get_abi.py
 create mode 100644 scripts/lib/abi/abi_parser.py
 create mode 100644 scripts/lib/abi/abi_regex.py
 create mode 100644 scripts/lib/abi/helpers.py
 create mode 100644 scripts/lib/abi/system_symbols.py

