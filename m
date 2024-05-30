Return-Path: <linux-kernel+bounces-195400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C019B8D4C33
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DD91C23834
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16246183065;
	Thu, 30 May 2024 13:02:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7309A17CA10
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074127; cv=none; b=rv76WIrMlRuDh1VhI7a/EoVX+cM22aTzVD6IjCIkvlAvqjhyM0W6TOwBnfu0jnwD7xaIBO0G69R2lUF+4JNVLNbXHxjuUdyNc5qIux7bizpxi+Gfn+wH4GQzdx0SCGupRGqHZUwxxOlCsCKvhoowRKTFuR87R4YbqEGKNdKeTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074127; c=relaxed/simple;
	bh=Zclcy1rakeT5f0M+PlcV2Mt4kyDmQgT74mkvgQcSmBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swZH5X86lRe/1B2Z2Lt4H4retf3dOrvccJmBo6BPWbHem1lWAhn6r9WsUILEBvqt7jaaDsLooiT70oQCAFbyCj1tbptck55Kz4KGkE9shj1uFRhi9DoIHXhNaqn7DUE+2u748g7mAwQZcIYDSM1aaCzQrBe33Y2R7xp7zJXZ9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sCfPq-00061d-1p; Thu, 30 May 2024 15:01:58 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sCfPp-003b90-Hq; Thu, 30 May 2024 15:01:57 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sCfPp-006vb6-1Q;
	Thu, 30 May 2024 15:01:57 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Date: Thu, 30 May 2024 15:01:56 +0200
Message-Id: <20240530130156.1651174-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The maximum number of AKM suites will be set to two if not specified by
the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
specify up to ten AKM suites in the akm_suites array.

Without only the first two AKM suites will be used, further ones are
ignored.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Current wpa_supplicant/hostapd only put a maximum of two into the
akm_suites array as well, a patch changing this can be found here:
http://lists.infradead.org/pipermail/hostap/2024-May/042720.html
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index b909a7665e9cc..908dfe01c30d7 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4358,6 +4358,8 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 				 BIT(NL80211_IFTYPE_P2P_GO) |
 				 BIT(NL80211_IFTYPE_AP);
 
+	wiphy->max_num_akm_suites = CFG80211_MAX_NUM_AKM_SUITES;
+
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
 
-- 
2.39.2


