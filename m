Return-Path: <linux-kernel+bounces-361800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2522299AD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830D8B299FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B71D0F7D;
	Fri, 11 Oct 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="VnqSB7l3"
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15071D14FF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676588; cv=none; b=qul+E75oZ2WulBvq2zNK5FI0RtdR6ZtA8ztUm/A9zzJtLBc3wAyjPVBvEJzAW006iOcaV87FCvJNo5CnTXyAN13H8jbyPxmBfXkA3MbznT6uHN5KxadVH5vCVkUFyEWXkt0bhiNiayuY8DK/uetgMkDomxgwiCo49Q4OXptKPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676588; c=relaxed/simple;
	bh=kMhqBLV5mjGtUt8LdHR7qKHyjqZ/myfONlPk5kLHUv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwJ1G1qCJk26GvEtB5Dgl6gX7Lcv0Z7Ze9D9kvdUY1ZrFd+QmSUFgc7IiWKSqqA6yAZJzX7lUAMsJ0H56ZgalgPCKFKwvj9GhdFrWleYPY9M5r5ZZa1/CXtf0CzmuC0aCn2X9Z4K6nF04R7CWhA2KRD5MQo8boQo3aRlZr29428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=VnqSB7l3; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YF0PlgvSUunNiKXyszUSHORQKnHjEJz6h3Ux8oFoJ70=; b=VnqSB7l30DlUMsNWN5buOufWzI
	mudgCYGAb0l28251GgvnD6mAoUjCsfOms2L8QZ5lX8IwGYE4FSMdfbWoHPDDzl22K3RffCAgtFcN8
	1skmJaUzd2rInj/qLkX3mOoSc11bn7UU0UC6MJC+xE82cMKSvlGA0KoQA8/w1hSv8HIw=;
Received: from 88-117-56-173.adsl.highway.telekom.at ([88.117.56.173] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szL4Q-0000000039T-3iMI;
	Fri, 11 Oct 2024 21:13:03 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH v2 2/8] misc: keba: Use capital letters for I2C error message
Date: Fri, 11 Oct 2024 21:12:51 +0200
Message-Id: <20241011191257.19702-3-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241011191257.19702-1-gerhard@engleder-embedded.com>
References: <20241011191257.19702-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

Print "I2C" instead of "i2c" in error message as "I2C" is the official
name for the bus.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index b5327feb2847..1eee130c3a7f 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -274,7 +274,7 @@ static void cp500_register_auxiliary_devs(struct cp500 *cp500)
 	struct device *dev = &cp500->pci_dev->dev;
 
 	if (cp500_register_i2c(cp500))
-		dev_warn(dev, "Failed to register i2c!\n");
+		dev_warn(dev, "Failed to register I2C!\n");
 }
 
 static void cp500_unregister_dev(struct auxiliary_device *auxdev)
-- 
2.39.2


