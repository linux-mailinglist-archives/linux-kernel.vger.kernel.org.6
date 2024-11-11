Return-Path: <linux-kernel+bounces-403461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B19509C360C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB79B21D65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDDE15624B;
	Mon, 11 Nov 2024 01:31:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA6155336;
	Mon, 11 Nov 2024 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288663; cv=none; b=ldDQnEM3xEGqt6yQfR7tp2QSXCPn2MXue5W7MPUJW5h4z+C4M3MeDn5QKuPx6kcaBTF7NHv8oRiuFgzG/aukVSrTielipMXjQp8In4b2fzG8W+QDxlrTCiPqQP6XFpCMOsuC6k+/zZ0c/cPVmV30r9VImifjFmBw18tPc7yv40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288663; c=relaxed/simple;
	bh=VrcR4honuL6cw9QQVVcd6hnrYiHK7cCudVS6r1m0wBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmwu6TPwVe5JSGXq6cY6D1GVqpVnViLgbofp3q6451T3wwnIeXqGlrIJEH7zhZnRkwCOc8xIaJqNPBePiRKcDZDGbmQuWVFNg1x+8BI/l2LQG4GQvZuYLw8w01+PCSngE5u95lqXKaxVjaozZkCeydb0CmEotlcSk9UZhTZtflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A48FB1CE0;
	Sun, 10 Nov 2024 17:31:31 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A63D3F66E;
	Sun, 10 Nov 2024 17:30:59 -0800 (PST)
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
Subject: [PATCH 08/14] dt-bindings: usb: sunxi-musb: add Allwinner A523 compatible string
Date: Mon, 11 Nov 2024 01:30:27 +0000
Message-ID: <20241111013033.22793-9-andre.przywara@arm.com>
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

The Allwinner A523/T527 SoCs have a MUSB controller fully compatible to
the D1 (and ultimately the A33), with five endpoints.

Add the new name to the list of compatible strings.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
index f972ce976e860..57c17d5a62d63 100644
--- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
@@ -24,6 +24,7 @@ properties:
               - allwinner,sun8i-a83t-musb
               - allwinner,sun20i-d1-musb
               - allwinner,sun50i-h6-musb
+              - allwinner,sun55i-a523-musb
           - const: allwinner,sun8i-a33-musb
       - items:
           - const: allwinner,sun50i-h616-musb
-- 
2.46.2


