Return-Path: <linux-kernel+bounces-258277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4F9385B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533DC2818F3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEE316CD00;
	Sun, 21 Jul 2024 17:37:39 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600A16C680
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583459; cv=none; b=Q20K70lN+Id+5WqR9P/GlQMtWOUA9ZdRVEvJDnCQ5YM6BVyJbtffBZOEOoBzhK4Dt1jKhN+ZnKaR9l6XNepEPTfpwV/MouWDKs7B6RYZA49SkEmPE+PEpJd1CsuLfjA2JSClyU8ugG+eSB0Hxf/HhX1o2UoRVnnADFIhXBtCvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583459; c=relaxed/simple;
	bh=lhFpPEQHjtznLKRbtE+WR30/61KVROsOMeLxocnt+1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUqEFVyEV5cY8SvKxyaf1K2s9PdUjvghtCbEaFqeeV37IbGBMxYAnWDNwdJt0V32Zsrq1ka3bknqcNaiQb3m9D6KB4yRfqvl7vnTd9X76gK6qYgMDmucrSXQqXv8/d63ZSC9J43+qC+xfx1cMjdAy6U5gqrlnNtR+USTQCnW7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVaV1-00075D-SV; Sun, 21 Jul 2024 19:37:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
Date: Sun, 21 Jul 2024 19:37:18 +0200
Message-Id: <20240721173723.919961-10-heiko@sntech.de>
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

Enable the tsadc node to allow for temperature measurements of the soc.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index d36467c2baf02..02fa46beb6371 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -243,6 +243,12 @@ &sdhci {
 	status = "okay";
 };
 
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.39.2


