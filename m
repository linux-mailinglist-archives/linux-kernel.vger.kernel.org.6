Return-Path: <linux-kernel+bounces-183906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE358C9FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B61F283275
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABEF1369BF;
	Mon, 20 May 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="l8Iufx47"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB4136E3D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219014; cv=none; b=e3WwaeOJSDmB9dHvlfYmCnsXDSON5ZmGdXJqP//W0jVQ8VDD86kYER98RdT5yvHKQcLyHHe30Dr1AUZFVwRIhaKWQ5aw3umqm/g6ExoUOLbcLaPq0Ph7Jq3WE0zBa9bdjwq/rmmKsS18q6LzHfgDBzyBrQ/xyTEdBzQ+BA2X7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219014; c=relaxed/simple;
	bh=myz+zjMaiVIdprC73JF/2+HbHVKa1GuOWNljRbXJcVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7fXqckKVfryZRpt4/8Hp0ok6yAnuy5In+H4KgX8YbxhOfYa6KaU+VI6mVzpvm5D9okJSUX2AXLmZMCeoRkjPhcm4E0zLgWSB5fIX00aGPMrFUVHT4/1ChS0KL3+obgC8fXI/b8YaGZkWwQ1jfM49hNPeHh4uLCW4S2LAX1Fy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=l8Iufx47; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Envelope-To: robh@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1716219010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNS/7gofY3jzirMluCy8uHvSKsq2/rQzRSXNUnOuMMw=;
	b=l8Iufx47Hj4tHsXkEUjLD/JKzTfntMxvvAdkEVNIc9o0DjWVHpIeEW0WCAzEXQFuJSdIYb
	AazFv/K/GjwNQbDs/Vs2oMK46eu7vu3yutctecQgj4Pvns/wm7mcave2KOraZex07yuzNA
	i4rzHuir5cE/BazDM4OzbG2kEbjiy8dTQ6IzzACbGk3qoWgdf58yTqUNpNJ5etPGRQzOfL
	AEKQN+NASPZqnzx8O0QF7HmnaEk8GXUHrS4VOCwKuHHb2vbicCFwMBPIraQDOTr4SSfpbq
	S8hw4BvJNcggoG01x0uJ4ugeyPyHBEIreOJ2MtOlOYNOGu3XifBEbYatIQIGTw==
X-Envelope-To: amartinz@shiftphones.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: ~postmarketos/upstreaming@lists.sr.ht
X-Envelope-To: konrad.dybcio@linaro.org
X-Envelope-To: linux-arm-msm@vger.kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: luca.weiss@fairphone.com
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: andersson@kernel.org
X-Envelope-To: krzysztof.kozlowski@linaro.org
X-Envelope-To: caleb@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Caleb Connolly <caleb@postmarketos.org>
Date: Mon, 20 May 2024 17:29:41 +0200
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add QCM6490 SHIFTphone 8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-otter-bringup-v2-1-d717d1dab6b8@linaro.org>
References: <20240520-otter-bringup-v2-0-d717d1dab6b8@linaro.org>
In-Reply-To: <20240520-otter-bringup-v2-0-d717d1dab6b8@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Martinz <amartinz@shiftphones.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Caleb Connolly <caleb@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=899;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=myz+zjMaiVIdprC73JF/2+HbHVKa1GuOWNljRbXJcVE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmS2yAKhy1j5xsmkcH60fctyXGaV1YMB8E0yskQ
 EJt+K7bysGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZktsgAAKCRAFgzErGV9k
 tqEID/9g0PIWEor5bYqUsba6C3+7Yj8x+1Ndhd15Za7IKhAsEu8PsbEfwV5Dx3QXh93SJ5HaQRY
 7FadPoyoq8rggKlkVeA4l3EX/N0O4rhZq8bf4E5gflnOC73Ox/5c8X9Q+tOnU24UcWQOcSyg0dV
 9K1r8kcn8Xy8wc7U+xykHo1gYcpE0j6w/Z0pOHiqsPwICKhqW8wHpP8u49V/abf+5BSkvHvDZc/
 5KIi8hlJoOfD8V3DwXeZz4GHLvgmn8mELYAv0kqKbhq3lOVxH52ygAyL8BibDTl1iIWr1hpbPrQ
 538leBRsOvWiGZYS67PYu14qiqJ+38Bw+yCvZlpS+pTXorZh+uhAVSjnFA+j3ZWINfIXcuHNACr
 J/qlz88Rb+7LPPbOGgbV1VCeGfVfnq14bXgFwhrTA0/lNPb2ghaw0nPI1W+soaJLx+zYtjI0Bl6
 g2NKMP19jPwM3LRsrDi5zdAknlBJwN8o/Jx/VcDamY4jazLZCpu08kA4fsI+xDxczFmT76zBLLU
 6jCBtfcLzfkasdvy/N1zGZNsjuHv+FAV1U5WInWLgJ8pskDcHqtcR1lJQMwUDUr0w9+sNom83Yw
 7Xa8sQIxeITQijI5S9dQkx5GnAo4D8Xxi0DeungB+yaCCgRD1s5uJnJYh5h4LGhH6nShYdVJGWO
 bPsdvavavQeCuOg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Migadu-Flow: FLOW_OUT

The SHIFTphone 8 (codename otter) is a smartphone based on the QCM6490
SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Caleb Connolly <caleb@postmarketos.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..d4b2d39f914e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -364,8 +364,9 @@ properties:
           - enum:
               - fairphone,fp5
               - qcom,qcm6490-idp
               - qcom,qcs6490-rb3gen2
+              - shift,otter
           - const: qcom,qcm6490
 
       - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
         items:

-- 
2.45.0


