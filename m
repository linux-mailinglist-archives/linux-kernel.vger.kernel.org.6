Return-Path: <linux-kernel+bounces-403466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5F9C3618
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D5F1C2244F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD0165F13;
	Mon, 11 Nov 2024 01:31:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E915ADA1;
	Mon, 11 Nov 2024 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288672; cv=none; b=gJKynZsJi2qGSYEdBjz6gjabBon/8j0zhi5HWcDFu37wxVp3bpLjDI8v3zi2YhulkqUicb+VfYLnFcjONEOunMdX0jk9xYjGZUA/QNd2ahP2trc3aFABwq/YAqbDDWBoiDS7zNO1SgR69hBiH01tCDdLLFjdiVgr9yLoDiWcqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288672; c=relaxed/simple;
	bh=8ZzeiKIa14SqtLylMvp/nXqWeWk+w9HC7+C1CXcTQuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLzcMlze/krAVeeJ1attyvR0T8gl7LEXeVHUgHerLRZujCoN52np1io5GVON9YtdpJd+68qjKuQiyth2KHg1F7HqPPkyc7nBGL2f1jWYo5V5gFUUkNH1DXWxgUYPf34OYosbzX0U5Bpbg00EWf48kUO0bfCuxVnG5HUxVK8cpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A243A13D5;
	Sun, 10 Nov 2024 17:31:40 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EB483F66E;
	Sun, 10 Nov 2024 17:31:09 -0800 (PST)
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
Subject: [PATCH 13/14] dt-bindings: arm: sunxi: Add Avaota A1 board
Date: Mon, 11 Nov 2024 01:30:32 +0000
Message-ID: <20241111013033.22793-14-andre.przywara@arm.com>
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

The Avaota A1 is an Open Source hardware router board using the
Allwinner T527 SoC.

Add its compatible name to the list.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 4aa15f3668e03..41d6509f48602 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -1070,4 +1070,9 @@ properties:
           - const: xunlong,orangepi-zero3
           - const: allwinner,sun50i-h618
 
+      - description: YuzukiHD Avaota A1
+        items:
+          - const: yuzukihd,avaota-a1
+          - const: allwinner,sun55i-t527
+
 additionalProperties: true
-- 
2.46.2


