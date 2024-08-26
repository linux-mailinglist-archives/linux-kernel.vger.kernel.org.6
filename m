Return-Path: <linux-kernel+bounces-300740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318FC95E7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624891C213D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D0E78C76;
	Mon, 26 Aug 2024 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="W4ZvxhUn"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81929CE7;
	Mon, 26 Aug 2024 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724647789; cv=none; b=e4Ck3TQGOsuzDpFWxikOGqZ0Zm9Es/I8KWNnPn3YEns56ao9r3Ry1i8pChh0uwQezrMFDQ2I5lHZdkLCxAr8d6dDHRtVcZQH0NwaQ3XtL+RP4RsDm5I3aWhw8/zrOM82uyVWF9jmHPd/7O804U9AyuyOYpga+eGKRl9cbP6RnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724647789; c=relaxed/simple;
	bh=HVf7gkki2CvASEGPTqQczGF3ztQOREGYSMauyOqDT5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnPFZJwn3IWv1rZD2ABRW3wgq6+FiKsEe3EltB3wQKWu8M5r3ESp4IALrXNyiLrDT2qQKZY+fA5/zTnhHm5g6UA3e5nryHbGTa72AUGfGSDLUnlmtKMKeMx5CnG5/UwbYajLx8/Rp+P6aClkKt9kcQ2zJvnmaqovO7Ln50bTyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=W4ZvxhUn; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-arm-node1.classfun.cn (unknown [124.72.161.4])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id EB63E78922;
	Mon, 26 Aug 2024 12:46:00 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn EB63E78922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1724647561;
	bh=fLYjuCo1RmAoQOic56outz/OhHOlYn5yO+2WrQYyZkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4ZvxhUnRmGghJcOYB8eIIn/csugOoL3/G3hCdkkUfGaeAWEmIgh5VBKuQnz9Qfzp
	 8v7MdU6wHbghCTlkuGhB9mOXQAqswBd86QHJ1YJ6sYf8opK6CtXfWvZlsATye6ReWZ
	 tP0qo/JOQIQW96Ptd6P6X7WVkP6TsS+Ho/zDbsu8=
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
Subject: [PATCH 2/3] dt-bindings: arm: rockchip: Add LCKFB Taishan Pi RK3566
Date: Mon, 26 Aug 2024 12:44:12 +0800
Message-ID: <20240826044530.726458-3-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826044530.726458-1-bigfoot@classfun.cn>
References: <20240826044530.726458-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents LCKFB Taishan Pi which is a SBC based on the RK3566 SoC.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..1fe3fbc36ced 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -622,6 +622,11 @@ properties:
           - const: leez,p710
           - const: rockchip,rk3399
 
+      - description: LCKFB Taishan Pi RK3566
+        items:
+          - const: lckfb,tspi-rk3566
+          - const: rockchip,rk3566
+
       - description: Lunzn FastRhino R66S / R68S
         items:
           - enum:
-- 
2.45.2


