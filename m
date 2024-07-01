Return-Path: <linux-kernel+bounces-236313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691491E050
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BF31C223E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE5815ECC6;
	Mon,  1 Jul 2024 13:11:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662015A87F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839463; cv=none; b=elcukZKA21657iKFugSyChUYWj7Q9O+ALu3SOiP9i0rxcGWt+5WzGFCdDcpbMcVeJA/tWsBRAH7byB7x6eHGikBBBF5yPf5vyXeu8iXYDPhfa22OD0foAYGsX+5Nefl2ILbbjVLRIyXrzchuZc6DTazzGIoiVVGGlUh+8OCrNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839463; c=relaxed/simple;
	bh=Oy6yYdKW4gW6aeA4+YZ6g8uaflkMG9fKhzoE8BIyvqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJ2THWHhjjpCVdbZ2TDu1ThI9nWpbaf2ImEOr0KrpF+JiEC03fgX3XFc82N7IZpnTHrWDijM6GxMCw5pJ14XIrNxlOheX7x9Lkq/mg8HIZ1AO2Ow4i8Twz3jG2lGJwW+ZIyLNTLDQUm8XG02Zj901HR85EaDRqGbrlo5/tDP5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sOGnt-0006DR-7p; Mon, 01 Jul 2024 15:10:45 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	sam@ravnborg.org
Cc: kernel@pengutronix.de,
	Conor Dooley <conor.dooley@microchip.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: display: simple: Add Jiangsu Smartwin SMMT043480272A-A19
Date: Mon,  1 Jul 2024 15:10:39 +0200
Message-Id: <20240701131041.2816856-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add compatible to panel-simple for Jiangsu Smartwin Electronics
SMMT043480272A-A19 4.3" 480x272 LCD-TFT panel.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:
v2:
- rebased ontop of drm-misc-next
- added Conor's acked-by

 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 8a87e0100dcb..55be695952cc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -176,6 +176,8 @@ properties:
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
+        # Jiangsu Smartwin Electronics 4.3" (480x272) TFT LCD panel
+      - jianda,smmt043480272a-a19
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
       - koe,tx14d24vm1bpa
         # Kaohsiung Opto-Electronics. TX31D200VM0BAA 12.3" HSXGA LVDS panel
-- 
2.39.2


