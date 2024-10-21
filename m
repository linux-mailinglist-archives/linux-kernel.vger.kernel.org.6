Return-Path: <linux-kernel+bounces-374854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF19A7123
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297241F23010
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED791F12FC;
	Mon, 21 Oct 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="385f+IkR"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC4199239;
	Mon, 21 Oct 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532233; cv=none; b=LRmEBGsX4tMjoEXeM/MzxYwNc+++Q3A7PtaWJrtdy91rYor/lcz2DOegqc4HZwC42SNEYVRHjdEkiSOOlbV02fjbkA+5zrTTbHZy9iQI4neZSOL6DA+qlrfpJgWKxq4A8rlV2I+IlrtMwnNX+LM6vaZAz1C/3y8ZREEl7eM+DTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532233; c=relaxed/simple;
	bh=0ssP+/C45v+G+qhQEUwDcfAMflnQ9ClkL/fOR4zIRX4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X8QzdZchv3ZwxsozzJE8n+/LdC1LE9A5WizcsHv0VOXAklKgCwBtl0CMup5coqeVXLiz6KXhbgL8cMN3OjR8wIzjkDnCCbdfSYZtL6E8v4iLNjEQk8RhmvhWys6WLeyZL9dntfD8nUUWgcR8NqVueivEiPejJlsiKoSiAnT2oyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=385f+IkR; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=y7dzIerB/KI11ADRmN80B/zGm4FVlX7K4IYPNpBrSck=; b=385f+IkRCbWxq59mxLMVgH21Wb
	YDipVHsEzRS8CEZEbEu527EEEoBo17dv0eOTkAW1Ivt44/E9htOhk538HdAT+JSQylZbxD+j1CHl5
	+6b9dJ9TvwxY6+mq9yxFy0oz8fhUBMHovau6reGScFw8jfYEWw2CQHdW2RAqMtum6KKYOjLfoqMpq
	FiwhNI2QDCF5ZEiYD7bPZxPXKWL4n1n+nY933Zfck/XF729NsJoBu+hpWLM40rwETDbz1Zc56PmyR
	dx98rEe/sy0R4bQyDJv0uAmyR1Gsvkjn8UyYdi6WXkCIu/z7g/UQUaKRE+AsHrZ3uh4WzcQf9Qqw/
	DRm5b7wg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/3] ARM: dts: add Kobo Clara 2E
Date: Mon, 21 Oct 2024 19:36:28 +0200
Message-Id: <20241021173631.299143-1-andreas@kemnade.info>
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

Andreas Kemnade (3):
  dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
  ARM: dts: imx: Add devicetree for Kobo Clara 2E
  ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E

 .../devicetree/bindings/arm/fsl.yaml          |   8 +
 arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
 .../dts/nxp/imx/imx6sll-kobo-clara2e-a.dts    |  23 +
 .../dts/nxp/imx/imx6sll-kobo-clara2e-b.dts    |  23 +
 .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 514 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig          |   2 +
 6 files changed, 572 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-common.dtsi

-- 
2.39.5


