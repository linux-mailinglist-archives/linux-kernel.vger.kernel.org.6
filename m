Return-Path: <linux-kernel+bounces-412378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365BC9D0843
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E260E1F214E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81F281745;
	Mon, 18 Nov 2024 04:03:24 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604874A1E;
	Mon, 18 Nov 2024 04:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902604; cv=none; b=TsIkNZOwyTDmX/1NAS8n0tkjwygsid+4Bqh9YaaVH/LpdLspbQQ84umCDrTWc8unhcvHNYGsEXW1EqZq7IgXpGKpTqXMG1B6zwSydsIEEt9jH/ZJ6G21OyvGEhTk6lFkzCPAZuyQngB7vK/ktnEdbbeHpIPQbMiUOfpxp6TRb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902604; c=relaxed/simple;
	bh=G5EZ6KG+xZGy2pTgAS4wNXvEUR/4cGNlhOi9JZfPMfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hK8vFUEdekV47PzJTl9hSRm6JMSFZ7AfK8Xg+EUmP/9wbAXCCjW3OWDk4TJ1aa2ZCmoHYWWTHHohaZpf0Opid3ps9erPKK1zf5NoGz4D7AjQLQ0G5L5BuigME80dm/50gIwejpgSmsY9TnPh6t3tWM1f2iJDeKTqUBdr2VTw5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id D5039B4B1653;
	Mon, 18 Nov 2024 05:03:15 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Henry Bell <dmoo_dv@protonmail.com>
Cc: E Shattow <e@freeshell.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function
Date: Sun, 17 Nov 2024 20:02:09 -0800
Message-ID: <20241118040250.43625-1-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable host mode JH7110 on-chip USB for Pine64 Star64 by setting host mode
and connect vbus pinctrl.

This functionality depends on setting the USB over-current register to disable at bootloader phase, for example U-Boot:
https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

If the over-current register is not prepared for us then the result is no
change in functional outcome with this patch applied; there is an error
visible to the user and this usb configuration fails (same as it is now).

E Shattow (1):
  riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function

 .../dts/starfive/jh7110-pine64-star64.dts     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.45.2


