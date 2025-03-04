Return-Path: <linux-kernel+bounces-544829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ED9A4E5B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3374610A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0108427C877;
	Tue,  4 Mar 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6KlEHUo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626927C844;
	Tue,  4 Mar 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103745; cv=none; b=ch2P/Gty7t267wE9HDVmOtHH01oaG4EzwRxBw/m1RMVaAXv86B07OPMtKmvmwwN4JyvRXg4dRTQqNaP2MaqPa5vQbVv5wBDVLVrYpzm2Uy9WZQ5GIutlvKD8+SQKa7jIMPutOR+ZXbt2V1ECszaxX78nG7je2KTuXG1hQRZI2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103745; c=relaxed/simple;
	bh=6JjWe01Fb74ikB8E5k4hcgywO/QJhek4Q9koYh3qr0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kCsKG4KrNstZ4BvsNdobUWbHq9GxiimbwxCL/7iNzSycJ1lveThTHhvrLxUWSI30NCGxO/eef6IQ/iXvQZmARBTgFbSyBfT9Ewt5p1t1RB8nKk2MhQO5kafdQszhpz7zZu7FligUccXNflHkulQQD+vyVNBI/4B76T64SrUnfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6KlEHUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C59DBC4CEE5;
	Tue,  4 Mar 2025 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741103744;
	bh=6JjWe01Fb74ikB8E5k4hcgywO/QJhek4Q9koYh3qr0c=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=q6KlEHUoDyrUti0TfKHMzxq+d7SgBDZeYljnyM0jimqCHYr8M/tZOu/vlYpQDYLtd
	 lECwbsJRJFwyBRBL3JiIr+9Jm9e+iVapkK+Fy9ITodWFSor6OemZT+pPoFtSy1q7ne
	 sQDOV6guhLuqZlzWvof0eTCP5gYfAQ5errXfeucgoJ6Lh8uG85FH5xTWnbytWH6XwV
	 DM/8ObgckJ6+P7Sm6cae7ukUaGL5cWTA0eReZAtcYXCY+sj31p5M9IwqrtdtdzE2YZ
	 Kj0P9uUhwFE2QnbgIj8RFLxkglePvXRjK5vSQqTnZIZiCOPOjtbGi+b8+U8/T5RU0I
	 7b6EK+8miPkoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E91C021B8;
	Tue,  4 Mar 2025 15:55:44 +0000 (UTC)
From: "Chester A. Unal via B4 Relay" <devnull+chester.a.unal.arinc9.com@kernel.org>
Date: Tue, 04 Mar 2025 15:55:36 +0000
Subject: [PATCH] ARM: dts: BCM5301X: Fix switch port labels of ASUS
 RT-AC3200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-for-broadcom-fix-rt-ac3200-switch-ports-v1-1-7e249a19a13e@arinc9.com>
X-B4-Tracking: v=1; b=H4sIAHcix2cC/x2NywrCMBAAf6Xs2YVt0oL6K+Ihj43dg92yCVUo/
 XeDx4Fh5oDKJlzhPhxgvEsVXTuMlwHSEtYXo+TO4MjN5GnCoobRNOSkbyzyRWsYkndEWD/S0oK
 bWquYuYwUyMd4vUGvbcbd/p8ez/P8AQpCTjx5AAAA
X-Change-ID: 20250304-for-broadcom-fix-rt-ac3200-switch-ports-def10a03bb89
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tom Brautaset <tbrautaset@gmail.com>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741103743; l=1391;
 i=chester.a.unal@arinc9.com; s=arinc9; h=from:subject:message-id;
 bh=5BwPF9flLou8o24Bv8iNZhdALbMlAOZ+jVIvmAjgycU=;
 b=PeGf3b5jyl/AR9FiXgqhGgQx7n+rYzrkdnnzZfnJJjgmQXZMpnSVYUJsyWjdEeBXq8Hup0E0s
 siibCPmaodZANVCthjQnH02OQqMLTxYWmU0G2MU8BQrx0p5iwFE/CRz
X-Developer-Key: i=chester.a.unal@arinc9.com; a=ed25519;
 pk=/g3vBAV0YSvcIpSQ052xJbid7nrPXz8ExGKhTEuc6IY=
X-Endpoint-Received: by B4 Relay for chester.a.unal@arinc9.com/arinc9 with
 auth_id=306
X-Original-From: "Chester A. Unal" <chester.a.unal@arinc9.com>
Reply-To: chester.a.unal@arinc9.com

From: "Chester A. Unal" <chester.a.unal@arinc9.com>

After using the device for a while, Tom reports that he initially described
the switch port labels incorrectly. Apparently, ASUS's own firmware also
describes them incorrectly. Correct them to what is seen on the chassis.

Reported-by: Tom Brautaset <tbrautaset@gmail.com>
Fixes: b116239094d8 ("ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200")
Signed-off-by: Chester A. Unal <chester.a.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
index 53cb0c58f6d0574f4f13c6aeb1d1bc5961d80379..3da2daee0c849d536df94c868849af7610cc1ded 100644
--- a/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
@@ -124,19 +124,19 @@ port@0 {
 		};
 
 		port@1 {
-			label = "lan1";
+			label = "lan4";
 		};
 
 		port@2 {
-			label = "lan2";
+			label = "lan3";
 		};
 
 		port@3 {
-			label = "lan3";
+			label = "lan2";
 		};
 
 		port@4 {
-			label = "lan4";
+			label = "lan1";
 		};
 	};
 };

---
base-commit: 768953614c1c13fdf771be5742f1be573eea8fa4
change-id: 20250304-for-broadcom-fix-rt-ac3200-switch-ports-def10a03bb89

Best regards,
-- 
Chester A. Unal <chester.a.unal@arinc9.com>



