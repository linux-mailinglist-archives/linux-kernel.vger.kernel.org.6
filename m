Return-Path: <linux-kernel+bounces-302204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D572C95FB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34086B236A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B819CCEA;
	Mon, 26 Aug 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="jvKNhVyz"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A41990D9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705778; cv=none; b=rTDaAj2J85GcgRvSbgnMtczE4/0sSVVPI248+UgBpgHjC/dEmJrtqJSlYwKhYVC42Wxq/nciUe9GDm7RcFL+PWsZRWeKM2xpl2Qg3ZHbP19yV8yLZh9GUeBanXcZYEx9o1cTcgLc/dOBv9FoHTeiCnlhORkFVXcpY7O9tIRb2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705778; c=relaxed/simple;
	bh=vO2eWZ2waRHxpnGqt0mvzeKQz0jLeoj0MI5ECRTWm7A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kA1LDpuVqG4ME7QGETlbCAeK9zPSbiZpphwI9fshHTckIiSrAltANPoj1YJ41sUGIGI6R5tNxWKQK0DguvjaUG4E5gbIMLlvJHYB6b6heAvSfqWxBxohihYvAKemijkmA6JnVN/ES/wybvlT6H4Id1XBKQhqK6NRPqw62c+0ltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=jvKNhVyz; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Date:
 Subject: Cc: To: From: Message-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1724705762; bh=rBviEIkX4NSS97yuSkuvpa/5bbBsSkrEIl8Rpy757A8=;
 b=jvKNhVyzBp1KI+Qik5JwQyEhAtzwOtah/4OrZheQjAVwj32DpPBQe8OcgqaaSy/lbqqfqmcfw
 x4mDv3wk15+F8QJWPrZcA/9xbBAz46qFFbEHtRD/u98QM5+1gsVh6C7q+0dTBNqkdj4xilnBwtf
 M2sW/g+tGZ1wTIwg1WA3DG5ggTv4nUDEZuDEfsslngPE27Z0/mgGBNUrMT7PqUQR9qMiO8hvVDj
 BfcTFzSTJKCy4BpoCQJcw7AOHrQPmN+TJ/JZ7WdAsgJNnjz3AByehprflTJHWTVnpD/WPzdXOKO
 5w59mc89HUE/WVQvYeHbxvBdRcLyxtLCiFVFSmkkGjJg==
Message-ID: 20240826205538.1066103-4-jonas@kwiboo.se
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/4] dt-bindings: arm: rockchip: Add Hardkernel ODROID-M1S
Date: Mon, 26 Aug 2024 20:55:30 +0000
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826205538.1066103-1-jonas@kwiboo.se>
References: <20240826205538.1066103-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ccebe2e59276ede82034a0

The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.

Add devicetree binding documentation for the Hardkernel ODROID-M1S board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index f08e9f2f5dfc..9e29a5ecc94d 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -598,6 +598,11 @@ properties:
           - const: hardkernel,rk3568-odroid-m1
           - const: rockchip,rk3568
 
+      - description: Hardkernel Odroid M1S
+        items:
+          - const: hardkernel,rk3566-odroid-m1s
+          - const: rockchip,rk3566
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.45.2


