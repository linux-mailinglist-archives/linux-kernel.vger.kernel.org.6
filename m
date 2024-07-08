Return-Path: <linux-kernel+bounces-244855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6591992AA63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9099B1C21BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A6328B6;
	Mon,  8 Jul 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="lmV6GBvl"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940267494
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469375; cv=none; b=S06yC5YBl/Cy206wqBRgkQHqGS4qccLlNGD2X5TkoJwaNpsD+FSv3CLpBoqgq3HAyC1cZUPLkKde/xsfloCsn6wpWWQBQEWeVQkO84bGHCAHIS1t1DoNJdahaQeoNXLsgmeq2ozdOcg+AKX/Z/Rbkyv1GaNuzM9K6tzoxzjOi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469375; c=relaxed/simple;
	bh=/860PKzXV8hZlUe4CUC1mX88Sj3j3dAl8681Xpvc5xI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PlHTUgXzJNruty7eAS8enBRtF/WmkTtADSgMiQ2lxsLFCTAtND58p/jyWXmc4Qua9ki3DN69U1Dg1075gtHGqovhVtLJLaHya0AaPCfFmQJ+Q6G/GZ3rLCr0CE1eDSl+WY6Fkamk07x+J25HkBfKouJ+jxmj3FzNHxH0ElSJ+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=lmV6GBvl; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6E32E10000C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 23:09:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6E32E10000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720469371;
	bh=N1Ap+j42JiQbWsfqVFE5/T1f1uHuLla7muwng1stdlw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=lmV6GBvliXFrOr7enokbuFGUMpwC1zO1DdwVfJWo45J5gtf+UFZPBzfQEqCtgAZDJ
	 yd9dtpzfiDwqvqE/v0/lxcApmUjwvJT/XNUYVj3TO9RIM6w96v89MixaEuMiNDONvJ
	 R1xzADLbyYwN05lEi/oaE+zgudO7ZWQ83HBkswhRy30H1BAE6lAlLgLdktJZBcTRPV
	 GRBjl8BiKBaT5EudBd9L/YM56/QlXgnBF7GmsnT9ZApXSiCxfA6uO8hNfkpd3nMzkZ
	 oCjvDlziyVQDKGvgzaFstSJM9TxsmQNTTHCQ67UeYbAkZ0NEP5bULH5ZHEN+n8Aww/
	 7flKqGVY3XHlA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 23:09:31 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jul 2024 23:09:30 +0300
From: George Stark <gnstark@salutedevices.com>
To: <linux-kernel@vger.kernel.org>
CC: <kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH 1/1] initrd: use O_SYNC flag while opening /dev/ram for write
Date: Mon, 8 Jul 2024 23:09:23 +0300
Message-ID: <20240708200923.1824270-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186376 [Jul 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 23 0.3.23 8881c50ebb08f9085352475be251cf18bb0fcfdd, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/08 19:07:00 #25919740
X-KSMG-AntiVirus-Status: Clean, skipped

initrd image is written to the /dev/ram block device using filp_open(),
kernel_write(). After fput() /dev/ram is mounted and may fail due to not
all data is actually written to the device yet. The mount error remains
hidden due to MS_SILENT flag usage and mount_root_generic has retries.
So use O_SYNC flag to have all data written to /dev/ram before mounting.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 init/do_mounts_rd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..c9a4721c8362 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -195,7 +195,7 @@ int __init rd_load_image(char *from)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
 
-	out_file = filp_open("/dev/ram", O_RDWR, 0);
+	out_file = filp_open("/dev/ram", O_RDWR | O_SYNC, 0);
 	if (IS_ERR(out_file))
 		goto out;
 
-- 
2.25.1


