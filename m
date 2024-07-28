Return-Path: <linux-kernel+bounces-264488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2486293E414
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AD1281C07
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C31A269;
	Sun, 28 Jul 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j1TpHLGL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ACAC8E0;
	Sun, 28 Jul 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722154864; cv=none; b=mwSG9NQnpVR9vRHd3XylPKuQNy3lHijzce3jIVDleTaqk9EJ2GqYCV2eYtnSxUu9Vse66VdZrd/3chYan9NSPeX3znO/AIeubI7UqciEFPxP5YEVlMEIm1o0Dh008UmcxheX1/+pOqKYyHOHy1Mc+bW9Kw5fc8gwBJJXW67/dYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722154864; c=relaxed/simple;
	bh=Nsoc8R5VBlidygLVBQl83egHyrMaJoplkAazsiIG8Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oVhjuEW6Lm/SDJe1xWbTAbFJF4FYzx8N6d7IFdG9FqQzxV2/0tCO9a13uC8wepW/ff64CFLIOC3WyFpo3m0rln8sn/QP/RqJl75MzPMqZZqfWcIdNijcnpfNsS2CC02qjBVwmbH9Trd9qbFRDdgQ0GvKqFD3VyiG9vLHICbDU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j1TpHLGL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t5vLD
	tWEMifZZfpDT+3oLY3w2bvWuIp/6iTxRMQ+2f4=; b=j1TpHLGLYNNYWHZrb47w8
	V4/5jXmnSBs2xL6C6noyqqOxYTT+Z9vBe/1F1AeMtoW224wotDQdeOIX8uCfWRsT
	MWEeMSb0aSU6CCOBdQLkDKssMQwq906i2UgHioaa77fsVqg6jhYx7yNWJ5Uydyh1
	slXWkCIg4O1Yu731ZU/HpI=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wCnb242_6VmJZF9Bw--.37149S3;
	Sun, 28 Jul 2024 16:20:11 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: dsimic@manjaro.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add Cool Pi CM5 GenBook
Date: Sun, 28 Jul 2024 16:20:03 +0800
Message-Id: <20240728082004.36575-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728082004.36575-1-andyshrk@163.com>
References: <20240728082004.36575-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnb242_6VmJZF9Bw--.37149S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryrur4UZry3WFy5Cr4rKrg_yoWfZrgEka
	4xZrWkGF4rtF1F93Wjyay8Gry5Aw42kF97C3W5JF4DAwn8J39xtFykt34SkFy8uF17urn3
	Ca1rXrWDWFnxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRANVyUUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQYqXmVOBz4pYwAAsD

Add Cool Pi CM5 GenBook, a laptop powered by RK3588.

Cool Pi GenBook works with a carrier board connect
with CM5.

Signed-off-by: Andy Yan <andyshrk@163.com>

---

Changes in v2:
- Descripte it as Cool Pi CM5 GenBook

 Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..a9bfb87e69f5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -96,6 +96,14 @@ properties:
           - const: coolpi,pi-cm5
           - const: rockchip,rk3588
 
+      - description: Cool Pi CM5 GenBook
+        items:
+          - enum:
+              - coolpi,genbook
+          - const: coolpi,pi-cm5
+          - const: rockchip,rk3588
+
+
       - description: Cool Pi 4 Model B
         items:
           - const: coolpi,pi-4b
-- 
2.34.1


