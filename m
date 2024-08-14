Return-Path: <linux-kernel+bounces-286942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D49520A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFDC1F26B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B051BBBE1;
	Wed, 14 Aug 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="KtR4RYZj"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D91BBBDA;
	Wed, 14 Aug 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654894; cv=none; b=WjOsigZY5EHpHur+AimxjU39IfcxRJ08ufpJni9fPEHQt0ANAwbs926rMw3MMNRAtxvrd/BfOPH9rLrXiwMCnlqTwuFpTTAM6gzGMtYQFmDStUfDkrIr3PaRzS4yE3gkarbn5oSyf2ZXG3E/2yweuYrLsZP5bCPWosvsbMHyB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654894; c=relaxed/simple;
	bh=FhHzZ7Fofg7D9EyPQCAwN+Azjn9o2X8l0uUXnvwgdA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQqJxPP+c5kyg1umUKVhkPubxS5/gv+Kx9/dJGQQRVs2s2nvbVACZJBnrqgshI18wwthgywr6f1cbH1prXRaJ65Rqt/dF63dcs+65s1xRvFcL74VPDte/OIR/O+1AyNKKbBxP/N/kd+x2AIUAJ8zcrgNtPxXr2Sk68CubkUqnkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=KtR4RYZj; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id 77AD840460D0; Wed, 14 Aug 2024 17:01:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su 77AD840460D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1723654877;
	bh=FhHzZ7Fofg7D9EyPQCAwN+Azjn9o2X8l0uUXnvwgdA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtR4RYZjwnDWPF/ssvHdl0xyQzyTKC83HYw4xaa0GPlSKthQKyIXpLCpO8cqxExYY
	 HiKxh17wsBAQ1xVvyvLN8fvDVZaAJpo8VnQx+qtM3p0IRlS0taUU2VZ4ir8Qo6es8r
	 5x4gVUbMyCmBwqwH99pkaEIbDaCDhi07wBY/1XmPZGAUu6QewJYwn1CpVcj0WeTeQP
	 jqKUno2sKWARSK/CCbUuB5+aOA6PXn5yhHNyKToU5NTcycoH+mN/UjzSZAlox4WErN
	 vI/LP9mQxm8Z1pEB5qJzEN9GpChczs0RlL458/2awFng1uWu0Ch6xTY8Sdenj7o28l
	 sudT/0euU3WDw==
From: Sergey Bostandzhyan <jin@mediatomb.cc>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Bostandzhyan <jin@mediatomb.cc>
Subject: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add NanoPi R2S Plus
Date: Wed, 14 Aug 2024 17:00:47 +0000
Message-Id: <20240814170048.23816-3-jin@mediatomb.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240814170048.23816-1-jin@mediatomb.cc>
References: <20240814170048.23816-1-jin@mediatomb.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the NanoPi R2S Plus variant, which is an R2S with eMMC.

Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..e3121d4eba18 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -216,6 +216,7 @@ properties:
               - friendlyarm,nanopi-r2c
               - friendlyarm,nanopi-r2c-plus
               - friendlyarm,nanopi-r2s
+              - friendlyarm,nanopi-r2s-plus
           - const: rockchip,rk3328
 
       - description: FriendlyElec NanoPi4 series boards
-- 
2.20.1


