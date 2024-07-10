Return-Path: <linux-kernel+bounces-247416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B392CF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B851F21AED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E419049E;
	Wed, 10 Jul 2024 10:28:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0C18FC7E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607322; cv=none; b=Vek+PgACmof7zEI+z8M36MUOYgd/unJ+tq7bbAmgdv+i6NDsFX14KYFGBYgYG3ekt3hMdCZfkmtvgVwfj0QMrFZnNhaswdykEzPOfZQQWNt4kv9Uwz6QvSQJaGaQdVgvir36ESHy7R9HBSbj3R42s3lVUl1Twfviwb8RUiVZMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607322; c=relaxed/simple;
	bh=jZwBAA681i2M486mbPO5auvpZEWdrPrRNSop60OMZwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blcPV4U1BY29jxdCmWmk8+iQZb28hbAbNAl4XipudyBELu96/xLeilqV+gBjwJI4SRL5d3375sRkiltyDGym1NP4qK23A8BQxX4t8gcl/lYdxyJLXKpQIKicGfE+sTvKrfmv64N+R3MMDfj1txyFsORvPbt7lzNQdgOUIfiYuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sRUYs-0001Y8-Vq; Wed, 10 Jul 2024 12:28:34 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 10 Jul 2024 12:28:31 +0200
Subject: [PATCH v3 1/2] dt-bindings: input: touchscreen: exc3000: add
 EXC81W32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-input-exc3000-exc81w32-v3-1-4272183628b4@pengutronix.de>
References: <20240710-input-exc3000-exc81w32-v3-0-4272183628b4@pengutronix.de>
In-Reply-To: <20240710-input-exc3000-exc81w32-v3-0-4272183628b4@pengutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add compatible for EXC81W32 touchscreen controllers.
They use the same protocol and have the same resolution as EXC80H84.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
v3: Mark exc81w32 as compatible with exc80h84.
---
 .../devicetree/bindings/input/touchscreen/eeti,exc3000.yaml  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
index 9dc25d30a0a8..1c7ae05a8c15 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -14,10 +14,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - eeti,exc3000
-      - eeti,exc80h60
-      - eeti,exc80h84
+    oneOf:
+      - const: eeti,exc3000
+      - const: eeti,exc80h60
+      - const: eeti,exc80h84
+      - items:
+          - enum:
+              - eeti,exc81w32
+          - const: eeti,exc80h84
   reg:
     const: 0x2a
   interrupts:

-- 
2.39.2


