Return-Path: <linux-kernel+bounces-222421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C2D910144
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A17281A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE91A8C1A;
	Thu, 20 Jun 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NjjYSalE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16F628;
	Thu, 20 Jun 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878626; cv=none; b=FmCc/Q4ccF41I4InY9dJWACDIH7yUo43JCFGyvsMSKySot9hhhzni5pIdBVQGRMJutchJLRn897KMs5YgtHkeVwnT2ODlQRVMrl4ovcZqJXpAU0J2HRJaV69LgqnQWCL79gxauwv2MpPT49iZVw5+BviIZG6XZXw86DyjM6K1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878626; c=relaxed/simple;
	bh=UFUBPQcSLVh5HOQ6vjmNUcwptTZHWQ6XHWTpYyTdK5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=teywDykdMyPpeUadi3aWhIXC90YjARvuaf54thfjnQou2Y6k2fj/nkktUbNeD6Cslos9zxaMlV/wr9UPxmB6cHjV718R+hMD6pZFta08d7RF+VmMMofO24vmDe89do+rTEvQbFqJ9Jl+CENGopfaOHI+FAHhrDGQV/OzPwSUSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NjjYSalE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878623;
	bh=UFUBPQcSLVh5HOQ6vjmNUcwptTZHWQ6XHWTpYyTdK5w=;
	h=From:To:Cc:Subject:Date:From;
	b=NjjYSalEE4KOLecX91PFv1cabRR9Kn7//NuyQxquW7y80yOfwOCSzSq+pHbYk55SA
	 xZWdyDHV3G7UdbsITxYcwxr4ckb3l8XbDjSxjuxbG+EMiJkEwi7TTpTRtiC1wb6bmb
	 5Bw10q+jioWXFDyHMB6W7ZEvuwzHb399UxDPz+F41AIV1PMafvAq4D27R7IpNpbqip
	 ZAgEw19vv6xYiEMdU5IZq3KV7Q2qd/JXUa9WOJhxyBvF9RCkK0qb5Qx9JtUZV1MiZr
	 VxgCg+Gj2cHh5rCc/7RiigHQe0wm624W+W0hMfmT00wX+nTU0vsICUYofzFyJvFFB/
	 zhftUPFONtVQA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EF81C37821AA;
	Thu, 20 Jun 2024 10:17:02 +0000 (UTC)
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
	kernel@collabora.com
Subject: [PATCH 0/2] dts: mediatek: Stop using unneeded definitions
Date: Thu, 20 Jun 2024 12:16:54 +0200
Message-ID: <20240620101656.1096374-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MTK_DRIVE_(x)_mA definition is useless, as it's simply defining (x).
Change all occurrences of that to simply x.

AngeloGioacchino Del Regno (2):
  arm64: dts: mediatek: Declare drive-strength numerically
  arm: dts: mediatek: Declare drive-strength numerically

 arch/arm/boot/dts/mediatek/mt2701-evb.dts     |  2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi        | 18 ++++-----
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts   |  4 +-
 .../dts/mediatek/mt6795-sony-xperia-m5.dts    |  8 ++--
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts   | 12 +++---
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      |  2 +-
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      |  2 +-
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  6 +--
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  8 ++--
 .../boot/dts/mediatek/mt8183-pumpkin.dts      |  4 +-
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts  | 26 ++++++------
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts   |  4 +-
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 40 +++++++++----------
 .../dts/mediatek/mt8395-genio-1200-evk.dts    | 28 ++++++-------
 14 files changed, 82 insertions(+), 82 deletions(-)

-- 
2.45.2


