Return-Path: <linux-kernel+bounces-254047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532D932C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD31283FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BE19E7FC;
	Tue, 16 Jul 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0e4kOoNv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ADD27733;
	Tue, 16 Jul 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145069; cv=none; b=ppabfemFa+iyBsZSbrkBpCIhD6FgNG2IrUnHOXl9vCcVv9jjM2EdlLUaZbJdCvzp7sP5D0Jod/EMDYP3E6++UoQkWj95ZIr88iVgM3OmZRBWbg60CLh475lwfiXjJJH5ENqNQSqXjGSX3wWZiQe4HjC70clWrlQbM0HizKU7Dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145069; c=relaxed/simple;
	bh=Q2Mlft8Y56s8Vjeg4O3l1zZuQNCYpMaZI5odbUhc1lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjnbYQbcXB0u7rFfM+fYqNyfEhPVrE1yildcbEuFDSxGT2X5EGJVffK/G5DdnzXHJHRwpd2e/aAreKkYbN1MfIQ5xCZdtHeFUV2teOTN3XmXsbvWHSdTBTUzyEbcUFIAlomTVzkBpn97YpONdukMgCefgmS1HSYSqAwPM7LKVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0e4kOoNv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721145066;
	bh=Q2Mlft8Y56s8Vjeg4O3l1zZuQNCYpMaZI5odbUhc1lE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0e4kOoNvRAg+zhLmyQowbrH3Entrkmhzhl4RK3TjIzQHF4On8mAgD2YaYtTMLJ82r
	 ZsEvOu/6pKTE4eyAhtSjD+RjbfQ/doIW7M0IWyFB5wDzfiYy2QUV+46J3PU4tzi2OK
	 TdXmY0lr2WLVtbcgJZCYdFyPy8CRZkrS7GRO79ZaKnXHqnhghU3NiyRUruFHjB/VYw
	 8F7RsB6PD1iNVtVp6UI9YVFC6sKoTAiWhk/DNGd0CYB2oeZM4pSMpW0SUwHzzhMdtz
	 nDF3Xdoil3aSQEJZSgJMtiFcz3jAv8FU/JEK1hSp1UIMpSTCmWTgni+4Ha0H/aZNxk
	 FN/Vn5MYzL6yw==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 990B637821CE;
	Tue, 16 Jul 2024 15:51:05 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Date: Tue, 16 Jul 2024 16:51:04 +0100
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: add Firefly CORE PX30 JD4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-rockchip-px30-firefly-v1-1-60cdad3023a3@collabora.com>
References: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
In-Reply-To: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Christopher Obbard <chris.obbard@collabora.com>
X-Mailer: b4 0.13.0

The Firefly CORE PX30 JD4 board is a SOM and motherboard bundle from
Firefly. Add devicetree binding documentation for it.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index e04c213a0dee4..19e06e1253e15 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -148,6 +148,11 @@ properties:
           - const: engicam,px30-core
           - const: rockchip,px30
 
+      - description: Firefly Core PX30 JD4
+        items:
+          - const: firefly,core-px30-jd4
+          - const: rockchip,px30
+
       - description: Firefly Firefly-RK3288
         items:
           - enum:

-- 
2.45.2


