Return-Path: <linux-kernel+bounces-313185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA0B96A19D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB82B20A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B733185925;
	Tue,  3 Sep 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="lRF0sOfX"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5216F8EF;
	Tue,  3 Sep 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376041; cv=none; b=EOQH+O6FuAa8zW3JformaaoPQoED7c516ADbTFvY+JMNmygrsmfF0eA6eJ8BgddQ5CWBefXqMvBHJDis7t4EGuXX86rDxzgXtgFvzr1scVOgwsJY5/73/R5CsYOWPKL+rZ9gzaFcEZ7/AzFv0NiMCD52AH1hdc2+TvBSt4DQPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376041; c=relaxed/simple;
	bh=uQjmMkrKPgcHbPmDQeBNR3RB/8fL2wxGhFOy33nKSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucMum8flq2AiS0PZaG//v9pMMAieK3xbThJGUrDKCAEEKC0spb8dqUPc6OIlLEvxz9VZLx/6HfIS+6lpIzlzmxgrU4Of1YgzJ1PSp76u70jfziwFy9Lm9tMUFK5ymoIhg+57BcA6CiOFDap+hPXXeOEDSSGsNQnl3koKEpBsFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=lRF0sOfX; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.162.211])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 9612E78909;
	Tue,  3 Sep 2024 23:07:04 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 9612E78909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725376028;
	bh=zR3hlRfJu9pUORdEkrrtBMeJ/HUUYi7vgBq4lCRz1Bc=;
	h=From:To:Cc:Subject:Date:From;
	b=lRF0sOfX8N9i53ksyw+5lCfNFv2MVVIIFDLMXnYI6NpEOD8mr/ditcwRtbCESZCJf
	 X5X7Sfl4+aBfTWeFESChsA6ZbzUhQiTfXS1PKVCBxENIl4eAuSLkWoqyayYvG4m8W3
	 j08R+oNxQHx89KNY6Lv4vNxaLl8xcFc+GjSUCRC4=
From: Junhao Xie <bigfoot@classfun.cn>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Junhao Xie <bigfoot@classfun.cn>
Subject: [PATCH] USB: serial: pl2303: add device id for Macrosilicon MS3020
Date: Tue,  3 Sep 2024 23:06:38 +0800
Message-ID: <20240903150638.3850030-1-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device id for the Macrosilicon MS3020 which is a
PL2303HXN based device.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 drivers/usb/serial/pl2303.c | 1 +
 drivers/usb/serial/pl2303.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d93f5d584557..8e327fcb222f 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -118,6 +118,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
 	{ USB_DEVICE(IBM_VENDOR_ID, IBM_PRODUCT_ID) },
+	{ USB_DEVICE(MACROSILICON_VENDOR_ID, MACROSILICON_MS3020_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 732f9b13ad5d..d60eda7f6eda 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -171,3 +171,7 @@
 /* Allied Telesis VT-Kit3 */
 #define AT_VENDOR_ID		0x0caa
 #define AT_VTKIT3_PRODUCT_ID	0x3001
+
+/* Macrosilicon MS3020 */
+#define MACROSILICON_VENDOR_ID		0x345f
+#define MACROSILICON_MS3020_PRODUCT_ID	0x3020
-- 
2.46.0


