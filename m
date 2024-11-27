Return-Path: <linux-kernel+bounces-423570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4389DA9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7769D282286
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAA81FF7A0;
	Wed, 27 Nov 2024 14:20:39 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61471FF601;
	Wed, 27 Nov 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717239; cv=none; b=DXQ2w/1au4knkm0/Fi8ZBLqq2eADba1WezgqS4VyG/1PZzwN5d+oJd6J+iQ4QRyVUyo7E4JcwVcSD9rV8CvioPajANRQe5pxQb+YpAe714zI6jt0UexHI8waDHHxLq1iNIjArLU5tl9CWkBjl3VfAf19fbakQEMJGo5MWFCmOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717239; c=relaxed/simple;
	bh=7ouDv0eJhWxuNacYNEXzjOkSLWY1KsFrGPEcfDKnXls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5Clyp4jcYQDOQ4/N7ExSZW3pVKuczSKuSFS5ufXcGFJCjxK8aUtkGwM0+YDQW0fAL65rfiKb9jLSn97sfZKpOpJPmeP6g5x0E65aBfIt9Fi9tg5r6lgCp86NTz/Re7LQhHksyhUZnKN1Dc/Iqy9mtOProYCT4HnUkLPy5audMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 4AREKPoC083271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 27 Nov 2024 22:20:25 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 22:20:25 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <alexandre.belloni@bootlin.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-rtc@vger.kernel>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>, <ycliang@andestech.com>
Subject: [PATCH V4 RESEND 3/3] MAINTAINERS: Add entry for ATCRTC100 RTC driver
Date: Wed, 27 Nov 2024 22:19:39 +0800
Message-ID: <20241127141939.1570952-4-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127141939.1570952-1-cl634@andestech.com>
References: <20241127141939.1570952-1-cl634@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 4AREKPoC083271

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
index 99c5b41df823..6cc21af6eb23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3559,6 +3559,12 @@ F:	drivers/power/reset/atc260x-poweroff.c
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


