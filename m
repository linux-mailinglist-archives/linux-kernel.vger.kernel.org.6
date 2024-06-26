Return-Path: <linux-kernel+bounces-231436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C819198B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7BD2857CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FBF192B63;
	Wed, 26 Jun 2024 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbCY+Gjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769B6E5FD;
	Wed, 26 Jun 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432068; cv=none; b=qfDVHE2YSvUNweI4vwGwfhBaTMftuI8FETEsHrZOU46b78CjfWdmSEuSbOOdXHS3/GHaGOFtF73T2qMQJHwsMZpnmTv2WM4EXsWrpr8olYSQ2iCvA4sTbvKV8I64Yl79k7Voymg1Smi3wrkdlYYnUu0fbzGdgX20pqFA86034yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432068; c=relaxed/simple;
	bh=glv0zhkfQDHpCeQyICpkcWEDMR/NtMSV3UI7HiOKrfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+VWiLabYa5XuDJ+uK7xuHwcrx4dKNpj/h5BTzKvFIpUBOqY/G3RXHCxMql6rcNPBG7fh7jPmMCTjVt7Ek/QF8PLFPdL5u/QOUaS241Ud5lgHkVDBz01ryy83Yw5oZVu3guNTDlWSftC0dUNWCJwqpIJcpYmhPU1qRVDpolpTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbCY+Gjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5F4C116B1;
	Wed, 26 Jun 2024 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432067;
	bh=glv0zhkfQDHpCeQyICpkcWEDMR/NtMSV3UI7HiOKrfA=;
	h=From:To:Cc:Subject:Date:From;
	b=mbCY+GjvPYn9u0y4yRIUYiIGnB1TbBPxdGuQgl3xW85bM1txvfRWY5ETsSLS+uQV4
	 t0wh5sANCRt5tWT8ESpmZz+NtYdH15jK4VbZ/xUiOuTMeUzdyKUUJtAYcEUMZfVFzk
	 VEyN73fmH9Zlv4VP3yeINy16qROxKC6x3/il46pP0i6xrZIGz6HrY90sts8NaxFB5I
	 I4OACUF78LXmD3iCxh6JKKoPfDHzbASonFfTprtZAUmB+nYChLouKwi9ZKQrrRrZ9w
	 KjAVfq95pvK2b1vEqATJiACDHm2TJwtlls+adCizoqDNfE844m5AWb2NTYjSZJXHlJ
	 uiroLScRaPgUQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: starfive: add pcie1 on the star64
Date: Wed, 26 Jun 2024 21:00:57 +0100
Message-ID: <20240626-traverse-excitable-a1d9be38a9da@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=fR3lsSSUrtI77PnMbXDKn8XXJOG9pY1FI0PcA96yBWE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGk1xVUuAhbKUYedL+iqbUvj8ps6rW7R/ukT/URCszZ/v /n5ZVFHRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbCEMbwi1kq7Jddg4v+h32T tk8R1Nq5yo+Lb7pd2an5U2OC2xhjTzIy/J+ftu3un2tqdyU8rtofLd/Vz3bsyon98/pkvy7w6vr Jxg4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

It was reported to me that the star64 actually /does/ have an exposed
PCIe port, despite the commit message there. In my original conversation
with Minda, they said that pcie1 was available there and pcie0 was not,
but the v2 patch didn't actually add pcie1 on the star64.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I think I'll just squash this in and fixup the commit message, since the
patch is still at the top of my branch.

CC: Minda Chen <minda.chen@starfivetech.com>
CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>,
CC: Emil Renner Berthing <emil.renner.berthing@canonical.com
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
---
 arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index 2d41f18e0359..b720cdd15ed6 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -39,6 +39,10 @@ phy1: ethernet-phy@1 {
 	};
 };
 
+&pcie1 {
+	status = "okay";
+};
+
 &phy0 {
 	rx-internal-delay-ps = <1900>;
 	tx-internal-delay-ps = <1500>;
-- 
2.43.0


