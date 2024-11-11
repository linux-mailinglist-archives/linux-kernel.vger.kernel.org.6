Return-Path: <linux-kernel+bounces-403462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C39C360F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CD0B21EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF204158520;
	Mon, 11 Nov 2024 01:31:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCFD156997;
	Mon, 11 Nov 2024 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288665; cv=none; b=N118/Lk88G2gaS1Ln54iWiFluxGUCsybcB7se/6v1Co1xrAuFFnl5b4OPNSP425wbXGbuRjIFsCgZo/ysgnSJ82GJLehc+grHrfm4bma9IHpkIVafEykj2/P4SC+Hi8NII8QyXh08mBWdcX1xQ8OAI98Q5wNZ8L5Bb369zZ00G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288665; c=relaxed/simple;
	bh=QMrladCcmc33UDoppwI2Mj3WEkVy8BFwUOhKtfkegqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZhU3cy5jGjiOg6N3c0aK3YpQhFMrrK/anyiktWWgufMSD3Vq/oSRKGbosFYm5I4XsDpXA/xrzOfDbzO5f8LfFYvQUbZdpX9aRrgQ1OheTXQhGuSX3VyxycoX96ku/gg4FAtBjsMkrLBjxUIRFjJY8RG247OEz0Ii7eeZ8MKt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E2D913D5;
	Sun, 10 Nov 2024 17:31:33 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04A193F66E;
	Sun, 10 Nov 2024 17:31:01 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 09/14] dt-bindings: usb: add A523 compatible string for EHCI and OCHI
Date: Mon, 11 Nov 2024 01:30:28 +0000
Message-ID: <20241111013033.22793-10-andre.przywara@arm.com>
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

The Allwinner A523/T527 feature generic EHCI and OHCI compatible USB-2.0
host controllers (in addition to an MUSB and an XHCI controller).

Add the new name to the list of supported compatible strings.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 2ed178f16a782..9c5884c1e7c53 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -31,6 +31,7 @@ properties:
               - allwinner,sun50i-a64-ehci
               - allwinner,sun50i-h6-ehci
               - allwinner,sun50i-h616-ehci
+              - allwinner,sun55i-a523-ehci
               - allwinner,sun5i-a13-ehci
               - allwinner,sun6i-a31-ehci
               - allwinner,sun7i-a20-ehci
diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index b9576015736bf..f1ae45aa4c86c 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -18,6 +18,7 @@ properties:
               - allwinner,sun50i-a64-ohci
               - allwinner,sun50i-h6-ohci
               - allwinner,sun50i-h616-ohci
+              - allwinner,sun55i-a523-ohci
               - allwinner,sun5i-a13-ohci
               - allwinner,sun6i-a31-ohci
               - allwinner,sun7i-a20-ohci
-- 
2.46.2


