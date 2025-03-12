Return-Path: <linux-kernel+bounces-558511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F2EA5E6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696C417A774
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C31F37BC;
	Wed, 12 Mar 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GeaONFQB"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387431F2C45;
	Wed, 12 Mar 2025 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816786; cv=none; b=rt5A6gP0AKXXZ6rY3Kxhl6W/Ytm77tTSiFKkG35Zr+AWGYyab1PhndrYjuC0tStYC5rZ7Wj0F8LSelXSz5sz/H9A7rEffaNp5BgMLvzTnex63ZvdvQ1P4iGdk9sKKy9ELDTZSywVrKL6qZqTeq6rCX85bmMqQI8SIBAj2AEFjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816786; c=relaxed/simple;
	bh=w+JrzCsi6xZcJjEWzjjP11MMDXz4otUfmP9aHaWn7L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBSms0TRSheo923X+U+xTC5RORnY1DUiM88pW2J4u0+/r8OROvIxpgEENtR0OOjejkbedZjXy8Y+bPohhlssFO7j8ecfL8DA/nxVyydfYcI7UQ3fBLiOXDXcYtOAYKPxOAK1iv89iooA5jH/4ZMuSNRwABLXvA6tDmY5Zu9VoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GeaONFQB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=RPZeAMND+U90bEKUDn6ihSLrgG/axOEBj8vKKlbjoxE=; b=GeaONFQBmB7HtgLI6iiUmJU14B
	2uYAB5VDedKtPtg1tPKjYIEjnMkzlr/oQMfZqT+en+XuDnnTqaqMAz98mty8sySEJskeBdn7kTWbB
	mQEq4itxJwgVNhHq54Er8aYkMhlue0e/WbEE8JUodxIrMqjet7QVkJ2+uLp0VU9oX6/GRbpty/amI
	mP7ZDYoKAhrNUZ4D9SEYGyDmgQSi3A9+kZl7MI+PwW2VcvxGOrT1wak7yZTXIqSrdBfv4nvrZLJVQ
	GgTtmoL8lbxYbJMatFKSSJUP5iKfkgK9CHHUFgmzrpGiIYTDxfOjReBdCFTDV+4NR+u9xUG0VP19C
	Gqngmjaw==;
Received: from p3ee2c254.dip0.t-ipconnect.de ([62.226.194.84] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsU6w-0002k3-7B; Wed, 12 Mar 2025 22:59:34 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de,
	sboyd@kernel.org,
	mturquette@baylibre.com
Cc: robh@kernel.org,
	p.zabel@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kever.yang@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dt-bindings: reset: fix double id on rk3562-cru reset ids
Date: Wed, 12 Mar 2025 22:59:23 +0100
Message-ID: <20250312215923.275625-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Id 173 was accidentially used two times for SRST_P_DDR_HWLP and
SRST_P_DDR_PHY. This makes both resets ambiguous and also causes build
warnings like:

drivers/clk/rockchip/rst-rk3562.c:21:57: error: initialized field overwritten [-Werror=override-init]
   21 | #define RK3562_DDRCRU_RESET_OFFSET(id, reg, bit) [id] = (0x20000*4 + reg * 16 + bit)
      |                                                         ^
drivers/clk/rockchip/rst-rk3562.c:266:9: note: in expansion of macro 'RK3562_DDRCRU_RESET_OFFSET'
  266 |         RK3562_DDRCRU_RESET_OFFSET(SRST_P_DDR_PHY, 0, 8),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/rockchip/rst-rk3562.c:21:57: note: (near initialization for 'rk3562_register_offset[173]')
   21 | #define RK3562_DDRCRU_RESET_OFFSET(id, reg, bit) [id] = (0x20000*4 + reg * 16 + bit)
      |                                                         ^
drivers/clk/rockchip/rst-rk3562.c:266:9: note: in expansion of macro 'RK3562_DDRCRU_RESET_OFFSET'
  266 |         RK3562_DDRCRU_RESET_OFFSET(SRST_P_DDR_PHY, 0, 8),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~

To fix that issue give SRST_P_DDR_PHY a new and now unique id.

Reported-by: Stephen Boyd <sboyd@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503121743.0zcDf6nE-lkp@intel.com/
Fixes: dd113c4fefc8 ("dt-bindings: clock: Add RK3562 cru")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
The original patch did go with the reset of the clock controller code
into the clock tree, so this patch should of course also go that way.

I also don't have anything more open for the 6.15 merge window, so
clock-maintainers could just apply this patch on top of the main changes.

 include/dt-bindings/reset/rockchip,rk3562-cru.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/reset/rockchip,rk3562-cru.h b/include/dt-bindings/reset/rockchip,rk3562-cru.h
index a74471d7d2a93..8df95113056e3 100644
--- a/include/dt-bindings/reset/rockchip,rk3562-cru.h
+++ b/include/dt-bindings/reset/rockchip,rk3562-cru.h
@@ -217,7 +217,7 @@
 #define SRST_MSCH_BRG_BIU		171
 #define SRST_P_MSCH_BIU			172
 #define SRST_P_DDR_HWLP			173
-#define SRST_P_DDR_PHY			173
+#define SRST_P_DDR_PHY			290
 #define SRST_P_DDR_DFICTL		174
 #define SRST_P_DDR_DMA2DDR		175
 /********Name=DDRSOFTRST_CON01,Offset=0x20204********/
-- 
2.47.2


