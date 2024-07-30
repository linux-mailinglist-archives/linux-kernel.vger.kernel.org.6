Return-Path: <linux-kernel+bounces-266869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8A69408E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADC41C22C29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F53168493;
	Tue, 30 Jul 2024 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=resel.fr header.i=@resel.fr header.b="OktrNOL1"
Received: from mail.resel.fr (mail.resel.fr [89.234.162.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195618FC60
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.162.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322405; cv=none; b=ccPIJsr+iVcBdCpkoqJgxLiVQVymM0ET19rRU7U/fbYdvLgcY59P3T05TdeiqKCISZ6sVs1sRLPl/cA1tvUPy5jHQ7alSSLK56WnvNIUMz9L6bUxgMDyTw6HGHfVShdvjr1J6hVAjTdkF038SiDLOzMUwgIRdDC/gqxUEmdpc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322405; c=relaxed/simple;
	bh=Fmrauft3n5A1TXpsgRKqSN0I0qJUwQYoncHRWQyp698=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xf4jZfbal9LdKwF0H3tr2GKAiQotgY5KRa8OF5z62Gaq9Le+wZc/dhU1XdmPdn0tbVZAz3eeKE5m6I54dFUlQ8FhC0dPpdzXoKkT4lr75frRv/CTvTpYrHhV11ktWMCMeQQY+e1v+tCHGx0xZ0hFCUKUBFYskjVow7XSuNTI6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resel.fr; spf=pass smtp.mailfrom=resel.fr; dkim=pass (1024-bit key) header.d=resel.fr header.i=@resel.fr header.b=OktrNOL1; arc=none smtp.client-ip=89.234.162.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resel.fr
Received: from amateria.intra.resel.fr (localhost [127.0.0.1])
	by mail.resel.fr (ResEl) with ESMTP id 98F231203F8;
	Tue, 30 Jul 2024 08:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=resel.fr; h=cc
	:cc:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=mail; bh=+PDFpHb
	pDNMbZ4/vK8oqUvIODzu+OamZcCQ7bM0oo9Q=; b=OktrNOL1GNoJLolGGQA6+dK
	+cv5lbkccsGdq7Co+UA6jmBKnMcl6JiqMqGvaS2qJ6kO/YEf/S/u8IC+Jd+1KirG
	qTqY04cLFxQRreuXohcEir2mTVYv5H9Dz03XI2y9kFYXTAlg3SVc6GAIZ5I9j1KK
	HUCel/JeXLN3whDT3vdY=
From: Benjamin Somers <benjamin.somers@resel.fr>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: [PATCH] staging: rtl8723bs: Fix spacing issues
Date: Tue, 30 Jul 2024 06:47:45 +0000
Message-Id: <20240730064745.2473-1-benjamin.somers@resel.fr>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spacing issues reported by checkpatch on lines 39-40

Signed-off-by: Benjamin Somers <benjamin.somers@resel.fr>

---
This is my first patch to the kernel
---
---
 drivers/staging/rtl8723bs/include/osdep_service_linux.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
index 188ed7e26..e470abfc2 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
@@ -36,8 +36,8 @@
 	#include <linux/list.h>
 	#include <linux/vmalloc.h>
 
-/* 	#include <linux/ieee80211.h> */
-        #include <net/ieee80211_radiotap.h>
+	/* #include <linux/ieee80211.h> */
+	#include <net/ieee80211_radiotap.h>
 	#include <net/cfg80211.h>
 
 	struct	__queue	{
-- 
2.20.1



