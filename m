Return-Path: <linux-kernel+bounces-189907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B148CF6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D53428168C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB363B;
	Mon, 27 May 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ypu5/bh4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CFE4A22;
	Mon, 27 May 2024 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716768511; cv=none; b=ZtU6XvkvNttuoc1B3QXZwocKysuLv+ErAZt8K0sQGKo2FGl4e9CHA+gZ9srsOFZ31ls/8HgZFjwDlBimaqdDT1mcYM5vjIMyD53p3YVyXN2GthN+mjl9qqJYwy/Y8ct7S0EWLLaGAShw88YtGSQwVfoaUV4wBmsJ9TqE2kpcXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716768511; c=relaxed/simple;
	bh=1DnSPx1927wY0qxG5SYM3bGMfUQSL6N53VjNPS8mNbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=monsfFkdlF/EnXFL7RXRApJIRpucQt8ppSV0kZ7+XxMfM8f8iAFaGshFdGDX/eBt1ecWwOY9NtBOLkN6JCLuwC4ree88YufGJ/p103FiLgGbo9HF6d5gF0vu5YxdvMgfTs15YqPwtuog8k0EocGpt11f7uOdBSiCrlONfqFa9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ypu5/bh4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716768507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhlozRtmWhweKm33A5xrnsIXwyKd6QqFHHtHt90tmDM=;
	b=Ypu5/bh4E0Fpd49tE0X/IVn/bMdZ2e+ejxFPdFED9g02FLXnRR9/k7p76QB9iNZxcSGHYL
	m2NUYlNPwyd/i2B596ewMQ71r0XtR8oufcOzV2L/yCevagBa0MtXusfEKt+hz/bTlctt4o
	5SR0dzt+YCgDpNSwUU+KrVC8Wjm2KCFRQFuULVH2m0T9vZVRqpZoctb3eBV7Aa/KB32tw9
	dwbej1LxgYBFKxwER+lxt1P+WqsNhZgGaGonD3zjIWgyBDffdpmEUC4xRXtQIU+A8pV0OG
	DAqZIagsuaq3q486m3rgBr5xKZfpCJNUEV68poCNrl72Almu3gjIM+hGB6wZrA==
To: linux-sunxi@lists.linux.dev
Cc: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	uwu@icenowy.me,
	andre.przywara@arm.com,
	didi.debian@cknow.org,
	Marek Kraus <gamiee@pine64.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: sunxi: Correct the descriptions for Pine64 boards
Date: Mon, 27 May 2024 02:08:17 +0200
Message-Id: <84cd1c70863704e950ca4cadffc7d5367434e06b.1716768092.git.dsimic@manjaro.org>
In-Reply-To: <cover.1716768092.git.dsimic@manjaro.org>
References: <cover.1716768092.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the descriptions of a few Pine64 boards and devices, according
to their official names used in the Pine64 wiki and on the official Pine64
website. [1][2][3]  This ensures consistency between the officially used
names and the names in the source code.

[1] https://wiki.pine64.org/wiki/PINE_A64
[2] https://wiki.pine64.org/wiki/PINE_H64
[3] https://pine64.org/devices/

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Cc: Marek Kraus <gamiee@pine64.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index c6d0d8d81ed4..3196dbeb0cbb 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -708,33 +708,33 @@ properties:
           - const: olimex,a64-teres-i
           - const: allwinner,sun50i-a64
 
-      - description: Pine64
+      - description: Pine64 PINE A64
         items:
           - const: pine64,pine64
           - const: allwinner,sun50i-a64
 
-      - description: Pine64+
+      - description: Pine64 PINE A64+
         items:
           - const: pine64,pine64-plus
           - const: allwinner,sun50i-a64
 
       - description: Pine64 PineCube
         items:
           - const: pine64,pinecube
           - const: sochip,s3
           - const: allwinner,sun8i-v3
 
-      - description: Pine64 PineH64 model A
+      - description: Pine64 PINE H64 Model A
         items:
           - const: pine64,pine-h64
           - const: allwinner,sun50i-h6
 
-      - description: Pine64 PineH64 model B
+      - description: Pine64 PINE H64 Model B
         items:
           - const: pine64,pine-h64-model-b
           - const: allwinner,sun50i-h6
 
-      - description: Pine64 LTS
+      - description: Pine64 PINE A64 LTS
         items:
           - const: pine64,pine64-lts
           - const: allwinner,sun50i-r18
@@ -763,17 +763,17 @@ properties:
           - const: pine64,pinephone
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 PineTab, Development Sample
+      - description: Pine64 PineTab Developer Sample
         items:
           - const: pine64,pinetab
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 PineTab, Early Adopter's batch (and maybe later ones)
+      - description: Pine64 PineTab Early Adopter
         items:
           - const: pine64,pinetab-early-adopter
           - const: allwinner,sun50i-a64
 
-      - description: Pine64 SoPine Baseboard
+      - description: Pine64 SOPINE
         items:
           - const: pine64,sopine-baseboard
           - const: pine64,sopine

