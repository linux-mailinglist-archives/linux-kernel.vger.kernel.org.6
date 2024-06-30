Return-Path: <linux-kernel+bounces-235266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8BA91D291
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C9C28169C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F0F15534E;
	Sun, 30 Jun 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UNNtXGRc"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08913DBBE;
	Sun, 30 Jun 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719763250; cv=none; b=XwNBE/BYAvm8JImQ4sZaKZ5Bcx0Pv2oGEtxHYFaZgANmEFy55wbJpjLcJgdWh5S22cf3QAAPNwAr0kj18lupt81+2yg9vlI2uqGBytloJBAW1Tmq6t9VsI5SYqbg2/Hu8ubk/pSlTnNxC3Ezt0ROg2V3rvgbMisqM8+QYH6RruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719763250; c=relaxed/simple;
	bh=UXJgWksWglnFs3muIQpJ7TNHZ3RJRjmZTfDMGVRRZcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTEe4YVmtJ3SPpghFnvaqRuH170Vf4SOgfBMdc59JNvSUo7v2j7AFooriMSC+zf9gh9XkPm4RDecnL03aFx4rNtY07IA0ifz8/tJawOKgzS7PRLsWxM+wXsrrAj46zYkGvaom88r9WMzFizZLhTveCOEjXyjQCH8LtusmXmen5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UNNtXGRc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719763246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Guv1sE7D+9DIv1Ejtj1tQsUSVZc3puEsRvEvnQebVMM=;
	b=UNNtXGRc4LwBEU3X/kQ1BtSCnp6NZxC8faJEiyINdG8haStOfiAW+kHXJo8pvo0THTEFb6
	9BX5+/HdxOX/AokQUqQ8q93xef5QKVG8i53ZzJuB/wfzG6YHO/6Tg7OZ6qKgExk9Z/xw0Q
	oHDCPIIictYkSM5V8atUmi2cDiv0O+qUsVDpNSfLDi6eAWWAIJsr0jkawJP42PIyrNJQX5
	UxGqRWGSHADptp6iqRJ/4yeegnU5kYk+0V6SROa3DV8WldAkZtqmX6VzolIU7LrNfMgr41
	lfCbx0RnbucyTT9X9R2El4jqllrce+woVXrC4gXNUMWQ794LwyFNwd7lRKFVKw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	didi.debian@cknow.org,
	jonas@kwiboo.se
Subject: [PATCH v3 2/2] arm64: dts: rockchip: Update GPU OPP voltages in RK356x SoC dtsi
Date: Sun, 30 Jun 2024 18:00:41 +0200
Message-Id: <80301764e8983c8410c806ed2256403823709897.1719763100.git.dsimic@manjaro.org>
In-Reply-To: <cover.1719763100.git.dsimic@manjaro.org>
References: <cover.1719763100.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Update the values for the exact Rockchip RK356x GPU OPP voltages and the
lower limits for the GPU OPP voltage ranges, using the most conservative
values (i.e. the highest per-OPP voltages) found in the vendor kernel source
(cf. downstream commit f8b9431ee38e ("arm64: dts: rockchip: rk3568: support
adjust opp-table by otp")). [1][2]

Using the most conservative per-OPP voltages ensures reliable GPU operation
regardless of the actual GPU binning, with the downside of possibly using
a bit more power than absolutely needed.

[1] https://github.com/rockchip-linux/kernel/commit/f8b9431ee38ed561650be7092ab93f564598daa9
[2] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi

Suggested-by: Diederik de Haas <didi.debian@cknow.org>
Helped-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index ec772bce359a..e3c77dabc72b 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -195,27 +195,27 @@ gpu_opp_table: opp-table-1 {
 
 		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <825000 825000 1000000>;
+			opp-microvolt = <850000 850000 1000000>;
 		};
 
 		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-			opp-microvolt = <825000 825000 1000000>;
+			opp-microvolt = <850000 850000 1000000>;
 		};
 
 		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <825000 825000 1000000>;
+			opp-microvolt = <850000 850000 1000000>;
 		};
 
 		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <825000 825000 1000000>;
+			opp-microvolt = <900000 900000 1000000>;
 		};
 
 		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
-			opp-microvolt = <900000 900000 1000000>;
+			opp-microvolt = <950000 950000 1000000>;
 		};
 
 		opp-800000000 {

