Return-Path: <linux-kernel+bounces-396254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898229BCA27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3D828408B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6A31D1F79;
	Tue,  5 Nov 2024 10:17:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E51D1747
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801831; cv=none; b=bQ9GlGAkTI2n1E3mKfgBRdn+D29RDLEhsFzVBjIA9mZUxzlO0eAXkmpQNP2mW8sCzt5XDX7P5RuPaTIGISoPWfyXF8V6gdton1Gvx5dfmOwlUrfB525HovRI/a9qbGa7wOAcWOU609fqgcDhCyZwav5vooR3i5yNlCkT1DkRP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801831; c=relaxed/simple;
	bh=uYFu5hk9RPg1nhk2wUqnvBIEwCZTXT9exQ8u7c3OuBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B95C2c06XuG+VZKS2TXb3zBrkYFnAVXKP05GS/RSBhMxzmE0WMhYkDwJ1b4too32EppQ9+VqpRFaVdSr+rJF5W3XbaWvL2hbhXTobBzSwsb/E3FOjlX2I4q2UcF32+HaFUHNqKqLvVPLgoF/yfF5S7XNocOTpUof2oWNxWMugPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1t8GcS-0002D7-FX; Tue, 05 Nov 2024 11:17:04 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: "robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, Sascha Hauer" <s.hauer@pengutronix.de>
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: add interconnect for lcdif-hdmi
Date: Tue,  5 Nov 2024 11:16:44 +0100
Message-Id: <20241105101645.231608-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add the missing interconnect for the lcdif-hdmi.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index f3531cfb0d79..09b0b63a7b88 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2023,6 +2023,10 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
 						     "pai", "pvi", "trng",
 						     "hdmi-tx", "hdmi-tx-phy",
 						     "hdcp", "hrv";
+				interconnects = <&noc IMX8MP_ICM_LCDIF_HDMI &noc IMX8MP_ICN_HDMI>,
+						<&noc IMX8MP_ICM_HRV &noc IMX8MP_ICN_HDMI>,
+						<&noc IMX8MP_ICM_HDCP &noc IMX8MP_ICN_HDMI>;
+				interconnect-names = "lcdif-hdmi", "hrv", "hdcp";
 				#power-domain-cells = <1>;
 			};
 
-- 
2.39.5


