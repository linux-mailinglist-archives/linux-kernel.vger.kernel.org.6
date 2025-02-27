Return-Path: <linux-kernel+bounces-535869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF8CA47855
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BFB16D16A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C8C226183;
	Thu, 27 Feb 2025 08:55:14 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BC1F16B;
	Thu, 27 Feb 2025 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646514; cv=none; b=XmyZF/s6gl0Mf4Muqp32DJiiNWfHZqX3FMMA9C/Z/TShReonhn+CznqWTlw/9w89lIiatz845CrBjL4W/UNiOzMB9KtafQF3fd39QX4Q8cAASu6VhzC/HKdbDIwwmYHBCzeJzitYmEgE+cRKb2VYO7rhb4SlMTMqwISaicMn8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646514; c=relaxed/simple;
	bh=aYzgU0t8poztoe0nxjONtkodc3MdC9aMA+pf7C0XWU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l7FWNt7QwALe1Wx6inbRToaAM0qcBSjDPoK185GN2Gwaywja7gXOWu98ypQ1tIABujqz0xkLs1vXDztQZmtVIK11OMGzacAhRlQJRgdxakHx6n+ByZS5ebiE59FjkkWpA7Bxio1pDQa1D+jYCG4DstLFC75sTY825uIkCQhxSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202502271653527198;
        Thu, 27 Feb 2025 16:53:52 +0800
Received: from locahost.localdomain (10.94.4.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 27 Feb 2025 16:53:48 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <oswald.buddenhagen@gmx.de>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] Sound: pci: emu10k1: fix inconsistent indenting warning in snd_emu10k1_synth_free()
Date: Thu, 27 Feb 2025 16:52:00 +0800
Message-ID: <20250227085243.18413-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20252271653533f52f137c123be1237982b5635f4c22a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
sound/pci/emu10k1/memory.c:444 snd_emu10k1_synth_free() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 sound/pci/emu10k1/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index d29711777161..f6982bc6ff0d 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -441,7 +441,7 @@ snd_emu10k1_synth_free(struct snd_emu10k1 *emu, struct snd_util_memblk *memblk)
 		unmap_memblk(emu, blk);
 	spin_unlock_irqrestore(&emu->memblk_lock, flags);
 	synth_free_pages(emu, blk);
-	 __snd_util_mem_free(hdr, memblk);
+	__snd_util_mem_free(hdr, memblk);
 	mutex_unlock(&hdr->block_mutex);
 	return 0;
 }
-- 
2.43.0


