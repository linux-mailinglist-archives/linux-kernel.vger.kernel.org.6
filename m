Return-Path: <linux-kernel+bounces-358771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3598998377
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD4B24200
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7821BB6BF;
	Thu, 10 Oct 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qtnIIL7a"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D41BFDF4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555810; cv=none; b=QgUjrMnY8QRF4LcdqZKVJcL0nybWKUwmFJUBUJxOnX6kFVDBvZRa/Ti4QnUz0qfEMQx9SSzqMzn3IT1uAwzoawpOHTAeGLdwK9jLFYAalyKBwcOu7rMe+l/+sFMZFwB5k3k7gRL/kP8rIO6mciE4zdRK2xzEu8eeFTCp5fjHLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555810; c=relaxed/simple;
	bh=4qm2O/FvqUhv43GxGytOJmIEyUznWr9x7uzfJeQeBL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvpdeuNZrp1+wJVZGszpHOSOuHioqzZUJJ7FuKBBLPpC0585WSZI87hv146aLKIN+k1i8YzL9HhYJhfu0eLT8KWAbF5xjUjWNMliz1eCw4dGT2eI6BtLWMpHis1DB2YJ1hGqHxgGXfIbz0ReWxFPW+HJolv8WXYdsO8F1EfsQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qtnIIL7a; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D13419CA;
	Thu, 10 Oct 2024 12:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728555702;
	bh=4qm2O/FvqUhv43GxGytOJmIEyUznWr9x7uzfJeQeBL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtnIIL7a8yAcyXXOmAc8zcyCWaTbF2H7q6WIfcBQAlAUj9YSlJcQqAvDjlo7LLOGQ
	 0npD4eLwE3TWDVlTVZS8dwqpWViDSxaW1ViHO1k8eZeu09T3vGLn0Egc3jyoDmaAAO
	 2nKNJl7yAcuAuGrMiiGTse9K7rSBnkPUwANefjco=
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
Subject: [PATCH 2/5] staging: vchiq_core: Indent static_assert on single line
Date: Thu, 10 Oct 2024 15:52:46 +0530
Message-ID: <20241010102250.236545-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010102250.236545-1-umang.jain@ideasonboard.com>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two static asserts are under 80 columns width, hence indent them
on the same line.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c  | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index dfd68d853214..1e4b2978c186 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -70,11 +70,9 @@
 #define BELL2	0x08
 
 /* Ensure the fields are wide enough */
-static_assert(VCHIQ_MSG_SRCPORT(VCHIQ_MAKE_MSG(0, 0, VCHIQ_PORT_MAX))
-	== 0);
+static_assert(VCHIQ_MSG_SRCPORT(VCHIQ_MAKE_MSG(0, 0, VCHIQ_PORT_MAX)) == 0);
 static_assert(VCHIQ_MSG_TYPE(VCHIQ_MAKE_MSG(0, VCHIQ_PORT_MAX, 0)) == 0);
-static_assert((unsigned int)VCHIQ_PORT_MAX <
-	(unsigned int)VCHIQ_PORT_FREE);
+static_assert((unsigned int)VCHIQ_PORT_MAX < (unsigned int)VCHIQ_PORT_FREE);
 
 #define VCHIQ_MSGID_PADDING            VCHIQ_MAKE_MSG(VCHIQ_MSG_PADDING, 0, 0)
 #define VCHIQ_MSGID_CLAIMED            0x40000000
-- 
2.45.2


