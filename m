Return-Path: <linux-kernel+bounces-332460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3D497BA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F161F21B49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0F176AB6;
	Wed, 18 Sep 2024 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC06XVHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1142868B;
	Wed, 18 Sep 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651211; cv=none; b=ib3Q+oLbfeAxQoyBbyEcgJJ0bU2jCh9XWCFuFgM5ao/2NRkcm78tyuRhOaPRwYttM7Vz6q/jK6jeY5N60kvdddNe0J70PlxntGCKfHWr0fiDrNtu12JyokBbZgXPSO+5oa+fVsh8tMopzbf5e87idSMEyXQdlpRP7mQS6ap/aHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651211; c=relaxed/simple;
	bh=2IPuGsFVx6i3IPlbaxYG1lBF+gtjjtT/tgBzPKncEKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JCSnOPGj96ldvcyLV+wRHRLuqZNb9fUg7bCjxFfrGDJZhtPTHUXBJ5gFryknlxvVx6l/LFcx49muuAUxDn4GJFMeVJgt51Xqk1WdVyM5luDHFbnzlTn5+EKzzk6qG9fldnNBH8+zOhxVnl7EUmxsMH7qi9n1PDfjGplrREnJaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC06XVHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2314C4CECD;
	Wed, 18 Sep 2024 09:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726651210;
	bh=2IPuGsFVx6i3IPlbaxYG1lBF+gtjjtT/tgBzPKncEKQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fC06XVHb0/Un4jdSh1HWBV7i/wmL1z2RxPkGk8bOlKg9AfKs01BfHtIzPEx+yuwTl
	 lBs6hYpXEK09I/sWdZSYTDA2yePX/1dUhQZTnoj2tMWdUN/lh4368Ri1SXjyMo6M1U
	 kGaeqrLxMYiNpHBuyUFq1li+i6nrob1V4+sMThYJezPS3HFbjkfgAtg3KbWaHQHctu
	 Opi3Fjbl8UDWlH75eCxCulPgpszA/eymt9iVSA4RifTcA6eJ8gFCF2A7X3yy5b7oiA
	 NdQNBtNgCQCg2joM8bqJn34ekUqhqnZYLWe0o77gcwGZ6Xd9FicrH1FxU61poWlcED
	 j6aJEIM8xkCKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971C5CCD193;
	Wed, 18 Sep 2024 09:20:10 +0000 (UTC)
From: Manojkiran Eda via B4 Relay <devnull+manojkiran.eda.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 14:50:03 +0530
Subject: [PATCH v2] ARM: dts: aspeed: Enable PECI and LPC snoop for IBM
 System1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-dts-aspeed-system1-peci-snoop-v2-1-2d4d17403670@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEKb6mYC/43NTQ6CMBCG4auQWTuGlp+qK+9hWJQywCRCmw4hE
 sLdrZzA5fMt3m8Hocgk8Mh2iLSysJ8T9CUDN9p5IOQuGXSuy/yuDHaLoJVA1KFsstCkMJBjlNn
 7gEZXzuR9actbBakRIvX8OfuvJnlkWXzczrtV/dZ/y6tChe29Nn1b2NoU1XOYLL+vzk/QHMfxB
 WL1jDLKAAAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Manojkiran Eda <manojkiran.eda@gmail.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, openbmc@lists.ozlabs.org, 
 Eddie James <eajames@linux.ibm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726651208; l=2124;
 i=manojkiran.eda@gmail.com; s=20240917; h=from:subject:message-id;
 bh=PhsAWX7PZUt4OM1Bw10bIDsLdGTH2xpjWLavU7+Q4Tk=;
 b=czWKIuxWc7LaxglC3n9wJmLebajDF5jrdBsRa+IlENMLoNzE6kVM3/qJqWPjuB3Y/egwdDuqB
 JNNjTtL1XS5BICAZswrBb/1tOEriGVb3/1DQfw2KkhL3/sE8CpMpgrM
X-Developer-Key: i=manojkiran.eda@gmail.com; a=ed25519;
 pk=DhQ/NRPeyE1WOxUmafF9Oy8LLco0c8CCeTN+Ef6q6Ts=
X-Endpoint-Received: by B4 Relay for manojkiran.eda@gmail.com/20240917 with
 auth_id=215
X-Original-From: Manojkiran Eda <manojkiran.eda@gmail.com>
Reply-To: manojkiran.eda@gmail.com

From: Manojkiran Eda <manojkiran.eda@gmail.com>

This patch enables the PECI interface and configures the LPC Snoop for
ports 0x80 and 0x81 in the ASPEED BMC for IBM System1.

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
---
This patch enables PECI and LPC snoop functionality on the IBM System1
BMC in the device tree.

The following changes have been made:

1. Enabled the PECI controller (peci0) by marking its status to "okay".
2. Enabled the LPC snoop engine, configuring snoop ports at 0x80 and
   0x81.

These changes are required to support PECI communication and LPC
snooping for system monitoring and debugging purposes.

To: Ninad Palsule <ninad@linux.ibm.com>
To: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
To: openbmc@lists.ozlabs.org
To: Eddie James <eajames@linux.ibm.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org

Changes in v2:
- Added ibm system1 in the subject & added upstream mailing
  list as well for reviews.
- Link to v1: https://lore.kernel.org/r/20240917-dts-aspeed-system1-peci-snoop-v1-1-b967fb3a6735@gmail.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index cb3063413d1f..738a86c787c0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -464,6 +464,15 @@ &kcs3 {
 	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 };
 
+&peci0 {
+	status = "okay";
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>, <0x81>;
+};
+
 &i2c0 {
 	status = "okay";
 

---
base-commit: ca2478a7d974f38d29d27acb42a952c7f168916e
change-id: 20240917-dts-aspeed-system1-peci-snoop-725c70f4a485

Best regards,
-- 
Manojkiran Eda <manojkiran.eda@gmail.com>



