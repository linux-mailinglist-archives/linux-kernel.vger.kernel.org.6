Return-Path: <linux-kernel+bounces-264828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A507D93E8DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1BE28179F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F04B61674;
	Sun, 28 Jul 2024 18:26:35 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A21DA2F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722191194; cv=none; b=J/310BsTpyTdBy6L0PrIrrrYG8EntEgie4Z5jXPs58DYh5lyBimZktS4xcsyHxUjMwc+WESe9ekvB3Ikg7DrO8MBxdX+Co5BptCA5I5GIKCZebohipMLQoObSL8HBe3IVQuqFjChCdQ+0yt40bPYbBHhBc3Xk3Jimwd07Sam+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722191194; c=relaxed/simple;
	bh=KggwzapIfmAFqTuE7JcNe8da/F4Js7wgWrt135l+6Fk=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=i8k2DTUp0Lq91Vtmg84nC5m/PVggaXyQksbTo2+PbbOqq+bjedMAX8B6T7Ezph+oLUstrmyUMHru00onkn5IVhWKMUB3JVSY+v4KHRb4DpIE4G2Xv5Qe8gXCGV/9CBvq2A3TrqYBEaYeyUIEyJXg8YtL33jmA9toO8CMZbauyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1C1706196A48;
	Sun, 28 Jul 2024 20:26:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qqol4RTJmMAz; Sun, 28 Jul 2024 20:26:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AE22261966B5;
	Sun, 28 Jul 2024 20:26:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y3fOQJaduj84; Sun, 28 Jul 2024 20:26:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8D1F764A3D3B;
	Sun, 28 Jul 2024 20:26:28 +0200 (CEST)
Date: Sun, 28 Jul 2024 20:26:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <589372570.132198.1722191188516.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI and UBIFS updates for v6.11-rc1, take 2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: 2zpJ3pnBqpNE8uOWpNZblj1nRl4weA==
Thread-Topic: UBI and UBIFS updates for v6.11-rc1, take 2

Linus,

As discussed, this is the updated PR for v6.11-rc1, it includes
the section mismatch fix.

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.11-rc1-take2

for you to fetch changes up to 92a286e90203ce3e6c3a6d945fa36da419c3671f:

  ubi: Fix ubi_init() ubiblock_exit() section mismatch (2024-07-28 20:08:25 +0200)

----------------------------------------------------------------
This pull request contains updates (actually, just fixes) for UBI and UBIFS:

- Many fixes for power-cut issues by Zhihao Cheng
- Another ubiblock error path fix
- ubiblock section mismatch fix
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

Richard Weinberger (1):
      ubi: Fix ubi_init() ubiblock_exit() section mismatch

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

 drivers/mtd/ubi/block.c |   9 +--
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
 21 files changed, 135 insertions(+), 214 deletions(-)

