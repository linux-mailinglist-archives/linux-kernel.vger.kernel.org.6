Return-Path: <linux-kernel+bounces-249374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB0892EACA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F51C21B01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AA5167271;
	Thu, 11 Jul 2024 14:32:40 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865081667FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708360; cv=none; b=sMxBJcmPpfVspbOhTMv3NRNup/2WOXkUyxkvxL7aNJwzBJQsn3PS5U6tdHet7q4dwKbxu2S/TW8OmaPL+GRgBumoJJqRZ5bj4d1VRMOOj+w+Zw47ad8TdCWz5BlOimAf4g5kIMB44GXGsGNyYLk+CgWc5hbDgnxCxf5dyyUEDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708360; c=relaxed/simple;
	bh=UXwrQTAUAqLJNVMjPrxyKJf2HTgbrYTXgRHz8Yv0GKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Joj+wlxpPj4SwdB8z1gSy1aOlAG2aE9vRD/4tS5oqY+wzU7yCMk/jzqdtfzEVMrqIpitrLs9JCiLvKAc780bTZwFggsahCHqWhLtIgXj5Jt8ubWXApsfOmSC5Q6AbJ6oBnLDJyK0uhkvBCTMxXMrOq+TvLO9EaQx/WiD/D89lY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:9b6b:6da0:997b:7165])
	by laurent.telenet-ops.be with bizsmtp
	id mEYc2C00H46XLxg01EYc1k; Thu, 11 Jul 2024 16:32:37 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRuqN-001kRe-3i;
	Thu, 11 Jul 2024 16:32:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRuqa-0009yc-LQ;
	Thu, 11 Jul 2024 16:32:36 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] platform: arm64: EC_LENOVO_YOGA_C630 should depend on ARCH_QCOM
Date: Thu, 11 Jul 2024 16:32:35 +0200
Message-Id: <0e4c9ffdc8a5caffcda2afb8d5480900f7adebf6.1720707932.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo Yoga C630 Embedded Controller is only present on the Qualcomm
Snapdragon-based Lenovo Yoga C630 laptop.  Hence add a dependency on
ARCH_QCOM, to prevent asking the user about this driver when configuring
a kernel without Qualcomm SoC support.

Fixes: 5e5f2f92cccc29f3 ("platform: arm64: add Lenovo Yoga C630 WOS EC driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/platform/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
index 058a4baa216a83b8..f7539e5419cf1616 100644
--- a/drivers/platform/arm64/Kconfig
+++ b/drivers/platform/arm64/Kconfig
@@ -35,6 +35,7 @@ config EC_ACER_ASPIRE1
 
 config EC_LENOVO_YOGA_C630
 	tristate "Lenovo Yoga C630 Embedded Controller driver"
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on I2C
 	select AUXILIARY_BUS
 	help
-- 
2.34.1


