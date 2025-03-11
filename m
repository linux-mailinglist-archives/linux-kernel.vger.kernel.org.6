Return-Path: <linux-kernel+bounces-556291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B40A5C3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4751A16DFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E394725BAD4;
	Tue, 11 Mar 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="No+MvgiJ"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFF253F13;
	Tue, 11 Mar 2025 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703148; cv=none; b=imYZf2z0R/Rfjv+vB/f4p1GJdmT+Kn8UoIFy/u7f4NomxseEnQra36+XIcz5GOCYvbQTWA5YzLCleZrDa/Ovh3bJFadXDGEhAPucaMGYoPxzrg8EP+zMEhYbQwQdCJSWm/QgaxE/K5bNhViucCOAyTLjAQHunkDBe4lmaE4Hzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703148; c=relaxed/simple;
	bh=vp0tIBA8f+2CJu7dG6oVcVXQApuWIJUhK4pPvf+Ggic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnM7i0xVcMhUI9H6Efghh64dMTYiOT7k15+7eNMhyWiXnHrrZYVuE8ZL2LFPe2QmEm0O5FQ0YIkbkDeagsqZ+174QaSE5WNGVxqXSxaK5Yjypwnoa/J6rnEK91MYro2cX95VOImP8PAKfIRUKsTvHRMV1ozH2QQU2xaJO6Hun1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=No+MvgiJ; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 383B91E001A;
	Tue, 11 Mar 2025 17:25:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 383B91E001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1741703144; bh=YV3nbpM2OnmxZIZIkjCarXY+9mtLYOYDmBs2avPdm64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=No+MvgiJfxzeVWI2FgjAxY1a6EtZcSZ2wE+PO3F8Cc67U2YMViUth0/V/ky7Oy1cd
	 Q4E0E1XibzksmxZcDRHGhhXDPNgeAsL6X8CoEJH2OwBNBw9kyLAh+CDUEiQ+2NHKtw
	 p/2zW/JSYDGsiXJzfzyizB02tjVbRmSoyjMQtT4mIxGlJ/hfPokk4Jw7j+TSs5NgoV
	 OsMRLiSzxOjwmdT+6mjhwlIWxj//fn2I7rLOaW1O/vqWRUXcq5h6hzld4l8xHFmrPp
	 yrjVN61IrYhcpBdugvnyGnxpuugK9KSfQx/POOpKUUR/K5yJXH/imyPDVKgfxrSLcN
	 8Dvj0vymbe8kA==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Tue, 11 Mar 2025 17:25:44 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.246.70) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Tue, 11 Mar
 2025 17:25:41 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Steve French <sfrench@samba.org>
CC: Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg
	<ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, Jeff Layton
	<jlayton@kernel.org>, Suresh Jayaraman <sjayaraman@suse.de>, "Paulo Alcantara
 (SUSE)" <pc@cjr.nz>, <linux-cifs@vger.kernel.org>,
	<samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Murad Masimov <m.masimov@mt-integration.ru>
Subject: [PATCH 3/4] cifs: Fix integer overflow while processing actimeo mount option
Date: Tue, 11 Mar 2025 17:22:05 +0300
Message-ID: <20250311142206.2045-4-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250311142206.2045-1-m.masimov@mt-integration.ru>
References: <20250311142206.2045-1-m.masimov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;81.200.124.62:7.1.2;ksmg02.maxima.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191671 [Mar 11 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/11 08:08:00 #27707391
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

User-provided mount parameter actimeo of type u32 is intended to have
an upper limit, but before it is validated, the value is converted from
seconds to jiffies which can lead to an integer overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6d20e8406f09 ("cifs: add attribute cache timeout (actimeo) tunable")
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
---
 fs/smb/client/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 7749309de782..89e54cf238f8 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1354,7 +1354,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->acdirmax = HZ * result.uint_32;
 		break;
 	case Opt_actimeo:
-		if (HZ * result.uint_32 > CIFS_MAX_ACTIMEO) {
+		if (result.uint_32 > CIFS_MAX_ACTIMEO / HZ) {
 			cifs_errorf(fc, "timeout too large\n");
 			goto cifs_parse_mount_err;
 		}
--
2.39.2


