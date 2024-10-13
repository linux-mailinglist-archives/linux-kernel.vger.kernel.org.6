Return-Path: <linux-kernel+bounces-362778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB299B934
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C70B2173C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C74E1482E9;
	Sun, 13 Oct 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="og26mZeB"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B2A146A62
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728818511; cv=none; b=BQJmQutpgSy8GRE5GF+1eKa1GW2Hxqu9/+aAnwuPcGjT7XsYC5+xK+cO+qTqVbIY0o35/6lliild45tSMLUd7hzppjkTk4HzIYJzTlAESWUFHCdcj8bvmaxKzpvO8Bgf5bp0cdwVvclGSQf8vUJZonD8n3bq1aiSAiH88f/WK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728818511; c=relaxed/simple;
	bh=gS6DbTXaVFqTwbbf8NQXEgOqBrparLUJCPWHfcZcNlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hb8cF5a8+YV0/sUTMmYcv6klqqrMDgxodsFR+3Q93pb6iRbdropSJE7Vwp97mzKpxucO2+UG1hQnShfsDQwK0Qn7cIz51l5SspJPIgRne6mFt1bazfD03VSR6Osn/c8gpLP+hs+dsG3tMjJLInSudlt1RnVLFnTPbPR1h3hgupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=og26mZeB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29415A06;
	Sun, 13 Oct 2024 13:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728818409;
	bh=gS6DbTXaVFqTwbbf8NQXEgOqBrparLUJCPWHfcZcNlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=og26mZeBEHJ0xo3oWjPowkxPyL1hEons2aKPaWQHlXwaDMAvpM/tU2DI2UNy+SxBO
	 m9IpAre76sK+ZjbLeKPvDdyqsGyanHk/IlD8rZzDjZdwlPrJwE3W8lELKWCrASs1E0
	 RLJD3crFyR/qnkPM2LMiOrL2bpuGHOAMTCKpkxbM=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v4 6/6] staging: vchiq_core: Lower indentation in vchiq_close_service_internal
Date: Sun, 13 Oct 2024 16:51:28 +0530
Message-ID: <20241013112128.397249-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013112128.397249-1-umang.jain@ideasonboard.com>
References: <20241013112128.397249-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce indentation of the conditional nesting in
vchiq_close_service_internal() switch case by checking the error paths
first and break early. This helps to reduce conditional branching and
reduce indentation levels.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 36f08f078564..3d347b425f20 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3163,19 +3163,21 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 		if (close_recvd) {
 			dev_err(state->dev, "core: (1) called in state %s\n",
 				srvstate_names[service->srvstate]);
-		} else if (is_server) {
-			if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
-				status = -EINVAL;
-			} else {
-				service->client_id = 0;
-				service->remoteport = VCHIQ_PORT_FREE;
-				if (service->srvstate == VCHIQ_SRVSTATE_CLOSEWAIT)
-					set_service_state(service, VCHIQ_SRVSTATE_LISTENING);
-			}
-			complete(&service->remove_event);
-		} else {
+			break;
+		} else if (!is_server) {
 			vchiq_free_service_internal(service);
+			break;
+		}
+
+		if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
+			status = -EINVAL;
+		} else {
+			service->client_id = 0;
+			service->remoteport = VCHIQ_PORT_FREE;
+			if (service->srvstate == VCHIQ_SRVSTATE_CLOSEWAIT)
+				set_service_state(service, VCHIQ_SRVSTATE_LISTENING);
 		}
+		complete(&service->remove_event);
 		break;
 	case VCHIQ_SRVSTATE_OPENING:
 		if (close_recvd) {
-- 
2.45.2


