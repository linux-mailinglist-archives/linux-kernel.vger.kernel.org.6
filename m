Return-Path: <linux-kernel+bounces-576644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6703A7126B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE0A3BD103
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39C11A2396;
	Wed, 26 Mar 2025 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="f2G1up5X"
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F819DF53
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976871; cv=none; b=XNSpvpJrrcG3iHPDaUQM7vHExylozFHnfZtTTfJM79yN6HmkqW5CteszNPco1agRgH9iZ1e3IxT5W1VzL9R77Up6zqcodKsYTw7LxJms1S/IDdtQjs8yshqzPG2LxBqr5n/tgPS/SPL13VhmE7VoGvuKQk36gGliTIrD3N4ZO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976871; c=relaxed/simple;
	bh=4ii4RbB5khDzrVzL7SDv7AMK9e8BPIkos2e4idCFtXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nwg2/aebX900HUhpggxRjnLg/TdJHX7bQ2ivJqq79eDPmmtkr/MOy3qTPOFbm7UyOw77u9t3mhRTU/gZsEQ8V3awP8GCEwJ8Uw0Ubbhf0X3flwxDNSY8PQ/l/+byNXUmMhTtB6KFZIpV1hei5P9ecLAwysuOx2GhR8DMrX4Ylfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=f2G1up5X; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 5D8B64406EE;
	Wed, 26 Mar 2025 10:05:20 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1742976320;
	bh=4ii4RbB5khDzrVzL7SDv7AMK9e8BPIkos2e4idCFtXU=;
	h=From:To:Cc:Subject:Date:From;
	b=f2G1up5X0P7nYeimxLzyTY2rJniwJhw8w6QnSfQ+HY5hBiS+RHYwIbTtIIR7OF9+q
	 hkryvVdc+a2yt0OXnequVeOySVAfQJ5iKs+rePyuqyfbsez90tqF3no2gEkTeQ2QqS
	 YOLqLX5yKzLF+hOx3NuOrk7DBeB3w08k36/PTVdga6340d2yiq+iOXyMag2jOX6KS7
	 8Sieme5+jtOZ4hYZEfyxl053WGUBNgi2Bb2qt4yjtS9n3MfB/rGTWBHeerg0ShVKks
	 guhYhdVAB8hmfZzJe6z+8wQijz4qWNAzGJ2bRE5wpXuQoWWkSHInIfuVzb8XxD/GYW
	 tHowfNqEUPcZg==
From: Baruch Siach <baruch@tkos.co.il>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] init/main.c: drop misleading comment
Date: Wed, 26 Mar 2025 10:05:36 +0200
Message-ID: <77c8d040201e17349fc825e445f472518776a434.1742976336.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

initcall_debug prints show with or without the DEBUG macro. This macro
does affect a few pr_debug() calls, so leave it there, but remove the
comment.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

Not sure who takes init/main.c patches. I followed THE REST entry from
MAINTAINERS. Hope this is OK.
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 7f0a2a3dbd29..3594c3e37760 100644
--- a/init/main.c
+++ b/init/main.c
@@ -10,7 +10,7 @@
  *  Simplified starting of init:  Michael A. Griffith <grif@acm.org>
  */
 
-#define DEBUG		/* Enable initcall_debug */
+#define DEBUG
 
 #include <linux/types.h>
 #include <linux/extable.h>
-- 
2.47.2


