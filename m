Return-Path: <linux-kernel+bounces-526238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9883EA3FC0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892238835E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696EA215051;
	Fri, 21 Feb 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=szczodrzynski.pl header.i=@szczodrzynski.pl header.b="HcK5seWl"
Received: from s2.avantea.pl (s2.avantea.pl [46.242.128.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D4214A97;
	Fri, 21 Feb 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.242.128.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156021; cv=none; b=YI4nJ8HlzG02oqGCV2SVike5aAINCfJK+9XdeHc3zIT4iYvXz7s+RiVOAV+uQWKqCeU6PxCZyHsvYTKAGIehTFv6A8jVSca0+uz6fFfELEMug7/0OBia7klVeiFg8KjLzuGMouIiHUglpHSE5etuQUvNeyDZ04scucDe4wTmnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156021; c=relaxed/simple;
	bh=xJu7so+7BBYyhSfxXPYt/2ar3s2g1qidAkZvUjP5T2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmfWumwhNV4lbhwiAmc9iQsyFYsqtVJHNFu+/T/uvM2gpT54iJuToBqYmbwjEa0Kaga21MdnoP0EZgSp5HxipjhlcGADYWzXznahorB09G5N8Ah6R+txCQ/vmttlvC+5aSrOwsw+KpjC4I3W77PmKcsI2NDECBhJi7Vk9a+FpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=szczodrzynski.pl; spf=pass smtp.mailfrom=szczodrzynski.pl; dkim=pass (2048-bit key) header.d=szczodrzynski.pl header.i=@szczodrzynski.pl header.b=HcK5seWl; arc=none smtp.client-ip=46.242.128.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=szczodrzynski.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szczodrzynski.pl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=szczodrzynski.pl; s=x; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5/V9/R7a9isS+zNiVj1HLAhpc5SCNNFYHIXlJodspTU=; b=HcK5seWlZAZbl0hkdyDFlNS5rh
	zZbbTejohyTCnv9XobrgEqiUzeWFg02A27ueeoZcrmNhZZKVl2qGxpFFjE9ffbW+00X6Jx7F0YRwi
	O00wkrUdGkcVfqQUjiEw6HFhlMvIcRVel6Wf2ZeN2uRYVPokh/iRjKMB0YB3Y2tGXG50AoSqWy1Sg
	RHOYGl52iJ0kDEAvqFsQLkSYEVp2UVgrBYiB1+Hi2PVUj/AAHxxuH8q+zOBC7CqTUkgiZybWb3R7D
	ARmTlh34ETeynSRA7MHUeRj+l8WI3F4wh9fyhev6lEATYAVlqor0dcaUQWYkHb1vqlNwStGf10Czu
	E9ZVLf7w==;
Received: from [62.171.184.96] (helo=buildhost.contaboserver.net)
	by s2.avantea.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96-58-g4e9ed49f8)
	(envelope-from <kuba@szczodrzynski.pl>)
	id 1tlViu-00AOLX-1R;
	Fri, 21 Feb 2025 17:17:56 +0100
From: =?UTF-8?q?Kuba=20Szczodrzy=C5=84ski?= <kuba@szczodrzynski.pl>
To: Maxime Ripard <mripard@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/5] phy: allwinner: phy-sun6i-mipi-dphy: Support LVDS in combo D-PHY
Date: Fri, 21 Feb 2025 17:17:47 +0100
Message-Id: <20250221161751.1278049-2-kuba@szczodrzynski.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221161751.1278049-1-kuba@szczodrzynski.pl>
References: <20250221161751.1278049-1-kuba@szczodrzynski.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: kuba@szczodrzynski.pl

Some Allwinner chips (notably the D1s/T113 and the A100) have a "combo
MIPI DSI D-PHY" which is required when using single-link LVDS0.

In this mode, the DSI peripheral is not used and the PHY is not
configured for DSI. Instead, the COMBO_PHY_REGx registers are set to
enable LVDS operation.

Enable the PHY driver to work in LVDS mode on chips with a combo D-PHY.

Signed-off-by: Kuba Szczodrzyński <kuba@szczodrzynski.pl>
---
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 65 ++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 36eab9527..f958e34da 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -166,8 +166,8 @@
 #define SUN50I_COMBO_PHY_REG0_EN_CP		BIT(0)
 
 #define SUN50I_COMBO_PHY_REG1		0x114
-#define SUN50I_COMBO_PHY_REG2_REG_VREF1P6(n)	(((n) & 0x7) << 4)
-#define SUN50I_COMBO_PHY_REG2_REG_VREF0P8(n)	((n) & 0x7)
+#define SUN50I_COMBO_PHY_REG1_REG_VREF1P6(n)	(((n) & 0x7) << 4)
+#define SUN50I_COMBO_PHY_REG1_REG_VREF0P8(n)	((n) & 0x7)
 
 #define SUN50I_COMBO_PHY_REG2		0x118
 #define SUN50I_COMBO_PHY_REG2_HS_STOP_DLY(n)	((n) & 0xff)
