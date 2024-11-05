Return-Path: <linux-kernel+bounces-396739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247D59BD177
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7382813E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE773179965;
	Tue,  5 Nov 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="OI9f6FWd"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F91514C9;
	Tue,  5 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822387; cv=none; b=puuJZrHM3xcjax+EmuHPfP45OT8eLqMVlWyEvWAv2KdZ+WOp8u3dtZhO6QzvnmOD5zWl1tbF68f9ZdO1LNDtdUcfOKsxkXabHupndA5y8i3ArmAvsT3ciJ8b5ayhRCsiIGodBf54N3AxcRXAWRPBRDdwR6Vg185zUJ8H2QeTjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822387; c=relaxed/simple;
	bh=qEsCNa+I4uXibhOsM8VA0my3x9twcfeY08gntsHzYSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hj9DyyadNwz6sJNMd37u9o9ZKEJj53kwhj06/x1+XYXb/Qe4GiamEjclnfRMryvaz7AFI9c8rbFSU1UgrNuTgmloArDd0ZPXuOdbe9GVJObMZEhbFMJtwS07wb5s9o3l6VO7vxdKiYJ7QnwOqkwtd10/0yrGlKxMYzEnir3okRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=OI9f6FWd; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EF3v3003827;
	Tue, 5 Nov 2024 15:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=d
	Y/LHP00NtneYQ7ErH5EMOZJIrzL6QTNZfwa2E4UEHA=; b=OI9f6FWdoOpPmVJUH
	3/0nVfPn2xQka1LiEwxYi6FsJPATTT5Kdp8YF52Cx5VgZBB8DosRv7D3/as746nl
	gFwXaN3ZwnzXQb1SQK8sFbqAuphGO3DeRNaxxO2teRZVWi/wxPVWrYM1FnkgKiff
	1p3F9anYAEJ4qMBcU9apNKyWyfPidN0BzUHBpyKcvbuq+QENWjvzCKd4v8RIT1iJ
	wnJIBHrUg7zYwi1EFKIkre5E/cL5tDUrqWJfAWFICNjBuk/mk+I6hY+G5sd68w3b
	B0D01Xf6+G2P91IZh9ZmEGDthhM42lhtltTjVz09RUH2Nkz8J+4okR/lkO94DBCA
	jYulQ==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 42nb7wta0s-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:27 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:26 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Tue, 5 Nov 2024 15:58:10 +0000
Subject: [PATCH 04/21] dt-bindings: gpu: img: Allow dma-coherent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-4-4ed30e865892@imgtec.com>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
In-Reply-To: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=matt.coster@imgtec.com;
 h=from:subject:message-id; bh=qEsCNa+I4uXibhOsM8VA0my3x9twcfeY08gntsHzYSU=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcypNTd/fjx6x+3Coinv9n16decIL/fThw/v83Q2e
 3C2pG+60lHKwiDGwSArpsiyY4XlCrU/aloSN34Vw8xhZQIZwsDFKQAT+dLL8D8jxnp12K9s6zn6
 c061pdkU/n0j0754W4bf3D0La+XLpJkYGeY7dU+1EJt+54AQ57GkwBK+M/8czq10KMmce2fD6y3
 pfEwA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=ddzS3mXe c=1 sm=1 tr=0 ts=672a40a3 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=r_1tXGB3AAAA:8 a=UMSW3LcNhMnowj35pGIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 4ZaP-Ltp-wtGIMmkjc3h9GU25WFLuz0y
X-Proofpoint-ORIG-GUID: 4ZaP-Ltp-wtGIMmkjc3h9GU25WFLuz0y

This attribute will be required for the BXS-4-64 MC1 and will be enabled in
the DTS for the TI k3-j721s2 in a subsequent patch; add it now so
dtbs_check doesn't complain later.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 55f422be1bc5b7564e3e81f24c4b93857f3e12fe..8a1861ca960c48853b2ceef414f588cc343b49b2 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -60,6 +60,8 @@ properties:
           - const: a
           - const: b
 
+  dma-coherent: true
+
 required:
   - compatible
   - reg

-- 
2.47.0


