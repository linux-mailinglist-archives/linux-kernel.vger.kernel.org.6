Return-Path: <linux-kernel+bounces-250257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5192F5C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98191B21691
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECB13DDDD;
	Fri, 12 Jul 2024 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNQNOJfd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0513D538;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767290; cv=none; b=AzPqZXTBjnZWow/iIKOmOryUg089XMUO8Vsj7cNkQ8R0ZeukX/B+YBIcdiU7MnlM0pFwwQ6OXVgxuws+coXJ+eHhnYWAVqwrh0Fkk1Rm/zMCsBDm1DGYypm95mSQl5wKa6G5A6erXBMeX5jmudLbawE//CREVj9r8TPRjCx/Oz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767290; c=relaxed/simple;
	bh=mQvjWlhdUJODo7htZQ1+hcdFam/twUz6WZBVeqfHTXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAuL8fjmCZKF9ctw5E0WLm+dCowX8dzE9X5MIgOxwABLA1MeEv1FdwqRIAEGWSsi2mFHqLkRdSOLk/wsdpMD8ASagN2oOBKrH9nL2bi790NHXwwKItXPlzzg1VG0MlMQNSQpLS6PzVuiZT/yNHruiD+9K2+/UTjmZoU8SudF7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNQNOJfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19AAAC4AF07;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767290;
	bh=mQvjWlhdUJODo7htZQ1+hcdFam/twUz6WZBVeqfHTXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gNQNOJfdeRMDorQD77FQu6qn3j0KMvbEqq6iCAXtINIuQz0f4EJLIcXzFsnKJPeLh
	 KKR2tRFWfNHyRFLfvrFZlPSeS7LfF6AuuRlhtSYio7U1Yv9i/8b/IlyW0ZSnkARHgM
	 bPu5Km/JbVXVYiwPRABq1aIUJQ4lW1d1GcergPYfPZmpcq3GMDZOdFU77iomxpZxLI
	 qcB9s7NzGddeBJwKFsoLm0ZPmoC4Den8xvr+8Y8DegVNpPtyETNS0zJQBTjfFPJAM8
	 P0IE6pcUbotSCf4JRxnAGi2zlp9ZREg16MJdIHw549DmnE2zV4wQ4KrqIie1pZsxC5
	 2q3T/U3bfgl5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07781C3DA4D;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 12 Jul 2024 14:54:46 +0800
Subject: [PATCH 1/5] soc: amlogic: meson-gx-socinfo: add new SoCs id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-soc_info-v1-1-05ba95929d5a@amlogic.com>
References: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
In-Reply-To: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720767287; l=1125;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=nnMjotXuHyUIt8Kx/nCa5XJH4NAVjChyKcIYDRAZ0Ws=;
 b=K2wHE0oUM7+bxhhudhE+NS3cqsySKqwMYTRXO3u1/826jSaFfDzabCLBVDD2ggy/RhSsImpVP
 eUd8thcgohACM1bc6py1qK9wuxEz7fF/aezCnHlp9kaUm0E+YZsAAVQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add new definition for Amlogi SoCs, include S4, C3, T7, A4, A5.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 8809a948201a..7549f1644e5e 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -41,6 +41,11 @@ static const struct meson_gx_soc_id {
 	{ "G12B", 0x29 },
 	{ "SM1", 0x2b },
 	{ "A1", 0x2c },
+	{ "T7", 0x36 },
+	{ "S4", 0x37 },
+	{ "A5", 0x3c },
+	{ "C3", 0x3d },
+	{ "A4", 0x40 },
 };
 
 static const struct meson_gx_package_id {
@@ -76,6 +81,11 @@ static const struct meson_gx_package_id {
 	{ "S905X3", 0x2b, 0x10, 0x3f },
 	{ "S905D3", 0x2b, 0x30, 0x3f },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
+	{ "S805X2", 0x37, 0x2, 0xf },
+	{ "C308L", 0x3d, 0x1, 0xf },
+	{ "A311D2", 0x36, 0x1, 0xf },
+	{ "A113X2", 0x3c, 0x1, 0xf },
+	{ "A113L2", 0x40, 0x1, 0xf },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)

-- 
2.37.1



