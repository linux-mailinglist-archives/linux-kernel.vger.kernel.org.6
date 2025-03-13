Return-Path: <linux-kernel+bounces-558954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63BA5ED85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DE93AE540
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88526036A;
	Thu, 13 Mar 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PjtMhAUd"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5F1EFF98;
	Thu, 13 Mar 2025 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853024; cv=none; b=EOQ8kDfN0YBdCOmpzAktNVhj2hNwUIR+es7Ydz/PjHFE5W4hEKYqT4h580X+L4FA4qo/uYWHI5/wIGsdX5LDcI4tjL+M2zFjET4ubypPyAUmaL86+jaPtsMDk0PRvxw1JLqgqr+VuVoOp5g582cKgJGmz1Y2ruvCTd8SXyyVq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853024; c=relaxed/simple;
	bh=BbndaW66x82a843D9atC0ooR505l5IQCJ7cnXblwzKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E/1WatN5pqhCgW/3+ooa8I9ARnNYKuXfgPgW4uK/tP/HeAKP0JzUJqx2Wsl0OhIO4e5bh7PMwrNkOEfeqBMA7xbt+uvKlMC6WozcCO0jk1EdyqPCyIGnsfb5mYnRQp0/rpuJNwWR1O1kQgn3eezw9cRVPYq0Cd0D8+hLcjrcb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PjtMhAUd; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=dmX0Ld07r5g3K2tF5F
	vGX02IifBySoRjjEUiUrveLek=; b=PjtMhAUdESAkBll3vjlSOmc/INWcmfIQPg
	2gP1mesVr6Trg9rMc5u777CA/wcyhLIFRVaXKsBJOpDcF5EFzdRvJHx9ucCnaJIs
	c1nsQ2SzZY7yJ8Dvfo49Z4TLI12Y4FN+fDKd8eScqQ5+9YbNQH5r1e4Jel0WHABO
	e3DAtq3zE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3PycpkdJnzmZnDw--.13922S2;
	Thu, 13 Mar 2025 16:02:51 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Wenliang Yan <wenliang202407@163.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v5 1/2] dt-bindings:Add SQ52206 to ina2xx devicetree bindings
Date: Thu, 13 Mar 2025 04:02:39 -0400
Message-Id: <20250313080240.5506-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250313075501.5435-1-wenliang202407@163.com>
References: <20250313075501.5435-1-wenliang202407@163.com>
X-CM-TRANSID:PigvCgD3PycpkdJnzmZnDw--.13922S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFy7ZFW7Jr4DGr1DGrykXwb_yoW8JrW7p3
	y3GF12gryFgr13W3yUt3WkGr15Zw1kua18KF1DJr1Sga1DXa4Yqa9xKr1kKF1UCr1fZFWr
	WFn2gr48tw40yw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRXdbUUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbibhcP02fSkRQCdAAAsj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add the sq52206 compatible to the ina2xx.yaml

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---

Add the meaning of 'shunt-gain' in SQ52206.

 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 05a9cb36cd82..bf2b334ba5c7 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -20,6 +20,7 @@ description: |
 properties:
   compatible:
     enum:
+      - silergy,sq52206
       - silergy,sy24655
       - ti,ina209
       - ti,ina219
@@ -58,6 +59,9 @@ properties:
       shunt voltage, and a value of 4 maps to ADCRANGE=0 such that a wider
       voltage range is used.
 
+      For SQ52206,the shunt-gain value 1 mapps to ADCRANGE=10/11, the value 2
+      mapps to ADCRANGE=01, and the value 4 mapps to ADCRANGE=00.
+
       The default value is device dependent, and is defined by the reset value
       of PGA/ADCRANGE in the respective configuration registers.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.17.1


