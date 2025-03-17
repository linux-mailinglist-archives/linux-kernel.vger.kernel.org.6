Return-Path: <linux-kernel+bounces-564416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E09A6547D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0653618966F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E124397B;
	Mon, 17 Mar 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="EXO/jW8D"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA22459D5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223329; cv=pass; b=Q8cXLW4+zrTL7QAMQiRCSxoqk5dNVPzFAEK01WqlV9UdzbgSOxsaBdJzSvuRYxPSScrXfIrhVWq4TR/DW7RnLBWYyC+2RSc5pm8LHYhFB/+UglUAS8BeITtrxB1zZKuKe5JeKp2kCYZx2nDhAtAnvYdUGYkGdAspB7gHYLiKVEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223329; c=relaxed/simple;
	bh=4g2ZQBFOSqDtFo7TcFJmBzRGTqG+IeUHgHmpfqX2nx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSh7whCBXEWPrmaBTqSqE1eOPgMB3vRWcFycq54vtzR5HLhktzsFuaHlTXv1n7t7sf7+OVr4ZJyfux26vg01FPMNirIrk0ZfXIcjNywJzGnnfIciz8IwbBf/RMzBzgaqT6TArM9Ysf/nIdpH7tGZY1iNks9Ec28gvkJjfPPmDUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=EXO/jW8D; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742223307; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FraZ/OZHfwHywgfrsOG7TMIsQQppBBwQIA4714x3XRnJP7e/ZVphJqe5ysLm+JszrBtO5HvJOhlxRv03o7iYYaeGiwTqWUQCryu6ClkboduZGLUehevcL/YPtTGITjJG9qQNDxDAnXjnyb2uyJm6eeApuqBS1fT0vwccFrEmRng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742223307; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=shM7+TC0TXgX3AuBtBbLz5FbCbczMV6yD/4P/qN2rI4=; 
	b=L7YHsNwyvwhYW7PygyZG7QsdKBi+3FQaGn5s9K2Ek9QYE1EIWUUieE9GzauUZZn/FGNx7zO3+qN6BR42d5XUZzZpLVXWlt+yeJkAU0LPJes169OuObYNdFicou6TxZ/nWOV3rNSZFSjUEOQk3uObv66/vdbFBxQRCNPRbJEOMvo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742223307;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=shM7+TC0TXgX3AuBtBbLz5FbCbczMV6yD/4P/qN2rI4=;
	b=EXO/jW8DFpe9a6NnJnrU/CfigN8dh4tmx/TMFuBx5CxrwtYNbq5aOePIXi8T0qDI
	zjIQrh+SrkG/03Gkqm0BBB6a3Z1J4ytpIWHp36aA9/So3R2QbRMabUfBQad0WwWvX/N
	XSsKRGXvx4bN/XqQr6gI92I4wrQqIuxyhpap+34A=
Received: by mx.zohomail.com with SMTPS id 1742223306740713.2683007620236;
	Mon, 17 Mar 2025 07:55:06 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sjoerd@collabora.com,
	angelogioacchino.delregno@collabora.com,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v4 6/6] drm/panfrost: Force AARCH64_4K page table format on MediaTek MT8192
Date: Mon, 17 Mar 2025 11:52:45 -0300
Message-ID: <20250317145245.910566-7-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317145245.910566-1-ariel.dalessandro@collabora.com>
References: <20250317145245.910566-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

MediaTek MT8192 SoC has an ARM Mali-G57 MC5 GPU (Valhall-JM). Now that
Panfrost supports AARCH64_4K page table format, let's enable it on this
SoC.

Running glmark2-es2-drm [0] benchmark, reported the same performance
score on both modes Mali LPAE (LEGACY) vs. AARCH64_4K, before and after
this commit. Tested on a Mediatek (MT8395) Genio 1200 EVK board.

[0] https://github.com/glmark2/glmark2

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index e854f290858f9..ef30d314b2281 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -836,6 +836,7 @@ static const struct panfrost_compatible mediatek_mt8192_data = {
 	.num_pm_domains = ARRAY_SIZE(mediatek_mt8192_pm_domains),
 	.pm_domain_names = mediatek_mt8192_pm_domains,
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
+	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
 };
 
 static const struct of_device_id dt_match[] = {
-- 
2.47.2


