Return-Path: <linux-kernel+bounces-258268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE79385AA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2E81F211C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE916A934;
	Sun, 21 Jul 2024 17:37:36 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006F167D95
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583455; cv=none; b=gc3NucF2BA+3YqIZn2gBeGt/BkRVtjNRhPkX18U1qCtLfvU+xfx0rwQXCJfHJCzwz5QaKg+tYI/6YHM4oC2oEeV44RmvaYOlQqboyr5yOUMYO96cHrnCbypq3TOTkEzacqAkX0QW6y2D5assj6pWVTl9QQ2lrAY8dsJAfDsB+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583455; c=relaxed/simple;
	bh=xYT2p87AowoYlGAhmU5UlLUPWo69ZpdLDP2trW1FxOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I05P15hcsOeAt4xYbJl8A3LEl+4/3ZFMNDdF+r4KLbLJ4ubHm3DSmcuJSvwgPsWvz7ncGFxS51kCf8i/zT5pk606y8ZDNuZaK+dfiRKKQgpTByWGB7C6kgdKcR0SKJSnGqul2SgYYhUR4LMWGkHbhtoxDgYrWpZsi8raitb+2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVaV1-00075D-96; Sun, 21 Jul 2024 19:37:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] arm64: dts: rockchip: add board-aliases for Qnap-TS433
Date: Sun, 21 Jul 2024 19:37:16 +0200
Message-Id: <20240721173723.919961-8-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240721173723.919961-1-heiko@sntech.de>
References: <20240721173723.919961-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the aliases for the internal network interface as well as the
emmc on the board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 69bed01cbe4ed..c05433ca7dda4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -13,6 +13,11 @@ / {
 	model = "Qnap TS-433-4G NAS System 4-Bay";
 	compatible = "qnap,ts433", "rockchip,rk3568";
 
+	aliases {
+		ethernet0 = &gmac0;
+		mmc0 = &sdhci;
+	};
+
 	chosen: chosen {
 		stdout-path = "serial2:115200n8";
 	};
-- 
2.39.2


