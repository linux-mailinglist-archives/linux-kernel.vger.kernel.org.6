Return-Path: <linux-kernel+bounces-412985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4F9D120D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D63B2BED1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C91C1F11;
	Mon, 18 Nov 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="OZFkp+kf"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0361BCA0C;
	Mon, 18 Nov 2024 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936598; cv=none; b=XSMbPxLFZT6pilY+WQ/9jiQ4DRCoS9PlMsw6zRtEwOMk7voiejsPrNS4mSrBWIK+/pJockBPTUkguteHFmt/MLhNmAnIL9iAX5ciyPJY5//Lv5Iq1AFnDeJ0764FMR6deH0M40Q5v3dprjb8IuOnzww4Y0AN7niuk1d23TJspaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936598; c=relaxed/simple;
	bh=Ntq50dzXPF1u84iPH0ii+gq7ncmvQWESeBQmF/KzVcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=u5lG88G9Q6rS3MF+sQs7tOCkeXq6drh7jOVoLFxPGPIeR5CpJUdQTO77xzMjcfNvYRltSMWu7Vv7WfNF9nGNc1LPdYyXnlildN9FEsHt+CiyiKbW8V+45q4E3svBjFwhPWou17ZZnWEgYr4IX7gj2Aq3CkKHB75GgA3Lq/z3CIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=OZFkp+kf; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AICK2Aq027968;
	Mon, 18 Nov 2024 13:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=B
	o2I2ESRILj0OhfqmXY+0n+Gsl8OPjyRH9ZU4sJ6oz4=; b=OZFkp+kfOQxXDgAhN
	HZIOkJDXoWcnpcIhPOOoCxKEED292Uk8inMLkybmBOyTPKrnwekjL1ZOZtaIquiY
	fnQZfXxBPUK4GMvEOrsbt9ns7IKq7sEgb4JgwIvqSqiLP3Fb0aOaNmQuL5W6axh5
	Ufbq1dRor35SmEvzYjsWYARdP10JGbZwDvAaYoutF41qrhPjTzEloESbvyUg1qxA
	18ihrtUdOgzc12ThWI2P4g6zKIFbztC9qvOjIolZZI3AaqkbZ5Im8sxSnbRDQ4ky
	VNk+UoCW5aAeUAn+QhK9h4FcRmtH6nsMTcY5JmBQBpadVWm9ek+NmTUUdp4Pb5Rt
	/FUOA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42xmc1hmj6-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 13:02:46 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 18 Nov 2024 13:02:45 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 18 Nov 2024 13:02:13 +0000
Subject: [PATCH v2 21/21] arm64: dts: ti: k3-j721s2: Add GPU node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241118-sets-bxs-4-64-patch-v1-v2-21-3fd45d9fb0cf@imgtec.com>
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=Ntq50dzXPF1u84iPH0ii+gq7ncmvQWESeBQmF/KzVcI=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRbWz2btX9to+2i67x3vJyCXPg61z4sFS810jhWrNvyT
 DL0zvJFHaUsDGIcDLJiiiw7VliuUPujpiVx41cxzBxWJpAhDFycAjCRKgWG/1mFuvzdj1vKHF+n
 vdV5/WNm6U+RvVe8pOP7uNMjP/s69DMyXGWKcpa/1ubv5zVDa7tOqtizHWu3rFRrlxCIe+mVUXS
 GAQA=
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: y9THFNVnkJv49gUP9ineJIyRJ3fKU6fj
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673b3af6 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=rLJv8WYccUdZFC7c5UsA:9 a=QEXdDO2ut3YA:10 a=S-JV1fTmrHgA:10 a=j2-svP0xy3wA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: y9THFNVnkJv49gUP9ineJIyRJ3fKU6fj

The J721S2 binding is based on the TI downstream binding in 54b0f2a00d92
("arm64: dts: ti: k3-j721s2-main: add gpu node") from [1] but with updated
compatible strings.

The clock[2] and power[3] indices were verified from docs, but the
source of the interrupt index remains elusive.

References for indices: clocks[1], interrupts[2], power[3].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel
[2]: https://downloads.ti.com/tisci/esd/latest/5_soc_doc/j721s2/clocks.html
[3]: https://downloads.ti.com/tisci/esd/latest/5_soc_doc/j721s2/devices.html

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v2:
- Use normal reg syntax for 64-bit values
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-21-4ed30e865892@imgtec.com
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 9ed6949b40e9dfafdaf6861944b0b128b053a44f..9adc2c704ba4b38d1a0e7c9ded035fe79630451d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -2047,4 +2047,16 @@ watchdog8: watchdog@23f0000 {
 		/* reserved for MAIN_R5F1_1 */
 		status = "reserved";
 	};
+
+	gpu: gpu@4e20000000 {
+		compatible = "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogue";
+		reg = <0x4e 0x20000000 0x00 0x80000>;
+		clocks = <&k3_clks 130 1>;
+		clock-names = "core";
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 130 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 373 TI_SCI_PD_EXCLUSIVE>;
+		power-domain-names = "a", "b";
+		dma-coherent;
+	};
 };

-- 
2.47.0


