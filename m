Return-Path: <linux-kernel+bounces-429141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E042F9E17DC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A1D28197B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE521E0B72;
	Tue,  3 Dec 2024 09:37:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D21DF99C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218663; cv=none; b=rqNSMMXLC98ipSzZd5R7zfjHe0foJsNlPl1OC4OKHq8y229Y43AKB9zBDGMDChq8GY2I6OgjucqIoWIuOoK3el5MZCtcQhJAuBh07V7+G+T/DDnzEt6kfa0yzvrxzAuN/ypGccESziFPyPptnngjTgCnIUXEuOKPrQDO3G5/HD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218663; c=relaxed/simple;
	bh=0L8AAzCGjxqDT9tSoEM1H4PxUPfUrUDm2XS8wz5bPHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIv3m8KrcZCajp1CpVyk3VdeBaIhQoOV4cdFn0rIYc0ApQAFVLoqnN6OQIAr1kb0nkJsaY4FlgxKtKIbCrqIZPEw7Hu+SSiRUaX3Wb2tIIAp034LxuwZ762XIKnWUv8dci5N6tEXoRnvEb07MURGj4w3z7JnZ+TCwVSS89/KyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1tIPLZ-0006C6-Jk; Tue, 03 Dec 2024 10:37:33 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Date: Tue, 03 Dec 2024 10:37:26 +0100
Subject: [PATCH v2 2/3] dt-bindings: mtd: mchp48l640 add mb85rs128ty
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-mb85rs128ty-v2-2-42df3e7ff147@pengutronix.de>
References: <20241203-mb85rs128ty-v2-0-42df3e7ff147@pengutronix.de>
In-Reply-To: <20241203-mb85rs128ty-v2-0-42df3e7ff147@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Schocher <hs@denx.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Jander <david@protonic.nl>, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=0L8AAzCGjxqDT9tSoEM1H4PxUPfUrUDm2XS8wz5bPHQ=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYkj3uxjd8CHZvc3jdcHm308m37zKJs686Uz/v59b4tc77
 3/tNrfAoqOUhUGMg0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjARUQWGf8a6H5fPaCu9aM2U
 N6XA6ZzYwZ8L8iQWfLGXWvn87P9V008xMlw9t0Mn2m2xk9z6iW9azi0UUw3Mzbvctb41sW/GY88
 qTTYA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add a compatible string to support Fujitsu MB85RS128TY.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
index 0ff32bd00bf6aee279fa78c624d8d47c6162f7f1..11f64056a28f98ad633265b00605ffd2c3e026c8 100644
--- a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
+++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
@@ -16,8 +16,9 @@ description: |
 
 properties:
   compatible:
-    items:
-      - const: microchip,48l640
+    enum:
+      - microchip,48l640
+      - fujitsu,mb85rs128ty
 
   reg:
     maxItems: 1

-- 
2.39.5


