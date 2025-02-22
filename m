Return-Path: <linux-kernel+bounces-527233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F4A408B9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B638705138
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863F013AD38;
	Sat, 22 Feb 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG0vd4TP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75278F59;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231265; cv=none; b=b8OwIvGqHFoH6F9speRIq037bF2ElZIQ41Qr3nijUYg1I24TqgZNKbqrqg2to3MlrXAYaiHUQL2xE+9Or1xrVXG0tyxS81UV1+PjiLc0qKVGS4b4gLniZs5ASMVjSer1FSDF1I63Lu6mN/H7eF37w26+hTgU7BCVv1Wzv/1YSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231265; c=relaxed/simple;
	bh=uJsu7Z3eUyAeqRsSEQzMEzclfBBrgVv7SPl+u/ez+H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Psl/OcAhzxat/Ka+yMRWXzbq7iz1LVuIezcfJ+Ay6U9wRV6zY0y7jb1HFAnIDMjPSFKsetsanJXgKXNCa1odaCe0/DqKLCd0PmS17VDT2f1T4uMVwZ0bwSUV3L5GGmrrbYc/K9tEpqRdG0jp3xyGrc50fm//BY59F0oXb24aXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG0vd4TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 403EAC4CEE6;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740231264;
	bh=uJsu7Z3eUyAeqRsSEQzMEzclfBBrgVv7SPl+u/ez+H4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FG0vd4TPsQ5uc5DbIDo/fXgZHntsMOfqtC5L6IkskdtBACdYK18mYFz6HJFIXGC/T
	 DTWhxqBjD3DYVJCaLrX3R6xhpQhb9HoG8C4Iw3rs9AgNVzqU20lcqWRb8wXYd/rKEz
	 v8gVmMVwbakB7meBa1rH49FISMHGAhs8xI7WBD/p4naQwm/toYiPjQgDNQ6pg4tF3D
	 2b+miPwE4GxEM2+y8Nb7M9ltzRiVXri7ACpYZOL2jO4o3hql8cEJidhz9VI4sZvfG7
	 oU844Qus8zXj4TRXqtih4ziJefnLcoDGY+lPjKUXrwdkcjMYCipG+pE3yxtVWM621N
	 ZkvNOvifK2s6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B401C021B6;
	Sat, 22 Feb 2025 13:34:24 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maud_spierings.hotmail.com@kernel.org>
Date: Sat, 22 Feb 2025 14:34:15 +0100
Subject: [PATCH v2 1/2] riscv: dts: starfive: jh7110-common: increase mmc0
 max-frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-fml13v01_emmc_speed-v2-1-3ffc5b1f5663@hotmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740231263; l=940;
 i=maud_spierings@hotmail.com; s=20250222; h=from:subject:message-id;
 bh=9gpWZSvQty4+e5gTi1J7LPpp/QLLJlyJMT9QPxYPoKE=;
 b=rQTRH8W8l+k+6KB0J0uKhxBq/QXMk1rJFTrbIikh0K5xR2A2el+LTzrFxUY/2eLhWxsKKKjOe
 zpIVYF513UsARWE/+kqYcS0q6813bnBnPMX+/60ALoEeN0RWuHr3BK/
X-Developer-Key: i=maud_spierings@hotmail.com; a=ed25519;
 pk=Z2m97WkDS9Sm3JnKpIpH4JwQtLm2Yw8oFCNw6uMBqb8=
X-Endpoint-Received: by B4 Relay for maud_spierings@hotmail.com/20250222
 with auth_id=346
X-Original-From: Maud Spierings <maud_spierings@hotmail.com>
Reply-To: maud_spierings@hotmail.com

From: Maud Spierings <maud_spierings@hotmail.com>

This sdio interface is capable of more than 100 MHz as already indicated
by the cap_hs200-1_8v attribute. Increase the max-frequency to 200 MHz
so users of this dtsi can increase their SDIO bus speed.

Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index dd2eefc295e5c8b568a02104ec2189e66b378904..19ca8dc24617c2ad565a4a9b2d9af9bd9491f22e 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -258,7 +258,7 @@ &i2c6 {
 };
 
 &mmc0 {
-	max-frequency = <100000000>;
+	max-frequency = <200000000>;
 	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
 	assigned-clock-rates = <50000000>;
 	bus-width = <8>;

-- 
2.48.1



