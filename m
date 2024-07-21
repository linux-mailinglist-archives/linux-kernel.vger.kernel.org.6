Return-Path: <linux-kernel+bounces-258273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874749385AF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424CE281387
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8EC16C68B;
	Sun, 21 Jul 2024 17:37:38 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BE168498
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583457; cv=none; b=CRIFaOvZPl0uFipzQyPO+ZoLIS1N0gEWFItyjH7RXTe1Lk/gi3q5w0zQtnsWTDp8AsCu7u6HbQW7eRoCBZkU8cUCdBBc8nbXQEC2b7eReA4oeDwyIUUleJa9pcmzlJcFMPe2oYv1FC4xezy1nrdcKNA2eDmHK9N+c53gsIUQ9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583457; c=relaxed/simple;
	bh=wkINWhHBxJoks9GEekUEFai0to46rsNWQPJ4fRqirYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=czWjLO1tJcLcU5JasG5btirhs8ERN1KBry/QW9H9OBHnjrKzzQp13ShpuSYESgnM7tI3vyG+/AawVQbnJIHYh2vVbHf/azZV97zIjxe/j72kEv0lsHlN42MNl2Aip1w1fRgSSh5wF5+RqhV0rNCbAcmExLHXaAMC9RQOBL9NjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVaV0-00075D-3s; Sun, 21 Jul 2024 19:37:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] arm64: dts: rockchip: enable uart0 on Qnap-TS433
Date: Sun, 21 Jul 2024 19:37:12 +0200
Message-Id: <20240721173723.919961-4-heiko@sntech.de>
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

Uart0 is connected to an MCU on the board that handles system control
like the fan-speed. So far no driver for it is available though.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 0636a08986572..f3ce3cc4598db 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -102,6 +102,10 @@ &sdhci {
 	status = "okay";
 };
 
+&uart0 {
+	status = "okay";
+};
+
 /*
  * Pins available on CN3 connector at TTL voltage level (3V3).
  * ,_  _.
-- 
2.39.2


