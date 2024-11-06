Return-Path: <linux-kernel+bounces-398434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F033E9BF13A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B425928155E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44CE202F84;
	Wed,  6 Nov 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cIMmw6GT"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD93202640;
	Wed,  6 Nov 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905715; cv=none; b=BpSA7xAwrpKpTRnTgz5yfNHYzkdUxow1v1KYbXmeAx83d1uotXqTFTjzsYy6LFmpf2mER0ps7Tf8xWHv1MCYTUkUof/d0K9cwmyNXSYx0EqHJDCstbkGHnfcBVN2QmFMFjmWpUjF6YT99981+zDDI0cp9rhHZscQRNAVlwOte6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905715; c=relaxed/simple;
	bh=uUkzMZj41LPzNgfXs5EAY3tFteaQ0YPumtOsRRyblWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXyc96yueAq9RU8VlQzUVhhnRZAkqJegme6YpTGu5ALJC1OJoa0Rba5SkLuF53ss4+ueuDVNwp4E2ARje2B5Q//MbxGscEXEQZmyB25rDoFBfnxDrjuHDioMx3Hzso4A0flak7J6fCRts/sB7HrnjP9JqZW41Axf0tGeKXgt6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cIMmw6GT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Qq2rN
	0eCOt1I3VzQ5611bxUaUOaauIcjUKKhXAI8CQY=; b=cIMmw6GTfnvnpy/FmyTO+
	paKW4ydRHjXiNvp0B7IwnQhaqRFDsCY6sRMld7eREfxLVpOkB/kOQtfZBoIPLzbG
	ZOi7sJC3l5bzUK9g5RPwRWbXuWs8A2+tEdNXcGQbX6fLcfuK3IvxCMBP4xHURlwp
	cmGtY0KUt2ruWwJKat3HzQ=
Received: from 100ask.localdomain (unknown [112.10.131.71])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAn76_NhStnn+5rCg--.55144S3;
	Wed, 06 Nov 2024 23:05:54 +0800 (CST)
From: wenliang <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: wenliang <wenliang202407@163.com>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/2] dt-bindings: Add SY24655 to ina2xx devicetree bindings
Date: Wed,  6 Nov 2024 10:05:47 -0500
Message-ID: <20241106150547.2538-2-wenliang202407@163.com>
X-Mailer: git-send-email 2.47.0.229.g8f8d6eee53
In-Reply-To: <20241106150547.2538-1-wenliang202407@163.com>
References: <b3da9f78-c7d5-4bbf-80f3-bf5b52270792@roeck-us.net>
 <20241106150547.2538-1-wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAn76_NhStnn+5rCg--.55144S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUJrW8tFy5tryrJr47Arb_yoWfAwcEgF
	WxA3WUXFZ8JFyYgr4qv3yxXryFyw1IkF4kCw1UCrZ5Aws5Zrs0ga4kG3s8CryUXay3uw13
	ua1kX3yqqrnFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNmiiDUUUUU==
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiRx6P02crflpf+QAAsL

SY24655 is similar to INA226. Its supply voltage and pin definitions
are therefore the same. Compared to INA226, SY24655 has two additional
registers for configuring and calculating average power.

Signed-off-by: wenliang <wenliang202407@163.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.47.0.229.g8f8d6eee53


