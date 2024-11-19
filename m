Return-Path: <linux-kernel+bounces-414479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B019F9D28B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770AB280FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF701CEACB;
	Tue, 19 Nov 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiprhkCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB9192D77
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028250; cv=none; b=Zj5YhC4HTmGE500DOErv36kf/u/+0dcn/veEzFyLGdaBun9XuYL0eWzxZqwXjCm68wa5W0drfIY8OqewTPx5fU82rPDWNe3DWW7PV7pJMIpPuqIOeXK7e07do+1T0GRRFHpVzGVtXcB0q+dpqd09PwCRhP9RR+/wU89vHHnEJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028250; c=relaxed/simple;
	bh=zD455pxGO/pPbjwDJ/NX1AkL1K0SjQr2sIIoO+GcYvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TutPxgQv1BuzfQmsETt9CEnMgArz/hdpxJt8UCJCwUhzXeiFumYl0dP3mEmt7Bo2uZkFxG/KDxhri2evELjwImBOVFizd1TYqAE902qiJXKXqYVZgtDbiF7TUmi6oJJblF/m16DsgiQREArQgdCW+BFpuZI8X9a0sVJ43pJTBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiprhkCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C043FC4CECF;
	Tue, 19 Nov 2024 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732028249;
	bh=zD455pxGO/pPbjwDJ/NX1AkL1K0SjQr2sIIoO+GcYvQ=;
	h=Date:From:To:Cc:Subject:From;
	b=MiprhkCfxr3gqRTMX7JdJRhUa9+JtizEA/qweJidUMXNvwHl7j/WZQsD/YoYMSli+
	 8Ouise/xxzeHp9MW0IrHTC/7c4qCtylF+IMtVSWO2ArLTHYq0VFiw/1a2Z8MiqFEcK
	 67TCR5gV7G3VEoV2DfJq3nx2q8MOwhOTEVCnAykPuCBiNIw6Rb7Q0riQRhDwpb86/V
	 T0fVC19iv7XCIPwjFsLevC3x+kzyQ5+BrF3UCLTbue0QqxIB3Nn8cSwypbwI/dl/eJ
	 8XGWs4GbijQzF93B2ojYZjTNN1yCrfWcWPPfZYuFZA1q38iE6jJlX+DhzQFt6UnIcQ
	 SA/vTXEXkA1qw==
Date: Tue, 19 Nov 2024 22:57:23 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>, Gou Hao <gouhao@uniontech.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs updates for 6.13-rc1
Message-ID: <ZzynU2PQOgkWy6BM@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>, Gou Hao <gouhao@uniontech.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for 6.13-rc1?

There is no outstanding feature for this cycle.  The most useful changes
are SEEK_{DATA,HOLE} support and some decompression micro-optimization.
Other than those, there are some bugfixes and cleanups as usual.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc1

for you to fetch changes up to 0bc8061ffc733a0a246b8689b2d32a3e9204f43c:

  erofs: handle NONHEAD !delta[1] lclusters gracefully (2024-11-18 18:50:14 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add SEEK_{DATA,HOLE} support;

 - Free redundant pclusters if no cached compressed data is valid;

 - Add sysfs entry to drop internal caches;

 - Several bugfixes & cleanups.

----------------------------------------------------------------
Chunhai Guo (2):
      erofs: free pclusters if no cached folio is attached
      erofs: add sysfs node to drop internal caches

Gao Xiang (8):
      erofs: add SEEK_{DATA,HOLE} support
      erofs: get rid of erofs_{find,insert}_workgroup
      erofs: move erofs_workgroup operations into zdata.c
      erofs: sunset `struct erofs_workgroup`
      erofs: fix file-backed mounts over FUSE
      erofs: get rid of `buf->kmap_type`
      erofs: clarify direct I/O support
      erofs: handle NONHEAD !delta[1] lclusters gracefully

Gou Hao (1):
      erofs: simplify definition of the log functions

Hongzhen Luo (1):
      erofs: fix blksize < PAGE_SIZE for file-backed mounts

 Documentation/ABI/testing/sysfs-fs-erofs |  11 ++
 fs/erofs/data.c                          |  69 +++++-----
 fs/erofs/inode.c                         |  12 +-
 fs/erofs/internal.h                      |  35 ++---
 fs/erofs/super.c                         |  35 ++---
 fs/erofs/sysfs.c                         |  17 +++
 fs/erofs/zdata.c                         | 221 +++++++++++++++++++++++--------
 fs/erofs/zmap.c                          |  17 +--
 fs/erofs/zutil.c                         | 155 +---------------------
 9 files changed, 276 insertions(+), 296 deletions(-)


