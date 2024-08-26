Return-Path: <linux-kernel+bounces-302203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2281C95FB18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54ED01C21083
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1A19B3C7;
	Mon, 26 Aug 2024 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="TMBFS5va"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [164.92.70.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2A19ABC3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.92.70.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705769; cv=none; b=CczrQGmD23VemKPHeUbMjpMDph1In4+clhaKiGzIWJ/KGfep/QbwIfCEJhvG4mf7JN4rL7ytwZXMQerrv8MnCyDASEATExWghxIcAFh4B/msEyuslkx2F48JzamOp8jR5o3Ze7m4//Xy3bq4+3NLYqg8EQImDXspem+mUTc64tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705769; c=relaxed/simple;
	bh=NgeBDAnm0EKMDnJgBstVQHavBCcAmHHPi7y81T53HlU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ch2aszZnJBiEorDbPwnvELJtmOYFhtOreM0Mrrh5HQnDnRfwMxZ3xTKdIhIEDMUdruEbIVp0K4Kzi4q/Sv8E0L81K+OlBMVhHHaMyDIiwgHKvW9qJhqDsoBv77bhoc2a5x9ho9IrOuUifUYPoPFuSyrI7u66zbn76hTcRrcVDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=TMBFS5va; arc=none smtp.client-ip=164.92.70.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Date:
 Subject: Cc: To: From: Message-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1724705762; bh=pCqv5neFrZz2AJ4AKmo3ddlk7/Ez4GptnTqfIqKAGgU=;
 b=TMBFS5vaC5kegUuJ4Jql+NM9xkdymdwbxKoa5eXIaZu77UI5OZC7i5pfIZ36eDwx3V5RgJCa2
 UkaYhoCaAUsKnmOq+CUwr/KlCA7hpuzeoqKgctuxM5cywwCf0bzUhJoiOQLvDPGptQYVmAHq2DC
 sfsyx3VSKvY5XUZ7EAqBEnxbAV3dbzDfLnJM1/ZmiHGJdyb8moVJJV3Rs9QfKBQg8yfR+HY9a5y
 eivp2g8PPBiAsIyMcDzuzjpcyyBKZmF9dJ5GrjaMGh3WsrTptmE7/VF5DadUQcOmxyVBa8GYmXz
 rs7sVeMBZzu4djwWbAes2v2F0ButVPf2LeY4LSXABjwA==
Message-ID: 20240826205538.1066103-3-jonas@kwiboo.se
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Dongjin Kim <tobetter@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
Date: Mon, 26 Aug 2024 20:55:29 +0000
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
 164.92.70.200
X-ForwardEmail-ID: 66ccebdde59276ede820348e

The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
rockchip. Use the proper hardkernel vendor prefix for this board.

Fixes: fd3583267703 ("arm64: dts: rockchip: Add Hardkernel ODROID-M1 board")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index a337f547caf5..9a122f67a6c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Hardkernel ODROID-M1";
-	compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
+	compatible = "hardkernel,rk3568-odroid-m1", "rockchip,rk3568";
 
 	aliases {
 		ethernet0 = &gmac0;
-- 
2.45.2


