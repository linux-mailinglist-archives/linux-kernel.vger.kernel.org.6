Return-Path: <linux-kernel+bounces-381843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9409B0537
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FB41F24750
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A251FB894;
	Fri, 25 Oct 2024 14:11:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F341D435C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865500; cv=none; b=LbYstoqgzfT+jq+E2BH0lOUG2apSmpFXytnzHc/tBlNol3KWgjHxjY+BUIn9N7Rf2Ed8S/VRRyQutGGlIr3hIjOkjEcIL9y13hcIOGn89ifYlaD/5ZgYWZXWPVivdfn5RqRQD7BBujMQwdkU8L9m7v+WNvNYGM/TvmjXJPMSQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865500; c=relaxed/simple;
	bh=PMa3XFW8isx7OEfx6EovNavMK8qZ+TaBedE9QEUSbxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fhHV2cXm7sJwpGMWdBzhR8O86p6rPb6BKiRpiQ4+Q3He8e5KbDRFdHncDqadFvAcVXDYyRFlxHmhh/+Lm7A2nW+cUD9vz1nLdSycBtsLXwwcsL9czssYc+V1MV8bKBVc96fMoTuZt7+XhLVnFKRl+2Bk8NeWnRxfcfx78I5oOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2M-0005MV-CY; Fri, 25 Oct 2024 16:11:34 +0200
Received: from dude06.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::5c])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2L-000NRE-39;
	Fri, 25 Oct 2024 16:11:33 +0200
Received: from rcz by dude06.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2L-00DL3M-2x;
	Fri, 25 Oct 2024 16:11:33 +0200
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add lxd
Date: Fri, 25 Oct 2024 16:11:27 +0200
Message-Id: <20241025141130.3179166-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rcz@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add vendor prefix for LXD Research & Display, LLC.
Link: https://www.lxdinc.com/

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
v2:
- no changes

v1: https://lore.kernel.org/all/20241023124411.1153552-1-r.czerwinski@pengutronix.de/

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe4..83d9e49eeb869 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -872,6 +872,8 @@ patternProperties:
     description: Liebherr-Werk Nenzing GmbH
   "^lxa,.*":
     description: Linux Automation GmbH
+  "^lxd,.*":
+    description: LXD Research & Display, LLC
   "^m5stack,.*":
     description: M5Stack
   "^macnica,.*":

base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
-- 
2.39.5


