Return-Path: <linux-kernel+bounces-244295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB192A248
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F124A280F8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EC4839E4;
	Mon,  8 Jul 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="D8q1AFg9"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A043C08A;
	Mon,  8 Jul 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440582; cv=none; b=gvOGJl7C3Q7wOwNytZACI2OKaChsqui2YH1S6bNX/TjqOEYHMk0gUvaSULX2zh8sKSGru2o5xk/VvA/SBjvv+YZRBPKVBt6Tz1LiJvuBFlco0XJcXnnR5F8AePoewxPpZ/YNWvZOAFEr1k61AceqkddeYiH5XqgiV8NNiADTQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440582; c=relaxed/simple;
	bh=LixmteUS5gYgJ/PPXczu+PsnnDVZsOkJdxUiZfHsntw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3sGWVoRl2rn6ewIft6xvVZLtCT0UVP89SdSUeL+eTjxfWCfH6raosL8w7ud1s5m2koGnT3zBIgvjhqBu2Vmmoul2TEGdBkPLlLsT9BLyL11MykmlsE8JINiWCkX0S7nf4zDGU5qU4iASDcxE+1suYWTI6uVKXMTaPPiBgDzh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=D8q1AFg9; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8E9E041AAD;
	Mon,  8 Jul 2024 14:09:32 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZZdBFLd7Gx_I; Mon,  8 Jul 2024 14:09:31 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720440571; bh=LixmteUS5gYgJ/PPXczu+PsnnDVZsOkJdxUiZfHsntw=;
	h=From:To:Cc:Subject:Date;
	b=D8q1AFg9z24hBB18YM8MJt044NefpABngXoUt0Z3FlzL2tkFswv3SlkdPaNOZqPuP
	 LHCQaSX3n7Vxr6EhXUWfJfoX4IerSx0AJ8uN21Um97G1YY86q5mUNcidnKw1HGPbWz
	 M6fNSRQIJh00FAHGk8su6FiL4udi2E1aaQbsYG4yU3Av0VDaJkWXYgzm/+cTok5jGz
	 X0BqirpWpzZ7SroB6ZWUpQhpoff9inRjovijWA52o2KBm6P5kCb9ZH7ZA+/+QEXiEh
	 MQpev+aQ/v4xG/3+44KTuTN0Ouvd4FhuruqxH+61RNWhPZA+WSIXNESeO/nIN3sGrs
	 ZH6rPB8wrQxBw==
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/3] Add USB support for Sophgo CV1800/SG200x SoCs
Date: Mon,  8 Jul 2024 12:08:27 +0000
Message-ID: <20240708120830.5785-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sophgo CV1800/SG200x SoCs integrate a USB 2.0 phy and a USB 2.0
controller based on dwc2 IP. This series implements a basic driver
for the USB phy and add USB-related device tree nodes.

Yao Zi (3):
  dt-bindings: phy: add YAML schema for cv1800-usb-phy driver bindings
  riscv: dts: sophgo: add nodes for USB phy and controller
  phy: sophgo: add usb phy driver for Sophgo CV1800 SoCs

 .../bindings/phy/sophgo,cv1800-usb-phy.yaml   |  67 ++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |  23 ++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/sophgo/Kconfig                    |  10 +
 drivers/phy/sophgo/Makefile                   |   2 +
 drivers/phy/sophgo/phy-cv1800-usb.c           | 213 ++++++++++++++++++
 7 files changed, 317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c

-- 
2.45.2


