Return-Path: <linux-kernel+bounces-214447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D059084B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0707B23CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3FD14885E;
	Fri, 14 Jun 2024 07:27:46 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8D1474BC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350065; cv=none; b=WPG7zYurO2aDQh/2IYhOGfhJuVTBI5lpcMwc5TwATrEyaN7MAGsPdA285iX9XMqKK8pTEKEUhBRRG4zpvnH9sFm5RQV8OEkIvK0uf9uAPl7NFCKdpPP4jTkL8yRgXywSWET00uDoKt1Gdye5JoGRLmPOWSmxT6MvPtUM5o/GcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350065; c=relaxed/simple;
	bh=EZcrKg2HdRtyxUW9ZShduOq06Xb0EKs/BKL46PbHROE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FO4WW67YPhmH1GhJ2ZKLZQsIdygHNvtI+8S/NjdmoGWjm7DFwTM2KZ98jKrW8tTwJ4HD/LL59VyxVK8N9j7U+bT/pDKbuA9CJtXLa5qtnMLm+6X0IZ+51ikSGneZ6DXuY+G19uzCKapeQW5N5vFsS82jXNb2XiZnPlHqSDnEFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [124.16.141.243])
	by APP-03 (Coremail) with SMTP id rQCowAB3mSb+7mtmfoSYEA--.19275S2;
	Fri, 14 Jun 2024 15:19:26 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Move myself from SPRD Maintainer to Reviewer
Date: Fri, 14 Jun 2024 15:19:16 +0800
Message-Id: <20240614071916.1927791-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3mSb+7mtmfoSYEA--.19275S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4UAFykJFW5CF45Jw18Krg_yoW3trg_G3
	WkXrWxWrWkJF9rA34kZF9rCa1Fv3yUWr4Fg3ZYqwn8Aay5ArykKFnFq3WxXw18Gr43KrZr
	KF98AFZagr1avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8CwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ya0PUUUUU==
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwsIB2Zr151IAQAAsN

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


