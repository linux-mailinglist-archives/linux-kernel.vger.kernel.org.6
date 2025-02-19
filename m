Return-Path: <linux-kernel+bounces-521810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33656A3C27D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37723188EC99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC71EA7DA;
	Wed, 19 Feb 2025 14:48:19 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6921F30A9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976499; cv=none; b=u9td2dbNIKPqFKhowVAZOvRlSIkwr/9bn86EHBzT/etPpPN7Qc9V6ozzXBWkRkRECM/V42y0dnEpwEUFaDdV9GX0K4DC7EHK9i4NwsB6xScQUgPAfElDrxyugTpHgpQSehQ9gGQyDrn81ZkeFAJMECF2pfV6j5oOX2fw43QGjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976499; c=relaxed/simple;
	bh=iuTi6nJ1Y4B5Y5oXJ4Bs/juLC780ovfDUBkTBKfgSRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqyrLug4vh/mSI8JsaPbHgMA8voVnRLkdiAl4A5jfmzWTfgXR8eKue89kMnj31hul/xFUayHQ/2uD/zHC+nsQpKMAGKAMqsIMmEdhJDj8cNN+fTESdpdC5DInUJ+1/iMSrjtFoPP1+4FNxgOjN8u0j6xN+1pBk02j6OJJxyxmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4YyfQH4rxyz4xHBc
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:48:07 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:47f6:a1ad:ad8e:b945])
	by andre.telenet-ops.be with cmsmtp
	id FSnz2E00M57WCNj01SnzuF; Wed, 19 Feb 2025 15:47:59 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tklMS-0000000B3U3-3gKY;
	Wed, 19 Feb 2025 15:47:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tklMl-0000000Baxh-2Bid;
	Wed, 19 Feb 2025 15:47:59 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] io_uring: Rename KConfig to Kconfig
Date: Wed, 19 Feb 2025 15:47:58 +0100
Message-ID: <5ae387c1465f54768b51a5a1ca87be7934c4b2ad.1739976387.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kconfig files are traditionally named "Kconfig".

Fixes: 6f377873cb239050 ("io_uring/zcrx: add interface queue and refill queue")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Kconfig                       | 2 +-
 io_uring/{KConfig => Kconfig} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename io_uring/{KConfig => Kconfig} (100%)

diff --git a/Kconfig b/Kconfig
index 529ea7694ba984b6..307e581144de32a0 100644
--- a/Kconfig
+++ b/Kconfig
@@ -31,4 +31,4 @@ source "lib/Kconfig.debug"
 
 source "Documentation/Kconfig"
 
-source "io_uring/KConfig"
+source "io_uring/Kconfig"
diff --git a/io_uring/KConfig b/io_uring/Kconfig
similarity index 100%
rename from io_uring/KConfig
rename to io_uring/Kconfig
-- 
2.43.0


