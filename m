Return-Path: <linux-kernel+bounces-242736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2050928C61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEDF1C21B45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5B16D4EC;
	Fri,  5 Jul 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="dymdx28z"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3E3C463
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197284; cv=none; b=pL838PIuafjoXbbmzZKcwQOsFAHX9FoXKjzE3jsyPYuB5vb6mvTyI2dTwbfJuVMyzMc/nFX4gyIk8zRc16jHDjhVU/TdpB0ztqGOig45dFNHFeIwGyyihS3wq+iM65It0VukrkYqFvtkcexPIU8E43Mn2UoXGKzGduCKQxFkrRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197284; c=relaxed/simple;
	bh=fYjKPtuLaZ2rvTns7tjcSPLHAonKpULwJRe753eIIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0SdC7BAVJmLTKKGfR99M16H0D3CZ7fDz6d3GiRcrDZjAHFpbsVbmE7OJpkrPbqd9PicbaRnIQJxjzt6TYe3Fb7ukgMJjMi1+41erurffQsFmrJXkSYrIG9usVDRoxmg0bDXAEn4M+LUbHhCO0ueTOYxKcK7Rjaz/Q5Z+Zgj8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=dymdx28z; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1720197279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTcYQTSND+4YUQLaRdcC8Bj5nXpCzHWY+jMRGob+qxw=;
	b=dymdx28zX9Qp2rsw/Wq1BBW1oaLHO6PKiVnhBEuA5tkMTpaqAkG6AEFJVlDY8pRSeokcJn
	J5kKdwVD6OcM0NMfu+Nx7JUso8WEz0PSqHuMGz8EjxKGMsA/eOeJKkvGpuqskTqmffe/gW
	rRnLZBrPZfc9Ki/QpCFy5va83X8iT0HYFbx8NpQ+Lh0qG66IKv7efq+doWgrHo2ws7KpuB
	FLjgtfXhXI3+dq0ki9XaTp1c2uJAsJ/Q+74cRU7ETEgXNIdD0OPUQXSOqt7L5wlOjheI54
	qQDQGngGqZ7epTYR7ql1qezQ2/OEOcM1zHgeAkqmiL4UQ1wV188COAcEHmH1xw==
X-Envelope-To: mweigand@mweigand.net
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: didi.debian@cknow.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: macromorgan@hotmail.com
X-Envelope-To: andyshrk@163.com
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: amadeus@jmu.edu.cn
X-Envelope-To: f.kardame@manjaro.org
X-Envelope-To: michael.riesch@wolfvision.net
X-Envelope-To: wiagn233@outlook.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Maximilian Weigand <mweigand@mweigand.net>,
	Dragan Simic <dsimic@manjaro.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Furkan Kardame <f.kardame@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH] arm64: dts: rockchip: Add dma-names to uart1 on Pine64 rk3566 devices
Date: Fri,  5 Jul 2024 18:22:14 +0200
Message-ID: <20240705163004.29678-4-didi.debian@cknow.org>
In-Reply-To: <20240705163004.29678-2-didi.debian@cknow.org>
References: <20240705163004.29678-2-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similar to bf6f26deb0e8 ("arm64: dts: rockchip: Add dma-names to uart1
on quartz64-b") also add the dma-names property to the other rk3566
devices from Pine64 with bluetooth functionality.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 1 +
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 1 +
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index d899087bf0b5..ae2536c65a83 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -674,6 +674,7 @@ &tsadc {
 };
 
 &uart1 {
+	dma-names = "tx", "rx";
 	pinctrl-0 = <&uart1m0_ctsn>, <&uart1m0_rtsn>, <&uart1m0_xfer>;
 	pinctrl-names = "default";
 	uart-has-rtscts;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 0b191d8462ad..37a1303d9a34 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -738,6 +738,7 @@ &uart0 {
 };
 
 &uart1 {
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index dd4e9c1893c6..e42c474ef4ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -614,6 +614,7 @@ &tsadc {
 };
 
 &uart1 {
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
 	uart-has-rtscts;
-- 
2.45.2


