Return-Path: <linux-kernel+bounces-242196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896D29284D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA31B1C20AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663E146A69;
	Fri,  5 Jul 2024 09:11:51 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CD145B21
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170710; cv=none; b=swv+ZBaD/X4xOqxmuU3Ib+bhwlMZsQ6G79JwUqNW4oLD0L2JhDOsjoZXr53qgEV5wgZv/q9+3GDySdlNqTvRgaYvvDfEVYX9LAsnBW7F+S87ukKyC8nVA/N2iyJvpYBefEev9q99NZHiP3c8Zp//VgpDu7WEc0mbs8fFFwvdK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170710; c=relaxed/simple;
	bh=EZcrKg2HdRtyxUW9ZShduOq06Xb0EKs/BKL46PbHROE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rfEBhHd1ZsGh3PwybugZINsAP6sbpT7FKNd7eRtMeiqRb0Kn7ecBAIZO2L8XyHzt4E0zAEOJE6yEasMu6399eMdAubiInRW7guKXtNjKWC1nGqUNxuVXNSvimF8AXKoRCZkkNu2s2x43irXggKtNDHf4RbCbcs+1dD7Inr3kkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [124.16.141.243])
	by APP-05 (Coremail) with SMTP id zQCowAC3iSHIuIdmxGKmAQ--.42380S2;
	Fri, 05 Jul 2024 17:11:38 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@kernel.org,
	Baolin Wang <baolin.wang7@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH] MAINTAINERS: Move myself from SPRD Maintainer to Reviewer
Date: Fri,  5 Jul 2024 17:11:33 +0800
Message-Id: <20240705091133.3308539-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3iSHIuIdmxGKmAQ--.42380S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4UAFykJFW5CF45Jw18Krg_yoW3trg_G3
	WkXrWxWrWkJF9rA34kZF9rCa1Fv3yUWr4Fg3ZYqwn8Aay5ArykKFnFq3WxXw18Gr43KrZr
	KF98AFZagr1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbF8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
	GrUvcSsGvfC2KfnxnUUI43ZEXa7IU86OJ5UUUUU==
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAgJB2aHhSy3QgAAs3

I've resigned from Unisoc (formerly Spreadtrum) and cannot access
internal HW specifications any more, also cannot commit much
time for maintaining sprd code, especially DTS.

While I'm happy to help review the sprd drivers I wrote before.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..d0d7711f05a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2893,7 +2893,7 @@ F:	drivers/edac/altera_edac.[ch]
 ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
 M:	Baolin Wang <baolin.wang7@gmail.com>
-M:	Chunyan Zhang <zhang.lyra@gmail.com>
+R:	Chunyan Zhang <zhang.lyra@gmail.com>
 S:	Maintained
 F:	arch/arm64/boot/dts/sprd
 N:	sprd
-- 
2.34.1


