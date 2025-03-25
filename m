Return-Path: <linux-kernel+bounces-575154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18115A6EE55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2E3B55F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B825523D;
	Tue, 25 Mar 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="liVmaXlJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE322E3378;
	Tue, 25 Mar 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900430; cv=none; b=KjxIA8lfCtkH9hu+9vYkrlFK8gyoMWoCntL4vCidFoZjF4GAoqEXkcB7XjQw/3I1EYwqSUYTa2t6FD5mpf/AjyW/F3zyIdR/F4/4XjeQ6wTkQIe//DuLvsfGKU8PIUyGoM0wSlSY4DQXG5Iv/es3Z0cRjLtPbk9dcgsngG/NA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900430; c=relaxed/simple;
	bh=phowVCc4uTjG/AswATQd9ZKQuxqVfWCIa0kdrQaIi0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e/5+aFK6BtehCMFLFPAkSH6DeMU7naB6wF0g3SsTNAh4EqAsY0yMYvOuQ2MX4LFOz/yQgEXQ/gNODq9VTGzRU8G6kQ9u/9phZdKQCZbxgg378LwQt0uSbjQj9N0gyRB6HmdNd9SgGlBX1XYu5/a2dexkKTXmmGE4hD+KGJbR0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=liVmaXlJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742900428; x=1774436428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=phowVCc4uTjG/AswATQd9ZKQuxqVfWCIa0kdrQaIi0I=;
  b=liVmaXlJL49FLenH8rZuetx7ONNZqCQrsHbh9Tf9deU8VXPs0NXtPLSf
   whcB4xaiistSYWjjsP9v0LR3JsSmJtLyd1bD1dHldshAO+3cavbS2S7PX
   pW7t1cY3eaQt5Fe7ZuAsRUijX331vfGrfebik8nmvpHLeInvXN/RcQ4Zg
   8Lm+ZO0J7zjDnMbNRcFK0PF5xba0R49b9HBEIraF1ekIyLY1pdq9NAHKh
   8kfg57Ibqh6sd5xXR9CO63fm/or/CHmVu/ekFXt16Kfl1tzwFxmj8fOAA
   7v+hM6zPkSvWE2dtqt+bA6vgtumntI6OWy3+3P2zdNRVkHhcUnQFYLPTP
   g==;
X-CSE-ConnectionGUID: QCM7Q2TFRhOTjnxaI+S+Ng==
X-CSE-MsgGUID: YxEN5IEmSd2KEJ+Bkl5RiA==
X-IronPort-AV: E=Sophos;i="6.14,274,1736838000"; 
   d="scan'208";a="271054509"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2025 04:00:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 04:00:01 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 25 Mar 2025 03:59:58 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: ethernet: microchip: lan743x: Fix memory allocation failure
Date: Tue, 25 Mar 2025 16:26:53 +0530
Message-ID: <20250325105653.6607-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The driver allocates ring elements using GFP_DMA flags. There is
no dependency from LAN743x hardware on memory allocation should be
in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC

Fixes: e8684db191e4 ("net: ethernet: microchip: lan743x: Fix skb allocation failure")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
v0
-Initial Commit

v1
-Modified GFP flags from GFP_KERNEL to GFP_ATOMIC
-added fixes tag

---
 drivers/net/ethernet/microchip/lan743x_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 23760b613d3e..8b6b9b6efe18 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2495,8 +2495,7 @@ static int lan743x_rx_process_buffer(struct lan743x_rx *rx)
 
 	/* save existing skb, allocate new skb and map to dma */
 	skb = buffer_info->skb;
-	if (lan743x_rx_init_ring_element(rx, rx->last_head,
-					 GFP_ATOMIC | GFP_DMA)) {
+	if (lan743x_rx_init_ring_element(rx, rx->last_head, GFP_ATOMIC)) {
 		/* failed to allocate next skb.
 		 * Memory is very low.
 		 * Drop this packet and reuse buffer.
-- 
2.25.1


