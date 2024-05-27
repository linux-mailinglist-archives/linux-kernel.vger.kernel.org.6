Return-Path: <linux-kernel+bounces-191412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D98D0EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17400282557
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF621649CC;
	Mon, 27 May 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XhE+wgkO"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE31649C8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843589; cv=none; b=DftHHtXH1hLNnm5ftCgX5XoUKCOuUGKnJaulJC1hg7yoh4OKEJivs6NVT9t4ac1a6lmVb9cNo0H3HIgyyhguGqvBP9fxp94uz4dSbLZ6z2+3G96wX8ABZzaXUFLP5LGdPF1/gw+FSTLpLLVRgD4DqzdUqaEEaCxcDqk7SwB6wCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843589; c=relaxed/simple;
	bh=HcX97VtMgkK0nkXJST/SVZ/bm4ZEFINcehfdM9hywdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8dHWiwRc9g+hM2+BnhFdDEZTKheNv9bPEiS4bZ0K9v44g/V4ymcDSVdFPdGYcxefD/+qT4SzFYXMjfUlj+e7Nhj+m2LpmWejCSz+7nmdy737tcDajOit6kf21CorDOPAt1MjXt2NIxamv0iDk6kSJMXyWsSuDTVuaOLW+l+BnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XhE+wgkO; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=uqDBWtxUYEvDABjUaqvx6+sNN3E4ACUWUJ++4IWADk0=; b=XhE+wgkOWTy0il1C
	TT9jizlYK8tNMfX1T5I1uDZSGvUOFC2VGumUVmvWyIgdYqHgys4hYOTm4cvPDbkcFgPWFM+s/lId7
	59zhQq1GN28EaFQRo9HNto7gJzA9HDd94BJShs+x7gPlxSyPtyz8Ep5PVSTsHLFg2tSr7cLn8Cdlz
	ToL7qN+eJ2QmDjqyNPzDu6K6fQh2DcBGHvKsDdDcEJbMONCGmemLrijZr5KAYhTB8tlb36FaxNcVX
	kPSeJPm+g02jJaWpNyZtPGxWMBIjQevet0pQ+d+oU3QNZZk50jYoUzVIwbQjjyDEqx3LjMhz+RjYO
	LR7Th1avAVHXV9W1qw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBhRS-002ocA-1d;
	Mon, 27 May 2024 20:59:39 +0000
From: linux@treblig.org
To: jack.zhu@starfivetech.com,
	changhuang.liang@starfivetech.com,
	vkoul@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] phy: starfive: remove unused struct 'regval'
Date: Mon, 27 May 2024 21:59:37 +0100
Message-ID: <20240527205937.165325-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'regval' is unused since the original
commit f8aa660841bc ("phy: starfive: Add mipi dphy rx support").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/phy/starfive/phy-jh7110-dphy-rx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/phy/starfive/phy-jh7110-dphy-rx.c b/drivers/phy/starfive/phy-jh7110-dphy-rx.c
index 037a9e0263cd..0b039e1f71c5 100644
--- a/drivers/phy/starfive/phy-jh7110-dphy-rx.c
+++ b/drivers/phy/starfive/phy-jh7110-dphy-rx.c
@@ -46,11 +46,6 @@
 
 #define STF_MAP_LANES_NUM			6
 
-struct regval {
-	u32 addr;
-	u32 val;
-};
-
 struct stf_dphy_info {
 	/**
 	 * @maps:
-- 
2.45.1


