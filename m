Return-Path: <linux-kernel+bounces-517871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752FA386D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB488188DBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7672222D1;
	Mon, 17 Feb 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="cf3EBCuy"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D812634EC;
	Mon, 17 Feb 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803585; cv=pass; b=habC7UlQ56Raz39qF9LU3E/FEUJNNnWahown3xHeFgfvLZaTquwVpraeDkzbNjplk4VOsY4zgVKY5rlfWQgzvvoOGNRCwp95EtjIConuqWmfzyXkqebjjEg6h0h7i1LXUIgZPeBuR8POUtZy0ZUU0YwCV9rOnei9V1h8Vomr6Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803585; c=relaxed/simple;
	bh=YRXNXjMPYXoSE1L+JFJ11zrQXwJWnj4NlsHIVqlz4qg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZIR2jwUZ5wmIPWmrrrfrUp6s305nSn57apYHZ/VIDgOJ8RLin+xZWau1CaWVxxTPawPLSQMIhKvrj/uBtRf6uguN32skLNhnTQuf1kS9KCJ8Vt/ObWQWhpDYAfom/JZhz5gbwCBXZBEEWn7d6VEO6qT3NdSj8wMn/UH2q5r8cC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=cf3EBCuy; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1739803559; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OCdIbFjJUEXY079sDGPYon0B1ZovDRUDia/NuDXFm7et5ed1y1DBawljU7zS/ks8n0xhtkMqbKRtRk2acA9it7mFs3AUacri00RwCyGUedFBrJiTu/CSNdtu4X4/3iyi5MtRzFLL9IgK3BhbpKTjoIlGwq54Bynqx0BBdbL+Q2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803559; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0YZKUhV0cXy/loIwnniom6HpRTlUDF9X2j+4OaCPS98=; 
	b=H+0xO49Zi5Ej66YVoETSlOzGeJyu1riVBqfoufi0hOuSrd/PluZC1+RmEY9/UrMWMoC66SJcBmZLSQeOyjVFhrtVdXImm7DkJL53Gu5y1Wc0fiLTT5JDgj6heMdG889krKUUDSy5pE4rH5hRUDROxgSpdr7Vu1HTz77NSGL78JA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803559;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=0YZKUhV0cXy/loIwnniom6HpRTlUDF9X2j+4OaCPS98=;
	b=cf3EBCuyBQGmXEOxuZp1y88gVhkIjb+Q5riUl8K5eZRvdlPwPCtqR5YzzVgif3il
	00YKGnTnb7/jPWxKkr4eQg3220lgUn4NkH0SUZIK7r/idjWOf5S2KUYVhazvDPuHZ8F
	f0a0j/3Au3ZretXP9ZzZPrYM3pBqfMbzPMYDI2BU=
Received: by mx.zohomail.com with SMTPS id 1739803556824557.5139876721179;
	Mon, 17 Feb 2025 06:45:56 -0800 (PST)
From: Xukai Wang <kingxukai@zohomail.com>
Subject: [PATCH v4 0/3] riscv: canaan: Add support for K230-Canmv clock
Date: Mon, 17 Feb 2025 22:45:15 +0800
Message-Id: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHtLs2cC/23PzU7EIBQF4FdpWIuBy/+sfA/jAm7BkplOta2NO
 um7SzuaTJ3uOCTf4XAhQ+xzHMihupA+TnnI3bkE+VARbPz5NdJcl0yAgeTANA2SHkEwiqcjdaC
 SECnWGoEU8dbHlD/XtueXa+7j+0cpHa+XJPghUuzaNo+HyqQ6gAzBozAYtQMhda1ZsC4p78FZK
 YMN1pKlq8nD2PVf69BJrGW/m8xm0yRoOQRunOLWRmOevruma30+PZZ3l5WFKcYB7llIySjl0WH
 CfQZM3DOhAY3jIJWBLVuGT/JmLJdbLgvnyBx6HYS0fofzGw5uy3nhANw7bqJlsd7h8MfLn5ndc
 li4CYJ5QK/gP5/n+QfOaqr2IAIAAA==
X-Change-ID: 20241206-b4-k230-clk-925f33fed6c2
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
Feedback-ID: rr08011227e5e3374731faf4bacb58367700001b1e03dceb14aa407b7373db18f731adce82ef30ff35181100:zu08011227e087a86ca1e9cb58aa500d1a00006374abe23d88b2ff848c1f1dceb1306d6d72180b995e4ea24f:rf0801122c2d7bf2098d92fce3a23adc5a0000f918bc9682786b4481a56dc271b3d237efbb87ea3326b402cf8767627b70:ZohoMail
X-ZohoMailClient: External

This patch series adds clock controller support for the Canaan Kendryte
K230 SoC. The K230 SoC includes an external 24MHz OSC and 4 internal
PLLs, with the controller managing these sources and their derived clocks.

The clock tree and hardware-specific definition can be found in the
vendor's DTS [1],
and this series is based on the K230 initial series [2].

Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/linux/arch/riscv/boot/dts/kendryte/clock_provider.dtsi [1]
Link: https://lore.kernel.org/linux-clk/tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com/ [2]

Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>

---
Changes in v4:
- Remove redundant onecell_get callback and add_provider function
for pll_divs.
- Modify the base-commit in cover letter.
- Link to v3: https://lore.kernel.org/r/20250203-b4-k230-clk-v3-0-362c79124572@zohomail.com

Changes in v3:
- Reorder the defination and declaration in drivers code.
- Reorder the properties in dts node.
- Replace global variable `k230_sysclk` with dynamic memory allocation.
- Rename the macro K230_NUM_CLKS to K230_CLK_NUM.
- Use dev_err_probe for error handling.
- Remove unused includes.
- Link to v2: https://lore.kernel.org/r/20250108-b4-k230-clk-v2-0-27b30a2ca52d@zohomail.com

Changes in v2:
- Add items and description.
- Rename k230-clk.h to canaan,k230-clk.h
- Link to v1: https://lore.kernel.org/r/20241229-b4-k230-clk-v1-0-221a917e80ed@zohomail.com

---
Xukai Wang (3):
      dt-bindings: clock: Add bindings for Canaan K230 clock controller
      clk: canaan: Add clock driver for Canaan K230
      riscv: dts: canaan: Add clock initial support for K230

 .../devicetree/bindings/clock/canaan,k230-clk.yaml |   43 +
 arch/riscv/boot/dts/canaan/k230.dtsi               |   32 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-k230.c                             | 1347 ++++++++++++++++++++
 include/dt-bindings/clock/canaan,k230-clk.h        |   49 +
 6 files changed, 1478 insertions(+)
---
base-commit: 7fdb24bbac37ce692346d60b89f5aa29844b8b88
change-id: 20241206-b4-k230-clk-925f33fed6c2

Best regards,
-- 
Xukai Wang <kingxukai@zohomail.com>


