Return-Path: <linux-kernel+bounces-529231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCE5A42216
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11FE16E4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AB25A2A7;
	Mon, 24 Feb 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKlaDFL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692D24CEFD;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405065; cv=none; b=m5/Daa65us6kHLWxEqdCBtAejuXdYByyE61MAB8U9gc9/5WLRs29H7Vz3+cY1LwV0ep4O77VDnFNDp5tP2Kg2zxeXYLTP8FveSCLBh6stkFvxHlr8taoYzdo8lLhB3emrdMRbVq5VyQ6cVgTVmbH1Cheu8pfoHspEwhB9S/vzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405065; c=relaxed/simple;
	bh=NkLn/3MG2E3CnR6jee3A29hXE2uuTTgpO4AUb4j8UnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IePHTtTnsYu5ewZBJtrAQcXyNgeX2x31zZhLOcA1Ur9AJxo03SB7PMK1nrZWm2p/IjiIoI5bOd5quFwOssSL+f4hG75zVgBvzGzMhPyMcUFO64ekam/9L9j2DU4gb99KOnM4Qjcp/g3LkztC4M1/E+FH7f5LR6ttLDKK32vkgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKlaDFL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D21C4CEF6;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=NkLn/3MG2E3CnR6jee3A29hXE2uuTTgpO4AUb4j8UnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iKlaDFL/agKTCm6ClZDzrHSOC0TdHAlP7wd/4D/uF1fTA6lFkPgtSZ5mLis5TPKi5
	 UbLHBYSwvNtajid2yN495VdKhYMSRYhHtEnIKkwD5zbUOf6T6V5z/Gvv6WFTcUpSHc
	 hwPm1ijOOoo5pGPhJ243XQfx9vE3XNEqRANFhpYnkBP1od35/QMe4TC30/24ClSXWO
	 KtgTehtsuLPkIgudGJVqKZWL2Tre+at1SWCUthkRwBCwYa62w8bqdk8wGASFBcH8J9
	 HAKglRMj+kxc4cTv4cVlCAuxh9J8ZUxSmQ5diIh1vSpfjoG4v27anu5jNcBCQXoJvk
	 n8aSreapHWF+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558DC021A6;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:50:56 +0100
Subject: [PATCH 06/14] arm64: dts: imx8mp: Add pinctrl config definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-6-5ccbbf613543@gocontroll.com>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
In-Reply-To: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=1790;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=onT8TBy0kWLgdCkmFuDnMoqyo8nMJja7Mwkr4JyDwjU=;
 b=hOJ3oQnibx8w4MPc+FcEJfZIDsCSGRpQL1vC/emd6CgR3e5dwXRVhMk7flegtw0k6nyRwuwAk
 xOTrdG71BgQCHrBcrklzfNBE9+K3HvREL4IjzR84Gi/x0CxIzzYsUFe
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this
register is written in the dts, these values are not obvious. Add defines
which describe the fields of this register which can be or-ed together to
produce readable settings.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

---
This patch has already been sent in a different group of patches: [1]
It was requested there to submit it along with a user, this series also
includes some users for it.

[1]: https://lore.kernel.org/all/20250218-pinctrl_defines-v2-2-c554cad0e1d2@gocontroll.com/
---
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
index 0fef066471ba607be02d0ab15da5a048a8a213a7..0927ed11ec687d5b273c4a4a6455e8d81468f676 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
@@ -6,6 +6,33 @@
 #ifndef __DTS_IMX8MP_PINFUNC_H
 #define __DTS_IMX8MP_PINFUNC_H
 
+//Drive Strength
+#define MX8MP_DSE_X1 0x0
+#define MX8MP_DSE_X2 0x4
+#define MX8MP_DSE_X4 0x2
+#define MX8MP_DSE_X6 0x6
+
+//Slew Rate
+#define MX8MP_FSEL_FAST 0x10
+#define MX8MP_FSEL_SLOW 0x0
+
+//Open Drain
+#define MX8MP_ODE_ENABLE 0x20
+#define MX8MP_ODE_DISABLE 0x0
+
+#define MX8MP_PULL_DOWN 0x0
+#define MX8MP_PULL_UP 0x40
+
+//Hysteresis
+#define MX8MP_HYS_CMOS 0x0
+#define MX8MP_HYS_SCHMITT 0x80
+
+#define MX8MP_PULL_ENABLE 0x100
+#define MX8MP_PULL_DISABLE 0x0
+
+//SION force input mode
+#define MX8MP_SION 0x40000000
+
 /*
  * The pin function ID is a tuple of
  * <mux_reg conf_reg input_reg mux_mode input_val>

-- 
2.48.1



