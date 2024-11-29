Return-Path: <linux-kernel+bounces-425990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A99DED73
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EF5B20CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393D190468;
	Fri, 29 Nov 2024 23:06:45 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F8160783
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921605; cv=none; b=qHteeT0wzl8uuXCksJ4PtWNQq3erUrcnltwMvh1EP4ZYAw4/N8ffGSCs1fmxzUWD+FNeqkc6DM1yjkC0dDHpExyLg/Ce4ZOPHOchF6KDwuHBxtNBSInc0ciTvTqMySfLIg1sXpTBPNWy3Xlg76S9sMRWG5kGkcLNj/lANs/TxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921605; c=relaxed/simple;
	bh=0J5M8LAbFZqYbBesCDyck/hrpiWVuTES3ZibDcRqqXk=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=bKI34MvfrJDhJiDCpeHjpOQ11Eh99cL1ZdbSu8pDYRiaS19cLLJEe8Txh4iSYWdEme9+B/051zdoJhglxB6tf1JoVL/YI0vEu01SudVLkvqgTu3+Bdt0s8AhOqRO7mh+1nApB19fVtt24UkJCyMHi2aYz4k6AI5ntOw3WH2CuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 58CA72F3327;
	Sat, 30 Nov 2024 00:06:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rXHNB-TZja_I; Sat, 30 Nov 2024 00:06:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DDCA22F3326;
	Sat, 30 Nov 2024 00:06:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SImoWFlGvozQ; Sat, 30 Nov 2024 00:06:39 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id BC6232F3325;
	Sat, 30 Nov 2024 00:06:39 +0100 (CET)
Date: Sat, 30 Nov 2024 00:06:39 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1445196426.11806664.1732921599708.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS, UBI and UBIFS changes for v6.13-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF133 (Linux)/8.8.12_GA_3809)
Thread-Index: ZnsWLHxGkw9Ed9uDAQ5Gbmjga6vi3Q==
Thread-Topic: JFFS, UBI and UBIFS changes for v6.13-rc1

Linus,

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623=
:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for=
-linus-6.13-rc1

for you to fetch changes up to bcdcb115eaed5e988cf37cc9a1dd5f5dd200e927:

  ubifs: Fix uninitialized use of err in ubifs_jnl_write_inode() (2024-11-1=
5 17:45:25 +0100)

----------------------------------------------------------------
This pull request contains updates for JFFS2, UBI and UBIFS:

JFFS2:
- Bug fix for rtime compression
- Various cleanups

UBI:
- Cleanups for fastmap and wear leveling

UBIFS:
- Add support for FS_IOC_GETFSSYSFSPATH
- Remove dead ioctl code
- Fix UAF in ubifs_tnc_end_commit()

----------------------------------------------------------------
Colin Ian King (2):
      mtd: ubi: remove redundant check on bytes_left at end of function
      jffs2: remove redundant check on outpos > pos

Hongbo Li (2):
      ubifs: remove unused ioctl flags GETFLAGS/SETFLAGS
      ubifs: add support for FS_IOC_GETFSSYSFSPATH

Javier Carrasco (1):
      mtd: ubi: fix unreleased fwnode_handle in find_volume_fwnode()

Kinsey Moore (1):
      jffs2: Prevent rtime decompress memory corruption

Liu Mingrui (1):
      ubifs: Display the inode number when orphan twice happens

Markus Elfring (2):
      ubifs: Call iput(xino) only once in ubifs_purge_xattrs()
      ubifs: Reduce kfree() calls in ubifs_purge_xattrs()

M=C3=A5rten Lindahl (1):
      ubi: wl: Close down wear-leveling before nand is suspended

Nathan Chancellor (1):
      ubifs: Fix uninitialized use of err in ubifs_jnl_write_inode()

Pascal Eberhard (1):
      ubifs: xattr: remove unused anonymous enum

Qingfang Deng (1):
      jffs2: fix use of uninitialized variable

Shen Lichuan (2):
      ubifs: Convert to use ERR_CAST()
      jffs2: Correct some typos in comments

Suraj Sonawane (1):
      fs: jffs2: Fix inconsistent indentation in jffs2_mark_node_obsolete

Thorsten Blum (1):
      jffs2: Use str_yes_no() helper function

Waqar Hameed (1):
      ubifs: authentication: Fix use-after-free in ubifs_tnc_end_commit

Zhang Zekun (1):
      mtd: ubi: Rmove unused declaration in header file

Zhihao Cheng (6):
      ubifs: ubifs_jnl_write_inode: Only check once for the limitation of x=
attr count
      ubifs: Remove ineffective function ubifs_evict_xattr_inode()
      ubi: wl: Put source PEB into correct list if trying locking LEB faile=
d
      ubi: fastmap: wl: Schedule fm_work if wear-leveling pool is empty
      ubifs: Correct the total block count by deducting journal reservation
      ubi: fastmap: Fix duplicate slab cache names while attaching

 drivers/mtd/ubi/attach.c     | 12 ++++++------
 drivers/mtd/ubi/fastmap-wl.c | 19 ++++++++++++++++---
 drivers/mtd/ubi/nvmem.c      |  2 +-
 drivers/mtd/ubi/ubi.h        |  3 ++-
 drivers/mtd/ubi/vmt.c        |  2 ++
 drivers/mtd/ubi/wl.c         | 32 +++++++++++++++++++++++++++++--
 drivers/mtd/ubi/wl.h         |  3 ++-
 fs/jffs2/compr_rtime.c       |  3 +++
 fs/jffs2/compr_rubin.c       |  5 -----
 fs/jffs2/erase.c             |  7 +++----
 fs/jffs2/gc.c                |  2 +-
 fs/jffs2/nodemgmt.c          | 17 +++++++++--------
 fs/jffs2/readinode.c         |  2 +-
 fs/ubifs/ioctl.c             |  6 ------
 fs/ubifs/journal.c           | 13 +++++++------
 fs/ubifs/lpt_commit.c        |  4 ++--
 fs/ubifs/orphan.c            |  2 +-
 fs/ubifs/super.c             |  8 +++++---
 fs/ubifs/tnc.c               |  2 --
 fs/ubifs/tnc_commit.c        |  2 ++
 fs/ubifs/ubifs.h             |  3 ---
 fs/ubifs/xattr.c             | 45 +++-------------------------------------=
----
 22 files changed, 96 insertions(+), 98 deletions(-)

