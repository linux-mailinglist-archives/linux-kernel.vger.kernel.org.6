Return-Path: <linux-kernel+bounces-308071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B4F9656E5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F051F24586
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06813150984;
	Fri, 30 Aug 2024 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOiQYwtU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CB142624;
	Fri, 30 Aug 2024 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724995571; cv=none; b=HHU1g3BgimmgBjRHdJPaXsrKVNv7DNhGqtL4OKS+IFTVtKLlGhMrH23FW6KX9p+7oD2mIHBAn3l73NnZ6MJ3G4PzGirhI/2PVhoa8eS/qSXjH7At+CMLzRT48zy1VR023X0EBkZUhXPg9raeD4+uMXJVoeCX8Ewd94edCvfIWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724995571; c=relaxed/simple;
	bh=IUuuhUvQU5dAs9RfLllL5/UhHvsk0Yi/7MPZkoNINGU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iyltuK2yYY827NhzhQMpUAT0D3a6/+zjg7/i/AxRw7rt5RdgEfDwPw7GFcmoMaC/nVU47/8otF25eEncIhFcfYGp6ENEzChw2rfqdEbU1MYpcrnAyEZqWPZ1L6lhniEgJ3A6H/LIUT11WKtwpvMSXcp7IdBRCGc9o8oXvMgjJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOiQYwtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A22F9C4CEC4;
	Fri, 30 Aug 2024 05:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724995570;
	bh=IUuuhUvQU5dAs9RfLllL5/UhHvsk0Yi/7MPZkoNINGU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AOiQYwtU5ROHw/29+znc/nI5KWgAkGNODK0Kha4LZrRpbxJhRDNTaY63eTqK0YBjB
	 Ugc+5cPwCBoT5JUHJp3sPqdda7m1dVc7OWUoy8ShoXlh9qMbpuNGxE1qQe8UhV1r6X
	 hWtKgritlMjEPrqJfTWrZrRrrQ3ZqeVMqSjg8lRig2/3veTQr8ajxwrAQ9it2mh2v1
	 Jbic5sTOCqDbBDRg9xp65Mfab+6zs6Gb7cURtJufcQbeqjZ2Az3WyZq5DwTfldKEEJ
	 Zo90XhuAjAXRwtCgv1yOnhHSdiVVdJuK+vRFv/tlBAZLhCYLlGBXQc6sP9MIlGi4ZC
	 7dH1KcsLKtLfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92985C83F0B;
	Fri, 30 Aug 2024 05:26:10 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v4 0/3] add some node for amlogic c3
Date: Fri, 30 Aug 2024 13:26:07 +0800
Message-Id: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9X0WYC/23MSwrCMBSF4a2UjI3c5IYkOnIfIiXNow1oI6kUp
 XTvph216PAc+P6JDD5HP5BzNZHsxzjE1JchDhWxnelbT6Mrm3DgAjRIarE2ztV9cp4KDgbVien
 ANCnimX2I77V2vZXdxeGV8meNj2x5/3dGRoFacF4wFEwiv5jHPbXRHm16kKU08o3msNe8aB0cB
 pCNaqz/1bjVuNdYNEqhUUlAFcRez/P8BfntYJokAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724995568; l=1482;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=IUuuhUvQU5dAs9RfLllL5/UhHvsk0Yi/7MPZkoNINGU=;
 b=sLy0R/VKRQWb9D1RVwxovgKBbzbGnPv1YWx1+E11zczo1cNy8ZD6jpFK6l5WzoTjbI5OQygfm
 QAX524CQKMWA0RIYMr9i5PP5x2Bu9LYWa4nq91OfJi6wqYKNtQDAxGA
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add some node for board AW409 and support board C308l AW419.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v4:
- Adjust the format of commit message.
- Link to v3: https://lore.kernel.org/r/20240823-c3_add_node-v3-0-3648376037f4@amlogic.com

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



