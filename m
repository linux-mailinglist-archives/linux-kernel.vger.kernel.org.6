Return-Path: <linux-kernel+bounces-369161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1529A1995
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71811C217CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D51304B0;
	Thu, 17 Oct 2024 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MaFRQ/4q"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452820E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729138026; cv=none; b=RVqGTeIrINEnRRqHaD+/FFcnrtZWy/RWVDQ6X4yiiGM52zY4gOfbnnmP/HggCnT2N9OVjJA78UWI87UlmWuNqGYZRaCDGODdojSgq5nYhOsYsbIeznZMCvZsVG4IAMKj4Yi4flV8ZbDvHgxKs7BwjOH2C871WqdV9Bg3SEbBgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729138026; c=relaxed/simple;
	bh=KxORnFS9bRVA6Iaczczd/vV70i3CutftsO13elv+Drw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TgnYnIReRe1m5mqG82JaNdfffM45dG9N3/nM2bEmeQrlV2Y1kxQ0E7j082YbHxGYF/8SzvlbcI77JPFCYwI2w4jMafWqR72Y0xmuYx56b15UcN8bfup9VI3ZwvoguYHvHhfp3VhGM9FCgNqEX4HJDiX7Q01FL33jslqUM1sWYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MaFRQ/4q; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729138020; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Iwz05P1p61sVpu5xupITnxxL612xYYGx4kkmJtzWbM8=;
	b=MaFRQ/4qlciqS3ELGqQnLYDhVCTLSkghW1OX3BD2I5G/UKaI/09kg7BBYvh09CB27d0oRVzmnbYAT2F3Jk1F3T+Mqu1p18PonyaAGE5+wDgkIEFV4poS6COqivNVw//z2wMCdj6NQmfPll1nOnTEx+JZtnsote2C38oZe32pnlw=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WHJR90w_1729138018 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 12:06:59 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: christian.bruel@foss.st.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] phy: stm32: Remove unneeded semicolon
Date: Thu, 17 Oct 2024 12:06:57 +0800
Message-Id: <20241017040657.33992-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes an unneeded semicolon after a switch statement.

./drivers/phy/st/phy-stm32-combophy.c:226:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11403
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/phy/st/phy-stm32-combophy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/st/phy-stm32-combophy.c b/drivers/phy/st/phy-stm32-combophy.c
index e1e7083ccb5f..765bb34fe358 100644
--- a/drivers/phy/st/phy-stm32-combophy.c
+++ b/drivers/phy/st/phy-stm32-combophy.c
@@ -223,7 +223,7 @@ static int stm32_combophy_pll_init(struct stm32_combophy *combophy)
 	default:
 		dev_err(combophy->dev, "Invalid rate 0x%x\n", clk_rate);
 		return -EINVAL;
-	};
+	}
 
 	cr1_mask |= SYSCFG_COMBOPHY_CR1_REFCLKDIV2;
 	cr1_val |= REFCLDIV_0;
-- 
2.32.0.3.g01195cf9f


