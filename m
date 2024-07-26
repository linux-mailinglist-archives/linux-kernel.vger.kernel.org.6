Return-Path: <linux-kernel+bounces-263291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC193D3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102101F24203
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A417BB19;
	Fri, 26 Jul 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsEh3Y7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5E23A8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999573; cv=none; b=Qj6gISXntMLH54f8CPJ72lt+NDrrI4xcry6bjHF2wrbcHYJZeqU3Xz4agSs2uKXTUP3Kho19fUb0yTVIOSogIHBncq0x1OspxIjBwAEoIDHlmYAxgFNJL5H4C5WRcBAYh/2+yfhXQv4coIa+S27wWFg1daIk+pIOpElvnbCEpo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999573; c=relaxed/simple;
	bh=+n9W4ZMWC0TWR+Gs0AP+tbxvG9OWgAbubrC48+1vsOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gmMg31u5D7STkvH7F8sLJE4HcXbzdBA1ZitGTgCIhJ7HEQwOHPO8L5+BaAfVIrzlxdEQ7aZaR/w/tI8UZ5CCtfI95EtxsDZjmsznADDfAVSEozJtmQ9PGgzNPqCmAXvI4o8X1VtiDd19gHUzIGc39NQNq63YWyqixje5k4j63Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsEh3Y7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CEBC32782;
	Fri, 26 Jul 2024 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721999573;
	bh=+n9W4ZMWC0TWR+Gs0AP+tbxvG9OWgAbubrC48+1vsOU=;
	h=Date:From:To:Cc:Subject:From;
	b=dsEh3Y7Q2WFszkhItk13QYdg5EtkAi8s2j4elndyJuZEZucV6Y+ERHP5QUamZ3J38
	 NgQssw0GxnXPbXpSlWvNOUxB40U3Nvy84ZAAA9erz8ecmg39+e2GCgcW5urWvybyQC
	 3d4VD1mFh8M3Uez9SWHjvjoqRFq2rc1Hy1ghmo7kbU7UpJk+zL6TMjAlNBI+u7EHDV
	 7R72EPJSuhxTDp33AVp28fqDFxutJj6qCCVS7zg65cDmkGCj9jnzSfazeWin0wIIpQ
	 1HKrASjAnJrV4RbFBVAcMbbAH1kN0KopXujps4ZcE4FF/zkrQkmgZqTERZiFqATKPN
	 5Be6bC3M/K0Lg==
Date: Fri, 26 Jul 2024 21:12:43 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Huang Xiaojia <huangxiaojia2@huawei.com>,
	Chen Ni <nichen@iscas.ac.cn>, Chao Yu <chao@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] erofs more updates for 6.11-rc1
Message-ID: <ZqOgy0Xh2hPy4Ojm@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Huang Xiaojia <huangxiaojia2@huawei.com>,
	Chen Ni <nichen@iscas.ac.cn>, Chao Yu <chao@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider these extra patches for 6.11-rc1?

Two patches add STATX_DIOALIGN and FS_IOC_GETFSSYSFSPATH support and
another one gets rid of the remaining page->index in the codebase
according to [1].  I tend to resolve them in this cycle since those
improvements are actually straight-forward.

The remaining fix addresses a LZ4 decompression race introduced in
v6.10 found by regular stress tests.

All commits have been in -next except for Chao's new reviewed-bys,
so I re-pushed them again.  No potential merge conflict is observed.

[1] https://lore.kernel.org/r/Zp8fgUSIBGQ1TN0D@casper.infradead.org

Thanks,
Gao Xiang

The following changes since commit a3c10bed330b7ab401254a0c91098a03b04f1448:

  erofs: silence uninitialized variable warning in z_erofs_scan_folio() (2024-07-13 12:47:34 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1-2

for you to fetch changes up to 14e9283fb22d0d259820a5f05c6059678bab9ac5:

  erofs: convert comma to semicolon (2024-07-26 18:48:12 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support STATX_DIOALIGN and FS_IOC_GETFSSYSFSPATH;

 - Fix a race of LZ4 decompression due to recent refactoring;

 - Another multi-page folio adaption in erofs_bread().

----------------------------------------------------------------
Chen Ni (1):
      erofs: convert comma to semicolon

Gao Xiang (2):
      erofs: fix race in z_erofs_get_gbuf()
      erofs: support multi-page folios for erofs_bread()

Hongbo Li (1):
      erofs: support STATX_DIOALIGN

Huang Xiaojia (1):
      erofs: add support for FS_IOC_GETFSSYSFSPATH

 fs/erofs/data.c              | 30 ++++++++++++------------------
 fs/erofs/decompressor_lzma.c |  2 +-
 fs/erofs/inode.c             | 19 +++++++++++++++++--
 fs/erofs/super.c             | 16 ++++++++++++++++
 fs/erofs/zutil.c             |  3 +++
 5 files changed, 49 insertions(+), 21 deletions(-)

