Return-Path: <linux-kernel+bounces-435950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5699E7F12
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045871883788
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4813BC18;
	Sat,  7 Dec 2024 08:40:36 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F89139CEF
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733560836; cv=none; b=ESnCXYnI88/XnFRsgdkd09xy+wC39SyFC+Af5w1YYu5ht8IeOSsG19Amz67hLTAwu4KquIjMOfm5zsmPQ9bcFMzM8mju1+/ssv6rv4yOtBxHU6kxCjPzbyfZZoOGEqRmgDIbs3u5jix5UKW736B6Qa2GNBRlFofxt3ABKwgekLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733560836; c=relaxed/simple;
	bh=FAwhwGver0Xink7EnbCQjsDv1FnYh/KNAx8FytEofH8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=sX8FXq33yq5pcPxfktj7mliJHf7+7crsawf8QNXlJHFoapyHMk9HN3HCbfGYeOnOAYvfg3XZi/LEY0iRICFXP9JGl4No01uhE5rFbH2xbf1aVPUjwsqTIVqYBiDPxjTOoAk0E078i0DP1tiFFDdXNi1200+FC5b1wBTCLcEJEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 96F002E6145;
	Sat,  7 Dec 2024 09:40:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qPy_3ZzQQ0Pu; Sat,  7 Dec 2024 09:40:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 520E32E6150;
	Sat,  7 Dec 2024 09:40:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vvl3TawRBc6n; Sat,  7 Dec 2024 09:40:25 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 33B032E6145;
	Sat,  7 Dec 2024 09:40:25 +0100 (CET)
Date: Sat, 7 Dec 2024 09:40:25 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <972877429.45679137.1733560825113.JavaMail.zimbra@nod.at>
Subject: [GIT PUL] JFFS2 fixes for v6.13-rc2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF133 (Linux)/8.8.12_GA_3809)
Thread-Index: 33KlDEGjZjqXAp/6Bdh5OoiTVbwAZg==
Thread-Topic: JFFS2 fixes for v6.13-rc2

Linus,

The following changes since commit feffde684ac29a3b7aec82d2df850fbdbdee55e4:

  Merge tag 'for-6.13-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2024-12-03 11:02:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.13-rc2

for you to fetch changes up to b29bf7119d6bbfd04aabb8d82b060fe2a33ef890:

  jffs2: Fix rtime decompressor (2024-12-05 12:31:40 +0100)

----------------------------------------------------------------
This pull request contains fixes for JFFS2:

- Fixup rtime compressor bounds checking

----------------------------------------------------------------
Richard Weinberger (1):
      jffs2: Fix rtime decompressor

 fs/jffs2/compr_rtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

