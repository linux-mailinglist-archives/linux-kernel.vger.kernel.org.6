Return-Path: <linux-kernel+bounces-241662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7E1927DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FDD1C22D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FA2137C2A;
	Thu,  4 Jul 2024 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="e5yZkCE9"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A6C6CDA1;
	Thu,  4 Jul 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120801; cv=none; b=PmK368iQuPW6waNgtfL9PHt5DUm0gqrJTnhELxH9Urau6ass6Uk7usOMDcN7TJW0DvG+l9eYh8f+hXwb/xC3SFAhxIhN9LtGzAisXdHZujV0ymnCG6GTz3PUEY0x9PyYera0wWZZeKvGCnmvkHYC6r4TshlejLvc/R/gOFpMOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120801; c=relaxed/simple;
	bh=5EKYtMONthEsFSA+n04NFH8luj6pT4LCFD5nneRT3jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhCJFyU2SAFmH7KLnCH/ZkqR6fcdH+XGvDZ1rjyXXRS5LdoIHBzILB++/E+xG4aGxUF+lCoJboznnrXxM+qMFpa20isvthEypXsRPdqBi1rNloMuL1daxHOehm6F50buoEAhBIWl8VsJ6IWyjnPm/F3dyj56Ob3mN0qqu42IN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=e5yZkCE9; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1720120794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=12kQGJpaxYXve/bNP2Rvzy67ptC3odJSOf9IDo8D060=;
	b=e5yZkCE9Ici3nvB7wz3sGd0TYcyIk2C3zY2FsiTaZiC9RFqNZwenUU0Pi0C9dQCkiaQLVx
	GthxTDvHEs0RrfGFiKJgkZwiwis9mQTzfH4h2QdHMKZAM+LW44xMIZN9Dl6Bs9nr1l0NN1
	Aqv+tLEuQo0AtZpWbzfI+SqBL7Nb66MQTznoHVT+p3fUyMa3sA65aBn5x6VJHStbpQv5mh
	niIEg3sAHNZQdI/rvMSO2sw04gpwjejRa/iNHmzpANDuSALc4qDbyDPi2QPB4Qlqt6lwKq
	oEgwIVGIxzjV9Mz3qFrIcQczJ+MlRVi8Qx4NHx0JZL5ohtdJXj/PxTNrZtIq6w==
X-Envelope-To: knaerzche@gmail.com
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Alex Bee <knaerzche@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] arm64: dts: rockchip: Add avdd supplies to hdmi on rock64
Date: Thu,  4 Jul 2024 21:18:33 +0200
Message-ID: <20240704191919.38856-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Pine64's Rock64 was missing the avdd supply properties on the hdmi node,
causing the following warnings:

  dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
  dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator

In the Rock64 Schematic document version 2.0 those supplies are marked
as DVIDEO_AVDD_1V0 and DVIDEO_AVDD_1V8 respectively, but in version 3.0
those are named HDMI_AVDD_1V0 and HDMI_AVDD_1V8, which is a bit clearer.
In both versions those are connected to LDO3 and LDO1 respectively.

While the DeviceTree property is named 'avdd-0v9-supply' the
'rockchip,dw-hdmi.yaml' binding document notes the following:

  A 0.9V supply that powers up the SoC internal circuitry. The actual
  pin name varies between the different SoCs and is usually
  HDMI_TX_AVDD_0V9 or sometimes HDMI_AVDD_1V0.

So the 'vdd_10' reference is not an error.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 229fe9da9c2d..90fef766f3ae 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -154,6 +154,8 @@ &gmac2io {
 };
 
 &hdmi {
+	avdd-0v9-supply = <&vdd_10>;
+	avdd-1v8-supply = <&vcc_18>;
 	status = "okay";
 };
 
-- 
2.45.2


