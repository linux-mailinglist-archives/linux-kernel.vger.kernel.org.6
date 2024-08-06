Return-Path: <linux-kernel+bounces-275980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630AC948CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959C51C235A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C571BF323;
	Tue,  6 Aug 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3z0xJFV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAF1BE248;
	Tue,  6 Aug 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722940037; cv=none; b=a9PNPOkobm3nwQgruQPlSzcdYzN6KJ5yINeREAG5MT+VvxuPbZzUT2H+2hvt2w/GFH/NvZUAr84R2tlPVBmFdBQ6zLMuO61+t4/jg4FyVb2UQq5RVOBJTVrN9dYvjQnE6eXnaHqxg0/cqealL0a3aywHITnsW3myiAVYTvXZwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722940037; c=relaxed/simple;
	bh=tnBvT/w43thSvlJ/YUxyz/XqxFCcr1JN1U9GgK3fKE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IFO8l9GDgs9Iq7OrsXrjEyuNSPB8Ws6CY/5sHZxn4kkJDar6EFg1cZ/kG5Jt/gFmkbt+q434XQ1oEwzldPtyT7abiOBXb7LXKKlfTuSr3IJQBEyF0ktmqsz8OYJZwlYoqT9HJkI1TcF++QGNZSjbSf6a/wRR+2DbPA/RK0a8YIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3z0xJFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 881A0C32786;
	Tue,  6 Aug 2024 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722940036;
	bh=tnBvT/w43thSvlJ/YUxyz/XqxFCcr1JN1U9GgK3fKE8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=G3z0xJFVivc041Sy8qMwej55oHUgXATmB8NHBvCXdmPRGqHOH5wqPJo50R6N18HVY
	 6Sk0oOMpRCGnAYltBAOKxFvgV1xD939Y8nSSvjblsqEXv7A6uO+aKh0l8HWzPIoFSl
	 taHQfDIvdCN3ttNq+WyeD0vRp+hZkHWTQ/YG9XqsgarlSFe95y8qSMNROUBSsvnr/Q
	 uA+ZhldVuG+f3G5Ot1I9xdHeWsTkNggObIbsU9cpf/FoQShPqtJUCZ50S9bvKOloXl
	 Berwnpa9epVQRZRH3DWemooLvZ/OuvA4AxwtKVwsrgqXJufUG3himI5U1SR7Jx5d4s
	 Hs21MfDoV7J7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBEAC3DA64;
	Tue,  6 Aug 2024 10:27:16 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] add some node for amlogic c3
Date: Tue, 06 Aug 2024 18:27:13 +0800
Message-Id: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIH6sWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwMz3WTj+MSUlPi8/JRUXRMjg0Rjc0tDizRDCyWgjoKi1LTMCrBp0bG
 1tQDCFNWhXQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722940034; l=874;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=tnBvT/w43thSvlJ/YUxyz/XqxFCcr1JN1U9GgK3fKE8=;
 b=kq/KGDII0tJHN+mDp2Tjv86DYLPfsOhBkzOjXGiwUXsyK5Xpb5CCfO6uXDYJJbwKFRfm4Npuf
 PSQhgYpsd1wB2RaH68n0SqrnFVsFrUbwFMxNah4ftdxMnXtjTNmEgHT
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add some node for board AW409 and support board C308l AW419.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (3):
      dt-bindings: clock: fix C3 PLL input parameter
      arm64: dts: amlogic: add some device nodes for C3
      arm64: dts: amlogic: add C3 AW419 board

 .../bindings/clock/amlogic,c3-pll-clkc.yaml        |   7 +-
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/amlogic-c3-c302x-aw409.dts    | 249 +++++++++++
 .../boot/dts/amlogic/amlogic-c3-c308l-aw419.dts    | 278 ++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 487 ++++++++++++++++++++-
 5 files changed, 1019 insertions(+), 3 deletions(-)
---
base-commit: 89933feccececf778cab56b1ec3d0916e9bbef3b
change-id: 20240806-c3_add_node-420a37918f18

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



