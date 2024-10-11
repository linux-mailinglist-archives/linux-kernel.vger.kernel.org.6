Return-Path: <linux-kernel+bounces-360652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB4C999DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE9E1C213C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3E20ADEA;
	Fri, 11 Oct 2024 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QmijJ7CX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170820ADCD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631373; cv=none; b=QjG3XTY+NgyD1SW9c2mON8aYiwE2wlwZU3kgsmt4zsK/IxZ/SQAr3M8wV/0UPqapM7JUkGp9FmKZwVgVzRt8FMzrrVEZBB559yGRYKo6b84AVqD1WANGT+rR7MoHofeBEymyshsbtE+1dgwCV1GEo25ScfnBWukG/QFzHgF3d88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631373; c=relaxed/simple;
	bh=2YLGkeJa2U+BvKGXmrgkaFnPqLRL5Gan4oQ6Tqqvyg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDPZHMX6hKG4I/YoU3R1+1zXrhcOuzX1MiJ3P+p7rky2mLF6Jjf2d7vsBE4cQRUjRxxiVYmcYCk1r/T1aMD5/cToPkGGEbVVK4ZhHrofEaVU/h8abFCL10vYXJUyqS2XLrFwdL4VyR9zQ0BAf/cNWq25Q3IVz8WvYU/Mu+NIJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QmijJ7CX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 882321659;
	Fri, 11 Oct 2024 09:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728631272;
	bh=2YLGkeJa2U+BvKGXmrgkaFnPqLRL5Gan4oQ6Tqqvyg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmijJ7CX+GKIGq4NTZG0+Aw6T50tZcIZnzMjXxSMJFNPVTuJmC1txtpruSvJKW1ij
	 PfNdAkuUS9Va6Thq2sNs9/vQUQD5X+P1R2b4tqCiWtCBCxPgJBq7ETIV1LyA94r2oJ
	 v06Epa97HMOV/J8V1PVHHpIl69I14L1J8cL97UwE=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 6/8] staging: vchiq_arm: Lower indentation of a conditional block
Date: Fri, 11 Oct 2024 12:52:08 +0530
Message-ID: <20241011072210.494672-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011072210.494672-1-umang.jain@ideasonboard.com>
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check early if we need to allocate the bulk waiter. This helps to
improve readability and reduces the indentation of the 'if (waiter)'
conditional block.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 27ceaac8f6cc..a4a7f31b124a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -564,28 +564,28 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 	}
 	mutex_unlock(&instance->bulk_waiter_list_mutex);
 
-	if (waiter) {
-		struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
-
-		if (bulk) {
-			/* This thread has an outstanding bulk transfer. */
-			/* FIXME: why compare a dma address to a pointer? */
-			if ((bulk->data != (dma_addr_t)(uintptr_t)data) || (bulk->size != size)) {
-				/*
-				 * This is not a retry of the previous one.
-				 * Cancel the signal when the transfer completes.
-				 */
-				spin_lock(&service->state->bulk_waiter_spinlock);
-				bulk->userdata = NULL;
-				spin_unlock(&service->state->bulk_waiter_spinlock);
-			}
-		}
-	} else {
+	if (!waiter) {
 		waiter = kzalloc(sizeof(*waiter), GFP_KERNEL);
 		if (!waiter)
 			return -ENOMEM;
 	}
 
+	struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
+
+	if (bulk) {
+		/* This thread has an outstanding bulk transfer. */
+		/* FIXME: why compare a dma address to a pointer? */
+		if ((bulk->data != (dma_addr_t)(uintptr_t)data) || (bulk->size != size)) {
+			/*
+			 * This is not a retry of the previous one.
+			 * Cancel the signal when the transfer completes.
+			 */
+			spin_lock(&service->state->bulk_waiter_spinlock);
+			bulk->userdata = NULL;
+			spin_unlock(&service->state->bulk_waiter_spinlock);
+		}
+	}
+
 	ret = vchiq_bulk_xfer_blocking(instance, handle, data, NULL, size,
 				       &waiter->bulk_waiter, dir);
 	if ((ret != -EAGAIN) || fatal_signal_pending(current) || !waiter->bulk_waiter.bulk) {
-- 
2.45.2


