Return-Path: <linux-kernel+bounces-444457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B91829F0729
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFA1280D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6264A1A8F85;
	Fri, 13 Dec 2024 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxRpzPIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7E187849
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080595; cv=none; b=KLbD/L1glkfQtzdop1ZZJ1r9Nqi6S22CdJwne6HD/OCpy331mK5/jkrmQDsHWPtGGEcAsKIolmf+PTnfp+6QlNPG48Ju1PGDfhdxpwAdtkJu2MsAQQWVeQoS1kjtB5R+qQg19QRyd+H2PcnfPBi+kPIHhwTtWQSImVk+5pZd0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080595; c=relaxed/simple;
	bh=NizxC6ffABBIqBlStRdWBBxHvkeP+72l2DX9fzyIYCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nn33zm1+FfeWaTHYugpetZSHVfrw3I+wXywa9hg1cCHrnkOQw77nqB5FU2Ykz5o0hUUyBhDquDuAM8abG1Bd3M1qBgyKQLPepL6uRFYgGBtAzxc5m7HnIu43Fbem1RDYSvXk810GOf1hBBpDiZ2U/3VqfGJu1wwHQG+SLM6+yvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxRpzPIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B13C4CED0;
	Fri, 13 Dec 2024 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734080595;
	bh=NizxC6ffABBIqBlStRdWBBxHvkeP+72l2DX9fzyIYCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxRpzPIZnnnDBm/XykoqLZyTN+GsGvqQvgPCw1HSgyhujXWEKZPqdlBRDdvtGVtUk
	 CG3+gWKfxHtFW7b/oQnIFLIHUjPCx8Vafi6IL1hUpdwtpo6EpceVegW8VGXjXxB1ej
	 D9Z0n5GduLYhGzbbeGnYWNOOxtl3I5DE6Oz7bAQWlm2AC7WGJapuaqLTk9CBYhql2V
	 adtOMV+DrPMMfVseR6EpzwtUSP1pNp60diN+yJ1xsmnut6JObdpNauEB2kpeWumXlp
	 apt1M3ub6suN3nqA9FDiH0mvWfqPVEd1hjSEs8OBL5CSDiAld+U0qPsbyKAyogBxKG
	 X2wocE0dxAA3g==
From: Arnd Bergmann <arnd@kernel.org>
To: Min Ma <min.ma@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	George Yang <George.Yang@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] accel/amdxdna: add missing includes
Date: Fri, 13 Dec 2024 10:02:55 +0100
Message-Id: <20241213090259.68492-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213090259.68492-1-arnd@kernel.org>
References: <20241213090259.68492-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This driver fails to build in random configurations:

drivers/accel/amdxdna/amdxdna_mailbox.c:357:8: error: unknown type name 'irqreturn_t'
  357 | static irqreturn_t mailbox_irq_handler(int irq, void *p)
      |        ^~~~~~~~~~~
drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'mailbox_irq_handler':
drivers/accel/amdxdna/amdxdna_mailbox.c:367:16: error: 'IRQ_HANDLED' undeclared (first use in this function)
  367 |         return IRQ_HANDLED;
      |                ^~~~~~~~~~~
drivers/accel/amdxdna/amdxdna_mailbox.c:367:16: note: each undeclared identifier is reported only once for each function it appears in
drivers/accel/amdxdna/amdxdna_mailbox.c: In function 'mailbox_rx_worker':
drivers/accel/amdxdna/amdxdna_mailbox.c:395:25: error: implicit declaration of function 'disable_irq'; did you mean 'disable_work'? [-Wimplicit-function-declaration]
  395 |                         disable_irq(mb_chann->msix_irq);
      |                         ^~~~~~~~~~~
drivers/accel/amdxdna/aie2_solver.c: In function 'remove_partition_node':
drivers/accel/amdxdna/aie2_solver.c:121:9: error: implicit declaration of function 'kfree' [-Wimplicit-function-declaration]
  121 |         kfree(pt_node);
      |         ^~~~~
drivers/accel/amdxdna/aie2_solver.c: In function 'get_free_partition':
drivers/accel/amdxdna/aie2_solver.c:153:19: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
  153 |         pt_node = kzalloc(sizeof(*pt_node), GFP_KERNEL);

Include the headers that have the necessary declarations.

Fixes: c88d3325ae69 ("accel/amdxdna: Add hardware resource solver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

amdxdna: includ linux/interrupt.h

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/accel/amdxdna/aie2_solver.c     | 1 +
 drivers/accel/amdxdna/amdxdna_mailbox.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_solver.c b/drivers/accel/amdxdna/aie2_solver.c
index a537c66589a4..0bbf91cad334 100644
--- a/drivers/accel/amdxdna/aie2_solver.c
+++ b/drivers/accel/amdxdna/aie2_solver.c
@@ -8,6 +8,7 @@
 #include <drm/drm_print.h>
 #include <linux/bitops.h>
 #include <linux/bitmap.h>
+#include <linux/slab.h>
 
 #include "aie2_solver.h"
 
diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 415d99abaaa3..41bbc5796e11 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -7,6 +7,7 @@
 #include <drm/drm_managed.h>
 #include <linux/bitfield.h>
 #include <linux/iopoll.h>
+#include <linux/interrupt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/amdxdna.h>
-- 
2.39.5


