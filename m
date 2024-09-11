Return-Path: <linux-kernel+bounces-324880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351F975205
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A111C22CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749BE189BA4;
	Wed, 11 Sep 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eH8YtZ4Z"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18161E50B;
	Wed, 11 Sep 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057587; cv=none; b=FIN4ck+8bvE3tuwHXsKd6pqHARFUyUNJInMlBS6fEOmJQVlPNMfPewpQxyjSNOKYWmdgppRlkrwSpiN7Xs98ecL0zJOv7pF7PiceVziFMZ/ep/emVGPfkrIz35AEA1FjI658VkeC8cTR2gYl8egI+UnxtsYyZJhhvIdGUA3kty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057587; c=relaxed/simple;
	bh=CCF36q2SdqMmoqLpIug7/RD5Zcpp7cgkuZs//0709JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Fs6Ilb/qgYoEBXkbf1ZZZtLPj3Ek9NWMaWEg85iy8k8dBFsQHRr3deoG/YmQuQjIiASt6sS+7DE90nHdpk/Ucdj04WhM7+muvyRmrerBEOEjvJdhGq+785ALunocELcEAIJli4aLU1iWjYBG8MLEpQ7OXGFbakrL6DIrUQQQtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eH8YtZ4Z; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=VIdwaVN4f8RG9byl7M
	H0HVoJuWCYEmfT9jRFzeAU+xo=; b=eH8YtZ4ZLURg53kFk6Cda2hiJG2O7tsnjP
	HErByxSLMxZb0HkITwituH4owqj6jIPE+iDn6X96lq5YJsxLMh3fdazotcBvGuTf
	YBF6briRcKjhoeFsCCFutI5sTGUWuVTOt9QM0X40OlFACfRcqoK79BRFplRw9RQk
	EjUw41my0=
Received: from 100ask.localdomain (unknown [36.23.125.181])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgBXdnYyjOFmHo+DBQ--.2634S3;
	Wed, 11 Sep 2024 20:25:28 +0800 (CST)
From: Wenliang <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: Wenliang <wenliang202407@163.com>,
	jdelvare@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH linux dev-6.11 2/2] dt-bindings: modified ina2xx to match SY24655(SQ52205)
Date: Wed, 11 Sep 2024 08:25:18 -0400
Message-Id: <20240911122518.41393-2-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240911122518.41393-1-wenliang202407@163.com>
References: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
 <20240911122518.41393-1-wenliang202407@163.com>
X-CM-TRANSID:sCgvCgBXdnYyjOFmHo+DBQ--.2634S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyfGr1fGw4UXr4DKFy8Krg_yoWxCwbEgF
	4xXw4UXr95XFyYgr1DAayvqr1ftw1akF4kCw1UCrZ5AwsrZrZ0ga4kJ3sxCr1Uuay3uF1r
	uan5JrWqqrsrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREEfO7UUUUU==
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiGRlX02XAk-i8rgAAsY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Modified the binding of ina2xx to make it compatible with SY24655. 

Signed-off-by: Wenliang <wenliang202407@163.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 6ae961732e6b..400e7cefad17 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -29,6 +29,7 @@ properties:
       - ti,ina237
       - ti,ina238
       - ti,ina260
+      - silergy,sy24655
 
   reg:
     maxItems: 1
-- 
2.17.1


