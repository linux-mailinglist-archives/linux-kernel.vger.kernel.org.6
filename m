Return-Path: <linux-kernel+bounces-361107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A8399A378
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA322281636
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCE219C83;
	Fri, 11 Oct 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bn2TPZx8"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729312194AC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648637; cv=none; b=iKhIfut+K8ua/12/XhMj+DpOB/6rvJBU34jAbRB98NN45a0XDc6xOUKJmltOfsIQujfyAFhmiNMH/v9DghOAcdGTXSlQh3oVOaUCZ4ARbKbY9wVqmeEZnVcOpkhhTCWatDZd/TCx0gaCgVER4wIyfPSco8CQht5tiByM585ZU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648637; c=relaxed/simple;
	bh=8lOj1aYnprRGk3+3bdbZuZ5MZEhtNLGjYMC9xY60S3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9y8y+2OK3swbGoYA7lKilRxBiUiiVXBvsJh3Kq4lfFq7crMyDpc7j6k7ESerJNGEDP3QFl2WJsofj2LeyhCQctG0fTh9TLWg3y9RjZH1eAdw7R3jYaOjXADBlbWiyXCop6ylOIqbfI3QmYxZ9zCKePAe3iltClq1UM3yE7Fw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bn2TPZx8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 77C45D8B;
	Fri, 11 Oct 2024 14:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728648535;
	bh=8lOj1aYnprRGk3+3bdbZuZ5MZEhtNLGjYMC9xY60S3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bn2TPZx8FRU6tC4x7WIXmFDAt3otB1OLutN2kJ5AOKcxKqK5Audr8OA4LVgsqPvSo
	 C+mx6jp9LpQLs9eUHHJ8yhygXylPd5AD9QvGx4iyr8TvAuHddHHkN1/o8+UJZrD+Tl
	 udK/dOxVHDl7JQ7PtUyqq5QtFiEOy1QuzzAp8kf4=
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
Subject: [PATCH v2 6/6] staging: vchiq_core: Lower indentation in vchiq_close_service_internal
Date: Fri, 11 Oct 2024 17:39:10 +0530
Message-ID: <20241011120910.74045-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011120910.74045-1-umang.jain@ideasonboard.com>
References: <20241011120910.74045-1-umang.jain@ideasonboard.com>
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
index 135b7b9b01ee..7c9ecf7bcb3d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3168,19 +3168,21 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
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


