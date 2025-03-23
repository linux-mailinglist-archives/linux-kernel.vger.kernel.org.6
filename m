Return-Path: <linux-kernel+bounces-572905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05D1A6D025
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901D57A68BC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2D1419A9;
	Sun, 23 Mar 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvuaozcb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B6136E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742749027; cv=none; b=oB72KUXeydD6Q1zcSLzIXpgAIOXifDBbmVrcru5Ezswcr9i7l9oGSx2Fk1N+bMfUjP3d10p6Ezv9lTOTd/BYfaRwXDI8R1QGzjEcsMynxtmiEeeHcziLmfhNCymGiNzZ7Z50c2tFEqXR8hjZDjM+0EutKOIA1+ispxGwYq5a30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742749027; c=relaxed/simple;
	bh=FxOUYhiHm+2OmW3aiiCHsAGgHhgywv+CYn5hIK/Lw08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CbdQwsRi5yyD0ylPcDN9zSjzT5CY93i2B+Z+FkUijBZEiPg0hJFR5vbdLszunUjXLJ1ZELtabzryy1mijlGgyuRb0ZUmbVDCfLkZO2S8guj0+4eQIFf8HXLzVTjkEevg34lkBEOPmPEZlW+iF08Glj6c9ai4iJ8pOClt4YZLuu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvuaozcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D03C4CEE2;
	Sun, 23 Mar 2025 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742749025;
	bh=FxOUYhiHm+2OmW3aiiCHsAGgHhgywv+CYn5hIK/Lw08=;
	h=Date:From:To:Cc:Subject:From;
	b=YvuaozcbbaZWjR5TUcLna2xhhJ+gMGzapwv8Nea3w8FH+SdIXAm0HB0sh63PZT8R5
	 fLwJn+ykfQtZlqeoyqVdrcoBoTEQbqt/t0AB+HTx6+kd/VDnx3dfYNC5+E3o3JRusl
	 cme4mEwvdpXG0kSuJzoD+DkICpYgvukU2sfGCViGF/aU6gSuO/y3K0Jb9O+KzNWmPP
	 lPPt0lNOra+bs2dtpyz8cjno8PQPneoqoONvYBK3xOYOaIgmqtUQD4WsLR2l0yBz03
	 oe2aTAaJiuXKHuTdNAB+airws5qyZy3Y5F0VIFrcS7ccfbrL5xnC25QFqbT8YnYQeI
	 T9BpDPuUhyJwA==
Date: Mon, 24 Mar 2025 00:57:00 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs updates for 6.15-rc1
Message-ID: <Z+A9XO3+rPjpLUa2@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Bo Liu <liubo03@inspur.com>,
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

Could you consider this pull request for 6.15-rc1?

In this cycle, EROFS 48-bit block addressing is available to support
massive datasets for model training and other large data archive use
cases.

In addition, byte-oriented encoded extents have been supported to
reduce metadata sizes when using large configurations as well as to
improve Zstd compression speed.

There are some bugfixes and cleanups as usual.  All commits have been
in -next for a while and no potential merge conflicts is observed.

Thanks,
Gao Xiang

The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.15-rc1

for you to fetch changes up to 0f24e3c05afeac905a9df557264cc48f3363ab47:

  erofs: enable 48-bit layout support (2025-03-17 14:02:16 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support 48-bit block addressing for large images;

 - Introduce encoded extents to reduce metadata on larger pclusters;

 - Enable unaligned compressed data to improve Zstd compression speed;

 - Allow 16-byte volume names again;

 - Minor cleanups.

----------------------------------------------------------------
Bo Liu (1):
      erofs: get rid of erofs_kmap_type

Gao Xiang (14):
      erofs: allow 16-byte volume name again
      erofs: simplify tail inline pcluster handling
      erofs: clean up header parsing for ztailpacking and fragments
      erofs: move {in,out}pages into struct z_erofs_decompress_req
      erofs: get rid of erofs_map_blocks_flatmode()
      erofs: simplify erofs_{read,fill}_inode()
      erofs: add 48-bit block addressing on-disk support
      erofs: implement 48-bit block addressing for unencoded inodes
      erofs: support dot-omitted directories
      erofs: initialize decompression early
      erofs: add encoded extent on-disk definition
      erofs: implement encoded extent metadata
      erofs: support unaligned encoded data
      erofs: enable 48-bit layout support

Hongzhen Luo (1):
      erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify switches

 fs/erofs/Kconfig                |  14 +-
 fs/erofs/compress.h             |   2 +-
 fs/erofs/data.c                 | 148 +++++++++------------
 fs/erofs/decompressor.c         |  95 +++++--------
 fs/erofs/decompressor_deflate.c |   8 +-
 fs/erofs/decompressor_lzma.c    |   8 +-
 fs/erofs/decompressor_zstd.c    |   8 +-
 fs/erofs/dir.c                  |   9 +-
 fs/erofs/erofs_fs.h             | 191 +++++++++++++--------------
 fs/erofs/fileio.c               |   2 +-
 fs/erofs/fscache.c              |   2 +-
 fs/erofs/inode.c                | 125 +++++++++---------
 fs/erofs/internal.h             |  47 +++----
 fs/erofs/namei.c                |   2 +-
 fs/erofs/super.c                |  85 ++++++------
 fs/erofs/sysfs.c                |   2 +
 fs/erofs/xattr.c                |  12 +-
 fs/erofs/zdata.c                | 102 +++++++-------
 fs/erofs/zmap.c                 | 286 ++++++++++++++++++++++++++--------------
 include/trace/events/erofs.h    |   2 +-
 20 files changed, 579 insertions(+), 571 deletions(-)

