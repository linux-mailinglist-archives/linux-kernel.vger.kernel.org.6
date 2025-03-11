Return-Path: <linux-kernel+bounces-555989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17163A5BF40
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E6D7A97B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A2254851;
	Tue, 11 Mar 2025 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PdlCoJyk"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FB2505AC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693017; cv=none; b=AsJEMsiVjBiTke6lhXt0NZC4XuinSHkT4yICzBvIDQWu4HXEbPZdNEFBqf/GkiqKoRbn4eeoUqNwMohR2ctCkxNMXzsJ0xbF8lVEI9R1pNXNv1KUzZZ1vigOB+EseUaoaLTTyttr+8qslLvrytSO2om+l1pX3VJDnIhbKcSdtmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693017; c=relaxed/simple;
	bh=oi7lV/lrHT+EHF4OxEPCf+t4jtrbHvMpeUS9/w8MW9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSUcArL0ViqwRHS8UBjNIzFxCV7QPZu4Bl/QQammAfunP89ayAyLu3oP8BAXA6m73VaVGSyg5zJqbeF9OecYlrB8ilE0WKdaEYtj/WGcUXopWuuZ9jxTEgcGI8HnBuPnlNdgjzbTaPqncTivapqvhK+93i4D6Z6gdBYRWnep3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PdlCoJyk; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741693013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hR+XlzJzGTiqSgbWiAdN0TiNYvqq5BOnYBxudITTpnY=;
	b=PdlCoJykbgkrfdXx1n82f5X4d+dTQ5hRn2zlYHv6wjRN9nUlblJ0Nhy5XAf7K2HkCWJNd4
	7xz7wBTFaeW1FUhFQ/K3qNooFfVOPB5y1qKphKI8EO0DEKJ51Dyn8QlPk4hgX+tu3ZIivB
	EaJ25BfXkB/4GBf7kxqLIPTFbi/+DP0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] sbus: envctrl: Fix typo in comment
Date: Tue, 11 Mar 2025 12:36:29 +0100
Message-ID: <20250311113632.496905-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/disinguish/distinguish/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/sbus/char/envctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 81918aa67109..69e49da93b8b 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -734,7 +734,7 @@ static void envctrl_set_mon(struct i2c_child_t *pchild,
 {
 	/* Firmware only has temperature type.  It does not distinguish
 	 * different kinds of temperatures.  We use channel description
-	 * to disinguish them.
+	 * to distinguish them.
 	 */
 	if (!(strcmp(chnl_desc,"temp,cpu")) ||
 	    !(strcmp(chnl_desc,"temp,cpu0")) ||
-- 
2.48.1


