Return-Path: <linux-kernel+bounces-352033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15A99194C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35168282FF4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F015B555;
	Sat,  5 Oct 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="jko0GRC7"
Received: from st43p00im-ztdg10063201.me.com (st43p00im-ztdg10063201.me.com [17.58.63.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765F15B12A
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151757; cv=none; b=pTsand6Cq6NvgiEWYJmZFzV08iiErR2uoWUlXI4YbUzTqrVbr7yZCk5cIroTafNxPLB+bmH5YqbRof5o0LG5KoYgOt68blMR3FYUltQJoS7dKX3JgGOjXt+SH17vrpLaG3HZCyKduUgTwhKXk/I5beSAe/isAvD54psAlVN2OZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151757; c=relaxed/simple;
	bh=mpFiRzfI1wl02WVDuIUkIWYKrK/hgMiDM9tngCp+29k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yjx/fM9G2PHmpeDwyzy0wSSt7gYkeAwVJ/IkiihHjG9C1sXAFHl8P4ZtBGlEcxTsCRMautpMUJdgzZs2Cn7jt0kuARGRuvdfFlszzv70uCY1YZ15rjMLNrgN241JnSXVPPcayMcTNIUTeHP1FnUXFeXWiRY0tYFq/1dDbrXsqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=jko0GRC7; arc=none smtp.client-ip=17.58.63.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1728151755; bh=7qNVpRk4hShjfI18Pwxsd9HJEZlZreJGT8LTSHQa0iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=jko0GRC7+2kWGDql7LJxnJYDkWLNnEXt+AwqLY//tHpqFO82oYVEHXEvWrq8HGqDY
	 CrWb+TskoDr0jsZJHuwqsDWNEIUptkCCDhIosWU1D/Ie9HYuXL67JXWNuwvEV6dcvF
	 5lNXozVgC0c2iF489YxwG+Q+OsONy3cCuPTmTAiSpRLfV3lBC+WNXLUwgzdnfcYfdo
	 Whhpm0BPaCSgKsfwTiGocHptIBDKpIqlsA6T9ZKgv+OxjJGBpJaliLMq9CLbHqHfSk
	 PZfyjQxX4yQNppvNOpo/8sgMzOTB2x5/wTITD3/plPDJ02kNuIizgcj5eoVDR3mN1X
	 OS63qywjG7blQ==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id A0E179803CA;
	Sat,  5 Oct 2024 18:09:09 +0000 (UTC)
From: Alain Volmat <avolmat@me.com>
Date: Sat, 05 Oct 2024 18:08:00 +0000
Subject: [PATCH 2/3] ARM: dts: st: add node for the MALI gpu on
 stih410.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-sti-gpu-v1-2-9bc11100b54b@me.com>
References: <20241005-sti-gpu-v1-0-9bc11100b54b@me.com>
In-Reply-To: <20241005-sti-gpu-v1-0-9bc11100b54b@me.com>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Alain Volmat <avolmat@me.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: ikPKVfJGHYnCfHiGGVwKwG-qG3Am1h7b
X-Proofpoint-ORIG-GUID: ikPKVfJGHYnCfHiGGVwKwG-qG3Am1h7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_17,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=587 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410050133
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Add the entry for the GPU (Mali400) on the stih410.dtsi

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih410.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/st/stih410.dtsi b/arch/arm/boot/dts/st/stih410.dtsi
index a69231854f783b1b9fd685ba2822eb406e0ffdf5..be34de10bbcb0d1f2d527568878e3ed1ff297954 100644
--- a/arch/arm/boot/dts/st/stih410.dtsi
+++ b/arch/arm/boot/dts/st/stih410.dtsi
@@ -285,5 +285,39 @@ cec@94a087c {
 			resets = <&softreset STIH407_LPM_SOFTRESET>;
 			hdmi-phandle = <&sti_hdmi>;
 		};
+
+		gpu: gpu@9f00000 {
+			compatible = "st,sti-mali", "arm,mali-400";
+			reg = <0x9f00000 0x10000>;
+			/* LIMA driver needs 2 clocks, use the same for both */
+			clocks = <&clk_s_c0_flexgen CLK_ICN_GPU>,
+				 <&clk_s_c0_flexgen CLK_ICN_GPU>;
+			clock-names = "bus", "core";
+			assigned-clocks = <&clk_s_c0_flexgen CLK_ICN_GPU>;
+			assigned-clock-rates = <400000000>;
+			resets = <&softreset STIH407_GPU_SOFTRESET>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pp2",
+					  "ppmmu2",
+					  "pp3",
+					  "ppmmu3";
+
+			status = "disabled";
+		};
 	};
 };

-- 
2.43.0


