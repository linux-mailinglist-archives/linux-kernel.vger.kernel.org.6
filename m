Return-Path: <linux-kernel+bounces-523516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB33A3D7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A68017176E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CAB1F0E29;
	Thu, 20 Feb 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lj5Rz8xF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A51DA10C;
	Thu, 20 Feb 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049802; cv=none; b=f54qmfzfYSjQReC6Kb5783yu5X4jAUJGnUUFn4rb3WE8KEaaO0M9Qrhu8rt8OerEFJfggdjKp3Uwpo5EuahRLTp1l1NaVRXnPmQ2hlZwT/oiz4ZZI9f/dcokDXiRMIOukqDL/NY5KOPoelcCsXAj8xU569gMhVZnXSbKM6mVXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049802; c=relaxed/simple;
	bh=KbXYp775cdnty7f1RIZ5D4SMIl7u1xJAlQegzHLVtg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXD8+WbdhebCHK8gF06MFAY0U9yqQBLowMkSW+x4/tv1yeZBTxIdOFP6U52csL8Fv4gaZelDb3mOJk8uXo++jbBiN40hl6DRq2Bth6X/2qj8r5CHK/VMbqhPz4KiXIYVqsrlaFBhi/c8gNw2hi8fhCiO5W9W8njGA/S5qGBDexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lj5Rz8xF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740049798;
	bh=KbXYp775cdnty7f1RIZ5D4SMIl7u1xJAlQegzHLVtg0=;
	h=From:To:Cc:Subject:Date:From;
	b=Lj5Rz8xFMibe4IC22N7/0i+iFcJChPrurFTfbm6FxtnBiXZjlcr0ysS8d18Kkk24H
	 JcBMXGugW9or6w3gy2zAAokcERw07Ft+q1MFQ1V2By+tzJ/v6fH0ruqbuLQpam24jt
	 bPUDMenlljFsyIHHrpTOnBx9ZzkkK1b/VDqJAkM8NFwKZP2Ax76OFtvFev2/qe75fY
	 qvgblGP7EeS4BCNpIFWY6dAXfHAAd92g+8/GGE9MjJeqcAqLF/wVQJTQbhkU5GlhuO
	 kNqVg06Py0PppaZ+hxFneiwETXc5Sennhn7a9nOMU9k2pD73FX6G4ZIZA0R1zbSFWK
	 v8TN7mI5oOR7A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B37CF17E1247;
	Thu, 20 Feb 2025 12:09:57 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v1 0/4] MediaTek MT8188 Display Graph: Chromebooks+Genio
Date: Thu, 20 Feb 2025 12:09:44 +0100
Message-ID: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like already done for MT8195 in a parallel series, this one adds a
base display controller graph for the MT8188 SoC, migrates the Geralt
Chromebooks to use it, and adds support for the DSI display found on
the Genio 510 and Genio 700 boards.

While at it, this also adds pinmux configuration for switching on/off
the fixed power supply of the touchscreen IC found in Genio 510 and 700
IoT boards to stop relying on the bootloader preconfiguring it as GPIO
before booting the kernel.

AngeloGioacchino Del Regno (4):
  arm64: dts: mediatek: mt8188: Add base display controller graph
  arm64: dts: mediatek: mt8390-genio-common: Add Display on DSI0
  arm64: dts: mediatek: mt8188-geralt: Add graph for DSI and DP displays
  arm64: dts: mediatek: mt8390-genio-common: Configure touch vreg pins

 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 155 +++++++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 140 ++++++++++++++++
 .../dts/mediatek/mt8390-genio-common.dtsi     | 154 ++++++++++++++++-
 3 files changed, 434 insertions(+), 15 deletions(-)

-- 
2.48.1


