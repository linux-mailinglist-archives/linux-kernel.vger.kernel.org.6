Return-Path: <linux-kernel+bounces-393820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AED119BA5C5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1441F217C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B0176AA1;
	Sun,  3 Nov 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="lDdwp72Q"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8516BE14;
	Sun,  3 Nov 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730641940; cv=none; b=u4wh+tO2sT+susJaeDKzFAn8ZrixT6MbZXeKXg5jXDI1dXlayH7VcCxx0v8CiCiok9kFx5Ze7bT/mVab6OUfP5K/6I2GUg811JM70W18SbuYIeoxPJ5vCXJRcqy3PG4Dxah29LZ/FmGeNLCMw70ChQslrbDqsuUCBliGL3FP4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730641940; c=relaxed/simple;
	bh=j2WxG1gi9sX9Q9XHaunLYPDXuZFPxo2eTPeWaKuZNcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WfxCo8NlP4qlBmlkavT+PhKb3ZFISKl8R4JDtQQ4nUsnSca+xFfw4Rc15v5iBCjq3L0lXdY7e6a32WRrL/++rqapn3SqKe+9e0DivvhjvipbZ7+AOVO5i3Kl7pv+03ykuQeaaXFXPbMtQtEkbcILnjC1z1xAhlJOW6oL+3K44v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=lDdwp72Q; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=A1dLRRt6Gpz+f3YNGF2cRhz0EDeBb4t+Te4s+RjcUeE=; b=lDdwp72QRpdcjecb79UtxXvLrU
	ZOJkSSVHO6PNrkQpfDHBwD4r1lOPiRs0WumKvSwaofaItO6z3zdXn3oWiGjFKe039SmNHMkvL8YO1
	oImbxsTrnUc9c6hzQJgh1bCMJCnk7b7pW5dLuZLfeJmvwnJNGD3ENkTBgVJKKr6rh2vAQ6Teo3IyJ
	u9nz2vKFeQq8woW26daQpDPOba4mSBoTiVuzs+yykzGlhuNgK9GJUu/spyzpL4FvvQKkxwnro8OxH
	foh8jfWtGm3PFMiF1z0kWTaoIThuU4rtrjY76d5bL4qR/eWhBGLvg8KQWEm01WlW6WVDKDc3BMuuz
	JogX233w==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 3/3] ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E
Date: Sun,  3 Nov 2024 14:52:01 +0100
Message-Id: <20241103135201.25615-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241103135201.25615-1-andreas@kemnade.info>
References: <20241103135201.25615-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable drivers used on Kobo Clara 2E

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 333ef55476a30..0beecdde55f58 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -68,6 +68,7 @@ CONFIG_BT=y
 CONFIG_BT_BNEP=m
 CONFIG_BT_HCIUART=y
 CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_NXPUART=m
 CONFIG_CFG80211=y
 CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=y
@@ -253,6 +254,7 @@ CONFIG_MFD_ROHM_BD71828=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_BD71815=y
+CONFIG_REGULATOR_BD71828=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
 CONFIG_REGULATOR_DA9063=y
-- 
2.39.5


