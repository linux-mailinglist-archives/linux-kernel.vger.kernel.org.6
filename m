Return-Path: <linux-kernel+bounces-304045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B9961915
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30D7284D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900021D4147;
	Tue, 27 Aug 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="pJhYjijI"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E30185941
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793534; cv=none; b=snovQBOKWAiG48nuQJb5xNjHNh5YgszPpITm8Q4Bi1fSsYm3maAFzL1cfUf5IHLhl39w0kySRgXdtfIzImcJdoC4Uif5215iO1opablLC6Ci1NIlXTkAVQHaSMHNuW0fI5KD/JdS/8/WqfvZhSQhljGAL2tPYrevQwIkmZTphU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793534; c=relaxed/simple;
	bh=J9m0TH3RTLGDZhK/FsmumDatc5ekmxd/lNLAfoeSBjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkAeQA5bkEhFtJ+8pvZjB2KE0XBnWrWCxJdVjoq+7DQkHDSZ6GChu3UpZ2wbm+lU33Zio8d0fMFJYrioKie5ymS/iJMbsJkJN6Wy2OBEd9yH0iCiTv4kghRTNyUzqghzkfRiQ3hrrUy5BqqL1dZW3pQGRte5d2vJQd9g93JxZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=pJhYjijI; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1724793523; bh=M4orfDghI+N/dIO/I56PBgYD5LKiULr/+/ZxLsuuTW4=;
 b=pJhYjijIyuSMRQVq1YCL/0/wzLUTGHkxk1QLbM0J6BIJgYt5+qTMEgGOpNSjwmx0A7yFRRBGn
 uvjLPT5zgTbTGiXD01SXMa7L3pIPKOfkU/SeA+ye8XFXPcpUS12kpb4W5qUGYNjQtSwRleA8JCU
 rKtwlzugmzDiuTJMlESsZLDuFzkIEEn1lmOO95HuGsFGm5+HiXammZK0RdVxoqMkCMj1GRicnYJ
 z30lEqsxr4RP+zqrHi0xmjn+BPfCvYOAHcrv7R9xHf/xsIWwGPh2wUrBBWZhu/a7K71EoxCD5cN
 SdltP8ajhIsBH1uL/sx6rOl5xYBdUqagqm56jI0pfylA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dongjin Kim <tobetter@gmail.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/4] arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
Date: Tue, 27 Aug 2024 21:18:16 +0000
Message-ID: <20240827211825.1419820-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827211825.1419820-1-jonas@kwiboo.se>
References: <20240827211825.1419820-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ce42afec205819dc6f17a3

The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
rockchip. Use the proper hardkernel vendor prefix for this board, while
at it also drop the redundant soc prefix.

Fixes: fd3583267703 ("arm64: dts: rockchip: Add Hardkernel ODROID-M1 board")
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Remove the redundant rk3568- soc prefix
- Collect r-b tag
---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index a337f547caf5..6a02db4f073f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Hardkernel ODROID-M1";
-	compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
+	compatible = "hardkernel,odroid-m1", "rockchip,rk3568";
 
 	aliases {
 		ethernet0 = &gmac0;
-- 
2.46.0


