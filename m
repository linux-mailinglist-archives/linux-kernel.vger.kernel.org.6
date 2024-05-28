Return-Path: <linux-kernel+bounces-191541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E328D10E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6CDB2148B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA746BA;
	Tue, 28 May 2024 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dyBn2MF/"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946E7E6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855924; cv=none; b=Sd+2qkvTS5SbqSu8o7BJhE7lA1xZ8TsU6LLRVKb8M+y/R0vMbWtwJCMWXAF2qRARf1IsAk0oxdMeBn4UqBLXEKYNxl69OKsR7ccia/tDGJ/6FDzf770In6uBgu+C1pWxEpljV4Pnj3PveTCl5Xkr8LMeGfvClvnOW0lNQalfROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855924; c=relaxed/simple;
	bh=bQ9jnVlFMDLqet6U9mvB6TyOpAqNzrCKFNL44Oc6YOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uGSdHomJP+U5fddNUTm6Y2KMBkVhA7Kg2lals4wNTBolJ9+ftH/IOQRir6wfBFxhiFNdgaX/bQJ78H0+P3wu/S55GqUOEG4qQm6bAkdrXJL2Qy8foa61ZQFyfT8J3YxzuZpb3JP4xxKlnhPlzcixacoQubm1dql5S8QNKrLmQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dyBn2MF/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=aR/3UyH7ymKWvCntIj02AXZeP9BrNGE9Clo/EC6gyU8=; b=dyBn2MF/9zgWyRVS
	zUowKr1zbD80bNz70+XwCvDdxXWYY9yHF/zj+CaY0kn/7E2Js9YCkcMOMNC+xaSF/GwslIgncRgYy
	1w3V9lWK3DFvxImEsbRSl+q2LS8066dqsbEJ2oKCSX8wTUu0PjvTeVrsUU6a4p+g7cuQef9ujrUoM
	MOdjSslfauM5oqQlFkEjXOQd4R9tKB3ELM5Kl8KZ3bqUIYCJBRht3KG4HoGH58MGFqM+U49MB8jx+
	+fnij6Z6xhSrfdHxl5z3m8/yYKYiVfM2ms0bO3rF28CeAfUO4G5yTGb2mp2ilBi6dXq/yjlgbU4dU
	giqc1GyzCUODNOV+1g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBkeV-002ps3-0F;
	Tue, 28 May 2024 00:25:19 +0000
From: linux@treblig.org
To: mporter@kernel.crashing.org,
	alex.bou9@gmail.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] rapidio: removse some dead defines
Date: Tue, 28 May 2024 01:25:15 +0100
Message-ID: <20240528002515.211366-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'mport_dma_buf', 'rio_mport_dma_map' and 'MPORT_MAX_DMA_BUFS' were
added in the original
commit e8de370188d0 ("rapidio: add mport char device driver")
but never used.

'rio_cm_work' was unused since the original
commit b6e8d4aa1110 ("rapidio: add RapidIO channelized messaging
driver")
but never used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 20 --------------------
 drivers/rapidio/rio_cm.c                 |  6 ------
 2 files changed, 26 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 27afbb9d544b..5c83741c3005 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -97,18 +97,6 @@ module_param(dbg_level, uint, S_IWUSR | S_IWGRP | S_IRUGO);
 MODULE_PARM_DESC(dbg_level, "Debugging output level (default 0 = none)");
 #endif
 
-/*
- * An internal DMA coherent buffer
- */
-struct mport_dma_buf {
-	void		*ib_base;
-	dma_addr_t	ib_phys;
-	u32		ib_size;
-	u64		ib_rio_base;
-	bool		ib_map;
-	struct file	*filp;
-};
-
 /*
  * Internal memory mapping structure
  */
@@ -131,14 +119,6 @@ struct rio_mport_mapping {
 	struct file *filp;
 };
 
-struct rio_mport_dma_map {
-	int valid;
-	u64 length;
-	void *vaddr;
-	dma_addr_t paddr;
-};
-
-#define MPORT_MAX_DMA_BUFS	16
 #define MPORT_EVENT_DEPTH	10
 
 /*
diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 9135227301c8..97287e838ce1 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -198,12 +198,6 @@ struct cm_peer {
 	struct rio_dev *rdev;
 };
 
-struct rio_cm_work {
-	struct work_struct work;
-	struct cm_dev *cm;
-	void *data;
-};
-
 struct conn_req {
 	struct list_head node;
 	u32 destid;	/* requester destID */
-- 
2.45.1


