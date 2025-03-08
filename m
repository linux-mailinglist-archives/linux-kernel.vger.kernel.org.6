Return-Path: <linux-kernel+bounces-552465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4306BA57A1A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3262189511D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD61D935C;
	Sat,  8 Mar 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SOvEmMEz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF31D0E2B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436499; cv=none; b=a8imbIn87laywxCTTvUkhgmyENmi1EUvkyqCiznvEvLLR8NDthAP5YH+JYE1Z5mvwfpiMOZRhJR+QEPnIFXDKEJYCVNvpE2U4aXTeYcWgJzOiV/0Ep4mjBETIHfEEQ3poaIB1U3uAAHE0y0i48xE4hE0UZpCwcTrTVyRKbhaaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436499; c=relaxed/simple;
	bh=H52on9OF9VHErJX/F0Xzfni4+/Tw4ZDeMorcaCchiac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=is98hZuP6JTMPHk/15D/+ICN6CNicXJaFvNyRxhuc3NQqdAYDyF3mKVS0le6ezwY60yp6WLwW/9oRwnarmdTmqCVu4iEbdWu42Z1iHU6+kyYUsp4AveTHru6njLijLwo/YVB1klsadkAWvoz9Q01+1x9LadGP9e74zB6D2SKF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SOvEmMEz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741436496;
	bh=H52on9OF9VHErJX/F0Xzfni4+/Tw4ZDeMorcaCchiac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SOvEmMEzdGebwFc16IIOF7TLRuQrKIXOyFI4XCFUq9ILoGX5xnclFfnJUqbRg/wlz
	 J/mytWMTciApUh6NBb6sJxAkrCHJ20sCo8B2iFH53k+wvl899ETBJBw1hJSf5G0wDa
	 +TZ2NVhZPJjRFM3OALa0/ITJNJE0UDq4fYwcGZGDKpTknTfxnFE0gSEk62xMjufqKv
	 o9ZANCeFDrgByV4FUQP10TW9LaBtw0bxljDwfjdlZMNUDjK5FyaTXFE6JFsvc6FEFs
	 4poyHaMvelGIjbpJF2hX/gUT9OIhpVnvpcE84ZMVu5Op6eMuIEKIeSxzQAsalwyZ/s
	 KrGk4iC5Cpjvw==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 4804017E0B12;
	Sat,  8 Mar 2025 13:21:36 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 08 Mar 2025 14:21:14 +0200
Subject: [PATCH v5 05/12] phy: rockchip: samsung-hdptx: Drop unused phy_cfg
 driver data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-phy-sam-hdptx-bpc-v5-5-35087287f9d1@collabora.com>
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

There is no usage of phy_cfg in the upstream driver data, nor in the
downstream one, hence remove it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index f9b5c96d6c789e435657e224032d35b5a6950945..06644c3d98d3f8b697fc704704df5acdd3c85bad 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -397,7 +397,6 @@ struct rk_hdptx_phy {
 	int phy_id;
 
 	struct phy *phy;
-	struct phy_config *phy_cfg;
 	struct clk_bulk_data *clks;
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];

-- 
2.48.1


