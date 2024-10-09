Return-Path: <linux-kernel+bounces-356089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A3995C57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD99A1F25393
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130C79D2;
	Wed,  9 Oct 2024 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kC07Q57f"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7D32F29;
	Wed,  9 Oct 2024 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434220; cv=none; b=nf7X6ZeZXaw90T9OmV4h0d93XyNJopPeyBzCRptKmrPj8k/wAvi5W+LH++pOHlYc4DgisyGufPZ+1dFk0inFj2+RDAuOLMg7ApN/kj7aPELlMhvfEgcJeJTEiGQPrpf0ioO/LcvlrOlnYVsiGo0eO02a+N2tM+frusn9UKf3OxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434220; c=relaxed/simple;
	bh=ymD639BE5mR2fgmq5xcXYA2xbwMXE50hIP+EFBXVqUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn3pNDnwRm7vuSQ4h/fyRAM1jcqKMJYqaTiAe1W2U0/k1U4eX6v5wtWk2tuLR6P5b0RSZT30Uo/hij19xOZqg+G0GxXRBBcGQ2tOCPChORVKLhn3XGHbXwltQ0sHJUMhFM+8dxXf1xoGr2qWF8nSJNo9JO9kuWeOrMOkv0JXi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kC07Q57f; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=WkLWjvO4MQ7wBqmnMHwtXCSWDx4NkomtvQLyx+KUk08=; b=kC07Q57fFmqgOuox
	PxSiWiH71Z0yGW0fcr8Z8tOIB85sqASOBihf5bNeHnOGbn2SqQvD31x8cVRwMoMX9UEat6G23ad/E
	LDSuXREPRPdqyaQpv7GmYcnbvck3oIxa9EDzymIUhdTOIB3ZxepF1YsSVpbk4Q1mnSUn+//aArQH5
	9Wc8dl1onc+Fj8GEtKCTm1shJMpHpRLh28+2XwTNPOpx5kRtfr80mLd7cLHjAj/vNYDcdroS0ejPU
	mSejZkuVHrpDUTj23UnxAcyBfu8+jovLgZZSbV8OysPp1DO4i89fogu2Q27sERYKF8ujEKLakQ/hK
	ZlHnsNNSeshjXTh8WA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1syKhB-009q4W-2G;
	Wed, 09 Oct 2024 00:36:53 +0000
From: linux@treblig.org
To: clemens@ladisch.de,
	o-takashi@sakamocchi.jp,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ALSA: firewire: Remove unused cmp_connection_update
Date: Wed,  9 Oct 2024 01:36:53 +0100
Message-ID: <20241009003653.254753-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cmp_connection_update() has been unused since 2019's commit
7eb7b18e9fc7 ("ALSA: fireworks: code refactoring for bus reset handler")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 sound/firewire/cmp.c | 47 --------------------------------------------
 sound/firewire/cmp.h |  1 -
 2 files changed, 48 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index b596bec19774..f5028a061a91 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -333,53 +333,6 @@ int cmp_connection_establish(struct cmp_connection *c)
 }
 EXPORT_SYMBOL(cmp_connection_establish);
 
-/**
- * cmp_connection_update - update the connection after a bus reset
- * @c: the connection manager
- *
- * This function must be called from the driver's .update handler to
- * reestablish any connection that might have been active.
- *
- * Returns zero on success, or a negative error code.  On an error, the
- * connection is broken and the caller must stop transmitting iso packets.
- */
-int cmp_connection_update(struct cmp_connection *c)
-{
-	int err;
-
-	mutex_lock(&c->mutex);
-
-	if (!c->connected) {
-		mutex_unlock(&c->mutex);
-		return 0;
-	}
-
-	err = fw_iso_resources_update(&c->resources);
-	if (err < 0)
-		goto err_unconnect;
-
-	if (c->direction == CMP_OUTPUT)
-		err = pcr_modify(c, opcr_set_modify, pcr_set_check,
-				 SUCCEED_ON_BUS_RESET);
-	else
-		err = pcr_modify(c, ipcr_set_modify, pcr_set_check,
-				 SUCCEED_ON_BUS_RESET);
-
-	if (err < 0)
-		goto err_unconnect;
-
-	mutex_unlock(&c->mutex);
-
-	return 0;
-
-err_unconnect:
-	c->connected = false;
-	mutex_unlock(&c->mutex);
-
-	return err;
-}
-EXPORT_SYMBOL(cmp_connection_update);
-
 static __be32 pcr_break_modify(struct cmp_connection *c, __be32 pcr)
 {
 	return pcr & ~cpu_to_be32(PCR_BCAST_CONN | PCR_P2P_CONN_MASK);
diff --git a/sound/firewire/cmp.h b/sound/firewire/cmp.h
index 26ab88000e34..66fc08b742d2 100644
--- a/sound/firewire/cmp.h
+++ b/sound/firewire/cmp.h
@@ -47,7 +47,6 @@ int cmp_connection_reserve(struct cmp_connection *connection,
 void cmp_connection_release(struct cmp_connection *connection);
 
 int cmp_connection_establish(struct cmp_connection *connection);
-int cmp_connection_update(struct cmp_connection *connection);
 void cmp_connection_break(struct cmp_connection *connection);
 
 #endif
-- 
2.46.2


