Return-Path: <linux-kernel+bounces-263745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741493DA0E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19A2284471
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886D149E09;
	Fri, 26 Jul 2024 20:58:47 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03EFC1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722027526; cv=none; b=hrNx/XDqaMGTnnqHczA7XhKxjrs8ErnOqnSNfY2V9JInyhG6vqUqFaUsk7vBmVpyOFF8MmgCUE3Q9C51p8tpWWM+MPeEYadlTnP4nmCAWXZQb4NDTQgbWL4b0KDFsIglc9v/PZ+IEKmkIZkhwNTkVoDbAV816a8oX5aSCy7ljv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722027526; c=relaxed/simple;
	bh=LqJDjtQKlASTWWhASW+0rWqVymX+KEaMgYd3bzPxKrM=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=nX2nvKpu2Vtt+Ub+i03JTDXOkqHU/rJIL0KzzWir8dlrfgSdbU1EgVKlu4MnwjjRZSVHo0Z4wEMBn7J9vySlWi8rXPDtEeObZ447hWPjLnywlTe7Z5Lcsi4nqNYd3xjzVRFw2LjVaC4dHYTZzXYTvbJbdGeO2gJZLnTrPw3S5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2D5856196A41;
	Fri, 26 Jul 2024 22:58:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id IFwWMynNwQVd; Fri, 26 Jul 2024 22:58:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C29656196A48;
	Fri, 26 Jul 2024 22:58:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u4xtvh4r-Tnn; Fri, 26 Jul 2024 22:58:34 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9AC946196A41;
	Fri, 26 Jul 2024 22:58:34 +0200 (CEST)
Date: Fri, 26 Jul 2024 22:58:34 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <896050924.123729.1722027514568.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI and UBIFS updates for v6.11-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: gbXApdcmd37b2LMIgXNqGyOlPMFBCg==
Thread-Topic: UBI and UBIFS updates for v6.11-rc1

Linus,

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.11-rc1

for you to fetch changes up to 054fd15984454f031611d6c63675fc578aad0cb1:

  ubifs: add check for crypto_shash_tfm_digest (2024-07-12 22:01:09 +0200)

----------------------------------------------------------------
This pull request contains updates (actually, just fixes) for UBI and UBIFS:

- Many fixes for power-cut issues by Zhihao Cheng
- Another ubiblock error path fix
- Misc fixes all over the place

----------------------------------------------------------------
Arnd Bergmann (1):
      mtd: ubi: avoid expensive do_div() on 32-bit machines

Ben Hutchings (1):
      mtd: ubi: Restore missing cleanup on ubi_init() failure path

Chen Ni (1):
      ubifs: add check for crypto_shash_tfm_digest

Fedor Pchelkin (1):
      ubi: eba: properly rollback inside self_check_eba

Jeff Johnson (1):
      ubifs: fix kernel-doc warnings

Li Nan (1):
      ubi: block: fix null-pointer-dereference in ubiblock_create()

Ricardo B. Marliere (1):
      mtd: ubi: make ubi_class constant

ZhaoLong Wang (1):
      ubifs: correct UBIFS_DFS_DIR_LEN macro definition and improve code clarity

Zhihao Cheng (10):
      ubifs: Fix unattached xattr inode if powercut happens after deleting
      ubifs: Don't add xattr inode into orphan area
      Revert "ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path"
      ubifs: Remove insert_dead_orphan from replaying orphan process
      ubifs: Fix adding orphan entry twice for the same inode
      ubifs: Move ui->data initialization after initializing security
      ubifs: Fix space leak when powercut happens in linking tmpfile
      ubifs: Fix unattached inode when powercut happens in creating
      ubifs: dbg_orphan_check: Fix missed key type checking
      ubifs: Fix inconsistent inode size when powercut happens during appendant writing

 drivers/mtd/ubi/block.c |   7 ++-
 drivers/mtd/ubi/build.c |   7 ++-
 drivers/mtd/ubi/debug.c |   4 +-
 drivers/mtd/ubi/eba.c   |   3 +-
 drivers/mtd/ubi/nvmem.c |   6 +-
 drivers/mtd/ubi/ubi.h   |   4 +-
 fs/ubifs/compress.c     |   2 +
 fs/ubifs/debug.c        |   4 +-
 fs/ubifs/debug.h        |   7 ++-
 fs/ubifs/dir.c          |  91 ++++++++++++++++------------
 fs/ubifs/file.c         |   2 +-
 fs/ubifs/find.c         |   8 +--
 fs/ubifs/journal.c      |  16 +++--
 fs/ubifs/lprops.c       |   2 +-
 fs/ubifs/lpt.c          |   1 +
 fs/ubifs/master.c       |   5 +-
 fs/ubifs/orphan.c       | 155 ++++++++----------------------------------------
 fs/ubifs/replay.c       |   1 +
 fs/ubifs/sysfs.c        |   6 +-
 fs/ubifs/ubifs.h        |  14 +----
 fs/ubifs/xattr.c        |   2 +-
 21 files changed, 134 insertions(+), 213 deletions(-)

