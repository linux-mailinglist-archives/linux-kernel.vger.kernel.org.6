Return-Path: <linux-kernel+bounces-252260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF39A9310B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0161C21BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B2318629E;
	Mon, 15 Jul 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYMRuFeb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DC185E57;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033961; cv=none; b=j+MmkK4J+120ZQqcAXxcIJ/Mfgrf7O+395mmrt1vCwnb6qSe5fGcFT2ht2jmicOgJuQCuPg1NgC0n8URt1ysAQfUfX1kBXUQgASqpRC0EoczoXicCNPiU8SoUnyNHihxVp/z+AXfXk0/LctYKpUgyY8w6xm12pNqocQByJA9AJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033961; c=relaxed/simple;
	bh=1X1lMeZGpdzV9mt09bNsIQMlalbtKkMui88g6bFSQE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AbpmEJpu1EzUdsudoIwe/OfnAzC/fwZLxKJZ43pB+JZa4w+fD6CGanCYCgrXsQPxtVbqWSnHe8zFii4TtEn3gnP7FTGa8vJWNCahGulEDGpVhjTArtzQFv+9+UvFFhDpMuLA0PZ2Zm57kaALHzz/3oMFRpa8OKKotjtBGxe1LWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYMRuFeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5037EC4AF0E;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721033961;
	bh=1X1lMeZGpdzV9mt09bNsIQMlalbtKkMui88g6bFSQE0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AYMRuFebTcAyJvTuZVQrD/ZPNQrxp2m05upe0mkLoXPpymA4H2TtHq0zGEjbnpwS+
	 wLZnVDePiWh8BtmkItksSbj5poy2Ti69PXtRO9nqh1v5nqGiosZnquztDiIYzjE0bW
	 M72d6JWMuYpUGg7+yKT2aZKexDjyZsWiUyUYb3fSXZ0X0gp5AUmCLeiyp9bHiiR8Jp
	 K68E5nVmUQEjvRzqy//16d+BQdf0fXk9xs5RbN8TH9JvzeyKC90lYkZwXL6LrkYkNg
	 GKBNL+Sfc4x9WxvrywNXsLuPBDLggfuKDglXzuBPZonpD+FrjjXjcsVwXs/a+LMrA9
	 InV75tv/VOjng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA8EC3DA5D;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/6] Add new Amlogic SoCs info defines.
Date: Mon, 15 Jul 2024 16:59:18 +0800
Message-Id: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAObklGYC/0XMQQrCMBCF4auUWRtJolHjyntIkTSZtgM2I4kUp
 eTuxoK4/B+Pb4GMiTDDuVkg4UyZONbQmwb86OKAgkJt0FLv5VEpkdnfKPYsglT2dOh2AaWFen8
 k7Om1Ute29kj5yem9yrP6rj9E/5FZCSmk6Zw1Vttg3MVNdx7Ibz1P0JZSPuPSe8KiAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721033959; l=1350;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=1X1lMeZGpdzV9mt09bNsIQMlalbtKkMui88g6bFSQE0=;
 b=LFT8ReBhEBQbxL20C4GgGLQv5fFEqrxtwgHaVVGjck5SfooLGn+EnlxWoF2LqJjZBeY7w7PB8
 zCkN97YAq1XAmfJKLwQlgbGGi4ymn/3cEaN4DceJdUmDLLQeZpS4Pbj
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add more Amlogic SoCs info defines, include S4, C3
T7, A4, A5.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Add S4,C3,T7,A4 ao-secure bindings.
- Modify ao_secure node using fallback to meson-gx.
- Link to v1: https://lore.kernel.org/r/20240712-soc_info-v1-0-05ba95929d5a@amlogic.com

---
Xianwei Zhao (6):
      dt-bindings: arm: amlogic: meson-gx-ao-secure: support more SoCs.
      soc: amlogic: meson-gx-socinfo: add new SoCs id
      arm64: dts: amlogic: s4: add ao secure node
      arm64: dts: amlogic: c3: add ao secure node
      arm64: dts: amlogic: t7: add ao secure node
      arm64: dts: amlogic: a4: add ao secure node

 .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml | 16 ++++++++++++----
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi       |  8 ++++++++
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi              |  7 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi              |  8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi                |  8 ++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c                   | 10 ++++++++++
 6 files changed, 53 insertions(+), 4 deletions(-)
---
base-commit: db067bd17c0124228c31c5fdfa29ec65239e692a
change-id: 20240711-soc_info-d01986b3de09

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



