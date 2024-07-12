Return-Path: <linux-kernel+bounces-250259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA892F5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC320B224B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5C313B2A8;
	Fri, 12 Jul 2024 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2bMaqZz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B613D601;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767290; cv=none; b=oXCoS+lSl3rVZdeqXrAjGWfsI2tnuSGO4ufMJxXF0uJD/roWdoVpnumaGe1nyH/cOAUALhomRkhLnV+OMe9l7G/wDhWJ2dTJ84DZO5f0yht4MQX+AeA87qShpWMZomdUYJgJZxRcW4TjbA8GTnSlOPqUGXHeOa4DZ2EClb3Whcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767290; c=relaxed/simple;
	bh=m+iNwr8XqQmoN6/h7bndxFBce7494wo4m/jNNEKTkOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crwFLWhgJdP5y/0sEXC2U/jxtQp0wNwPb8l1inV0zsyejJNjxWdZ8roVJ7cXiOyv6fcDqFjP1TPtsSBZZMEZWSisw/8JFUP5QzoWes9xv4vYP4ZeXUx6dIT/Vq5CHUemrdwpxQmUCvOGlIqgBvMBXi5U7zDvVhWuaSibxiQNJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2bMaqZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26D2CC4AF09;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767290;
	bh=m+iNwr8XqQmoN6/h7bndxFBce7494wo4m/jNNEKTkOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T2bMaqZzE+GYrU3mt4h2mIOiMALuUKy11oELyMh+d20A/6rKVkTlhINgpKOGoeeNY
	 nFD3nFkQuDaQSzjOVgHM0XZft/uO8hUY8h1xH+VoPkvmNMSsLzPj/WbPa/YFQOqE3B
	 FP7V+Ozax/WFHxy9m2Oy5aKEqPsROtUND4UfzWQbgNqmVzbcsI1twaIi8jM3rnK79U
	 PUzFlPXZf2M2JtkqqpzON+qH1USPvK2KuZY6EUyR4ddXNSW0+UmOHrVZxKW25Z+m88
	 EZlN2qDGj+QsAnk/lTFaGl0Be/lzIgeof8NqBySHGAV+oDTWFmjwh4dc1sp2cSl6eQ
	 KdAVEI6CcdKpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A9EC3DA45;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 12 Jul 2024 14:54:47 +0800
Subject: [PATCH 2/5] arm64: dts: amlogic: s4: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-soc_info-v1-2-05ba95929d5a@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720767288; l=1031;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=7PP3wpwyeNhRjy2GgIapC6CYSMcoSRh5nUct3QlTnCc=;
 b=Cf3A1+/cFFFp6d+el5Zs82tP9+WFpxClaZdHoC/jfpz6Nwl3TqxqbR8o6Wn6i9+U3q41LkPzo
 GpFCBhv0PSIByJrGkOSndt14QLD2Aq4LtQQhF9+OR7/RWYyhepLgYDQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add node for board info registers, which allows getting SoC family and
board revision.

For example, with MESON_GX_SOCINFO config enabled we can get the
following information for board with Amlogic S4 SoC:
soc soc0: Amlogic S4 (S805X2) Revision 37:a (2:1) Detecte

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index c11c947fa18c..316905ec191c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -763,6 +763,12 @@ reset: reset-controller@2000 {
 				#reset-cells = <1>;
 			};
 
+			sec_ao: ao-secure@10220 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x10220 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
 			ir: ir@84040 {
 				compatible = "amlogic,meson-s4-ir";
 				reg = <0x0 0x84040 0x0 0x30>;

-- 
2.37.1



