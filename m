Return-Path: <linux-kernel+bounces-379489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D09ADF44
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EED028295B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640501B0F2B;
	Thu, 24 Oct 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ICTN9q9M"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158A01AF0BB;
	Thu, 24 Oct 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758832; cv=none; b=FxFNvftyoshYroq5rJTxleg8kAnyZSfyB+zOU6LuSooKBmOWcUNg/G7t74sy8SizmtWezPhDkcinbFEhxZj/5jmscjoYBAKUj5QpevJsIfVbqbLorsYYsyEIQjzI5+DyAwhqvunFdZnWUiHrrcT1yPEbunnwUJ4ZcAkPeXk8reg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758832; c=relaxed/simple;
	bh=n4b4fzSs2P32E19t4asIMv0hMw49CCuiLOuk/E8i2oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QCP4sxYN4pAVPMhwteVky21OHPqyHv3n3nFiQqrZ/rlFyZNN8ddjepmql+iPzmGCiCul4Om2uUGhmrL7cbcquNjuW3qM8Q/O4qNOvQxwc82Du24lMwTSYwVyUUfdBwJVuQH4B/LZXtRCZCmr4q73FvpVJIg+4Suw09cnUxzBNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ICTN9q9M; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=5khT+UHyoZl+t7GP6P
	EOie3EpeFip0Z1zDlZlASstnk=; b=ICTN9q9MtxE+VNSI5W4vjSJUS6CBx+syMu
	xUEBHJ+wusaxtaC2CZbuh3IFiqMEpr6D6odbRSVrDQ1aIKHFj8BMoMXNK9k4XC3h
	TO4HraO2/dvnA67zvj9GSwVV6Dp6s1ObVvoSrRZRi+sQqJ23nS5QBbmTGQbb51xc
	hfZBG2qJs=
Received: from 100ask.localdomain (unknown [36.18.166.195])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v07CBRpnboiLDA--.18S3;
	Thu, 24 Oct 2024 16:31:05 +0800 (CST)
From: Wenliang <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: Wenliang <wenliang202407@163.com>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: [PATCH v3 2/2] dt-bindings: modified ina2xx to match SY24655
Date: Thu, 24 Oct 2024 04:30:55 -0400
Message-Id: <20241024083055.82047-2-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241024083055.82047-1-wenliang202407@163.com>
References: <80bfd968-8f12-46b1-9b72-837502ccdb2a@roeck-us.ne>
 <20241024083055.82047-1-wenliang202407@163.com>
X-CM-TRANSID:_____wD3v07CBRpnboiLDA--.18S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1Dtw1kJrykXF1rAFy3XFb_yoWfAwcEga
	1xAw1UXrZ8JFyYgr4qy397JryFyw1SkF4kAw1jkrZ3Aw4rZrZ0ga4kJ3s0kry8Xay3uF13
	uws5X3yjqrsrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_oGQDUUUUU==
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiowmC02caAfpCAAAAs-
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Adding Silergy's sy24655 as an adapter chip for Ina2xx drivers.

Because it is similar to INA226, the supply voltage and pin definitions
are the same. It also supports IIC communication, with only two
additional registers added for configuring and calculating average power.

Signed-off-by: Wenliang <wenliang202407@163.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 6ae961732e6b..05a9cb36cd82 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -20,6 +20,7 @@ description: |
 properties:
   compatible:
     enum:
+      - silergy,sy24655
       - ti,ina209
       - ti,ina219
       - ti,ina220
-- 
2.17.1


