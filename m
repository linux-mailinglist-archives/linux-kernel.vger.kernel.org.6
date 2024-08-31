Return-Path: <linux-kernel+bounces-309860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D86967130
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAABB22555
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627417E01D;
	Sat, 31 Aug 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="FLIXdZ27"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5D181B87;
	Sat, 31 Aug 2024 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102807; cv=none; b=qdaeSimsNs17ywo2TYqmeEjp8GScB/OJSsS7H7juT/bszK+bLTwiWjsqU3iKpcFXz5YBjd8gFZfugpmL9LTsrBTXxck99ApcnPKx4dxEyjDHtqMPxNtk9B+M0JUmwsvW9YYIy5uvoEspcuH1nQxWaV6yTFUziwBxmrlUlzHPKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102807; c=relaxed/simple;
	bh=fjypYTmq4TL8zA6CIPItT6m4EIoPg8M5EgossoiYvLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrZNZPopqGTwpc7VAXk7sciAL4e5XAGMcKWPbOpU370K7JTw3eogJ09LrG1r5eV92mS1AMApq2keZ+eXp7HbZvp9fCbxjeiu7z0lkD5/eQgvIrZzWYYLjRCsa3RefegTpAlTl2Z1HkjSmrSZTPYC6h5diBmUlDeG2u8zJaZjKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=FLIXdZ27; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1725102803; x=1725362003;
	bh=+TQ0qt1mWAjXQIfsJ9efhsTaspk3PcSx0ULEnGhzXfk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FLIXdZ27/ZclnlqifPCKq4YuHt08XnAx8/zjhSrvIiyYrEo4xEDZqvzEukdBRHbNc
	 FKPZPjO/bMhdGdD1Llv+J8kIxOfAYrX5SIuRxzN+KqL3aa8pwTnKLU4EBx+2ovtqfk
	 H6dIh0pwhKeGFIWRRigNiILhHEyoco4bHugxZURq3yi6HnUnEqqNv5PxI5CnXv0uwE
	 I+uN+oCV5RfWV78kfdDVZHNaxRTp+XqV0GDZ/rPUQ9ozmSlXTW6vq0KDq4jrfVYaJJ
	 l/RXsCyeEUEKV2iFrRNVUmpg+198NbPzVciq3H8ZlizikOaPq73lQgkZj2RIU4ID4a
	 rII9+V75FsbpQ==
Date: Sat, 31 Aug 2024 11:13:20 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] dt-bindings: clock: xilinx: describe whether dynamic reconfig is enabled
Message-ID: <20240831111056.3864-6-hpausten@protonmail.com>
In-Reply-To: <20240831111056.3864-1-hpausten@protonmail.com>
References: <20240831111056.3864-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 8a799e2205f23a03b8ffef16e5f1dd54c88f397f
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

Signed-off-by: Harry Austen <hpausten@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/xlnx,clocking-wizard.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.y=
aml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
index 9d5324dc1027a..46547ccdc9005 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
@@ -40,6 +40,12 @@ properties:
       - const: s_axi_aclk
=20
=20
+  xlnx,dynamic-reconfig:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicate whether the core has been configured with support for dynam=
ic
+      runtime reconfguration of the clocking primitive MMCM/PLL.
+
   xlnx,speed-grade:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3]
@@ -70,6 +76,7 @@ examples:
         compatible =3D "xlnx,clocking-wizard";
         reg =3D <0xb0000000 0x10000>;
         #clock-cells =3D <1>;
+        xlnx,dynamic-reconfig;
         xlnx,speed-grade =3D <1>;
         xlnx,nr-outputs =3D <6>;
         clock-names =3D "clk_in1", "s_axi_aclk";
--=20
2.46.0



