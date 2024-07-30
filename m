Return-Path: <linux-kernel+bounces-267250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D734940F07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB971C20C75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CDC1990C7;
	Tue, 30 Jul 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VNta/Rpn"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12539198852;
	Tue, 30 Jul 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335162; cv=none; b=AYyxq4iFCjujeuaW71nGQ5dH18iv0W4MVZydAVgYIRM8Mllb4rp5whA/Tro4yjn4KJ4lZ209Mws1irUK/0U1hnCpFzWq06ocp63aUTx/Q8WhUDTFg5CuTnKh+5yVo4m3ld+7dmk9LZm5yFu+cmvUpBdCVTdq87jr4/KGdbgZxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335162; c=relaxed/simple;
	bh=BKIbb85ctX7IF5XjOrG2kQo54pW3e8Dmu2zx8oGBjY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5edeIEnSruCZ0HvrUSR/cVAbR+6mBMyk5gCC4YBcnjYazsK7DxkZxo1dpNQcFg9xDPaMJFQy+cc/uDrSl6cOgQgv3w6hkks7TuRK1gL5BGJr0EHXR2zgFXuIkWqeRyLVxl5XgaExFWRCvpwr0egA9geW7UtIww8ORslIqY10vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VNta/Rpn; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=m/8GT
	GsNRYMgI37cG9UOkJiw2XcJBGDdiSUAQ2dlerk=; b=VNta/Rpncid69i+rYTTCO
	swE2nBhcdGyTVYfizl9cSqu225+cPi/9trU2xjiolhNoW8j8zcfS5NtJRDU6LbC5
	Ly+Epm6YZcRllrN9ANCXkjoj/iA2Ej1FXbtsokZazZHFZv5gsXPAFtSzYH4BtQJq
	F1nvHrQlES2sCKmRhkumfI=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3f_div6hmxPMCFA--.50877S3;
	Tue, 30 Jul 2024 18:24:38 +0800 (CST)
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
Subject: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add Cool Pi CM5 GenBook
Date: Tue, 30 Jul 2024 18:24:32 +0800
Message-Id: <20240730102433.540260-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730102433.540260-1-andyshrk@163.com>
References: <20240730102433.540260-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f_div6hmxPMCFA--.50877S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryruw4DCw1fXw45ur4xCrg_yoWkJrXEka
	4xA3ykGF4FqF1Y93Wjyay8Gry5Aw42kFn7AF45JF4DAwn8JwsrtF95J3sayF15ua13urn3
	Ca1rJryDXFnxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJMa8UUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0ggsXmWXzXvc-gAAsO

Add Cool Pi CM5 GenBook, a laptop powered by RK3588.

Cool Pi GenBook works with a carrier board connect with CM5.

Signed-off-by: Andy Yan <andyshrk@163.com>

---

Changes in v3:
- Wrap commit message by a maximum 75 chars per line
- Remove the superfluous blank line
- Use "coolpi,pi-cm5-genbook" instead of "coolpi,genbook"

Changes in v2:
- Descripte it as Cool Pi CM5 GenBook

 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 2ad835f4068e..18ea4160e3e2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -96,6 +96,13 @@ properties:
           - const: coolpi,pi-cm5
           - const: rockchip,rk3588
 
+      - description: Cool Pi CM5 GenBook
+        items:
+          - enum:
+              - coolpi,pi-cm5-genbook
+          - const: coolpi,pi-cm5
+          - const: rockchip,rk3588
+
       - description: Cool Pi 4 Model B
         items:
           - const: coolpi,pi-4b
-- 
2.34.1


