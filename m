Return-Path: <linux-kernel+bounces-393881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A029BA6AE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA10281935
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1A188592;
	Sun,  3 Nov 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V/WNNszn"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53470AD2D;
	Sun,  3 Nov 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730652002; cv=none; b=lHFo1lsBakdgwAOTsTSBBMoGp9gI75hfIjMYfMJHwKzi9IYxYqS1pz+blYzSZeNq5hbxyBRg+FSCxpcO3W7jJiz903h97j261KVZZJPYrkrwEwKOEggjXFgMeI97AcgDkv+vswGbjsC6bVbOSDxXlI0/YL18lyKplvel4nzka0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730652002; c=relaxed/simple;
	bh=B2XWJUFled52xvHd4GjxQkLraBNHHyiNbE8xycuLjoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM4d3CxyxnK4/aABrIYFesZmdcovKDoeVUstWIQ4WxwUHpUsavMJ4OWUVKM3p088nHiCOvwFSLQpvoG1dFmi3dD/2+vr+pjAQLal1Gn1yaC5fwG9FZxtWIiGagZ4KxOfeQlEvyXTN38qywnTgcnQs38uH520SGMSlwTZanHMiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V/WNNszn; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=FbWwF
	FWXwSYGZ7x6HYor0Xf23KSHwmI8qh1gVcDacTE=; b=V/WNNsznVjwztLOMmEUIn
	rRf5CooDRTz1bjIvAcjVwCewl8YDjA7FcwBWpRDkC/MFx/y5Ln+KqUcY+qVRw3aJ
	tTzIMdvCBdmX2fMTErbPtA2y+Opai7ldxH/axesuvXICEePF2xyCnWYfkMrnKbwm
	vuxiWw43yNnU4TE8W+FXVg=
Received: from 100ask.localdomain (unknown [112.10.131.71])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXX6gupydnXah8Ew--.35873S3;
	Mon, 04 Nov 2024 00:39:14 +0800 (CST)
From: Wenliang <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: book <book@100ask.localdomain>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH linux dev-6.11 v3 2/2] dt-bindings: Add SY24655 to ina2xx devicetree bindings
Date: Sun,  3 Nov 2024 11:39:08 -0500
Message-ID: <20241103163908.11890-2-wenliang202407@163.com>
X-Mailer: git-send-email 2.47.0.229.g8f8d6eee53
In-Reply-To: <20241103163908.11890-1-wenliang202407@163.com>
References: <706d4821-2637-4aac-869b-822f69aebbfa@roeck-us.net>
 <20241103163908.11890-1-wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX6gupydnXah8Ew--.35873S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyfWw1rtw4fCFy5GFyrXrb_yoWftrbEga
	y7Jw1UZFZ8JFyYgr4qy3yxXFyFy3WSkF4kCr1UCrZ5Aw4rZws0ga4kG3sxAryUXrWUu3W3
	ua1kZ3y8Xr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8OJ57UUUUU==
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiNQ+M02cnoLAwsQABs1

From: book <book@100ask.localdomain>

SY24655 is similar to INA226. Its supply voltage and pin definitions
are therefore the same. Compared to INA226, SY24655 has two additional
registers for configuring and calculating average power.

Signed-off-by: book <book@100ask.localdomain>
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


