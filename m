Return-Path: <linux-kernel+bounces-328030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98771977DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C811F27350
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E71D88AF;
	Fri, 13 Sep 2024 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="qZtLeqwm"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D61D58A8;
	Fri, 13 Sep 2024 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224561; cv=pass; b=lHjDRKbgtB0Zci61JpiMVH06aJfNQM5T6QJCkNKCWGWwUu5+bDnaydo3/OrnKYixRoDsVPHqKxGRxomZ1rtorSlkAhb5DH8ox89LkD+rWexIbS8NfEYrfppUkIH3NoQYFP+QMdzVYwAHaIaR8UIl9jolyesdpIuHO+mUPr657pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224561; c=relaxed/simple;
	bh=rrqHstqaOoJH0oNf7w9RLAC65EvHqF+QEqg7yXEXkXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoiRDZnlX1jOzT65JrN/ei6rT2fgqWYyYFLIpTcx/wIClE33kDY/v6YB5eHp0RFTME6Yzyr0GGbWFCxY38SiSzHxSe6omxKTrRazcTmQqX/o0/whvtrAt34S9dzJ5Ikp/gaoNkiZXM+Oi0n05WfifQcF1Ns/in2d9I8VLkh5itc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=qZtLeqwm; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1726224544; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JgCHy26J5RTuZfALei11p0LhFB2xQIpGjsbqbvN9xv7ak/7OkkOAcXpS7EI5ZITdMYpf/oM3Xj/hui9a07q6BtSa1OYcb0b/n3BubOu93V8x/hD3BVGVfDnnO+DzLm8R7iFz//EBM77fiWXTIlwEtM52wHmIXMzZbXUUA7xoF1M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726224544; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JgVVClL/nl81iGMgJH6Or+qEABIgBR2m9kRyKGMQOxs=; 
	b=EkrO2d2Y0f9JOBlm+Ef1G5O9iV7x7U9rPwWWjsqLr9iKX1Fymcx8NjQyoGuCMG2vu+tsX1A5Hw8yAK7fR6fLEZ67HetLbHSdtsXvWUIgCbbrJLf5py2GqtsQ2iep+CQAKDMsVu9C/Sasw26mKNS8EchPsicMz7A07znK1f4cY5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726224544;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JgVVClL/nl81iGMgJH6Or+qEABIgBR2m9kRyKGMQOxs=;
	b=qZtLeqwmL+sYAKut+OP6DssmODsfmsiVnRMD5/zrlLlQ6dL0H4LVkD5rBelNi6/R
	vGjHGyRed5k1EaXuUVf1y9gcGrCmCdE0uetObtqmH5rluSOXFvMe0vv4RfmNh8CBeDU
	QBgpmV8D0WOFEk1ETLqsCHzifCyD/pjijuy3L1QB3Fon4t0Miv0vEvh9Z3/655n8BmK
	liAle6a9bdd9PM0kbns3EzfvfEvCVLnzvJ3iP+4Mo++vOE2OjmXmoAeRwh08Q7pnbfd
	zClLtfNicvVWgNjPM29aKSxdw4Lfq6y3CjTjLmSPfnFQxgGQXPv/kboF4wcCqHObGqm
	80xC5+IgwA==
Received: by mx.zohomail.com with SMTPS id 1726224543413872.8186395558075;
	Fri, 13 Sep 2024 03:49:03 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: document RerVision A33-Vstar board
Date: Fri, 13 Sep 2024 18:48:44 +0800
Message-ID: <20240913104845.4112986-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

RerVision A33-Vstar is an evaluation board of their A33-Core1 SoM.

Add its compatible (with the SoM compatible) to the sunxi board DT
binding file.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09dc6f4249866..6e56530d02439 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -841,6 +841,12 @@ properties:
           - const: allwinner,sun50i-h64
           - const: allwinner,sun50i-a64
 
+      - description: RerVision A33-Vstar (with A33-Core1 SoM)
+        items:
+          - const: rervision,a33-vstar
+          - const: rervision,a33-core1
+          - const: allwinner,sun8i-a33
+
       - description: RerVision H3-DVK
         items:
           - const: rervision,h3-dvk
-- 
2.46.0


