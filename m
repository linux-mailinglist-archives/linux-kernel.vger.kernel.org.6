Return-Path: <linux-kernel+bounces-380081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C99AE8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92864B23031
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD04820101A;
	Thu, 24 Oct 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="t2cFi7Rt"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760911E6321;
	Thu, 24 Oct 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779744; cv=none; b=MdLWhGJwHR5iFrdH3ZEVd35cN485A9fIt68txuwcq1G8XUCVO9lpanmTa8QEfRXPzcMvQ1pYHdBJ6qiHsD8dkqM5n7L3ovIlX+jKswejvZBVb1d4CcwE0Go2dgcLhKy10x2SG5Jib15wVxO3YYwlT7uHcH1RXLpZ9Z4LxGUcc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779744; c=relaxed/simple;
	bh=IkNGanu8ey3aOoRDoN21CFRMSVo7ePidCr07qRbGzOg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l6u85rqEEfUlKKoASkfhCIzwkgpzj+5S2AC1HoISDux0Z177fzbF1vD4BC2aZ74m0ojq0YjZUxroDMnQBgOF1Pw/QYcISMZuKzHSFgMt6NMVMGC7nms5uh5/gpjXhPQ/VQEgzJm7OmNySXSlFS974JFnAIvLpuZBl17VatA3yjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=t2cFi7Rt; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=J378zJcqWPCAas8Dzp0ISGD00hjd/6FaXGndJEzEA1s=; b=t2cFi7Rt+pgvPPajEh7dWgrA/y
	WJhqGXUDXcmuQfVG63VhV4zYbmjMHKQGGqhb7KM5g+m9RG57netT6XGzgBTeJbEjrhiYDLhH6f2zh
	hvrtmRABprxpam44KsZPdDJ+KMXxrlk2nfaEfvOoYlE2TpwmusVzdMEpcm2p7qMYEeBO8cnfW+rQH
	dzWTFtUmRMJ9O5u1KVN8QZTnfuU2xFhgjgIAsHBqr3ZWSV51GY2c4/nGdV26Du9lA0HclU7MusWm4
	6FUVfMl9SPmAqxu1/KYXnolJcXnlXvEtm5xQiyOmWp25qej/O0bEq7iUAVK5b3UVKyMOJiRgvXh58
	V6Xqq3kA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	imx@lists.linux.dev
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/3] ARM: dts: add Kobo Clara 2E
Date: Thu, 24 Oct 2024 16:22:03 +0200
Message-Id: <20241024142206.411336-1-andreas@kemnade.info>
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
 .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 514 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig          |   2 +
 6 files changed, 572 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-common.dtsi

-- 
2.39.5


