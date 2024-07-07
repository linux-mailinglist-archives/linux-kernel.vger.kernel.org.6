Return-Path: <linux-kernel+bounces-243753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29486929A20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E38E1F214E1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B2A7581D;
	Sun,  7 Jul 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="feB7IUdG"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13D55886;
	Sun,  7 Jul 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393721; cv=none; b=byfYNaOyxczcFzxNyvmSiDzdkCf3v+ZHt+/ZEBa/RuKx9WhKQ493D/0kKTq/Jk5t7DY6aUzaSEDEPEjStUgF+bY8GLqNktTvRX5hDEZn5RWqlaOoJpdapstR/mLvjtEcangwe0Jwq3fU6qgp7knIeQdPpDhwysI0eUEkIOYe7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393721; c=relaxed/simple;
	bh=LRyBD6gNgopag0sH6jtdDyGi31BCRChuc2vJ7ynw+Hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEcbV8GoAN3b9uorvYnd77Y57HRIYc42RtZMk3Zfm+EroZsSY5ziViYun3z2Cmrkub5v34UCKq6+9N6J7oj7tOorPSA+f4E6iSFX1Db0CWiHr8F3hyRvs+wk1HuCXU4Jq2HfGPYX8E4c+Xe+HQmSzX1DWWbBvEUmxvHFlD6jjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=feB7IUdG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720393702; x=1720998502; i=j.neuschaefer@gmx.net;
	bh=rHQsHXPo5ANfTRvxba5Xnn2aInYxUPu4/gZAELBFVNY=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=feB7IUdGRjt2DZ0jG4+VTIb55v1i/+l86ceVrjO7DNz4+XyWyI+uUeEEcr6FPu0w
	 /zS5nOvwAprkwRuAUxyCrMZLc9vslU/PL95S92JgIuSh3FHYA7VhkpYKKk86H1hRP
	 lqR3rMWWqehFzy3JsGE+Oj930lQzbfE/LJ1yrPuSDulWHLpEXEnaZE3sUO3CqWgiP
	 rkzoGRQZmtOhL3cLoDKpWGy5MyvVJVBl1c9vcXttM7i8v7ragM/gQaZivM5L8U7H0
	 0thyu/zMxpMvpQhs4xEfshK0imbmE6srq+f9BMS76WE7xtRmFh31n0eipEFO1s2nU
	 jtHGm61J1uYEiI4IHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1rxKdp2pGF-00f1Gp; Mon, 08
 Jul 2024 01:08:22 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Mon, 08 Jul 2024 01:08:14 +0200
Subject: [PATCH 1/2] dt-bindings: arm: bcm2835: Specify
 /system/linux,revision property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240708-raspi-revision-v1-1-66e7e403e0b5@gmx.net>
References: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
In-Reply-To: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720393700; l=1326;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=CH0h/rMYcfWtKxJDlLMxtCMqdP5QD4SXR1lZ4bdD/N4=;
 b=5w0uVFOyLApniryuo2OANod7N+IYoxonjc/9jFBoitiEG4F8yT9e0YPOvxVvf7vAJV4RdYCO3
 2XOSXiPI6FCAkMq6eqgAnoNryUSwcF/KbKMH+sOWTYw7G+7lToyv8Xr
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:tMOB8xxsjl5P+9YdnZBzT+rdJLsFSmqcM52OrGP7uNTMid6d7ER
 7s6V+12GQX25jX3J75km10eENPjab/nEUZq7OdwRFBaYfbSZUkIUJuBWiljNNZNQ/VoxzW1
 XtFI+PvH6y4hYN2qFgtmv9VkssypOiVh4JcVnzus1H65EHmM52ePaSH9XlGXoVjldApA9PH
 pMRCF6l1yLTYNBRVl30Ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E+c6H4qH2C4=;kNUsWqstbTIJw2UiOrbAfg5jJGL
 b6IEVwOwH/orB/CH//tBNq+1KLysu6X1DzlCvJXoM5z9R0Rii0Mfnl4y3uSRO3HmB3f3aA/AK
 4qE6Pmj1+pMCkj/63jvhe9TcsgsuLg4e8fiZQL0JxwsJTUuW93cTwMBi4RJ7FRWpimII+2XTP
 tqKfnb+JCmDW6BrBhWjaz9GqhzEsRTUBas0F/SzHvuMVN7N0aMgKtRTG6RyhM6UsGYo1dxxtU
 O8yJ3fLR4psaB8vkDdNPb53lrT5jNNna45FzAbAZMn4EXkStt71gZ1iWdHe5HOJemRI4MfMof
 oEFXFdik5cDqLLfVACCC2Q3ZBlvpvAIDd79MeU3JLgMCpYXDAWhHFxN1te0d/eF3yA02/A1QZ
 BNZHmXiTngRitLuoXqf0F6lmWCBY888E9GRl8YWl+QbNvlCuHYJhw0W7L8wWnmzq3ssK6989v
 65LqzC4J6K/HjA/M6ULz2hWWlvF2ewcj3s3Ro99vwN6dWOXAO+KKZgv/HyZHynUh7rH0EVI/z
 4t6KS6Qa1x6K4Np93JqsD2+VL2Dw2IZ5W3Kx8Ss3evfzTTsx+WILPnqYoHHht2IXicJvDV5pB
 w+tSPfVPLO+vBh+FKUNw9uJgRcNnSoE+EhjyTcCFCPV2G6H+ZqhtRh78kRTQQSb/nb8yGFsnb
 3wIePraHNqgsnmG/umSVjCyQvbCINiA6nl7EZ9qi21t3mGYKH/D3fzbdulu/+bUsOS6nVrS6v
 93toDU84G0T1Bfo9oDOvDfry8AGRdi+LVM9yfcsHNKw+tZvDNGNaudJT2FV90HYEM8RRJT0nl
 5LZyaWw8uZHlnJCV0KXY7jahr79/iei/lgkN57AGeIZnU=

The Raspberry Pi bootloader provides a revision code[0] in the
devicetree, at /system/linux,revision. This patch adds
/system/linux,revision to the schema to allow it to be used in
mainline Linux.

[0]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html=
#new-style-revision-codes
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Docu=
mentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 162a39dab21823..c6abf818b5ea57 100644
=2D-- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -54,6 +54,18 @@ properties:
               - raspberrypi,model-zero-2-w
           - const: brcm,bcm2837

+  system:
+    type: object
+    additionalProperties: true
+    properties:
+
+      linux,revision:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description:
+          The "system revision" number, as determined by the bootloader.
+          https://www.raspberrypi.com/documentation/computers/raspberry-p=
i.html#new-style-revision-codes
+
+
 additionalProperties: true

 ...

=2D-
2.43.0


