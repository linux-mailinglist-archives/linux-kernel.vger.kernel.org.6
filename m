Return-Path: <linux-kernel+bounces-328670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8106978727
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E33D1F223DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBED126BE9;
	Fri, 13 Sep 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Tq02fW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BE85283
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249718; cv=none; b=qEbHZKDYRYnz9NihZJjBQxrbFEr4Chvyt6+bVLmg0VjTymeMiBInj2rEQ8dAP/HEon+h/JjM/bYCtZjnOaa2fJ0DaNUMydysjd//eDDrrFlpn5VpizibpRraZ4EYFs4z8DwHZIB6zWWenigL9g9KYWOSsmVEX1jYiwbvy8hCXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249718; c=relaxed/simple;
	bh=Y5gQ40zmMeWnVA/ZC0/AJPglvrv6zNXwP2X+yYqn3YM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WRDxRWiGsMWpWVzWGnjuEyYD5D2m2hjPRcT4zjCn0wZ6uAGKbaE1k8Dco8lcwip3+gQGEBYXboSjVTnArHl1iSbciSv3OJ3NB4EVCNWHmLOtN0suF0uPuUlyJx9cPJ9vdpK7/9E/ssbyTQO/BrHAAxOltqvKsAsX3ocTXQW/Nug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Tq02fW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459F2C4CEC0;
	Fri, 13 Sep 2024 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726249717;
	bh=Y5gQ40zmMeWnVA/ZC0/AJPglvrv6zNXwP2X+yYqn3YM=;
	h=Date:From:To:Cc:Subject:From;
	b=B9Tq02fW45jqkSbXtFOm+kioCJNAQSd7QyYnJmGNTmaixZ3Qe/24zcvG3vMfotRWC
	 nLVBvcEiZ8NeQ0wovVd/S8qBy7YtEmxOXHPjmqY4NK/zfHyQrDbDIqnEQ0SQ7dDl4n
	 ZVnNYH8EXZfuO4qiFIjqmEfEcegYlP+8WP9boVqthqkTC+1uCx+9cTJa1mtjR4IqMp
	 YrzfYXGfiM6KXtvuoTntPU0EqCQO4m1YA/yJYt3r77dsrG8l+PHRSirvehyB8liAuQ
	 bF7CwOGCtoputDlOaSlIDn3UwttsC1viR9u0R4Ol0OvX6waav8wA90dUJc9o/eD+Y0
	 A1RvwLLuVwLew==
Date: Sat, 14 Sep 2024 01:48:29 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>, Sandeep Dhavale <dhavale@google.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Yiyang Wu <toolmanp@tlmp.cc>, Chunhai Guo <guochunhai@vivo.com>
Subject: [GIT PULL] erofs updates for 6.12-rc1
Message-ID: <ZuR67f12ntVf59FZ@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>, Sandeep Dhavale <dhavale@google.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Yiyang Wu <toolmanp@tlmp.cc>, Chunhai Guo <guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for 6.12-rc1? It's a bit earlier
due to our mid-autumn festival holidays next week.

In this cycle, we'd like to add file-backed mount support, which has
has been a strong requirement for years.  It is especially useful when
there are thousands of images running on the same host for containers
and other sandbox use cases, unlike OS image use cases.

Without file-backed mounts, it's hard for container runtimes  to manage
and isolate so many unnecessary virtual block devices safely and
efficiently, therefore file-backed mounts are highly preferred.
For EROFS users, ComposeFS [1], containerd, and Android APEXes [2] will
directly benefit from it, and I've seen no risk in implementing it as
a completely immutable filesystem.

The previous experimental feature "EROFS over fscache" is now marked as
deprecated because:

 - Fscache is no longer an independent subsystem and has been merged
   into netfs, which was somewhat unexpected when it was proposed.

 - New HSM "fanotify pre-content hooks" [3] will be landed upstream.
   These hooks will replace "EROFS over fscache" in a simpler way, as
   EROFS won't be bother with kernel caching anymore.  Userspace
   programs can also manage their own caching hierarchy more flexibly.

Once the HSM "fanotify pre-content hooks" is landed, I will remove the
fscache backend entirely as an internal dependency cleanup.  More
backgrounds are listed in the original patchset [4].

In addition to that, there are bugfixes and cleanups as usual as shown
below.  All commits have been in -next and no potential merge conflict
is observed.

Thanks,
Gao Xiang

[1] https://github.com/containers/storage/pull/2039 
[2] https://lore.kernel.org/r/CAB=BE-R3wU7hBBaeAXdkDp2kvODxSFWNQtcmc5tCppN5qwdQgw@mail.gmail.com
[3] https://lore.kernel.org/r/cover.1725481503.git.josef@toxicpanda.com
[4] https://lore.kernel.org/r/20240830032840.3783206-1-hsiangkao@linux.alibaba.com 

The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc1

for you to fetch changes up to 025497e1d176a9e063d1e60699527e2f3a871935:

  erofs: reject inodes with negative i_size (2024-09-12 23:00:09 +0800)

----------------------------------------------------------------
Changes since last update:

 - Support file-backed mounts for containers and sandboxes;

 - Mark the experimental fscache backend as deprecated;

 - Handle overlapped pclusters caused by crafted images properly;

 - Fix a failure path which could cause infinite loops in
   z_erofs_init_decompressor();

 - Get rid of unnecessary NOFAILs;

 - Harmless on-disk hardening & minor cleanups.

----------------------------------------------------------------
Chunhai Guo (1):
      erofs: allocate more short-lived pages from reserved pool first

Gao Xiang (10):
      erofs: fix incorrect symlink detection in fast symlink
      erofs: clean up erofs_register_sysfs()
      erofs: handle overlapped pclusters out of crafted images properly
      erofs: add file-backed mount support
      erofs: support unencoded inodes for fileio
      erofs: support compressed inodes for fileio
      erofs: mark experimental fscache backend deprecated
      erofs: sunset unneeded NOFAILs
      erofs: restrict pcluster size limitations
      erofs: reject inodes with negative i_size

Hongzhen Luo (1):
      erofs: simplify erofs_map_blocks_flatmode()

Sandeep Dhavale (1):
      erofs: fix error handling in z_erofs_init_decompressor

Yiyang Wu (2):
      erofs: use kmemdup_nul in erofs_fill_symlink
      erofs: refactor read_inode calling convention

 fs/erofs/Kconfig        |  22 +++++-
 fs/erofs/Makefile       |   1 +
 fs/erofs/data.c         | 109 ++++++++++++++++++---------
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/erofs_fs.h     |   5 +-
 fs/erofs/fileio.c       | 192 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c        | 138 +++++++++++++++-------------------
 fs/erofs/internal.h     |  26 ++++++-
 fs/erofs/super.c        |  80 +++++++++++++-------
 fs/erofs/sysfs.c        |  30 ++------
 fs/erofs/zdata.c        | 196 ++++++++++++++++++++++--------------------------
 fs/erofs/zmap.c         |  42 +++++------
 12 files changed, 544 insertions(+), 299 deletions(-)
 create mode 100644 fs/erofs/fileio.c

