Return-Path: <linux-kernel+bounces-293676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F261995830C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAE21F21964
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2218E020;
	Tue, 20 Aug 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrSnKTaC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66918C007;
	Tue, 20 Aug 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146918; cv=none; b=NIngXCf4U8591KpxmFfr2Ohx+SRIgWwHElKPvbHGKgt496OqgNkiFnntDFHISbclmVx0ABZXSI4ySgKuAz1HgJAojbftLBrjnMRxgg62sx6MySRmOY6r4DNQMCVuuJCwyVkvHVD3mw5It/n1SMOhnC3VbRQ+WjImq0xrBjdb6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146918; c=relaxed/simple;
	bh=cS20O9LXg3AxB+iOazOUR7zUszo+e+eKg5CJ/BJIyYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jhbZVdhQCU8ztPJzjbmQpNv7zl1D+3rfv4VKxYJXeXd7RFiQu5PNfWqwmKVKZtamPaGR9SIorQXIx1GzqVYf5IQc3/VRM7FRRRh7RmQOPtt1cRRoGHvHPxVCoVbA2w/N7aUQhqPY2PzZafLL/BOq/1YsyeyymIlW7+XyMdV5XT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrSnKTaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 224C8C4AF10;
	Tue, 20 Aug 2024 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724146918;
	bh=cS20O9LXg3AxB+iOazOUR7zUszo+e+eKg5CJ/BJIyYs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PrSnKTaCGokWJ+9ot5LjVydsVuSn/k07HAcQoLftiADwT4RVBwcvD9QGP5cksnf2p
	 ycIdCBCc5rSTOJC2nfIFPRWVhD0kVyT62zNzaeAKRRZBJosVynDtHe3SqVQxpMowZa
	 e9RxbBA5AkKKHHQh4E5Ergfp4jT7O4zJtDoHyEJToT8/sasJpv8qHkfuGk5QIuEwIy
	 LsyNiMGLJEK/r8NgggJe8MfH5g+3gpyjxhfNdxXUrWVCIv+lP8OqF3IAyOtl8jOVkY
	 IX90E/xUAgiEh6ke9/4MkxmkiShMLhRTLa2c/Vwv+80Wz59SqFLEJzjGgRi8ga/UY9
	 lLkWuNIM+oXPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B843C3DA4A;
	Tue, 20 Aug 2024 09:41:58 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] add some node for amlogic c3
Date: Tue, 20 Aug 2024 17:41:55 +0800
Message-Id: <20240820-c3_add_node-v2-0-8fd3f06b7bce@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONkxGYC/23MSwrCMBSF4a2UOzaSFzU6ch9SSkhu2ws2KYkEp
 WTvxo4d/gfOt0PGRJjh1u2QsFCmGFrIUwdusWFGRr41SC41N7xnTo3W+zFEj0xLbtXlKswkDLT
 HlnCi96E9htYL5VdMnwMv4rf+d4pgnDnuUQulRa/k3a7POJM7u7jCUGv9AiR7nACoAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724146916; l=1180;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=cS20O9LXg3AxB+iOazOUR7zUszo+e+eKg5CJ/BJIyYs=;
 b=dEY14KH7ypUWXvY00gpy9k1dyt91sftLPhTyXn/YCkHQkpRRd7iQ3NoQZlsiNGwHgCjzBMFMa
 qxe+0khm288APEdCK7iN2riSD4Go5XCsXZ6NiEtR5pJ0cMB6Pu2CfH+
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add some node for board AW409 and support board C308l AW419.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
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
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 487 ++++++++++++++++++++-
 5 files changed, 987 insertions(+), 3 deletions(-)
---
base-commit: bfe05c592279e509a67c3ae305517859f3f5a58c
change-id: 20240806-c3_add_node-420a37918f18

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



