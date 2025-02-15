Return-Path: <linux-kernel+bounces-516118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02EA36D1A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF377A2430
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5699D19E994;
	Sat, 15 Feb 2025 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFJ5ddGr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98519049B;
	Sat, 15 Feb 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612810; cv=none; b=DjqXx3imFZ7VZJAwKYdWcyTLn86RgENsWwHB+6IdiKQsZ+afzKMvMNUkBtthmnyh5T61MQvulHFAgip2s8akvgzg6SmWh3S6nKt+qYTsHw6LxUEvj/47anlwo4cmaGhxrpygyuZSyqPlesOvAO/iXNIY1LrJBmmqk/Rc1vbNtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612810; c=relaxed/simple;
	bh=JaoDCVqlef7TKkto6nX2vIsKnIPc62DALi/qmnmAW1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ImMi9RD8c6aLFNKMYPqtTUZGvDAItS6X0XhpEs2nPCpQP9w6iD7bkwJXQJoVau5hm2Ns9shOjkygyaXpSfnGOLBXvUyypTAtuJ/qPDATSQVa+gOasva0O+YW/dkpngIUey1wyo6exeI8h0Gc2zVPlFlz3ufNy8jrLrE7Iv3vg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFJ5ddGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18F2BC4CEDF;
	Sat, 15 Feb 2025 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739612810;
	bh=JaoDCVqlef7TKkto6nX2vIsKnIPc62DALi/qmnmAW1o=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CFJ5ddGra9P0ybP1ZswNAj7bp8nNO4qrNrmggV1Vs20hsu5fNA9UtTGvnSTH2htcb
	 NIVOgVBJttGUlkPgbdQBguk+tTdcep6BP34ciTQD09F949Vs7X7P3yfNK+VSYUvqks
	 yATK6zVfUywbxPi99pg1f0jJHwSyYwEjBVhFBe60dAME/nnQTPkMYvGNFYhsJ1VYoB
	 aQIfLh0FYfQkUDGjJRMuX4kYHyLnFLfq3q4+gn/rw+2KjXiyW29Js0NwhwwYFCvuDA
	 +Es1wMKQTsYDjkVPq668wsBlQVy6iRMd63SUwqle0Sbbp3dQ8ED9tjnD17sO2kSQGd
	 LU4GHUajbVKJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F266BC021A0;
	Sat, 15 Feb 2025 09:46:49 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maud_spierings.hotmail.com@kernel.org>
Date: Sat, 15 Feb 2025 10:46:47 +0100
Subject: [PATCH] riscv: dts: starfive: fml13v01: increase eMMC bus speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-fml13v01_emmc_speed-v1-1-e3bd224ae0e8@hotmail.com>
X-B4-Tracking: v=1; b=H4sIAIZisGcC/x3MTQqAIBBA4avErBMc0/6uEhGVUw1kiUIE0d2Tl
 t/ivQciBaYIbfZAoIsjn0cC5hnM23isJNgmg5LKSIVGLG7H4pI4kHPzED2RFWVVo5psM2mpIZU
 +0ML3f+369/0AZumOPWUAAAA=
X-Change-ID: 20250215-fml13v01_emmc_speed-67812bd9b404
To: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612809; l=1547;
 i=maud_spierings@hotmail.com; s=20241110; h=from:subject:message-id;
 bh=Qt3zVrtNxWWmhv3zol8ojyDROGvggaowhiJ4UV1nnpE=;
 b=ABsIVsrA7IzSOMBc4BWZIT3O7KPYMp7Yc8IZ6p9dAl9a6kVX4JD1KwgZJwIhwFCZ5hE8xVmRr
 dSiZK0HOv4SBEbNstLQNVK3+ycPP0TrdD42NBGv3rCQEFrVCIdDw6Ni
X-Developer-Key: i=maud_spierings@hotmail.com; a=ed25519;
 pk=CeFKVnZvRfX2QjB1DpdiAe2N+MEjwLEB9Yhx/OAcxRc=
X-Endpoint-Received: by B4 Relay for maud_spierings@hotmail.com/20241110
 with auth_id=273
X-Original-From: Maud Spierings <maud_spierings@hotmail.com>
Reply-To: maud_spierings@hotmail.com

From: Maud Spierings <maud_spierings@hotmail.com>

The assigned clock speed of 50 MHz is and max-frequency of 100MHz are
limitting this interface which is SDIO 5.0 capable. Sadly at 200MHz it
fails to mount an eMMC drive, 150MHz (really 132 MHz) is the highest it
was able to get.

This improves the seq read/write performance by 2x~

Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
---
I put this in this specific dts instead of the common one as I cannot
test if other boards are also able to handle these speeds.

This patch depends on [1]

[1]: https://lore.kernel.org/all/20250207093618.126636-1-sandie.cao@deepcomputing.io/
---
 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
index 8d9ce8b69a71be78ca57618ae842c9f415648450..1f4bac9f89463a6af844b8f1743bdfa659e612ab 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
@@ -11,6 +11,11 @@ / {
 	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
 };
 
+&mmc0 {
+	max-frequency = <200000000>;
+	assigned-clock-rates = <150000000>;
+};
+
 &pcie1 {
 	perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
 	phys = <&pciephy1>;

---
base-commit: 0bc08ec1ff5a32449d2b04704173dbf3ebd6b014
change-id: 20250215-fml13v01_emmc_speed-67812bd9b404

Best regards,
-- 
Maud Spierings <maud_spierings@hotmail.com>



