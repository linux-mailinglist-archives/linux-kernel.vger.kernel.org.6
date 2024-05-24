Return-Path: <linux-kernel+bounces-189145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F015D8CEBC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2508C1C21621
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE10D126F05;
	Fri, 24 May 2024 21:26:21 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA186252
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716585981; cv=none; b=Y7z268ZtgVQt1e9h2NHSRZbF2HUkZbE4t4F+qa46RqEadU5PfX2d2YhC4O7QlGHdky434an2iGWfcQO8xw/TwhgEjFoUK8B0tv+gIK3ztUHokzNGIAke+UQPb6a4J4ElKNRcaSTPpoeh90ZEhypjk43mGNlUaNs9jIiK7FlnzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716585981; c=relaxed/simple;
	bh=MhEXXJaGtK5CuXaH/4qB+AN6Ncn/Q0Vpk8EX2802L4w=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=Z0kZPDxjISp43hEzzzFvLUnO3HoLGFztAZyMg68/FUj8E28MYcwtMdKRKC+OW6NpkWmYVBKExo0rUeXsi2FBFMLvbAsBlnX8r74Wi1PEJzgj3abPUQLx5dwLVOZxsdK60lLpJosvBeFt7wg98CfjYgdFp0bFsyFEoP5KzDL1TeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 191566195FCC;
	Fri, 24 May 2024 23:26:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id BseJo4ok6U60; Fri, 24 May 2024 23:26:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D381462348A5;
	Fri, 24 May 2024 23:26:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wGqtls3FURQ2; Fri, 24 May 2024 23:26:17 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id BD35B6195FCC;
	Fri, 24 May 2024 23:26:17 +0200 (CEST)
Date: Fri, 24 May 2024 23:26:17 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1964508139.144819.1716585977753.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2 changes for v6.10-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: nPIz3nA82xmA2mDanngZbL3Wwp7WGA==
Thread-Topic: JFFS2 changes for v6.10-rc1

Linus,

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/jffs2-for-linus-6.10-rc1

for you to fetch changes up to af9a8730ddb6a4b2edd779ccc0aceb994d616830:

  jffs2: Fix potential illegal address access in jffs2_free_inode (2024-05-12 22:57:04 +0200)

----------------------------------------------------------------
This pull request contains the following changes for JFFS2:

- Fix Illegal memory access jffs2_free_inode()
- Kernel-doc fixes
- Print symbolic error names

----------------------------------------------------------------
Christian Heusel (1):
      jffs2: print symbolic error name instead of error code

Kunwu Chan (1):
      jffs2: Simplify the allocation of slab caches

Randy Dunlap (1):
      jffs2: nodemgmt: fix kernel-doc comments

Wang Yong (1):
      jffs2: Fix potential illegal address access in jffs2_free_inode

 fs/jffs2/background.c |  4 ++--
 fs/jffs2/malloc.c     | 32 ++++++++------------------------
 fs/jffs2/nodemgmt.c   | 24 +++++++++++++++---------
 fs/jffs2/super.c      |  1 +
 4 files changed, 26 insertions(+), 35 deletions(-)

