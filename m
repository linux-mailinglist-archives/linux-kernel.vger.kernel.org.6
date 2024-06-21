Return-Path: <linux-kernel+bounces-224054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E09911CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9724281972
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2C16B390;
	Fri, 21 Jun 2024 07:19:22 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60A3C2F;
	Fri, 21 Jun 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954362; cv=none; b=LfbEmBdKz3kxHxX7kvvPtjVATpwLT1Jws5/I90+NPtczHWxu8BckFINHHOhpVKP0VyQbVg52GaEa3F5uUSLhfAmI8QKmvw4Xf/Qj1Kyg+zjiSKxRd9j0REhTbVo/3IH1t3yVQIvMm7VdnbQPvvOfgj1J8fdPFf2rkqdSq3KGp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954362; c=relaxed/simple;
	bh=Vbt3KEbr1m6YxqC56yXnCO80Xjj2EUYisNm8PUBM71w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g21YN/sT74Q+3ooh4+EEox3IXk9p34iByRyD0lzG6+yhyXlulTyEVh+dgekgRrKZCJ1GNDS07nzx5jcynKq4SVMUQ+OuyKsZpCfHVmY7rSz1ro1TOFHA667/9/6GsUu8aMfeUTQ4JUHqJoQ2lHWgUbBxhSRJNdWSiXwcMv4rIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from localhost.localdomain (ip5f5af243.dynamic.kabel-deutschland.de [95.90.242.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5ABFF61E5FE05;
	Fri, 21 Jun 2024 09:19:04 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kiran K <kiran.k@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Fix spelling of *intermediate* in comment
Date: Fri, 21 Jun 2024 09:18:57 +0200
Message-ID: <20240621071858.148358-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: f3b845e0aea3 ("Bluetooth: btintel: Add support to download intermediate loader")
Cc: Kiran K <kiran.k@intel.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0c855c3ee1c1..bd4b2ee4eeee 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2635,7 +2635,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 		return err;
 
 	/* If image type returned is BTINTEL_IMG_IML, then controller supports
-	 * intermediae loader image
+	 * intermediate loader image
 	 */
 	if (ver->img_type == BTINTEL_IMG_IML) {
 		err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
-- 
2.45.2