@@ -181,7 +181,9 @@ struct sun6i_dphy;
 
 struct sun6i_dphy_variant {
 	void	(*tx_power_on)(struct sun6i_dphy *dphy);
+	void	(*lvds_power_on)(struct sun6i_dphy *dphy);
 	bool	rx_supported;
+	bool	is_combo_dphy;
 };
 
 struct sun6i_dphy {
@@ -222,6 +224,18 @@ static int sun6i_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
+static int sun6i_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct sun6i_dphy *dphy = phy_get_drvdata(phy);
+
+	if (mode == PHY_MODE_LVDS && !dphy->variant->is_combo_dphy) {
+		/* Not a combo D-PHY: LVDS is not supported */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void sun6i_a31_mipi_dphy_tx_power_on(struct sun6i_dphy *dphy)
 {
 	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
@@ -329,6 +343,37 @@ static void sun50i_a100_mipi_dphy_tx_power_on(struct sun6i_dphy *dphy)
 	udelay(1);
 }
 
+static void sun50i_a100_mipi_dphy_lvds_power_on(struct sun6i_dphy *dphy)
+{
+	regmap_write(dphy->regs, SUN50I_COMBO_PHY_REG1,
+		     SUN50I_COMBO_PHY_REG1_REG_VREF1P6(4) |
+		     SUN50I_COMBO_PHY_REG1_REG_VREF0P8(3));
+
+	regmap_write(dphy->regs, SUN50I_COMBO_PHY_REG0,
+		     SUN50I_COMBO_PHY_REG0_EN_CP);
+	udelay(5);
+	regmap_update_bits(dphy->regs, SUN50I_COMBO_PHY_REG0,
+			   SUN50I_COMBO_PHY_REG0_EN_LVDS,
+			   SUN50I_COMBO_PHY_REG0_EN_LVDS);
+	udelay(5);
+	regmap_update_bits(dphy->regs, SUN50I_COMBO_PHY_REG0,
+			   SUN50I_COMBO_PHY_REG0_EN_COMBOLDO,
+			   SUN50I_COMBO_PHY_REG0_EN_COMBOLDO);
+	udelay(5);
+	regmap_update_bits(dphy->regs, SUN50I_COMBO_PHY_REG0,
+			   SUN50I_COMBO_PHY_REG0_EN_MIPI,
+			   SUN50I_COMBO_PHY_REG0_EN_MIPI);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA4_REG,
+		     SUN6I_DPHY_ANA4_REG_EN_MIPI |
+		     SUN6I_DPHY_ANA4_REG_IB(2));
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA3_REG,
+		     SUN6I_DPHY_ANA3_EN_LDOR |
+		     SUN6I_DPHY_ANA3_EN_LDOD);
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA2_REG, 0);
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA1_REG, 0);
+}
+
 static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 {
 	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
@@ -492,6 +537,14 @@ static int sun6i_dphy_power_on(struct phy *phy)
 {
 	struct sun6i_dphy *dphy = phy_get_drvdata(phy);
 
+	if (phy->attrs.mode == PHY_MODE_LVDS && dphy->variant->is_combo_dphy) {
+		if (dphy->variant->lvds_power_on) {
+			dphy->variant->lvds_power_on(dphy);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
 	switch (dphy->direction) {
 	case SUN6I_DPHY_DIRECTION_TX:
 		return sun6i_dphy_tx_power_on(dphy);
@@ -514,6 +567,11 @@ static int sun6i_dphy_power_off(struct phy *phy)
 	regmap_write(dphy->regs, SUN6I_DPHY_ANA3_REG, 0);
 	regmap_write(dphy->regs, SUN6I_DPHY_ANA4_REG, 0);
 
+	if (phy->attrs.mode == PHY_MODE_LVDS && dphy->variant->is_combo_dphy) {
+		regmap_write(dphy->regs, SUN50I_COMBO_PHY_REG1, 0);
+		regmap_write(dphy->regs, SUN50I_COMBO_PHY_REG0, 0);
+	}
+
 	return 0;
 }
 
@@ -533,6 +591,7 @@ static const struct phy_ops sun6i_dphy_ops = {
 	.configure	= sun6i_dphy_configure,
 	.power_on	= sun6i_dphy_power_on,
 	.power_off	= sun6i_dphy_power_off,
+	.set_mode	= sun6i_dphy_set_mode,
 	.init		= sun6i_dphy_init,
 	.exit		= sun6i_dphy_exit,
 };
@@ -619,6 +678,8 @@ static const struct sun6i_dphy_variant sun6i_a31_mipi_dphy_variant = {
 
 static const struct sun6i_dphy_variant sun50i_a100_mipi_dphy_variant = {
 	.tx_power_on	= sun50i_a100_mipi_dphy_tx_power_on,
+	.lvds_power_on	= sun50i_a100_mipi_dphy_lvds_power_on,
+	.is_combo_dphy	= true,
 };
 
 static const struct of_device_id sun6i_dphy_of_table[] = {
-- 
2.25.1


