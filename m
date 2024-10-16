Return-Path: <linux-kernel+bounces-368815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E9D9A1532
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32C51F2211D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F91D6DB8;
	Wed, 16 Oct 2024 21:52:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB61D5CCF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115555; cv=none; b=NhBKfkEMfJiljSfv+UUyJPtktjx4wycUNVeihbI5Ub6BhNG2sBovoxg6ZeXFW1VsBHgUi93UAiKFAs6UVIijnMD+N/S+a/T1k/XwNJODxF1CSjoHzNnRR99tL3vtab+iHITS4AbUPuQjZSQT14rfGB4jOpR2l3QzT8l5CrBkQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115555; c=relaxed/simple;
	bh=GpjAIxnnnGVUXNOqNhnCl60xQrUalApU+7hyOkbxr1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UaG18NS2A3CmJqYI8Bc53SVG5HZ8Cvs7mSYTyd+ZzrT3MtqSqj2cYiXO0KS5bIB8ZwDwkSb+IFoXXWL+IpOkUBK/WFZ5OYZUZKB/tY2fRioqiRsMN0Ckp2JpwT5+RTDfCs3tdJRr1EV52bIm8bvlzh1K3WLEIXPKuvHnhB8mGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwO-0003JZ-8W
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:24 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwN-002OP9-8f
	for linux-kernel@vger.kernel.org; Wed, 16 Oct 2024 23:52:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id DC0863548C0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 081F635487B;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 154b0c78;
	Wed, 16 Oct 2024 21:52:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:51 +0200
Subject: [PATCH net-next 03/13] net: fec: add missing header files
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-3-de783bd15e6a@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=GpjAIxnnnGVUXNOqNhnCl60xQrUalApU+7hyOkbxr1s=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnEDWC32dOchoew6fax2I185fuEq8ZRit7iLBQf
 Ub38y54jbSJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxA1ggAKCRAoOKI+ei28
 b9TkCACTD7BEGFU8thT4R3wcLcABSbobH8V8xJrkzKVco+3xwKNebKDhJduh8XT4Z6o3q6c8Z0E
 WwYKYHyg8Uv2h9i9DOZWrJya7caSVHTfkJqVhS3t9GsCr9TxbKHD3y+hbU1TRVw/ib7xUWVHPdO
 g9L9E5A5R92+bnAytwdUU28czTj8296QT9o+TyKfaxqDwNllDPGDBdjhTbc87n91vneC95RDAoD
 3VpcKQEEz3AMIaK8g56tPHq2F4FNkRZuMJnjSc+wPmJqi0XMAlfgwUJXVOENszk3dM6YpEzZHrf
 AUnrnaZk3YF6R+nHH1q4q7g7fBe6e2GhlIChkjbEhIajbPij
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The fec.h isn't self contained. Add missing header files, so that it
can be parsed by language servers without errors.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index e55c7ccad2ec39a9f3492135675d480a22f7032d..63744a86752540fcede7fc4c29865b2529492526 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -15,7 +15,9 @@
 /****************************************************************************/
 
 #include <linux/clocksource.h>
+#include <linux/ethtool.h>
 #include <linux/net_tstamp.h>
+#include <linux/phy.h>
 #include <linux/pm_qos.h>
 #include <linux/bpf.h>
 #include <linux/ptp_clock_kernel.h>

-- 
2.45.2



