Return-Path: <linux-kernel+bounces-414442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3303C9D2823
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E1CB2BDFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392841CDA3D;
	Tue, 19 Nov 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="T1WUS4l0"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BAD2AE74;
	Tue, 19 Nov 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026283; cv=none; b=j5Ropcgbu4WNtPkPvBnxHPg2ISOmrjnpCjT9mSlYU4t08HlzaNwSyBhhTVCCjAkw3kgL70lzPkPBMfZDx57lnXVb8IQ/geiaKZ8Q7GjiUzI1zpAaE8xvHkhkej4bSgdk8E1ADcgh7D1TS0vckRMoKkDuQ6q025jONnx5dV2Ec/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026283; c=relaxed/simple;
	bh=cr80setFQkb+HicAmRHKidwGqzhdJSMoba5ZQwQOueQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIdWsl0ujoA1VlHYE5EPvX1PGyahMK7wc8Kx5TSkGYxrD4T7Q8TPu+xjAPNXZXjLh1mrHkGGGobhazwZw+SjGdQ+IcW3GCy/X0f1oaQAUm/zcWCK1E9VFbL1QnnT/3nizSz1khM6wu8W3lIbLePr+3O1lOOd+pdrII9/QNaPgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=T1WUS4l0; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Y2Rlk
	M23+q/RmSNnamSnu5n9SxZAH/rknzHQi6Lbzeo=; b=T1WUS4l0qLl2g6xPZL+2B
	H+3BQe0gOGyTA3LoH+OsTkxnhZPT0Ay/KkAkBK76H9eJzw7kl/Qv6duSzbDMXCDL
	OOKQauYMeaZKl+IjyhClr+IZqeBS/wW/cIoraZkTpMl/Ji2dxioUd2zFDtuYtzdL
	zlw2TqJDTiumwlZCyKXadw=
Received: from localhost.localdomain (unknown [122.225.16.198])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3H6a0mzxn+SwgBw--.35577S3;
	Tue, 19 Nov 2024 22:08:03 +0800 (CST)
From: JuenKit Yip <hunterteaegg@126.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	peteryin.openbmc@gmail.com,
	noahwang.wang@outlook.com,
	festevam@gmail.com,
	marex@denx.de,
	lukas@wunner.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: JuenKit Yip <hunterteaegg@126.com>
Subject: [PATCH 2/2] dt-bindings: trivial-devices: add sensirion,sht3x
Date: Tue, 19 Nov 2024 09:07:25 -0500
Message-Id: <20241119140725.75297-2-hunterteaegg@126.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241119140725.75297-1-hunterteaegg@126.com>
References: <20241119140725.75297-1-hunterteaegg@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6a0mzxn+SwgBw--.35577S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1DZFyrGry5Kw1UuFy7GFg_yoWfZrc_A3
	Wxuw1kAr48JF95t39Ikr1xJr1Yk3yIkFn7Cw1Uta97uw1xu39xKFyvqa4av3y7GrWUu3Wr
	urn7KrZFqwnrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRZMa0DUUUUU==
X-CM-SenderInfo: xkxq3v5uwhtvljj6ij2wof0z/1tbifhuc7Gc8lqAyUQAAsb

add sensirion,sht3x as trivial device for devicetree support

Signed-off-by: JuenKit Yip <hunterteaegg@126.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 9bf0fb17a05e..be006b21b1ea 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -333,6 +333,8 @@ properties:
           - sensirion,sgp40
             # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
+            # Sensirion SHT3x-DIS humidity and temperature sensor with I2C interface
+          - sensirion,sht3x
             # Sensirion temperature & humidity sensor with I2C interface
           - sensirion,sht4x
             # Sensortek 3 axis accelerometer
-- 
2.39.5


