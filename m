Return-Path: <linux-kernel+bounces-314493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88AA96B411
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A263E287C93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA218BB97;
	Wed,  4 Sep 2024 08:13:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0AD17D35B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437622; cv=none; b=EOdSDch+k2cpDbgT/Y8BJrMMx3GBcpnvj2bS1qrl/l6UOAzxGlG++NffPub72z3anVszmj4zIfG1xXEqFyQAa49zCGYu+YSDV67UfBkvn+bTDap6mw8mUahqnaGoO6rcQ4B7G/dz/Z0Ga3Ybk5Cu8cO5gE6awhAw2dM3HYmdagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437622; c=relaxed/simple;
	bh=dZ/z0OYSJdLd/zc3tGmB/s4VwJfdIqUEsJyC51U0B6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5taN3fwWiPcoGz3RQUnRRykWUgYnIQnuoR0WngRNpaMjL7QuKoYxxYKqFI8UXXP2QQYGdp7LrE3nJ9frlzfy+AFjM0wrDLF/yAxdPbOHIxOxqccN10sjUMEZBTuZqhXYsFyjc0ofgIek5iD0Y0XLwHYZHe06GzULza2+TJP0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8z-0007ii-MC
	for linux-kernel@vger.kernel.org; Wed, 04 Sep 2024 10:13:37 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8v-005Ox4-3c
	for linux-kernel@vger.kernel.org; Wed, 04 Sep 2024 10:13:33 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8427333209C
	for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:13:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 818C6331F5F;
	Wed, 04 Sep 2024 08:13:22 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e055f60d;
	Wed, 4 Sep 2024 08:13:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 04 Sep 2024 10:12:52 +0200
Subject: [PATCH can-next v5 08/20] can: rockchip_canfd: add notes about
 known issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-rockchip-canfd-v5-8-8ae22bcb27cc@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
In-Reply-To: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dZ/z0OYSJdLd/zc3tGmB/s4VwJfdIqUEsJyC51U0B6w=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2BaNEzeW8uZs77H+SsMDfxG94xtKf/kNf0aVo
 ICPHmwrwQaJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtgWjQAKCRAoOKI+ei28
 b0RkB/9G44XDclMwUAXnWqCYsa4nu7L1v0MRrki8nV0Qu6ZM2K6pTNUQGEqC8JmDpoDo5pKrnTE
 RST64p01oLw5UJMxGmuLPlXQKSI7BwMDJTqCEQWQvg/3QOi7swWGSO0YL3XJfHNhBk+zIwMh+it
 UlSDztQL8Gthg/WqJsoLZYB0Lp3QIuW02L/y/oKqYbzCsMQ+SGtcs0d1TN9F1nUAvT87YPWrtOt
 ziiDr9xCGkfjEQairdC3IkgZ/0ulU6EpDbaIE/eIROWH36BE2zqQUbt3iKZFbbTxhsDC8KkAoc1
 pyOCi9hjZKQZ2+LGOIvdR17vgmt4eKUONGQpgoCMSgeeR4IE
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Even the rk3568v3 has some known issues. Document them together with a
reproducer.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 9b446331fbd0..3dafb5e68dc5 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -370,6 +370,26 @@
  */
 #define RKCANFD_QUIRK_CANFD_BROKEN BIT(12)
 
+/* known issues with rk3568v3:
+ *
+ * - Overload situation during high bus load
+ *   To reproduce:
+ *   host:
+ *     # add a 2nd CAN adapter to the CAN bus
+ *     cangen can0 -I 1 -Li -Di -p10 -g 0.3
+ *     cansequence -rve
+ *   DUT:
+ *     cangen can0 -I2 -L1 -Di -p10 -c10 -g 1 -e
+ *     cansequence -rv -i 1
+ *
+ * - TX starvation after repeated Bus-Off
+ *   To reproduce:
+ *   host:
+ *     sleep 3 && cangen can0 -I2 -Li -Di -p10 -g 0.0
+ *   DUT:
+ *     cangen can0 -I2 -Li -Di -p10 -g 0.05
+ */
+
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,

-- 
2.45.2



