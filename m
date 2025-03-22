Return-Path: <linux-kernel+bounces-572404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBDA6CA04
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C981A7AE038
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B91EF38A;
	Sat, 22 Mar 2025 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT3VC/vZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894017E0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645061; cv=none; b=EzxXAwnqCIfMq8pjzSe6slIpQS97gGpTVP1GRRaq4Av07P0X1xSH620OV586KbLhFE+Runuj/fVBQnKvonu82T8O9jnz6byIYCD9nCrs7C0zrz9ezMB7qk9GJjR8sfRdaMXrdJks/zHVXNMfDIIZVD/ukqsrb3XKEyswbUf+ywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645061; c=relaxed/simple;
	bh=P0n0RK+qJlh2K1u2szlYWLBBAEw3vZNc4gJtH0ioQtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XCv5Xi1SQbd6wB+CKRLkhwzkQyaCRLcqjcVsjjY1RAdWOThTEkPiLU6LuqCLJ1SHnwR+D4TaJtbhzlEgupomxHQRfT9baBGgQ5m9xArMeHZfPn3z+t5ZdCye0DcA2daXVbtVjB4CHqpQAy9GxZZrYdrACPFkpL+sZqQYVNckITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT3VC/vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709A0C4CEDD;
	Sat, 22 Mar 2025 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742645061;
	bh=P0n0RK+qJlh2K1u2szlYWLBBAEw3vZNc4gJtH0ioQtw=;
	h=Date:From:To:Cc:Subject:From;
	b=pT3VC/vZdBd+vDFjN2HU4HOc/4uIzH4IrA7b4cy7BUHyc8LEeB2fkyVZ1xJ+a2L9a
	 qe729UelyK0DaSVxGXPvgyYm6SY3ziNnwKVJupAO6HhqQB9gd7ELodB/Bz+TWh6Bla
	 EAw/rt0bs1jsFDrnTgj7rpaasOrOTgPZ2rYqAmg9hZ4TJHOMFWkKB50MQHl/FStjsk
	 ebxD7ZjXGjcp70EEsSu7TeMwL7Hd1wiKuyAT35LxdtAxu35FLqy8rias10a4v3QXE7
	 bOzS25rWlNwQM3PIH2ymPcAvbTvNm1Ww4nUaRHvnpRHIswozpIaBnxgsj0YZu0Bh86
	 PxjsWBXueKGpQ==
Date: Sat, 22 Mar 2025 13:04:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/platform updates for v6.15
Message-ID: <Z96nQRHujehne_Sj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/platform Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2025-03-22

   # HEAD: ef69de53c46a4b526442f6bc5970fc14f7a0bb32 x86/platform/olpc: Remove unused variable 'len' in olpc_dt_compatible_match()

Two small cleanups in the x86 platform support code.

 Thanks,

	Ingo

------------------>
Wolfram Sang (1):
      x86/platform/olpc-xo1-sci: Don't include <linux/pm_wakeup.h> directly

Zeng Heng (1):
      x86/platform/olpc: Remove unused variable 'len' in olpc_dt_compatible_match()


 arch/x86/platform/olpc/olpc-xo1-sci.c | 1 -
 arch/x86/platform/olpc/olpc_dt.c      | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index ccb23c73cbe8..63066e7c8517 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
-#include <linux/pm_wakeup.h>
 #include <linux/power_supply.h>
 #include <linux/suspend.h>
 #include <linux/workqueue.h>
diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index cf5dca2dbb91..e108ce7dad6a 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -215,13 +215,12 @@ static u32 __init olpc_dt_get_board_revision(void)
 static int __init olpc_dt_compatible_match(phandle node, const char *compat)
 {
 	char buf[64], *p;
-	int plen, len;
+	int plen;
 
 	plen = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
 	if (plen <= 0)
 		return 0;
 
-	len = strlen(compat);
 	for (p = buf; p < buf + plen; p += strlen(p) + 1) {
 		if (strcmp(p, compat) == 0)
 			return 1;

