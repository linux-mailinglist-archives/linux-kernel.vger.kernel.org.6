Return-Path: <linux-kernel+bounces-449350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B5C9F4D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FBE188331D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C941F5434;
	Tue, 17 Dec 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag1JbsLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9813398A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445445; cv=none; b=nw9/fn553Y6XACtwAnG5eahAgSWKqSqhnVe1Gf49TRLCrrsO1+DOJEhj7vsnU3j0rBSSLPRrDOaWXf03Si+pHTCa1JkUaIBZYzxJcPjCwszy29sNokklIyjai2A41/MsBRWDTzFHA9PnvP2T9Rth7r0xgDKgkIa7vQa2A2g+68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445445; c=relaxed/simple;
	bh=j3HRziA2BSqPktqBMFjFA6JGdKsy5NE/8LDdhAzqgWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=avY8SDuxPhjSA1WrP5NN/K0nrziSoa3e43+aIHQ8sRLNktkTyvOpT+PMYoTis9IZXTREqpFcUAlg+joXupkH1WakvgbWMzqLoLOZMDKiQ+AjU5QDTzqplXSIpfCF7/P7izKSGe1WfqeAyQzaYlL5U0waOFVqsJ1Zr+maiXaWrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag1JbsLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7BEC4CED3;
	Tue, 17 Dec 2024 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445445;
	bh=j3HRziA2BSqPktqBMFjFA6JGdKsy5NE/8LDdhAzqgWQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Ag1JbsLDqEOmqLWOxJ2b2/gtGJiptyFZvUaPQF2iP6duiwvrC8dLKNZSN3LW0lso7
	 lie5xEPnBOckCI+I7pApjdZWHjrirFn3VQ3o0xZif5VBpEo9mdJHdnvqslKzQWMoNB
	 f0KrH2wvr9k/p35e8Lmhav8nAS/t4wtpQ5POocoh6tAjmqmxVAvUkHZggVYZFeiWP4
	 hVtc61PHq3r2oPkR+/Mz+8fwO1psX00X97E5jqJF49TRCfMSmLwPtQRX+NelVeHAJV
	 ixkmgFvdXYlQTkBErqW0igyDXU2HYbUXVqqN8HY+BmqcuVGFZ6RDN0/0RFoyQuGH/L
	 yXAiKM+BJcyZA==
Date: Tue, 17 Dec 2024 22:23:58 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	chao@kernel.org, Yue Hu <zbestahu@gmail.com>
Subject: [GIT PULL] erofs fixes for 6.13-rc4
Message-ID: <Z2GJfmDTrzh0mM8P@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	chao@kernel.org, Yue Hu <zbestahu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider these three fixes for 6.13-rc4?

The first one fixes a syzbot UAF report caused by a commit introduced
in this cycle, but it also addresses a longstanding memory leak.  The
second one resolves a PSI memstall mis-accounting issue.

The remaining patches switch file-backed mounts to use buffered I/Os
by default instead of direct I/Os, since the page cache of underlay
files is typically valid and maybe even dirty.  This change also aligns
with the default policy of loopback devices.  A mount option has been
added to try to use direct I/Os explicitly.

All commits have been in -next and no potential merge conflict
is observed.

Thanks,
Gao Xiang

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.13-rc4-fixes

for you to fetch changes up to 6422cde1b0d5a31b206b263417c1c2b3c80fe82c:

  erofs: use buffered I/O for file-backed mounts by default (2024-12-16 21:02:07 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix (pcluster) memory leak and (sbi) UAF after umounting;

 - Fix a case of PSI memstall mis-accounting;

 - Use buffered I/Os by default for file-backed mounts.

----------------------------------------------------------------
Gao Xiang (6):
      erofs: fix rare pcluster memory leak after unmounting
      erofs: fix PSI memstall accounting
      erofs: add erofs_sb_free() helper
      erofs: use `struct erofs_device_info` for the primary device
      erofs: reference `struct erofs_device_info` for erofs_map_dev
      erofs: use buffered I/O for file-backed mounts by default

Yue Hu (1):
      MAINTAINERS: erofs: update Yue Hu's email address

 MAINTAINERS         |  2 +-
 fs/erofs/data.c     | 36 +++++++++----------------
 fs/erofs/fileio.c   |  9 ++++---
 fs/erofs/fscache.c  | 10 +++----
 fs/erofs/internal.h | 15 ++++-------
 fs/erofs/super.c    | 78 +++++++++++++++++++++++++++++------------------------
 fs/erofs/zdata.c    |  4 +--
 fs/erofs/zutil.c    |  7 ++---
 8 files changed, 79 insertions(+), 82 deletions(-)

