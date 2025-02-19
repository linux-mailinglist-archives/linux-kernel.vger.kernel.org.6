Return-Path: <linux-kernel+bounces-521811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84E6A3C291
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D503BB9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14081F30BB;
	Wed, 19 Feb 2025 14:48:36 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9C1DA4E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976516; cv=none; b=q8EncT0CQTGC8a2I+W4IkleAmlmsqv3UtP/nDIMB83H04SUYPznOAkqPESSZh07bmDTdkaWQBOepdTB5vdOpeSYqC0sr5eeiGtkjPofjWRltIdwJsia5zh48WjClMftKcggrmJMPzo48Vi9COEl6RnCNxvpTBswC8uWDalulF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976516; c=relaxed/simple;
	bh=qoCk6NYlcujso7TP2XRSRh8uOohh5dbjXEelZKk3AL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beBObRqf3Cnwn1P9GjfLouGIXfAjaeHEJHKOI8KaY+v3/MvcUCsFZuIIPt1E0ZLusQJuCCbkwgpPf2iI5bTDtanEnv0SfqzrENVVV0PvtdjUKMnNWGuoIP5P45pbPa5FVMfORzwYFau91+0CRYu2N0zqtnw/SheogjZ/nPV9pbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:47f6:a1ad:ad8e:b945])
	by laurent.telenet-ops.be with cmsmtp
	id FSoR2E00E57WCNj01SoRVC; Wed, 19 Feb 2025 15:48:25 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tklMs-0000000B3U8-2oij;
	Wed, 19 Feb 2025 15:48:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tklNB-0000000BazG-1JnU;
	Wed, 19 Feb 2025 15:48:25 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu: Spelling s/KConfig/Kconfig/
Date: Wed, 19 Feb 2025 15:48:24 +0100
Message-ID: <ff5b7c88eea8b126ed76029fb57254f29542aa22.1739976486.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two misspellings of "Kconfig".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6cfd1b5b6e07f038..6c46e1d58987cd11 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -348,14 +348,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	  an iommu domain will report an abort back to the device and
 	  will not be allowed to pass through the SMMU.
 
-	  Any old kernels that existed before this KConfig was
+	  Any old kernels that existed before this Kconfig was
 	  introduced would default to _allowing_ bypass (AKA the
 	  equivalent of NO for this config).  However the default for
 	  this option is YES because the old behavior is insecure.
 
 	  There are few reasons to allow unmatched stream bypass, and
 	  even fewer good ones.  If saying YES here breaks your board
-	  you should work on fixing your board.  This KConfig option
+	  you should work on fixing your board.  This Kconfig option
 	  is expected to be removed in the future and we'll simply
 	  hardcode the bypass disable in the code.
 
-- 
2.43.0


