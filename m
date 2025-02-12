Return-Path: <linux-kernel+bounces-511051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8248A32515
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7828618889EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182E271828;
	Wed, 12 Feb 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QmhQdlNx"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD0220AF75
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360092; cv=none; b=eFSnKJ8MSWSKL3r0J5V3aiuK9suE1ulr5BVS+JbP8fkXAp2CsR78hx1umjm8t+P19f3co/qCZb+96ydqjJxKO4IlllplXn7pN04jRmLzWVDAZIiLAd9ZqYPeOU338dxMpkg2aFTiBXBa9UMgqjOeCM4gTTEewxAToo/JKxDMx70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360092; c=relaxed/simple;
	bh=m/u7M39ivXqj7Jq/6rCvAE8BnBXopuT7Jjr+JcepCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHO4fWG3ii0Tx3U9Y+Q1Id8+eirBo3H1RAQ6Fu+Lltamu+pGrp9mzbwe31homX03KQ0PdRYU9wzyIdtOJqxH3pKC9Wxu2JeY4mLfz0qStdsN+aIip8ODZMH/EYCh4oNq6baqfaCHmZDilRs3PhZ08ZeIyuJ+e4/TtNL+1XIWVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QmhQdlNx; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739360078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T8J1PsZyRoDRpxk/eEDn0T9wcQpmCgYNz2QyDJPcKSk=;
	b=QmhQdlNxoJ2lE8L2kDoIMsn7gmsxsvGX2CLrg9xdu7pHbtpGR4DLq4lvNyDOEQ+zjOqJtA
	7jOpSd16NoMG4hvf9q46ga4aFVBzCMkDqf80ThWOrVDRWr4P0UTwSQEcwEb6OwXSPdOjmw
	eiDadk7p7IZXEOpWvFLw0GtGfdWzja0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Vinod Koul <vkoul@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: Fix typo in comment
Date: Wed, 12 Feb 2025 12:34:10 +0100
Message-ID: <20250212113414.45357-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/consumer/consume/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/dma/sh/shdma-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index fdd41e1c2263..6b4fce453c85 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -725,7 +725,7 @@ static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
 	slave_addr = ops->slave_addr(schan);
 
 	/*
-	 * Allocate the sg list dynamically as it would consumer too much stack
+	 * Allocate the sg list dynamically as it would consume too much stack
 	 * space.
 	 */
 	sgl = kmalloc_array(sg_len, sizeof(*sgl), GFP_KERNEL);
-- 
2.48.1


