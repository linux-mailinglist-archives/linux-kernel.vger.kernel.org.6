Return-Path: <linux-kernel+bounces-429265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B6B9E1991
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3E816671C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF201E285E;
	Tue,  3 Dec 2024 10:39:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D211E0493
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222358; cv=none; b=pyHEluGfuouAB0U2ofjeQWrCCZtXCnnvggGxlx1VUcvl8TF4HVna0LKiSsco9SgTi3SscXeDZ9PIMX/oTqRG0+CS4obv4SHU/q1XEoZiklnd6Ry+JFGSHiLT53glw2+EWLuslYq+e72/imo1DQIB2ZVAXImjrVlgQ82grxfbWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222358; c=relaxed/simple;
	bh=WCBRKK2EpvRkqNqUvWntlT5eb/TfdsDmqZAXrw/5Qos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NhHVn1GAstpAI0zeC9uOoAWKspmlYv58C1gjPVu3qtcgR5ibzV6utmG4a48nyYmSxpixQUhIU6uvPYDmleLBv29KLW1DoS9i1YmrBUSIA5HScVJle1WLD4VSeeK4M/aJmzmTcwXq0mQNfdz0mSxMtSb1ZtttaE+oj36xEd3P0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1tIQJ6-00012Q-4o; Tue, 03 Dec 2024 11:39:04 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Date: Tue, 03 Dec 2024 11:38:36 +0100
Subject: [PATCH v3 2/3] dt-bindings: mtd: mchp48l640 add mb85rs128ty
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-mb85rs128ty-v3-2-79107d54d839@pengutronix.de>
References: <20241203-mb85rs128ty-v3-0-79107d54d839@pengutronix.de>
In-Reply-To: <20241203-mb85rs128ty-v3-0-79107d54d839@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Schocher <hs@denx.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Jander <david@protonic.nl>, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=WCBRKK2EpvRkqNqUvWntlT5eb/TfdsDmqZAXrw/5Qos=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYkj3u3+ULyvz5JLvvcET/CznH69vUdITCOs+oLwsu/5Zu
 UnZ49bSjlIWBjEOBlkxRZZYNTkFIWP/62aVdrEwc1iZQIYwcHEKwER6rRkZzrow3brd5vdozk1B
 A+5d7Clh3m8S5A+oprqVqt9Lmq4wiZFhvWRwivuhzhuF65PrYuucrfP2CUvM/JP/45znF4lfbcb
 MAA==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add a compatible string to support Fujitsu MB85RS128TY.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
index 0ff32bd00bf6aee279fa78c624d8d47c6162f7f1..5c6b628c608d82515c7efd5dc74dfb8469894bef 100644
--- a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
+++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
@@ -16,8 +16,9 @@ description: |
 
 properties:
   compatible:
-    items:
-      - const: microchip,48l640
+    enum:
+      - fujitsu,mb85rs128ty
+      - microchip,48l640
 
   reg:
     maxItems: 1

-- 
2.39.5


