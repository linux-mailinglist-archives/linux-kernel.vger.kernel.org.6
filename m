Return-Path: <linux-kernel+bounces-438831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687E49EA6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C0E283426
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88B2248A1;
	Tue, 10 Dec 2024 04:07:46 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6441C6C;
	Tue, 10 Dec 2024 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803665; cv=none; b=M7owiESAMSRQaKI8Mr6TyMDU9y4kbEhlTyHmD6kl/YdCpAiAa8VjfGk5GM0sR8bM/fmwsMrQU2frwGk9tMcZ0Y0ILXU4S1fr9x/e5jDWzu09MSX3uZK7RQV8TbrbanN/YpovBmXah2rOKA2woSnh5DnVWra2PUmQBCOJZs7ttH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803665; c=relaxed/simple;
	bh=b4gFqxoPZtRye3qNt7TqI3ggrd78s3I4PX+HkztL/qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OivCmiu6PGBp6zzO3a7Ce1LQrbMNneOi5noCZyUe8SaSQsvMtF6U5nkoJKnXPfR7tkr8+uODGqRCkkm2s737RvmLH2qa5iPmzEd8AwFTqyTXx8e4gn/w8p0hNELM+88gkVDNeqFR8fmHmtphfr3jwfM4C0Mq4UEFvYz3vjR9ruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id EB949B4B29B1;
	Tue, 10 Dec 2024 05:07:36 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: E Shattow <e@freeshell.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: starfive: jh7110-common: Use named definition for mmc1 card detect
Date: Mon,  9 Dec 2024 20:06:46 -0800
Message-ID: <20241210040652.164030-1-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use named definition for mmc1 card detect GPIO instead of numeric literal.

Fixes: ac9a37e2d6b63 ("riscv: dts: starfive: introduce a common board dtsi for jh7110 based boards")
Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 48fb5091b817..12a90d38ab31 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -281,7 +281,7 @@ &mmc1 {
 	bus-width = <4>;
 	no-sdio;
 	no-mmc;
-	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&sysgpio GPI_SYS_SDIO1_CD GPIO_ACTIVE_LOW>;
 	disable-wp;
 	cap-sd-highspeed;
 	post-power-on-delay-ms = <200>;

base-commit: 708d55db3edbe2ccf88d94b5f2e2b404bc0ba37c
-- 
2.45.2


