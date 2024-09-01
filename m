Return-Path: <linux-kernel+bounces-310199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E05967627
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20958281977
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D716F0D0;
	Sun,  1 Sep 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="P8j46QGB"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A5157465
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725189649; cv=none; b=GoYJfQB+/trBYON9TgnqMiiHk49rAYvIbe9nviaxGpoYIWNpsoECjQNVB9ihKziipGyCHgPVDzauGNYZfcswtN1muIQo1T0KNRkpDemqR3wk5S+yzrCv61Jb2fF+GapNChM5ltF4cuJVupNnRDunRZgbfXFcyqG2FvqlCSS3GH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725189649; c=relaxed/simple;
	bh=HoZPIusXuVN5IrExVyTetu/h5iu0ElVGDAiSoTaFCd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU85Nqe/+qxJzCRr+jTX/AqXoBoffAMO38raa/LWYfWEDKRpa3n5zfkUFdVBoNdywSvoy9IIyjOa4X0CGBtYAlYpJSbMS5YxLDCuWNZSgNMQstdrVOPwJuNEuAHXcxD0oGSLAVCsQC2LKDcXeLG6hOATT7ivyr5jCeCPZKqcRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=P8j46QGB; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725189633; bh=QRMQHn0PZt4Cg7zwDP1ucgJnlnivck4MuK7e8FtsTjg=;
 b=P8j46QGBso+OYf6lNV5qxXOhaUoGXp+k7GfghVDM4AV08StyuI8TSOWOp8lBifnrQOgUTqcTn
 ggKgT9qdFCK/fJJn8FW6iEEfFiJFjk173Lrmx7zqj5kmgTFvFjl34drRo39kDz+lNcGg5igAFDT
 WJqAkYnwHmYBWkZZ1f7ZUKgZzwkdPCSeF+heUjQFch7WA2dKwzNKLE+tnNP43LE4dpjsqQtpAKq
 FTj+HnKDRHcBG5V2wwtbieI3Fa+AjoUywwHn4ViO3C+x6892vMWPrbQuBEERhGYE5KpO3fNwc6R
 4+JTLPa8zWwAyk0TCeX9jWpEnosAecoEIXdro4frX2rw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Dongjin Kim <tobetter@gmail.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add Hardkernel ODROID-M2
Date: Sun,  1 Sep 2024 11:20:14 +0000
Message-ID: <20240901112020.3224704-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901112020.3224704-1-jonas@kwiboo.se>
References: <20240901112020.3224704-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66d44e00556ab34bbda73d2b

The Hardkernel ODROID-M2 is a single-board computer based on Rockchip
RK3588S2 SoC. It features e.g. 8/16 GB LPDDR5 RAM, 64 GB eMMC, SD-card,
GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0/Type-C.

Add devicetree binding documentation for the Hardkernel ODROID-M2 board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 0c810037200d..ff9f2f529beb 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -605,6 +605,11 @@ properties:
           - const: hardkernel,odroid-m1s
           - const: rockchip,rk3566
 
+      - description: Hardkernel Odroid M2
+        items:
+          - const: hardkernel,odroid-m2
+          - const: rockchip,rk3588s
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.46.0


