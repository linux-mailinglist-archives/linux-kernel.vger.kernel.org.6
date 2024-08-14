Return-Path: <linux-kernel+bounces-286181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467BD9517A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30791F243D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5B1474D7;
	Wed, 14 Aug 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="K4UXvkwY"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2D143C65
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627607; cv=none; b=RlFvvVgC+LeUF9W0eKhBfjWz506FH4jiX2AKxfvtGs5yBTGR69MEGJ2josaOahTC5MmxyBSKJ6TXrzGI5ig+dDF3Okavq4hlMxk0p3NRXIPd8AUwli2ShsD3QFgAEFct4yESoiLDDKK3QQjdRiZzOezistWAujzSIFNgq5UQ7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627607; c=relaxed/simple;
	bh=LDfee/0hzCfU3XzMAT277mwZLvQvqiV+j8Fggew9fb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PggUNZ97vErAH1odnrZd0sDdq4P4loH3Uqt5QdUvYdOzQKRsgyKvpAThAPkWBm96kJGAaCx4t4dRKsZZZ67d/sy5dU0TucWDqoCYiHsE7klMgGN9aThKA+L3exRt9S9y2vheENHvHe3vJ6WuKwuEFlDyv/9jc25RtCuK/m+Q3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=K4UXvkwY; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723627599; x=1726219599;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LDfee/0hzCfU3XzMAT277mwZLvQvqiV+j8Fggew9fb4=;
	b=K4UXvkwY0iiC4HB3jjaLB/1NHHDW9VI4pRP/Gip/r/+O7nRozFA3F06YHU0Zh7Bb
	asgimrW1eEQm5p8w2Rdeiy+baDnupigmTMJmD7raQhUYYyx32hP2pNZq0xF8Y9PK
	bXKAeeJgZ6qOClFaY5vHeBujsiWk7rMKI9boOBDlGQ4=;
X-AuditID: ac14000a-03251700000021bc-bc-66bc784f4966
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 38.54.08636.F487CB66; Wed, 14 Aug 2024 11:26:39 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 14 Aug
 2024 11:26:39 +0200
From: Teresa Remmet <t.remmet@phytec.de>
Date: Wed, 14 Aug 2024 11:26:10 +0200
Subject: [PATCH 3/6] arm64: dts: imx8mp-phyboard-pollux: Add SD-Card vqmmc
 supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-3-e2500950c632@phytec.de>
References: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
In-Reply-To: <20240814-b4-wip-t-remmet-phytec-de-bspimx8m-3392_upstream-v1-0-e2500950c632@phytec.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <b.hahn@phytec.de>,
	Yashwanth Varakala <y.varakala@phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWyRpKBR9e/Yk+aQfMiRYs1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DKWHbNteAd
	a8XESVeYGxhbWbsYOTgkBEwkJs6s7mLk4hASWMIk8e1LBzuE85hR4uP5wyxdjJwcbAIaEk9X
	nGYCsVkEVCXubesEs4UFgiV2vZ/CDGLzCghKnJz5hAVkKLOApsT6XfogYWYBeYntb+dAlSRL
	HJn6jxHEFgKyp0+7C2ZzCqRIXL95DmyviMAkJomj104wgjjMAn1MEp3TzrODVEkICEt83r2G
	DaJbXmLXpZOMEHF5iWnnXjND2KESRzatZprAKDQLyU2zEG6aheSmBYzMqxiFcjOTs1OLMrP1
	CjIqS1KT9VJSNzGCIkmEgWsHY98cj0OMTByMhxglOJiVRHgDTXalCfGmJFZWpRblxxeV5qQW
	H2KU5mBREudd3RGcKiSQnliSmp2aWpBaBJNl4uCUamAMd249EHMioWrGiSc3Pxszi7es236v
	7hTbo29zZhkd4YixXhd48HtMi5xzzsfn3gc3Twxe/l286c9BIfHA7+pJ0ucOa/9VPHk+bfsS
	mXVHOZu27axu4zdmvniZi8HqYHxq9xfbK0sEoh8dDloQsXpi8prF28OUW4NmM/E2/mlYsORL
	WXv/A0FWJZbijERDLeai4kQAg0sUnJICAAA=

Add SD-Card property for the bus IO power from the PMIC.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 3427936f9045..341baa167191 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -285,6 +285,7 @@ &usdhc2 {
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&ldo5>;
 	bus-width = <4>;
 	status = "okay";
 };

-- 
2.25.1


