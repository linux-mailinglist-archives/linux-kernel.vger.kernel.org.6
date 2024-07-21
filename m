Return-Path: <linux-kernel+bounces-258281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ECB9385B7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938BD281D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121ED16B720;
	Sun, 21 Jul 2024 17:39:53 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB516A92B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583592; cv=none; b=on7b+oUK5EWLhw/cNli8m9aICcjdX++7iY4dII/Osk67r92u6JlZqsRzeSFR3GJMJ4F9HB3lC8XUrGBad9nG6M+j1wV8mKeOMgkV3/6J4MzNad/7GfDXbd4Jk9Q9NUi4dvKAiEt57Hw+cKhzN0lhKRH9+pN3iJ1fSmScClXVaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583592; c=relaxed/simple;
	bh=1GAu6fEt+bsasuQ15PRVAVglsoINnZo00xZ6FGY1mPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYUAu9eg4tXFth/MMbu4XEaXfEgSTyPVIU58WVB/RR8yke+F/e35rpF8mgyqqGcpRlJINM9EtROfC2JRpoy6PFkT2NwTEMJei6hn+RCzpWiosWtOZRY12NmfHiYL8whaz2f8caPAAgg5fiKa9jiaes6CJsFN7YvmSiFJtZ4TjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVaV3-00075D-Bo; Sun, 21 Jul 2024 19:37:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433
Date: Sun, 21 Jul 2024 19:37:23 +0200
Message-Id: <20240721173723.919961-15-heiko@sntech.de>
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

Add the two supplies for the pmu-io-domains that are defined in the
vendor devicetree for the TS433.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 913d28cee8e9e..4213c351faf5d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -528,6 +528,11 @@ vcc5v0_otg_en: vcc5v0-otg-en {
 	};
 };
 
+&pmu_io_domains {
+	vccio4-supply = <&vcc_1v8>;
+	vccio6-supply = <&vcc_1v8>;
+};
+
 &sata1 {
 	status = "okay";
 };
-- 
2.39.2


