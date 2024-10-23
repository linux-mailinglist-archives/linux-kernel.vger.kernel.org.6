Return-Path: <linux-kernel+bounces-378031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F99ACA61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D34FB230D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEFA1AC882;
	Wed, 23 Oct 2024 12:44:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0901ABEA7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687493; cv=none; b=pza6h4WSO8roefvVqyb/5/s0C2LX99WMbx1YnQsS8NO2lVxRG7ZW9O6ZJ7CPWcT0BjOt5vFaL5u5AONbj/lavx9cAC5bQ/1w8OSeYiw05irosRJSEh0F7NRCPwpX86fr7E/QOPUnm8qb9hm3GfrcC5FnlSJhsT9UZ63j4qxKTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687493; c=relaxed/simple;
	bh=fByUSN6RGekOx1nltk9/mF65wLziCd68dJQ299n5opY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S2u3HVQsj/ew4nGCbnLkuc7DhWXOsOxFzgQcVJ6BAhV2t+1rkbMPK+/oQwMMGM6eURcMTDJgNqpIpIi4lnQo9ZNMtGfxLCHoi6X/ag8YO4kib802x5/im339/lMqomS4vBx2nDB/30+gVndkRC71KkcPluxdNrREnETWjRUgoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rcz@pengutronix.de>)
	id 1t3ajH-0000Nc-Sd; Wed, 23 Oct 2024 14:44:47 +0200
Received: from dude06.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::5c])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1t3ajH-0002Hq-2E;
	Wed, 23 Oct 2024 14:44:47 +0200
Received: from rcz by dude06.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1t3ajH-004q6I-22;
	Wed, 23 Oct 2024 14:44:47 +0200
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add lxd
Date: Wed, 23 Oct 2024 14:44:08 +0200
Message-Id: <20241023124411.1153552-1-r.czerwinski@pengutronix.de>
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


