Return-Path: <linux-kernel+bounces-429537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F329E1D78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB001652A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C31EC013;
	Tue,  3 Dec 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG+N/WIf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D707224F0;
	Tue,  3 Dec 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232187; cv=none; b=jiHTUQjkSk0H43/UeS49BWiGjZ24SBFwnJTw4aNmLqJlJD+tvc2ps4RhgZSKsppV9YGIJIb0aSi3Qsor1mztsNCc+S0t4pXbI48wksoEOC1T3w9HVXD/4HAjTWFCbhDnPV4QyC9lzktzoROqBhh05EHswvwJThaKuZoh1XrhfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232187; c=relaxed/simple;
	bh=iZ4QmU3VYs0LDZ8lr0fIemo81foNLGPlwRopsTWq1P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GQ8y3+GDPMO93lYOSmFtuHgkdUAHjok80Blzr6KuLeF7+7jq9j9VTMdow1J6DN08KCuVd1s/jIj1uLlOosplWrg216otR+HsRhROxToRRHyTNrz8HjRJtzu+XWwXMqCuQBPLv3ub5lw1ZriJojq90P2JFDWxfHRKi7HuKLaWSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG+N/WIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74229C4CED8;
	Tue,  3 Dec 2024 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733232186;
	bh=iZ4QmU3VYs0LDZ8lr0fIemo81foNLGPlwRopsTWq1P0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GG+N/WIfnow38JRGkOfEUiqgEc8xibKWgESFJaJwR0/r5CeXFZfjHzUPdkXqIVXoZ
	 sSSEQ7mkh31hGjPyo1lXQ0JdWOf5gS/pK7+x21tsqZyBOGzK1xDwtBUEdzPjclGXMk
	 q67bDbgYt8PCuctS91TY55sFkMoZL/N3iXF4eAdedqqd0kCUlL6J7SnW4As8neP9M7
	 LYmT2SClZZbkYnk1DeHDGbkt2m4nuUW2CKjvUIxFjCDm0HvS+iPn1+mdONVT1mn2iP
	 siHZgH2lDRXJ8VBcdmW/odcujw3h1He5t1pFB2mj5ck3JKb6R8Ie0+Kh43UUc8aLDi
	 M79Lh9i6I1xSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A53BE64A93;
	Tue,  3 Dec 2024 13:23:06 +0000 (UTC)
From: Manojkiran Eda via B4 Relay <devnull+manojkiran.eda.gmail.com@kernel.org>
Date: Tue, 03 Dec 2024 18:52:45 +0530
Subject: [PATCH] ARM: dts: aspeed: Enable video engine for IBM System1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
X-B4-Tracking: v=1; b=H4sIACQGT2cC/x3MMQqAMAxA0atIZgNNtSJeRRzERs1glUZEKd7d4
 viG/xMoR2GFrkgQ+RKVPWRQWcC0jmFhFJ8N1tiarKnQn4r66Mkb4SWedzSmJe/cSK5hyN0ReZb
 7f/bD+36t1tcFYwAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Manojkiran Eda <manojkiran.eda@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733232165; l=1038;
 i=manojkiran.eda@gmail.com; s=20241203; h=from:subject:message-id;
 bh=ejXpM+ALtz0H3f+cLC7p2P7soAQAZRSfhVgLG/KNusk=;
 b=JjpeBLox0ewhPlPyR7prwy4gXMJDMjI5b0bU4tGW8YA3C9sw1giJi/yDs/0TpN8fL4ElkieUV
 1aQ6F65esdRAp5zDtx9n76PrAZNP1uwmNdM+yruTohVCsvcdrDKlH7S
X-Developer-Key: i=manojkiran.eda@gmail.com; a=ed25519;
 pk=54WqHEFtBzlAODOpTWKI2J1uhv/sAk3WQ+lDMxMyKTI=
X-Endpoint-Received: by B4 Relay for manojkiran.eda@gmail.com/20241203 with
 auth_id=292
X-Original-From: Manojkiran Eda <manojkiran.eda@gmail.com>
Reply-To: manojkiran.eda@gmail.com

From: Manojkiran Eda <manojkiran.eda@gmail.com>

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
---
This patch enables the aspeed video engine support in ASPEED BMC for
IBM System1. It is crucial for facilitating the BMC's video capture
and redirection capabilities, which are integral to remote management
and KVM (Keyboard-Video-Mouse) over IP functionality.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index c8597dcded31..bea858b2eee6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -479,6 +479,10 @@ &lpc_snoop {
 	snoop-ports = <0x80>, <0x81>;
 };
 
+&video {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 

---
base-commit: f6d73b12ca9fd3b1c29a6a725cd751b972c740cf
change-id: 20241203-dts-system1-video-0081d55a156e

Best regards,
-- 
Manojkiran Eda <manojkiran.eda@gmail.com>



