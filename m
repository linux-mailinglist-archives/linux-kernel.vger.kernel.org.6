Return-Path: <linux-kernel+bounces-360650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA03999DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035BD1F23711
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B520A5E7;
	Fri, 11 Oct 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XwXRAuV9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B1209F2D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631369; cv=none; b=MWznEYvUetFDdPh1vWUh+K6WdwHhFu03MDv7Q8Jo9iEeM22rXEg+ipJl2jNQ259dHGARqI7TSZ+P/EDEJyau3pkmqGYxGQ8zEVegP8cOc26zbrfMjJWO+vPj57chIMgi/NumHA1TfU5Ucz7LBpBKGTpCjhxZ/q+jnWsL1mhcm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631369; c=relaxed/simple;
	bh=aq1G9v7QkkDHMgWxaXZsBIyzSkrAQpuXZGFVJXUhnZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlYPi9njfqyg81ko0M4eliIKkr2QhfUlGqsnlW8cFbq6KlZE7l266hmKhqm/9Pb7U7hU+bgYeB7wm8izk9ehSOvpSexLG2W3lou+9TuT2ekt4/eSpFHZdz2LqMLBz82yU/6sGwD7Xv7t3+dvmwpRjqNxWdF/esMopqZ3YsJPyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XwXRAuV9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5570F1A6F;
	Fri, 11 Oct 2024 09:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728631268;
	bh=aq1G9v7QkkDHMgWxaXZsBIyzSkrAQpuXZGFVJXUhnZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwXRAuV9zzPqheho81zUAQd38jqjNnPHHbjzJZuIGPaHphGqb38tGrF58x9GhT+EE
	 qTThT8jl21AWqwjdbh/vTjjcGSoy+9t3N8A2gp9UrJMEDUQ/Km9zboFQ467jVudzjb
	 HW6gquQKG9/++2QWBGPnJaEYH9jJdlHMEEKg3KS4=
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
Subject: [PATCH 4/8] staging: vchiq_core: Lower indentation of a conditional block
Date: Fri, 11 Oct 2024 12:52:06 +0530
Message-ID: <20241011072210.494672-5-umang.jain@ideasonboard.com>
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

Lower indentation of 'if (bulk->data && service->instance)'
conditional block. This is achieved introducing a early check for
(!bulk->data || !service->instance) and using a goto label 'complete'
if it evaluates to true.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 61 ++++++++++---------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 15257cf66fa4..b95443043c27 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1326,44 +1326,45 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 		struct vchiq_bulk *bulk =
 			&queue->bulks[BULK_INDEX(queue->remove)];
 
+		if (!bulk->data || !service->instance)
+			goto complete;
+
 		/*
 		 * Only generate callbacks for non-dummy bulk
 		 * requests, and non-terminated services
 		 */
-		if (bulk->data && service->instance) {
-			if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
-				if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
-					VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
-					VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
-								bulk->actual);
-				} else {
-					VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
-					VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
-								bulk->actual);
-				}
+		if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
+			if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
+				VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
+				VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
+							bulk->actual);
 			} else {
-				VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
-			}
-			if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
-				struct bulk_waiter *waiter;
-
-				spin_lock(&service->state->bulk_waiter_spinlock);
-				waiter = bulk->userdata;
-				if (waiter) {
-					waiter->actual = bulk->actual;
-					complete(&waiter->event);
-				}
-				spin_unlock(&service->state->bulk_waiter_spinlock);
-			} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
-				enum vchiq_reason reason =
-						get_bulk_reason(bulk);
-				status = make_service_callback(service, reason,	NULL,
-							       bulk->userdata);
-				if (status == -EAGAIN)
-					break;
+				VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
+				VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
+							bulk->actual);
 			}
+		} else {
+			VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
 		}
+		if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
+			struct bulk_waiter *waiter;
 
+			spin_lock(&service->state->bulk_waiter_spinlock);
+			waiter = bulk->userdata;
+			if (waiter) {
+				waiter->actual = bulk->actual;
+				complete(&waiter->event);
+			}
+			spin_unlock(&service->state->bulk_waiter_spinlock);
+		} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
+			enum vchiq_reason reason =
+					get_bulk_reason(bulk);
+			status = make_service_callback(service, reason,	NULL,
+						       bulk->userdata);
+			if (status == -EAGAIN)
+				break;
+		}
+complete:
 		queue->remove++;
 		complete(&service->bulk_remove_event);
 	}
-- 
2.45.2


