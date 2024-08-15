Return-Path: <linux-kernel+bounces-287636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB3F952A37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEA92837D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E4A1993AE;
	Thu, 15 Aug 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="Hmx0jFYA"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52521176AA1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708606; cv=none; b=jShksBMG217oJDCJ0Lp58b3OJIkObakpCDpAN5Fp94fQCx4qNHrew+KwxiQ17tI0vMXiaH0LdDAbGarCOnR8Uji9zRRLoVKoqT2CTwKKjpAxcbslRv5WqzWZH1ZPyGYYA7bQOqbLcd2Fd5x5e53w2OOa9DH5rT5dMqY6czPP98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708606; c=relaxed/simple;
	bh=5z7fF+TnfX+LXdWikfENO8d32MXfCW+MMcVrT9DX66Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=flIIxytF9Eip2Vx5J4MJnSQjWtJ/fNL61UOIbftwwPMfyEqnj4zY4sxRLZmCY6STTDRB3rmifR68FdPVQa2SiVjbKzIIgtL0pk5MdDfZ4I57ykDeBz3j8lP971ygY1yL1t4yg8OyBuAwEvLAF3vjHeh4uIRmQUD8zQ+BVSGMGJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=Hmx0jFYA; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 15880 invoked from network); 15 Aug 2024 09:49:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1723708198; bh=WBY4GMf9mjFw4X+BJHr6XblU/xSHdCH+pOR7tJbNRb4=;
          h=From:To:Subject;
          b=Hmx0jFYAjKpTk2MdQCDXEg1xE2Whbxqi2Uhf760mHwV75B3lIJ3v/3zlJN6vL7Q07
           S2VmmtpiqmGm+2Uz2fSA00OTNJxaQjC3Yohd6w7m7lZUTEIdpwfDp6yClhK22Iv5IX
           4PKsBkA54gh+3r1tJZ1/aRqHpmfXddWGjvGKRENU=
Received: from 83.24.147.218.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.147.218])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 15 Aug 2024 09:49:58 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	jacob.e.keller@intel.com,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: lantiq_etop: remove unused variable
Date: Thu, 15 Aug 2024 09:49:56 +0200
Message-Id: <20240815074956.155224-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 05eafb17e5a12033c9bbbeb6c3475e4e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [oZNE]                               

Remove a variable that has never been used.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 9e6984815386..3c289bfe0a09 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -95,7 +95,6 @@ struct ltq_etop_priv {
 	struct mii_bus *mii_bus;
 
 	struct ltq_etop_chan ch[MAX_DMA_CHAN];
-	int tx_free[MAX_DMA_CHAN >> 1];
 
 	int tx_burst_len;
 	int rx_burst_len;
-- 
2.39.2


