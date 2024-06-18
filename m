Return-Path: <linux-kernel+bounces-219694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B190D6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9681F22E75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613E2376E0;
	Tue, 18 Jun 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pDoAh6/O"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A892263A;
	Tue, 18 Jun 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723394; cv=none; b=Ntf7V1Sfmpy7OibfeKnC0FN+VgpdAuTtqsWehuSlA6hXEgF5+/eIhHDswh7df13bjwHm7wIXIk7hjAhM1QvQ65xM5A48xYW8HQoRshDlrMldPnAL6mxlJ69B/2V7m/lSHb9pW73RgkAk/ieSlhQm9jQiWXGPASnR9P0P6EKQq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723394; c=relaxed/simple;
	bh=B53BGKxQmabISwKjocxk1363P57YlZxzXIQCwz4jBN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlyKMaQUd72urG1veM+NdVC/7zhgv+Q041qadjd84ohs4d3J96IDAwiCiSHWFJ4SQAvhfTF8Ej8QBmR1MKyO1DIwe1cxdtbzoA0ZbiVMgJQhRzRRgZT08ZiVQTqVbF7y6CqsmpA+SSuhTP9Y+Y6ODVkr2ZftQ8R0Fr1Mti6ND+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pDoAh6/O; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79E51C0009;
	Tue, 18 Jun 2024 15:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718723385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EX6SLvwadbWaNtTpalkIr5zRsirT8e/junE+m0UUPHs=;
	b=pDoAh6/OWFJLLu+Y20vaJt9LzvsUEZY316W7IguUy/m2i7LEf/mRJ8d+5JqlGdQeH2fklM
	Gze+at67crKJiEijnh/l39oPWUKL1ErKnV7cdGt+EvgzuRohltmVfOHV9CfRDs1tFS9Z4C
	s4o/DgDLp5st2nWUeVyin3EBFcpe4HmGYyMxiDZ3NFXwn1S2kp/eC4u7tMCUp0DRqygvky
	fJ/A8K/sFI9yAP+Ac0RFaVojxEnIzeGIeWiA/W90xdf8ooGMZ4wStcT8YPqjCy9bFn8dLj
	FmxBUIddohbj0LyJlVT2o0pgWCWITCzXTLy8hFV/wFfSEogmRVTBFOPS8CDT0A==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 1/2] dt-bindings: ti: fix TISCI protocol URL link
Date: Tue, 18 Jun 2024 17:09:32 +0200
Message-ID: <20240618150933.1824185-2-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618150933.1824185-1-richard.genoud@bootlin.com>
References: <20240618150933.1824185-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

The http://processors.wiki.ti.com EOL in january 2021

Fix the old URL with the new one.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml  | 2 +-
 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml     | 2 +-
 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml   | 2 +-
 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 7f06b1080244..25a2b42105e5 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -20,7 +20,7 @@ description: |
   initialized early into boot process and provides services to Operating Systems
   on multiple processors including ones running Linux.
 
-  See http://processors.wiki.ti.com/index.php/TISCI for protocol definition.
+  See https://software-dl.ti.com/tisci/esd/latest/index.html for protocol definition.
 
   The TI-SCI node describes the Texas Instrument's System Controller entity node.
   This parent node may optionally have additional children nodes which describe
diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
index 0a9d6a4c4b66..66e8e66ca175 100644
--- a/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
@@ -36,7 +36,7 @@ properties:
 
       The second cell should contain the clock ID.
 
-      Please see  http://processors.wiki.ti.com/index.php/TISCI for
+      Please see https://software-dl.ti.com/tisci/esd/latest/index.html for
       protocol documentation for the values to be used for different devices.
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml b/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
index e10eb98eddad..1db08ce9ae27 100644
--- a/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/ti,sci-reset.yaml
@@ -37,7 +37,7 @@ properties:
       The second cell should contain the reset mask corresponding to the device
       used by system controller.
 
-      Please see  http://processors.wiki.ti.com/index.php/TISCI for
+      Please see https://software-dl.ti.com/tisci/esd/latest/index.html for
       protocol documentation for the values to be used for different devices.
 
 
diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
index a750035d6234..b6da72032151 100644
--- a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
@@ -40,7 +40,7 @@ properties:
       TI_SCI_PD_SHARED - Allows the device to be shared by multiple hosts.
       Please refer to dt-bindings/soc/ti,sci_pm_domain.h for the definitions.
 
-      Please see  http://processors.wiki.ti.com/index.php/TISCI for
+      Please see https://software-dl.ti.com/tisci/esd/latest/index.html for
       protocol documentation for the values to be used for different devices.
 
 additionalProperties: false

