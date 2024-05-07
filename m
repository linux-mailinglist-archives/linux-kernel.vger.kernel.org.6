Return-Path: <linux-kernel+bounces-170760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C88BDB9B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1700B20C91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB773504;
	Tue,  7 May 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="k+DjRtDY"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F72EB08
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063853; cv=none; b=UMhNSFysT9OVaUVyWsq4sWxIpXG1AR3ha7Z78ktdb5iMMehv3gjrssS9Rz0lBbmKLcRpXrkXD3EoWkWvFumgMyqhHm2ONUw995dHFuMIQP/1C6hJ++8sgNPEloY2JcjKsbAGZ/hTT9noTINYfjZrkeMDZJ46MPOvI87CFixhnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063853; c=relaxed/simple;
	bh=aNqvmh4BAzwck/OFAIQFc1HiCyrj8eEwPMX9mubrqK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iq67KiCZyQl4shWAd6E8HGbwJZGGGyiHmp8aGNRQBjRHOwXo8oWpow5r5xx35pPKwP3bGE2rNP0c55F4zLtC42WzYQ8lis3ZnY/JtJaszzz75snjSj9AH2wTaasz3BHMIyz2UZcjDrFVQS10qTMZGKGarwzMZYhaPx/c2+8ViDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=k+DjRtDY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1715063849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pocBmO/840pe2OoT/2yDl6Dta7ieL6aZ6dhZo77iND0=;
	b=k+DjRtDYA/jxT5T84+YLgGNomCyAJER0aS+QtFD2OwSHw7f2yk5KPqLoUyrSyCCMjBaz8v
	/HM3KGnZzDa4oDnKi3S5sLivlhfCi1SKWA8JcH6mWUa+rejjye0S9tKYop1GxIXWZFCIoF
	loLggRgQ+0/q0elF+DCFIacp9dwMcTp/C+fOfezhTOPUMQ3XorYzFD7USR7KRq5fI6SL+m
	57WyvStiz+BZX1mxy8MS8KLroR1UvedxgXyXtyuhGMfwnj9Ck4ZvL5uFrKcMjXCCS1iAs3
	L5JNsw+PbRlNX+qNBrnrxbNkjRTJ2q4aY0W+NWZv7lqMVZd5787b5qPqltI91w==
From: Kenny Levinsen <kl@kl.wtf>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kenny Levinsen <kl@kl.wtf>
Subject: [PATCH] HID: i2c-hid: Remove unused label in i2c_hid_set_power
Date: Tue,  7 May 2024 08:36:56 +0200
Message-ID: <20240507063656.2892-1-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This label was left behind when the wake-up logic was moved from
i2c_hid_set_power to i2c_hid_probe_address. Clean it up as it causes
warnings-as-errors builds to fail.

Fixes: bb1033c8a3ea ("HID: i2c-hid: Use address probe to wake on resume")
Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 3e3885ae6ce2..632eaf9e11a6 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -407,8 +407,6 @@ static int i2c_hid_set_power(struct i2c_hid *ihid, int power_state)
 		dev_err(&ihid->client->dev,
 			"failed to change power setting.\n");
 
-set_pwr_exit:
-
 	/*
 	 * The HID over I2C specification states that if a DEVICE needs time
 	 * after the PWR_ON request, it should utilise CLOCK stretching.
-- 
2.45.0


