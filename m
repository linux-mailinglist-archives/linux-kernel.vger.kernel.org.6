Return-Path: <linux-kernel+bounces-362127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A838699B168
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E98283AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358D13B59E;
	Sat, 12 Oct 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FQ/qmjW5"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA2E10940;
	Sat, 12 Oct 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728716840; cv=none; b=ctMe8o5xokR5lpPfOQSdE+psKUN6sq8k3hOR/wkg8IkJ3Jcs9bJWVqWa+QnE/GpLnvr+TyPbe49v3jMyg5ZfVIL41Fme8ttHhYVDQrcvL5a2nBXQBWqFtKgQDOTN1fP65piXhhxKJ1wLxW5pvyqUu9ZhBUa/UNvnq1LYfRHXrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728716840; c=relaxed/simple;
	bh=qTkGrv0p7+4vinrP3/grAVnhUVtY10seEVTYYhHkma4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Jw/ms3Mx5T+TV9s/EFm72VfUZrTld9BE5lD+qD3kZCVz474DhiY5N2O2RrepvvwZcy92Edwbe7kWTvbI2W9Rx610cpJ64z2jLVZpHqhlA/XY3jGoEdlhr5XdCdinrYfwmo/AkyVCFTYHmarOnh+HC3YcpeLPksThiM8KKUk/Now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FQ/qmjW5; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=quz+2hMWjcczLuJItS
	DKvNUVNrU4bXl5LbBt2SkvvLc=; b=FQ/qmjW595pERdGdNqUZx73pAwXZwHuPr8
	DzchcGeRWQjhguTRc+M7lqYvxiZlnOBthqNGgP2F013qM2ygWuyc9ccRNSJxJ832
	gExP+oqHnK3zSk22P1cAx9uINjoFj3vcKFOaBBjG0l4VEd05EayWzVBfH1mo9fCe
	IF2K5O1AE=
Received: from 100ask.localdomain (unknown [36.18.172.102])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3nwP1HwpnNwWcAg--.5517S3;
	Sat, 12 Oct 2024 15:06:39 +0800 (CST)
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
Subject: [PATCH linux dev-6.11 2/2] v3: dt-bindings: modified ina2xx to match SY24655
Date: Sat, 12 Oct 2024 03:06:27 -0400
Message-Id: <20241012070627.20788-2-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241012070627.20788-1-wenliang202407@163.com>
References: <f7653d58-9cee-4496-91b8-55dda44289bc@roeck-us.net>
 <20241012070627.20788-1-wenliang202407@163.com>
X-CM-TRANSID:_____wD3nwP1HwpnNwWcAg--.5517S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyfGr1fGw4DZw4DJryfCrg_yoWDArcEga
	yxAw18XFZ8XFyYgF1DA395Jr1ayw4a9r48Aw15JrsYywn3ZrWqga4kJ3sxAr4xWay3uF13
	uan5GrWvqrsrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUbiL0UUUUUU==
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiRwt202cKG1NL7QAAsq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Modified the binding of ina2xx to make it compatible with SY24655. 

Signed-off-by: Wenliang <wenliang202407@163.com>
---

SY24655 is a fixed gain power monitor from Silergy, with a power supply
of 2.7-5.5V and communication mode of IIC capable of detecting bus voltage
and voltage on shunt resistors. Its first 5 registers are identical to
ina226, and also have alert and limit functions. So, the sy24655 is
compatible with the ina2xx devices.

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


