Return-Path: <linux-kernel+bounces-187938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21AA8CDAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD272813F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7784A56;
	Thu, 23 May 2024 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8W0AOho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4355FB9C;
	Thu, 23 May 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493511; cv=none; b=Fwc0ajzU3/Egly0mWJkxR5ApyF18uAqyhd8R6s9Gcq2rLVh0Rkyq9rsJ16NRisagRC1cODnOvfNVeYYw/VtDAzeKYlQu0i3qAjS7z7OKH81Hnu3sQjGkMecbhBaLMAAxinJkljYrFr3O6TX15sI7oXhKdpRCt8nJWqAV3jtRaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493511; c=relaxed/simple;
	bh=JbL1YQc7XIQR2UADcbvWlAd8dwqij8i2yvBbh/aBN54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3+RNvnpnDitLXhtFDWuQjIT26xAklOF5n1RrT4FuOXZ0VfKgBCmzuqaItnGICBooPzWvMfmlHRYgQW1dcP3y1+itWor2+XYy/cdqnIt5NbzwF5HHK93GxPIbxoyJmFcHrdoCpVw/JyI6QdZcqAjgOUjnOwZbh1m2fAXxTXcly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8W0AOho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D8CC3277B;
	Thu, 23 May 2024 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716493509;
	bh=JbL1YQc7XIQR2UADcbvWlAd8dwqij8i2yvBbh/aBN54=;
	h=From:To:Cc:Subject:Date:From;
	b=u8W0AOho/ZcpS7IMP8I+Rg3DUahaQ24B69IGzgC/TjwNfxDEF+hBV9A0SL9r7GONm
	 LnBOdelRcangdL1aObr85Cxg90s0pUlaSywkYSshS5ZNXMCJSb0uTYri+irgcdJmeW
	 qoR2FvYu5IbgoMXgxv24qmrOqaEOW5QwA6RwDUl9MtFJbBEQu90l13b5aQ1JcE07D6
	 IJvhg3JXVuYhJ3/M7Fi0kz5LZqAFNP1Z6PbGaQVVS2VtYIcKC62A+3tp7Krf0Vi+6u
	 xD0xyConBiekYJaqoYuXNZFx0EbVzWhLUMiQfFaZtfVfl7x+uhYvC2JLHTzTkwh2LE
	 cFxrpkaXww16A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: realtek,rts5411: Add missing "additionalProperties" on child nodes
Date: Thu, 23 May 2024 14:44:59 -0500
Message-ID: <20240523194500.2958192-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All nodes need an explicit additionalProperties or unevaluatedProperties
unless a $ref has one that's false. As that is not the case with
usb-device.yaml, "additionalProperties" is needed here.

Fixes: c44d9dab31d6 ("dt-bindings: usb: Add downstream facing ports to realtek binding")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
index 0874fc21f66f..6577a61cc075 100644
--- a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
+++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
@@ -65,6 +65,7 @@ patternProperties:
     description: The hard wired USB devices
     type: object
     $ref: /schemas/usb/usb-device.yaml
+    additionalProperties: true
 
 required:
   - peer-hub
-- 
2.43.0


