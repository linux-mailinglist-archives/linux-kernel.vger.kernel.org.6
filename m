Return-Path: <linux-kernel+bounces-565926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485D3A67129
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B92C422A09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA8209667;
	Tue, 18 Mar 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mY6PtpEj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F1207DFC;
	Tue, 18 Mar 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293418; cv=none; b=Bo9U0G8K5Vp7BThZhakUwkO76RziJ+HVT1jojPqE2UqsQwZNZlC8lJiXiZniyBIn/LW98AOEr2YzY/kuORGk69kDxkm7+KXwGWZsFdCcZogR+amiuAZU7vwBv+Un4k5cBPrIqqa0zyRN3J0RXtwTmFAnaaTbzSk5yGzgQxbXkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293418; c=relaxed/simple;
	bh=+wbnDO1Pqe10oOmycZARCAUSDWGZz6dvqzpBhlHSIvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awObNEUc8wLVmtOrRC07X1Jcx5DJELK/uo3kYTr4rMju+vjMr5EfqYkexf8o0hawirLvs+ksGAB/CTKDy5b8gNGRhUos4DnkkizHwM4t4zMpqtwTAcXM0igPcIRVSGI2eut6Y7UUOYIutcAq2YWVP4GCOTFz4c2/73Bx/YaN8l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mY6PtpEj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742293404;
	bh=+wbnDO1Pqe10oOmycZARCAUSDWGZz6dvqzpBhlHSIvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mY6PtpEjVeZ8GPVcNf/GEFUg+ElLuY0lhio+IPbUtzIMkQL0i32Bc86SdIXKG5L6P
	 5T9vJvNFnRwtOqGGxRT6Egi3BQWwDmaSPjCCw/aOf+PGK9+EuzClWiYyIVC9UzrWHH
	 mkziT0mvvGqcCVoqt3IR+wTLkGfbNm51ET8GgvoGGbLde/9KHK8UAQW4YHuEm5F5L1
	 1xYDkw8s+l8+K6yq4Bv8DvlWbBfgkHESxFJR5IA+fRKbQl3QRNQVFG0ShLtZ6ZAXry
	 8qBbH5XLVd3Hpa7s7JMEEsV3BZcug8z1C7OeWSvZLjF2JX8ihLRJUsV1B7gD4RF2kf
	 Y+iP2JUsRfSbw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:79a1:e959:3816:993])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E960017E05A6;
	Tue, 18 Mar 2025 11:23:23 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bleung@chromium.org,
	tzungbi@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	nfraprado@collabora.com,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 1/2] platform/chrome: Add support for Google Spherion in HW prober
Date: Tue, 18 Mar 2025 11:22:58 +0100
Message-Id: <20250318102259.189289-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318102259.189289-1-laura.nao@collabora.com>
References: <20250318102259.189289-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new compatible entry for "google,spherion" to the hardware prober
platform list, using the same I2C component prober and trackpad data as
"google,hana".

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/platform/chrome/chromeos_of_hw_prober.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_of_hw_prober.c b/drivers/platform/chrome/chromeos_of_hw_prober.c
index c6992f5cdc76..019578bc7ad0 100644
--- a/drivers/platform/chrome/chromeos_of_hw_prober.c
+++ b/drivers/platform/chrome/chromeos_of_hw_prober.c
@@ -84,6 +84,10 @@ static const struct hw_prober_entry hw_prober_platforms[] = {
 		.compatible = "google,hana",
 		.prober = chromeos_i2c_component_prober,
 		.data = &chromeos_i2c_probe_hana_trackpad,
+	}, {
+		.compatible = "google,spherion",
+		.prober = chromeos_i2c_component_prober,
+		.data = &chromeos_i2c_probe_hana_trackpad,
 	},
 };
 
-- 
2.39.5


