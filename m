Return-Path: <linux-kernel+bounces-409415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385169C8CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BF1B36271
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570CD14389F;
	Thu, 14 Nov 2024 14:01:07 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8A7603A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592867; cv=none; b=UP13R7t04sQ5lFKiXJx77mLcqsK+sRgWh6ePTTydIaDCkW9A+ibsF8U1/L6WxuPZFAe9XKAvve09mgWzucyhzVZ7cXWZrac+hr/2Xgdydub6VMjfKqA3/8qjh5xeCPTcCSkRgTQhgpN1cgQsGUnuUkKqEsvCDnOJWSymgETEn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592867; c=relaxed/simple;
	bh=U5i6WRMa3M6C5Yls+tvu8AQmzd+azkQDFRgsp3saWiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyA19PFSAMsRMhbD6VZ4yMIL4kgibzKh64tg5v7ANAwev4MtgXqDkMnPmGol1rbeQX77LWhwmDH8S3+jbDL5lv5ibBsg8MHGuKXZLe7IOQuSRNyJhcF40XCyuiFwdrbO60nI3DfhQ8kDvojNnkvwx/nBFbKFb7Ypa6g8J4LzBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 4AEE0sGD035854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 14 Nov 2024 22:00:54 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 22:00:55 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <alexandre.belloni@bootlin.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tim609@andestech.com>
Subject: [PATCH V4 RESEND 3/3] MAINTAINERS: Add entry for ATCRTC100 RTC driver
Date: Thu, 14 Nov 2024 22:00:23 +0800
Message-ID: <20241114140023.3534980-4-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114140023.3534980-1-cl634@andestech.com>
References: <20241114140023.3534980-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 4AEE0sGD035854

Add support entry for the Andes ATCRTC100 RTC driver in the MAINTAINERS file.

Signed-off-by: CL Wang <cl634@andestech.com>
---
Changes for v3:
 - Initial entry for the ATCRTC100 RTC driver.

Changes for v4:
 - No changes
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91d0609db61b..703d61052add 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3538,6 +3538,12 @@ F:	drivers/power/reset/atc260x-poweroff.c
 F:	drivers/regulator/atc260x-regulator.c
 F:	include/linux/mfd/atc260x/*
 
+ATCRTC100 RTC DRIVER
+M:	CL Wang <cl634@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/rtc/andestech,atcrtc100.yaml
+F:	drivers/rtc/rtc-atcrtc100.c
+
 ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
 S:	Maintained
-- 
2.34.1


