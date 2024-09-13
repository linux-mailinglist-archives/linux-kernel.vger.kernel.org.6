Return-Path: <linux-kernel+bounces-328773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59AA9788A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C128312D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E525155389;
	Fri, 13 Sep 2024 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RLccJbI1"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFE146D6D;
	Fri, 13 Sep 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254704; cv=none; b=WkIm67YVklnnOp251UdSATknCxmtNgjlwSkLIEMOXs8hp7Hz4t0dqd2AyXBNLyW0TwuyS1pBDrexlcz0lozL5KH9bW8EgE99JHcSD8pqbGWH7cY+CwEKk9TL1wbmzCMVbFR8xuDO1D58DFqeOyPSXEp+mwg/5TrgN8Uu8uHtfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254704; c=relaxed/simple;
	bh=bxjEfcIAw3G69yFnN1jVI/zDGOe024EvxtZK+xb84Vg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqG06+mXbTiZnePaxUEj662edP+zdOhtdzIQUdrTT07r/pjrJXEkV2TBJRBl7IFle+FE6IA3D4Auow+pBd7NPA0wMnAGpZDgDi06/ogJtAU1yUACFx4Dx0GEzU6JwydEzeun7vt3bW4dGkgt6BrmDymI3I5BoQMY5kbLyTcxV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=RLccJbI1; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726254701; x=1726513901;
	bh=BO5F8gZ2+XQmMySVgluXmKZCMf7FHSNQE9WqjQCRqXM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RLccJbI1VyGdM8MwrH96/pvdRmGy5mCuYCBoAOUEUVet9Nz07M+SnLzzkdYUKuV1y
	 Da6CYpvhxS74hW4RXItAMI2kLxG65JFN5qXT2CIO77m3ijfl+wMhTWZPG6dpu6jA3A
	 fQ0Seubh8hVtaFLeTf0ek4vOUGsgZEUwYYBDAk9U/l6flDCZztdI3Vxm+F0Gd74upQ
	 LykWZaY3oSlYlt7uHHtZ0bpmxwkp+7W5tXpHAtlpiNxdo6awmR1ox670f2LebU7lrq
	 yJcVZA1U/CuHB2pl8U9aAelzrsIHHQtosAqfS5JtTirF4KtnsxQUECJ0ZVvDEtV2+Q
	 V4z8bzu4LnYQQ==
Date: Fri, 13 Sep 2024 19:11:37 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 5/6] dt-bindings: clock: xilinx: describe whether dynamic reconfig is enabled
Message-ID: <20240913191037.2690-6-hpausten@protonmail.com>
In-Reply-To: <20240913191037.2690-1-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 2221ecd0086cec656555c1c3be1f8b4e576c5eef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xilinx clocking wizard IP core's dynamic reconfiguration support is
optionally enabled at build time. Add a devicetree boolean property to
describe whether the hardware supports this feature or not.

Since dynamic reconfiguration support was previously assumed enabled,
introduce a property to indicate the inverse, in order to maintain
devicetree backwards compatibility. Hence, this new xlnx,static-config
property should be specified when dynamic reconfiguration support is
disabled in the IP core configuration.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
v1 -> v2:
- Invert meaning of the new DT property
- Renamed from xlnx,dynamic-reconfig to xlnx,static-config

 .../devicetree/bindings/clock/xlnx,clocking-wizard.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.y=
aml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
index 9d5324dc1027a..b44a76a958f4e 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -39,6 +39,11 @@ properties:
       - const: clk_in1
       - const: s_axi_aclk
=20
+  xlnx,static-config:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicate whether the core has been configured without support for dy=
namic
+      runtime reconfguration of the clocking primitive MMCM/PLL.
=20
   xlnx,speed-grade:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -70,6 +75,7 @@ examples:
         compatible =3D "xlnx,clocking-wizard";
         reg =3D <0xb0000000 0x10000>;
         #clock-cells =3D <1>;
+        xlnx,static-config;
         xlnx,speed-grade =3D <1>;
         xlnx,nr-outputs =3D <6>;
         clock-names =3D "clk_in1", "s_axi_aclk";
--=20
2.46.0



