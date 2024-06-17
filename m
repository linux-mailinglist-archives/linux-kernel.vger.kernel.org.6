Return-Path: <linux-kernel+bounces-218354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17990BD18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4541F22EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777119924B;
	Mon, 17 Jun 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QV0bLGs7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534C1922D0;
	Mon, 17 Jun 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661388; cv=none; b=uVMMeMsubQ/1bMAEbB59ecB/tdhEOYsD6wB6z6CTJMzKYE22bmwA0X2SCU8TzjLLJ8qiy71wpo1zkPPW2jdFOkiRZvL3X9olXwldYP1bdNM4Z/lHbHShNGrXwzqwzUCDkxJq2Dti5Qi0KxRXKNHVkpz+3QaZEq1PkhJe2BWQdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661388; c=relaxed/simple;
	bh=/Tf0+9ywBhA2xu+ay36C238U4Xe6QDQ8N9Bh//pwcvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZsVawYCsOniw6FbkVbXkugjvbDAWvD5lOCjOChoCeC66Z4dCMYUM/MqKO6/nNz8TqNrqHHwRYX39cQhD8GVSiOkl/YlTfb23Ak6C33exbrtjXOCl1nvOFsLTU8iXe8UPodBK24MGP4Ne2lZgZDp53l9s/v3Vm+HqWiSZ0RJdR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QV0bLGs7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718661385;
	bh=/Tf0+9ywBhA2xu+ay36C238U4Xe6QDQ8N9Bh//pwcvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QV0bLGs7qU2pkEZQLaP496J4V1YrlQbHD8hWAmNmhZ3GEkb4VXHglTeN2oCBpy1mu
	 ydj29ucf2/hYmidGOuxRPSCfQ7NzbMjYAlEXqd+/zyd4FMxDx534cIfGAMVjTuJH8E
	 mE50zko6BfRUTdmrSqe37skUuprD51mchRAXbCTfDxUwtqKl4BIe71oyoAeEmHUEP2
	 DUP99T1SzRgWoe5AHeTju+UGT146e4dOIy6XH+GQ3OjmxlkjarI5etGlmE7IFJ+RCE
	 8b1U+EI2vfIb7c1pd3pkCi/EbSoLXKTRt/JB3E5Tr8daLJ/63QVm2QYIS9eHx80fNh
	 kE5BdmsKwXxKQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B49313782167;
	Mon, 17 Jun 2024 21:56:24 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Jun 2024 00:48:09 +0300
Subject: [PATCH 1/4] phy: phy-rockchip-samsung-hdptx: Explicitly include
 pm_runtime.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-rk3588-hdmiphy-clkprov-v1-1-80e4aa12177e@collabora.com>
References: <20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com>
In-Reply-To: <20240618-rk3588-hdmiphy-clkprov-v1-0-80e4aa12177e@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14-dev-f7c49

Driver makes use of helpers from pm_runtime.h, but relies on the header
file being implicitly included.

Explicitly pull the header in to avoid potential build failures in some
configurations.

Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 946c01210ac8..3bd9b62b23dc 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>

-- 
2.45.2


