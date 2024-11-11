Return-Path: <linux-kernel+bounces-403465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09B9C3616
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC60B1F22D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D9515B0EE;
	Mon, 11 Nov 2024 01:31:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4715ADB4;
	Mon, 11 Nov 2024 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288670; cv=none; b=Xcb3OXs/VtU0e48BccAOdvwmmoQHUo+NmCCZlWZV+iXNCCax6aE8A42i7zYYZ1tI90/lP3cMMcFVoHjb3y7Z4dzqwFtUVNhDA3TI2ajoSFGQFzXmMm2DtcJBXx1qyngppA6PuDJ4V5vRGwYhUNRyASf2HMLuPFiic5nkbs8Z1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288670; c=relaxed/simple;
	bh=TwpZYl9QvhwfqqOCIafcqps97uL6a+bHMAe2qDWUr3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+ueZfhWY9IPgOtTFVcewns7B5cNewJxyF8RH9Hxj8hoSPAJphF5/Shr6hw7gA5Bg8rCa82Fhs7rImnElQinLMRRfSoScxyW8gc7+SWC2h8MkVX+rKhTcIhTUEOsFqOtaWudxR3MfXHq97r06T8sSKRT1+SUdNlIOnKCpWmvzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEBB11480;
	Sun, 10 Nov 2024 17:31:38 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B31A3F66E;
	Sun, 10 Nov 2024 17:31:07 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] dt-bindings: vendor-prefixes: Add YuzukiHD name
Date: Mon, 11 Nov 2024 01:30:31 +0000
Message-ID: <20241111013033.22793-13-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241111013033.22793-1-andre.przywara@arm.com>
References: <20241111013033.22793-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YuzukiHD provides Open Source Hardware designs, and also offers
ready-made builds of them: https://github.com/YuzukiHD

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe4..936dcafd6adeb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1709,6 +1709,8 @@ patternProperties:
     description: Shenzhen Yashi Changhua Intelligent Technology Co., Ltd.
   "^ysoft,.*":
     description: Y Soft Corporation a.s.
+  "^yuzukihd,.*":
+    description: YuzukiHD Open Source Hardware
   "^zarlink,.*":
     description: Zarlink Semiconductor
   "^zealz,.*":
-- 
2.46.2


