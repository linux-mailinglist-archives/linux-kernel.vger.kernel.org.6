Return-Path: <linux-kernel+bounces-231176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53BB918724
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF8288046
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E8E18F2F5;
	Wed, 26 Jun 2024 16:17:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6B18EFF6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418674; cv=none; b=AV4FbfeLYZ4o6SPxgaXiwSuNRu3jKyH4/BxeBqqKCmSAfBYvI98QGq/8g/SGRvX6lQn9Khm1ZsxDfmuVyK5p81g2JHay7a5v3lrL/B0nppjQkCcGwvXhG9PDwrOFTsqZhR5ffiRteJFF02X7s4e7tRc5GBBQ4yV4STjgLNovdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418674; c=relaxed/simple;
	bh=6xEpTCipjd5Dbp4vZ1NqE6c+HKy1CSgrExRxmIBzOVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n8zprgeJDCMktPQUxQvH7qukQjR6lSxyMWL3kj+6tBlLjv7ZveeTAZrxBw1tnttmxRovXXxhFCYmdZ8UBFMUMFptPUbBWNcPCvxg+6ZN5CxgJ+Yp4OlVhQaUrUOydpMyAFknQ3YBN8QqFV1j1gRXvz5h050ZIfRBEgMbiLjMglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sMVL0-0008Im-3t; Wed, 26 Jun 2024 18:17:38 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com
Cc: kernel@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: simple: Add Jiangsu Smartwin SMMT043480272A-A19
Date: Wed, 26 Jun 2024 18:17:12 +0200
Message-Id: <20240626161714.4057983-1-m.felsch@pengutronix.de>
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

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 5067f5c0a272..6fcb1ebb86f9 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -206,6 +206,8 @@ properties:
       - innolux,p120zdg-bf1
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
+        # Jiangsu Smartwin Electronics 4.3" (480x272) TFT LCD panel
+      - jianda,smmt043480272a-a19
         # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
       - kingdisplay,kd116n21-30nv-a010
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
-- 
2.39.2


