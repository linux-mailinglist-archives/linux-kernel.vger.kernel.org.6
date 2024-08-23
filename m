Return-Path: <linux-kernel+bounces-298161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D691995C346
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93949284A12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478D9381D4;
	Fri, 23 Aug 2024 02:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoLIvhjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43C27269;
	Fri, 23 Aug 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380160; cv=none; b=TwoiieTVBAenhZPhOUe7F5WyLDbs1CAyrNCFYJwHUUjAHZIXQqrbnWBEOWZ0cRSFaWtura4+T6Rs7obOi8Oq3xB1BqURvuNsqRq9mydpJOqgfchZYSSCiKBfMQQIVUCh7QSjPFjUVauwDXwmyB//FODHG3IH9T3NX8lCMBvntnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380160; c=relaxed/simple;
	bh=YS7E0HAr61srZxZYh8jsHirXK/krzpEqZNEfQ+EuQlw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qUokfAKl9j6EjtWwGm1tEisdrBnDOzdvwwucsZjCGeaggp+R9giLZAaHKFVakJsCJsauGbDgk7O08249zIqkOwy5CIA75B78wLIlcukntodwfZhMVXdhUIZPbnaOrjdbYJtjgorbjDfXyBZvCfx5TXgQv+R1wu4BmaRoE3vpgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoLIvhjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0074AC4AF09;
	Fri, 23 Aug 2024 02:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724380160;
	bh=YS7E0HAr61srZxZYh8jsHirXK/krzpEqZNEfQ+EuQlw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VoLIvhjllRXlyVr3KxLyuKf+1QS14zzx3Dl03Zq1QPLpDlB81yNam5QbN8bMlkxlR
	 8DYnT5DxC4tKUWW0sodL4Yl8Tat+K9rZrEJzUhVcTWNQke4imJeQwarlEQY6WG0xHW
	 mfVDy5nvlSYGW3e0QRF8IyNKqeJy90rsJw6Qr5guVKCLak+2gukG/3eoO5z9GVSQBT
	 kuXnpP7hJSjyB2v0gwtu8q0hfyPCTvAvPpKAn8PL2SI4onJLVVMM7ppUdRupGVQe2P
	 t2BRDKjiJOSd/NvfIrt9Qerv7abW7KLi0VYd1NC/4kzivTBnaf3UQ0Oj7dNCVku4Cf
	 VsPhUSbpVMh1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD482C5321E;
	Fri, 23 Aug 2024 02:29:19 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/3] add some node for amlogic c3
Date: Fri, 23 Aug 2024 10:29:16 +0800
Message-Id: <20240823-c3_add_node-v3-0-3648376037f4@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP3zx2YC/23MSwqDMBSF4a1Ixk25eaBpR91HKRKTGw1UI0kJL
 eLeGx1V6PAc+P6FJIweE7lWC4mYffJhKkOcKmIGPfVIvS2bcOASFNTUiFZb207BIpUctGguTDm
 mSBFzROffe+3+KHvw6RXiZ49ntr3/O5lRoAYsSiYkqwW/6fEZem/OJoxkK2X+ozkcNS9aOSsc1
 F3TGTzqdV2/WH4rQOYAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724380157; l=1332;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=YS7E0HAr61srZxZYh8jsHirXK/krzpEqZNEfQ+EuQlw=;
 b=rJ1KyhYO+6cuH76Vvojb68o3/JNzMHApeeDi7nPitNh/mOklbsz0OpsV++GEcrvtTIs36A1jz
 J4dHiQjt7uXAiCCNUw56VBIMjgNSeCPwn4M9rsQFGpyiFkcaNUAzf6p
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add some node for board AW409 and support board C308l AW419.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v3:
- Change clkc_periphs node to the first.
- Link to v2: https://lore.kernel.org/r/20240820-c3_add_node-v2-0-8fd3f06b7bce@amlogic.com

Changes in v2:
- Delete unused sdio node in board level dts.
- Add the description of modifying the binding in commit msg.
- Add the reason why some node property fileds place at board level in commit msg.
- Link to v1: https://lore.kernel.org/r/20240806-c3_add_node-v1-0-c0de41341632@amlogic.com

---
Xianwei Zhao (3):
      dt-bindings: clock: fix C3 PLL input parameter
      arm64: dts: amlogic: add some device nodes for C3
      arm64: dts: amlogic: add C3 AW419 board

 .../bindings/clock/amlogic,c3-pll-clkc.yaml        |   7 +-
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/amlogic-c3-c302x-aw409.dts    | 233 ++++++++++
 .../boot/dts/amlogic/amlogic-c3-c308l-aw419.dts    | 262 +++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 488 ++++++++++++++++++++-
 5 files changed, 988 insertions(+), 3 deletions(-)
---
base-commit: 7a5d2ce79d1fc8535a6f10e51011ae9671bd86e8
change-id: 20240806-c3_add_node-420a37918f18

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



