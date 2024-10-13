Return-Path: <linux-kernel+bounces-362737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA30199B8CD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6855EB21567
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A913BAC6;
	Sun, 13 Oct 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TawpI1Re"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41F12CDBA
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728809143; cv=none; b=si3Vb/GtgSk6wd5nEpmAFv1bZK3KxCTJCIx4QSuGrKIG7p1ZoIQcJJ9xexxZq/JHybiThI3yNk1OyUMAxd8vXjP87q3EkyIN6njQzBIXJnqKSWKTfF+LgM8HVBPa0TBOm2WHt+UkKU5tGw+wgOETEDR1i9zSn2K4wtzygsdR0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728809143; c=relaxed/simple;
	bh=Iiy7xQXIT4ZGsO8md7Xqk0przPDBC9t9cmDGVGB3waY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7UHHxEUt8HnxgI14ekQT+w1ktuoH+/RSoSKym5QQ0GfRtyMLljbKanQIJKptR/QGv7fQl4zZXV30jLDpTFgJKG179eNEtyL1Jmxhx6mgAeJX5bO50ssc2koFnfFHuO6hHMbkSRzOVqNbTmX+CnOPWM2T06Ecu4mMve2gTliGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TawpI1Re; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A8DFF9EC;
	Sun, 13 Oct 2024 10:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728809039;
	bh=Iiy7xQXIT4ZGsO8md7Xqk0przPDBC9t9cmDGVGB3waY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TawpI1RezAL0bY0jIwc9Gy4cFSJK26ljwdZ/HN99nAz2xc9o5svwoccIf86ZmoaWs
	 11r3bavuAUd/e94Qr4hY4IsiJvEhUES/a/rp6QFuIOPP7XNNZCTMGPl9xvyKjvWWUO
	 YOh5UsRLXaodsSgHTnpPO3AMCOsW6Z2GRWJOGcMw=
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
Subject: [PATCH 1/2] staging: vchiq_arm: Drop blank lines
Date: Sun, 13 Oct 2024 14:15:28 +0530
Message-ID: <20241013084529.377488-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013084529.377488-1-umang.jain@ideasonboard.com>
References: <20241013084529.377488-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop unnecessary blank lines from vchiq_arm.c.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 27ceaac8f6cc..e780ed714a14 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -309,9 +309,6 @@ static struct vchiq_arm_state *vchiq_platform_get_arm_state(struct vchiq_state *
 	return (struct vchiq_arm_state *)state->platform_state;
 }
 
-
-
-
 void vchiq_dump_platform_state(struct seq_file *f)
 {
 	seq_puts(f, "  Platform: 2835 (VC master)\n");
-- 
2.45.2


