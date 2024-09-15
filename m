Return-Path: <linux-kernel+bounces-329885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7BA97971A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712E2B21870
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321E1C7B92;
	Sun, 15 Sep 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fys986Q/"
Received: from mail-8160.188.com (mail-8160.188.com [60.191.81.60])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6841C6F7F;
	Sun, 15 Sep 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.81.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410332; cv=none; b=Qep6i1SrGNXaxZxfBJGa7NcPpQuVwuvXDtaZCshxuKKiaVpaHyBj0m8IWt9AF8KqrOQngzCTZs3Kco1cVYJJ6yGEa+3iQqaIptDHO3t7Eroj5NSc4XwznkGLtabmhkvZXUVOzoB60HUo8Z0NIn2egIirttk8IioVhXCvROCpwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410332; c=relaxed/simple;
	bh=jAwSw4LEIfXT39XmNvQkkX3/1clNMqBMeMdEHqSLLuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=szUym7d0PaJjoe1vs5z+d8r65fs7095an1jPp78UXy0U3KOs7Y8RiKnKNXOikmPTtEhrosHd9K3iPLbbYhn/hkl4t6CSdDWOrOyPejU+hsPlUkFr6qVI8pR5tXW00w4fpoQFBPAaY48mq28Yw98ItRN6RAc31WjxKj9ouumtjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fys986Q/; arc=none smtp.client-ip=60.191.81.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=H5SO/a1hfbyVpeTzy2AAy5aKvwSqfgsGs2lOMb5bsec=;
	b=fys986Q/g+u4A0/xZa184KzB/igUG7h3XWl6DRMDWbn/ODou+b7WA1OF6OGQx3
	X9xSNe0ctTIav1KwG9TfetzQHJAMwmMRyxJ/5vYO7vQ+cL1k9jNoz6vgZHy5zlmj
	cjwCI/JiIUr0saZC6T3xgoUNfBCeNjiPU65efM/YDyrpM=
Received: from localhost (unknown [27.18.168.209])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgAXyoqA7eZmsSQ2Bw--.53271S2;
	Sun, 15 Sep 2024 22:21:52 +0800 (CST)
Date: Sun, 15 Sep 2024 22:21:52 +0800
From: Ze Huang <18771902331@163.com>
To: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, conor@kernel.org
Cc: cyy@cyyself.name, jesse@rivosinc.com, jszhang@kernel.org,
	inochiama@outlook.com, uwu@icenowy.me, zhangmeng.kevin@spacemit.com,
	kevin.z.m@hotmail.com, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	dlan@gentoo.org, 18771902331@163.com
Subject: [PATCH 1/3] dt-bindings: pinctrl: Add support for canaan,k230 SoC
Message-ID: <ZubtgIxm-rzAWHaO@jean.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:sCgvCgAXyoqA7eZmsSQ2Bw--.53271S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF17Cr1xuw1rZr4rAryfXrb_yoWrJFyxpF
	ZxKa98KF1rWF47K3yfta18uF13Xa1kArsagw1Utry7tw45WF18Kr1akr4IvF4DWFn7J3Wa
	qFWIgry7KF47Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziYLvJUUUUU=
X-CM-SenderInfo: zpryllqrzqjjitr6il2tof0z/1tbiNxxbomXAnRCLnwAGso

Add device tree binding details for Canaan K230 pinctrl device.

Signed-off-by: Ze Huang <18771902331@163.com>
---
 .../bindings/pinctrl/canaan,k230-pinctrl.yaml | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml
new file mode 100644
index 000000000000..979c5bd71e3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/canaan,k230-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Canaan Kendryte K230 Pin Controller
+
+maintainers:
+  - Ze Huang <18771902331@163.com>
+
+description:
+  The Canaan Kendryte K230 platform includes 64 IO pins, each capable of
+  multiplexing up to 5 different functions. Pin function configuration is
+  performed on a per-pin basis.
+
+properties:
+  compatible:
+    const: canaan,k230-pinctrl
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+    description:
+      A pinctrl node should contain at least one subnode representing the
+      pinctrl groups available on the machine.
+
+    patternProperties:
+      '-cfg$':
+        type: object
+        $ref: /schemas/pinctrl/pincfg-node.yaml
+        additionalProperties: false
+        description:
+          Each subnode will list the pins it needs, and how they should
+          be configured, with regard to muxer configuration, bias, input
+          enable/disable, input schmitt trigger, slew-rate enable/disable,
+          slew-rate, drive strength.
+
+        properties:
+          pinmux:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            description:
+              The list of GPIOs and their mux settings that properties in
+              the node apply to. This should be set with the macro
+              'K230_PINMUX(pin, mode)'
+
+          bias-disable: true
+
+          bias-pull-up: true
+
+          bias-pull-down: true
+
+          drive-strength:
+            minimum: 0
+            maximum: 15
+
+          input-enable: true
+
+          output-enable: true
+
+          input-schmitt-enable: true
+
+          slew-rate:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              slew rate control enable
+              0: disable
+              1: enable
+
+            enum: [0, 1]
+
+          power-source:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Specifies the power source voltage for the IO bank that the
+              pin belongs to. Each bank of IO pins operate at a specific,
+              fixed voltage levels. Incorrect voltage configuration can
+              damage the chip. The defined constants represent the
+              possible voltage configurations:
+
+              - K230_MSC_3V3 (value 0): 3.3V power supply
+              - K230_MSC_1V8 (value 1): 1.8V power supply
+
+              The following banks have the corresponding voltage
+              configurations:
+
+              - bank IO0 to IO1: Fixed at 1.8V
+              - bank IO2 to IO13: Fixed at 1.8V
+              - bank IO14 to IO25: Fixed at 1.8V
+              - bank IO26 to IO37: Fixed at 1.8V
+              - bank IO38 to IO49: Fixed at 1.8V
+              - bank IO50 to IO61: Fixed at 3.3V
+              - bank IO62 to IO63: Fixed at 1.8V
+
+            enum: [0, 1]
+
+        required:
+          - pinmux
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl: pinctrl@91105000 {
+        compatible = "canaan,k230-pinctrl";
+        reg = <0x91105000 0x100>;
+
+        uart2_pins: uart2-pins {
+            uart2-pins-cfg {
+                pinmux = <0x503>, /* uart2 txd */
+                         <0x603>; /* uart2 rxd */
+                slew-rate = <0>;
+                drive-strength = <4>;
+                power-source = <1>;
+                input-enable;
+                output-enable;
+                bias-disable;
+            };
+        };
+    };
-- 
2.46.1


