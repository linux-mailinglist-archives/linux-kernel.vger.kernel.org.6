Return-Path: <linux-kernel+bounces-393823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244469BA5CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965FFB21473
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5E51865FC;
	Sun,  3 Nov 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="12cTzl7Y"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA8A31;
	Sun,  3 Nov 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730641941; cv=none; b=e0jWL92VDTcsIogV2g1kp9qLrRWRDDvmRSqgrDANclKIcOM6m2lj1szwufPFWDe2w8f/9QTa1irFud4HFhU/E0rQ5EhLB0PiGMZqJ4n7MYSij/glxnHeMZgKooha0718GJypIOzuAf0gHz3+SH5xG7fB/CoM8d7dQ9BRNi5O9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730641941; c=relaxed/simple;
	bh=czf7XeC+ghUUOND93LkL6BYMnysaoDQTP/DqE4tRs0U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NnLBnvU8IDArrd8TYu8e3Kri3PMFoAnALZcvSMbkc5D00TXcGtMPb/ZZffBP958mmw3vGzdpT8yFISCkFJViD7S0OFOq3zTLS6zV2d+kWFPGh/V71Sr6HaOs3YGuwCDGkkGaBlAAi+ZlfzJYj2IyI3wCuIb9rVAkGG4Aggry+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=12cTzl7Y; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=WmTUPeSBb+svkmezLqwSQpXBbexJ56aq+pF1uohHTgo=; b=12cTzl7YxUPUCCjgFAuYrUZgH/
	0hNLb5yLIguXpbk4sQHNTIlzdyCvF6MB+3Q6kgHfFn8CNqSjIW72mOYTMTl4+mWZ8v5pLP3TfqQwS
	VcWKv04VXpNuAk+4g3oHM6M61r3o/QnqINkuqGLhS67I1NyeR1nT66RQrW4nuqClbZc6AlYTyTYkc
	6xZbpGESqLdC55v23uQWZsBYuFA3Gc/bEJ1LXV2YKHAqRJjTMl/Si2q3qwjegR0DbYpMFquerEGq+
	EaAurzsSTT6pnvcQQZQmUAslsrMs6E4uA8nWS+X+Z/euC9FAaUDq61V/I7KU2nhzYoebq4nf4MHNj
	MwUTRyWQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 0/3] ARM: dts: add Kobo Clara 2E
Date: Sun,  3 Nov 2024 14:51:58 +0100
Message-Id: <20241103135201.25615-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic device tree for the Kobo Clara 2E Ebook reader.
It is equipped with an i.MX6SLL SoC. EPDC PMIC drivers
are not ready for mainline yet.

Changes in V4:
- fix order of pinmux nodes
- remove some blank lines

Changes in V3:
- removed 30MegaOhm current sense resistor nonsense

Changes in V2:
- improved commit message about devices without binding

Andreas Kemnade (3):
  dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
  ARM: dts: imx: Add devicetree for Kobo Clara 2E
  ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E

 .../devicetree/bindings/arm/fsl.yaml          |   8 +
 arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
 .../dts/nxp/imx/imx6sll-kobo-clara2e-a.dts    |  23 +
 .../dts/nxp/imx/imx6sll-kobo-clara2e-b.dts    |  23 +
 .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 511 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig          |   2 +
 6 files changed, 569 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-common.dtsi

-- 
2.39.5


