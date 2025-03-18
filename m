Return-Path: <linux-kernel+bounces-565833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C5A66FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9494F19A2D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B7207A32;
	Tue, 18 Mar 2025 09:34:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ADB46447
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290461; cv=none; b=syhaAHoaln3Q2+UiYAQbsyqYCCIFqdDXzWHM+4dLxXtJhk4B1xO8pmey3M9nuZ8UqE87kBZWU3F7ZmXDCIOCCFtRgomUb11RHxwSireLTQuwHZyVTRi9wCu0npUV1MHg78OBx7KvXH91qDlI6VEOhnz7jVFfGVCOzCBJcU/DQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290461; c=relaxed/simple;
	bh=GOgGPCG0Hzz9F9wHqmx2VxDQR/YAO+/6jXkuUnfVXDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYk/+n6au64kijlFyKSQ4nrpbF6oksECDMvhehE5xLw2rpqS6GNzW1h+7qLIYDBWKsP0YKuExTHM3fdTK0z5yXZYnc1bGkgqrwdXp9Q4O9MzmbTtcIf9VRa1nzeei3bBlaj+ShVm8UnSCnfq2H5D+H1KS/KK8KuKNpSsV7gi1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKu-0005yL-LX; Tue, 18 Mar 2025 10:34:12 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-000Oyc-0T;
	Tue, 18 Mar 2025 10:34:11 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-00Cmvl-1H;
	Tue, 18 Mar 2025 10:34:11 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 10/10] net: usb: lan78xx: remove unused struct members
Date: Tue, 18 Mar 2025 10:34:10 +0100
Message-Id: <20250318093410.3047828-11-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318093410.3047828-1-o.rempel@pengutronix.de>
References: <20250318093410.3047828-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Remove unused members from struct lan78xx_net, including:

    driver_priv
    suspend_count
    link_on
    mdix_ctrl
    interface
    fc_autoneg
    fc_request_control

These fields are no longer used in the driver and can be safely removed
as part of a cleanup.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c2ff358a0ec0..08fe9668adaf 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -414,7 +414,6 @@ struct lan78xx_net {
 	struct net_device	*net;
 	struct usb_device	*udev;
 	struct usb_interface	*intf;
-	void			*driver_priv;
 
 	unsigned int		tx_pend_data_len;
 	size_t			n_tx_urbs;
@@ -449,23 +448,15 @@ struct lan78xx_net {
 	unsigned long		flags;
 
 	wait_queue_head_t	*wait;
-	unsigned char		suspend_count;
 
 	unsigned int		maxpacket;
 	struct timer_list	stat_monitor;
 
 	unsigned long		data[5];
 
-	int			link_on;
-	u8			mdix_ctrl;
-
 	u32			chipid;
 	u32			chiprev;
 	struct mii_bus		*mdiobus;
-	phy_interface_t		interface;
-
-	int			fc_autoneg;
-	u8			fc_request_control;
 
 	int			delta;
 	struct statstage	stats;
-- 
2.39.5


