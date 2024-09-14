Return-Path: <linux-kernel+bounces-329461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4B9791AD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5131C2156C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA531D04B9;
	Sat, 14 Sep 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="V+2k1ms5"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15401CDFCD;
	Sat, 14 Sep 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325773; cv=none; b=A6trrj3rYw2h5tsrapM76ECCYZLCpiwZ5hTM50TSIylPbioHspLtt7BkRw4WS+sqPnqkWLBSWaZwGIMSXxWUc7HrLUIO7ETGHF2GGEzJOLD+cKEdvYVhGwsqJtwG9MFrsPA1Ag67pUUrlO9wBxDxnmy/cACWUaMVinrqm69m/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325773; c=relaxed/simple;
	bh=TGse2xgHyrJ86lk+geFp8JWO8clvO33za4oO/yaOSzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSXqJHh/5XETkfHG9Oh5LErv/vt0P6tOWjnWSyXttsqECYqALjvFsltIldfJBAXJLQbv7DqWxMiS1+ktpN7UO4lrPH/UUGn+gHwVyrNmI2xXoUE5KFNF1D1BetqTfLHiMgKUrcnRTBhPgqIOIe1RL2E/d+wXshybLkT34nuVrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=V+2k1ms5; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.122])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id A7DF3789E0;
	Sat, 14 Sep 2024 22:56:03 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn A7DF3789E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1726325764;
	bh=lRER49IU2r+IDAkeANEnbgPaU7VQG0ThpFJyDhD3UTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+2k1ms5UMmefM+geGYeYZO+fYHmmzGyqDOsjdZEC0sDV3ToXnh0TComQxRfrz0kf
	 iz5ix40YG7uWPOooQFsB7D34VKLTijs4lcsnDMFXTpc+mviFYYrMBq/onkAk1ivAOS
	 NmTJEO77jHY9eRjS15hujq6FqOg8o1yNBt/osavs=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
Date: Sat, 14 Sep 2024 22:55:48 +0800
Message-ID: <20240914145549.879936-3-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240914145549.879936-1-bigfoot@classfun.cn>
References: <20240914145549.879936-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents Ariaboard Photonicat which is a router based on RK3568 SoC.

Link: https://ariaboard.com/
Link: https://photonicat.com/

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..c35541b56175 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566
 
+      - description: Ariaboard Photonicat
+        items:
+          - const: ariaboard,photonicat
+          - const: rockchip,rk3568
+
       - description: ArmSoM Sige7 board
         items:
           - const: armsom,sige7
-- 
2.46.0


