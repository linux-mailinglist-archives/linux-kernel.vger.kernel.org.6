Return-Path: <linux-kernel+bounces-336114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2475597EF60
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCD91F221AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1B19EECD;
	Mon, 23 Sep 2024 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OPwmuXIL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47019D063
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109649; cv=none; b=TnbPxPm8K3Dp2PQPM7Evex2or+MwG4QiacFakfpvuS/9/ZPNrRldwtj/3ikfKHfTLqEHDvmzN4vIkrdErrqhBcolLR71LxvsjNKoFQxk+U1Wdo8WiKyAcOlozmO4o7YtIgXgMF8d5h/VY7W85Mqrb9yVSqIRPhQvUV74+vqLG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109649; c=relaxed/simple;
	bh=uj6nS9/Qqyl5x+LHHnU01IA4P1bnKBhIiYwrpVYWxeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F01hUqqCUktjSCAjZY3XTFUQQPcq83oKdczNryO1UH51R8aycPAv2zxR+6uaXaWRZcNc2jCqLiHaSfMcCP8JHM0/3cLTolN8XvWt13ARJdbW/S0y9Sx1NKzgSGWRmKWUNiS1ByMuf9rMhsxAqjUn/nOEAxiKfy0ys0xdhwGke0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OPwmuXIL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727109645;
	bh=uj6nS9/Qqyl5x+LHHnU01IA4P1bnKBhIiYwrpVYWxeE=;
	h=From:Date:Subject:To:Cc:From;
	b=OPwmuXILF1yS8XPJ7fuAMpcBG2cDzPBI/TRsZUG40KAXD7y+DIxoXlQbyQVUx1HOH
	 KfVg6Z6NyKq+4kAn/bh2aVCs2A2/xBz1heTLjV4BwHCtt3/eKZmvIk4ji0u7X4p36O
	 Kt92JtLJP2ucLYZ9JUjX6TVaxUU/PxfYFE6+8pf/0Op3hUvcaINjbE+EsVOykhJUY+
	 TsRk1ukfmw82Gi01XW6mod3siN/nxSbMEHxm4zIopiR7SumFP0Ow2ioQ2X70ZSg/E4
	 p+17XapppP/Amx33GS7Xi8x3JklJ4YHnKdWCI4KBT1RXO6rFPteVfjUk+bp7XuTn2s
	 VlAuZCouvHJxg==
Received: from localhost (unknown [5.14.149.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8972A17E3600;
	Mon, 23 Sep 2024 18:40:44 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 23 Sep 2024 19:40:16 +0300
Subject: [PATCH] phy: phy-rockchip-samsung-hdptx: Depend on
 CONFIG_COMMON_CLK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-sam-hdptx-link-fix-v1-1-8d10d7456305@collabora.com>
X-B4-Tracking: v=1; b=H4sIAO+Z8WYC/x2M0QpAMBRAf0X32a0ZGX5FHsYubpi1SWr5d8vjO
 XVOhECeKUCXRfB0c+DTJijyDKZV24WQTWKQQlailSUGfeBq3PXgznbDmR+cZK0apagcCw0pdJ6
 S/qf98L4f1Iocl2QAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.1

Ensure CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX depends on CONFIG_COMMON_CLK to
fix the following link errors when compile testing some random kernel
configurations:

  m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.o: in function `rk_hdptx_phy_clk_register':
  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1031:(.text+0x470): undefined reference to `__clk_get_name'
  m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1036:(.text+0x4ba): undefined reference to `devm_clk_hw_register'
  m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1040:(.text+0x4d2): undefined reference to `of_clk_hw_simple_get'
  m68k-linux-ld: drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:1040:(.text+0x4da): undefined reference to `devm_of_clk_add_hw_provider'

Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409180305.53PXymZn-lkp@intel.com/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 490263375057..2f7a05f21dc5 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -86,6 +86,7 @@ config PHY_ROCKCHIP_PCIE
 config PHY_ROCKCHIP_SAMSUNG_HDPTX
 	tristate "Rockchip Samsung HDMI/eDP Combo PHY driver"
 	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
+	depends on COMMON_CLK
 	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON

---
base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
change-id: 20240923-sam-hdptx-link-fix-c267877e3b1a


