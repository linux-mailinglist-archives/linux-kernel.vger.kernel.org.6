Return-Path: <linux-kernel+bounces-512790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF163A33DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7EB166FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D486822171E;
	Thu, 13 Feb 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kkCLYmHq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D69221708;
	Thu, 13 Feb 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445617; cv=none; b=nHmJl9hQOoJZJJYhunvuXzicAcmnfDTxKnXFxCEcNhoaPALXrM6D3EvHRFqC1BTv5iJ0rVpWuX7bjmQDorA3hLlIvGUfQ4W0wIfz3mqeGnDMJ2Q9jaWh9DS1ABC2+8epgXAEJ9F5S3AnuqyhkD7GhGvkj11lnfKI27EkA7ZTrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445617; c=relaxed/simple;
	bh=c+PRWIgQRlOLKV70WxMuEmtDfXA0VqGW/OzrGTH7ptM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLhzrvGSqfsZY3DsPXrPrncXQ6qqdpMGV9gDNlJDCFJ98Eigc631DTWvf2ril20e96fJc/x188AllgIGX3uUMbcd8vXz4scLaJzwoFGtgyY1gPb/qyWh+ZORbF+aI/1NABeZLHCFtUWQp5OzGXCSyFq0YXMfWAFZ6G/RZe3n/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kkCLYmHq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739445612;
	bh=c+PRWIgQRlOLKV70WxMuEmtDfXA0VqGW/OzrGTH7ptM=;
	h=From:To:Cc:Subject:Date:From;
	b=kkCLYmHqigOlumjAgmhC0vswBSB//+IYO7wIoKFRhPvw71hWuZJEbcEngHEYR6YJh
	 vndp2Tf9GQDuWz/arpjrLLHRQFtmtyAHbU7lDIa7kGqis0eC2ke3Ebfgxei4fo5+lR
	 8ocOPYHyneGE3raK37cTPWjpQGO0IzHeQbvcfLaDwxqYIeJorLSjAZ+vn5jRtqqtAd
	 3pjwyZB8T2FXeHjbkDEvNMZp3b0jtQCDwjffIXWdaZYLz+DMRnWIqnO766Yvzi2c11
	 JCE8Gds8sR7rdM8yjr5cXHIAOen7meEkFconAP/TQyY2VBJxPv8Vbl5OrLX9rx85X/
	 5/Z+Jl9dzIKdw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2192717E0E93;
	Thu, 13 Feb 2025 12:20:12 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v1 0/3] MediaTek MT8195/MT8395 Display Controller Graph
Date: Thu, 13 Feb 2025 12:20:05 +0100
Message-ID: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a full OF Graph for the Display Controller in the
MT8195 dtsi, and configures the MT8195 Cherry devices to use it.

This was mainly done to allow different display controller paths
for the Radxa NIO 12L board (compared to Chromebooks), and this
series contains a preconfiguration for the DSI0 pipeline.

No DSI display was actually added to the Radxa board, because that's
a SBC and, even though there is a display from Radxa that can be used
with this device, it's not mandatory to use exactly that.

The NIO 12L also features an HDMI output, which will be added later
when the series adding HDMIv2/DDCv2 drivers will be merged upstream.

AngeloGioacchino Del Regno (3):
  arm64: dts: mediatek: mt8195: Add base display controller graph
  arm64: mediatek: mt8195-cherry: Add graph for eDP and DP displays
  arm64: dts: mediatek: mt8395-nio-12l: Preconfigure DSI0 pipeline

 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 184 +++++++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 129 ++++++++++++
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     |  26 +++
 3 files changed, 332 insertions(+), 7 deletions(-)

-- 
2.48.1


