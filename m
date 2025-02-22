Return-Path: <linux-kernel+bounces-527232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD7A408B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D239D17EA7F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652013B29B;
	Sat, 22 Feb 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn/XfAF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78A7DA93;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231265; cv=none; b=reCaMeA6pOxj2DcPhpzKSo42YGxtnRUP/X6oSxPe5Qs6HuxYimfh8IYUBQJ+TRaU9YDPmqtnewsFp1BxcVtR5gs2bx3SHHsIv8EcqZZeC+wzdrJaU5WCi62N9T0wBjIGC3p6JDeiVz5fSa+ctIy6fKq4/AinPwWjtRiAgP/9ub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231265; c=relaxed/simple;
	bh=lsXh6HepfnMc+Q/WXCkVqPl5KJ3TC9cVI9pNgzO5tzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWOP7wc6O5E/fkEQeOI4HnfNwbn/DYRYNo7E9tgfIWAlWQgPpcLJjdqVVfajoBhha/HNuVHYYCT8Xrw5PCyiuDjemIhE0Pvfwlx5xHchwwhHm7qzxKr394Z45F4CHmhVS4ACKZxCbiA/99oelmm+WnO9EDQSNiW41VsmXT0X4Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sn/XfAF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57328C4CEE7;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740231264;
	bh=lsXh6HepfnMc+Q/WXCkVqPl5KJ3TC9cVI9pNgzO5tzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sn/XfAF1WWc6JLdoK1USOIIi2YFxmwVcR0+Af3DRone6dZk/0V4bBx8zRMRQpsMks
	 41CGA2uhlgg8XGLAVSx7Lw8JDgPSuZlo90lCvqJ5SK4l+mrzqQ07KMdm5HvD15Q8Lx
	 aBV3Ybrlv7Yh9Stuad9/6j+2w1uT2AVWSyq1vpFQ4Svfpc4nGpVAnXzo6OxAoHns11
	 Jth+F6L9S/pKapR+INq9iVIWa2u6LqbelCKUtxp8ONzXxvLmJeWs+jpD5xT26699PQ
	 P+5bYt4DPtsaPIOvkzWQ7Ic0Aov/HuNmyONWL0bjyY0imVnweyNL8whkeOs+QHRg4p
	 L/UJNRqhU27lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CDAC021B8;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maud_spierings.hotmail.com@kernel.org>
Date: Sat, 22 Feb 2025 14:34:16 +0100
Subject: [PATCH v2 2/2] riscv: dts: starfive: fml13v01: increase eMMC bus
 speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-fml13v01_emmc_speed-v2-2-3ffc5b1f5663@hotmail.com>
References: <20250222-fml13v01_emmc_speed-v2-0-3ffc5b1f5663@hotmail.com>
In-Reply-To: <20250222-fml13v01_emmc_speed-v2-0-3ffc5b1f5663@hotmail.com>
To: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740231263; l=1059;
 i=maud_spierings@hotmail.com; s=20250222; h=from:subject:message-id;
 bh=6oKEZmpEgAskDT6drBgPswULe7sk6pmiFucVopPkPkQ=;
 b=HISq9mxkhULqrOz8w55mew/rcWCHUqglVyJ7IgxAcKmWD/2YQN766hisLl/aobRLIwGdeNfp3
 sjHDAQxsHuyAQDKnhr3zIIoSHBveLa/iQIAvP6iCeHcVt98HumFzn2c
X-Developer-Key: i=maud_spierings@hotmail.com; a=ed25519;
 pk=Z2m97WkDS9Sm3JnKpIpH4JwQtLm2Yw8oFCNw6uMBqb8=
X-Endpoint-Received: by B4 Relay for maud_spierings@hotmail.com/20250222
 with auth_id=346
X-Original-From: Maud Spierings <maud_spierings@hotmail.com>
Reply-To: maud_spierings@hotmail.com

From: Maud Spierings <maud_spierings@hotmail.com>

The assigned clock speed of 50 MHz is limitting this interface which is
SDIO 5.0 capable. Sadly at 200MHz it fails to mount an eMMC drive,
150MHz (really 132 MHz) is the highest it was able to get.

This improves the seq read/write performance by 2x~

Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
---
 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
index 8d9ce8b69a71be78ca57618ae842c9f415648450..63b539bedd63d39dbe2096f85aaf70ba6ab64d29 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
@@ -11,6 +11,10 @@ / {
 	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
 };
 
+&mmc0 {
+	assigned-clock-rates = <150000000>;
+};
+
 &pcie1 {
 	perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
 	phys = <&pciephy1>;

-- 
2.48.1



