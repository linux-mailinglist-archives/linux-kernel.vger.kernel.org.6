Return-Path: <linux-kernel+bounces-231621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76207919AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15DE1C21EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF03194132;
	Wed, 26 Jun 2024 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="TKM+2wRD"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464B1940B0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443032; cv=none; b=SHl43U8KxPRLSOCqhlgfZ4zWAUs0KBlNfHiYHjQf77GRFdFIKAHH4Ukrf/APESkXi2xG7moEu9xq5kJ3DiI+CikVSJdHN4ICrWzhFXiUGIq2C+/fcfOQ0OblKjEg6K8BqBqb2zzL51zDZnHxJoN6aKjIu0m6myD9VxuwSanIiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443032; c=relaxed/simple;
	bh=1IybheleqOX5uCgnHK8MQH2kT6HCabRYmw6iEw7Zchw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBu+OCVDrwX+FpMDYICZG5+QUsbYk+3jMXHVHbff9H4b3Sf2rXVuwTvG9PqezI9WrwluhpXiiY4ilsInedWr5QFWFdLsuTpAWRK5VCV8CIM4mwBB9dgzL6vnkouV9sT2v/z/21ewMgu0mjDQI+mtyi2hIIL2LQ+ToxIZlavY0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=TKM+2wRD; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1719443011; bh=/08aZoPZcm6PqJnpe9JVrfDo0qAhTWbb4DSpQzJcuOk=;
 b=TKM+2wRDUoj7HqTxPmAGENGTUN51l/sTWl/n217gys02Vc1nRBYVgUH3s9QA6YEVmUc75Z75Q
 u5VoeYn9K3zaUV5FM7fKR3sZPtdQQeo/JLYwoighKGvuXARjdZvqXGapwPodP4juLdgBwAQz8Mm
 Yg3+Eg6uYpgfVedlOh7ICtRq0WIOYrf64XPa47/7WBcP5oep2RlKFMjHfS6XHVdCQFRatADk5/P
 VivZNovGTKUEuUXdCoLpRsV4ncOOHH3vRTsarM09boMmctIAS9YOH0bDAJVdlhNgkPug/mdcj9U
 5JFY72daY713wt8+hWR/MAC9Uo9fJwnMEWygt/UwYT1w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add Xunlong Orange Pi 3B
Date: Wed, 26 Jun 2024 23:03:11 +0000
Message-ID: <20240626230319.1425316-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626230319.1425316-1-jonas@kwiboo.se>
References: <20240626230319.1425316-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 667c9e41c59a3ae6af4b1629

Add devicetree binding for the Xunlong Orange Pi 3B board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Add v1.1/v2.1 suffix to support new hw revision

Acked-by tag was not collected because of this change.
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index bbb2d7c217fc..3710e06618bc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -988,6 +988,14 @@ properties:
           - const: wolfvision,rk3568-pf5
           - const: rockchip,rk3568
 
+      - description: Xunlong Orange Pi 3B
+        items:
+          - enum:
+              - xunlong,orangepi-3b-v1.1
+              - xunlong,orangepi-3b-v2.1
+          - const: xunlong,orangepi-3b
+          - const: rockchip,rk3566
+
       - description: Xunlong Orange Pi 5 Plus
         items:
           - const: xunlong,orangepi-5-plus
-- 
2.45.2


