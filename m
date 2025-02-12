Return-Path: <linux-kernel+bounces-511170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7ADA32732
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF603A7728
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8AE20E326;
	Wed, 12 Feb 2025 13:33:39 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B9134A8;
	Wed, 12 Feb 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367218; cv=none; b=nSucyiw+MIU+UpqVbhSqSTrhnATdjvm1JaQ2fT4Ml1I4YQPoO6iRrT1BYZJxDqKhw7LwhrxV8zgqaPHiHjvb1r5RiGSOWQn6Gvpn4JLEO+80WTzNFG8WFgG7z0dgOj349LbxCf5yfcKD4znfnT5ggxjIibP1zzLf8OGNwrSuNBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367218; c=relaxed/simple;
	bh=kRC9h/NjswUsCTS/MZhW3HUYH5eDFR7D3QfHDQFIgV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HYV/EbYNpiUaPLRsTGoqPRMrmhpH6wNEdzmdfPS2AU5xmWinF5timIhB/yacH/Kz+6pravhm7y31T8LV0DU4Z0PhYWOy0j43TgI1MHhyzb2xgVPfze11KoyJYJ83OmTSfGrF7zsW5VPJZoPaZncpx05yNKVjKU5GhhA1H+mFa5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AFF6020097E;
	Wed, 12 Feb 2025 14:23:42 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A2D502003DD;
	Wed, 12 Feb 2025 14:23:42 +0100 (CET)
Received: from lsv15573.swis.ro-buh01.nxp.com (lsv15573.swis.ro-buh01.nxp.com [10.172.0.77])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F60F20395;
	Wed, 12 Feb 2025 14:23:41 +0100 (CET)
From: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com,
	Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Subject: [PATCH 1/2] dt-bindings: i3c: Add NXP P3H2x4x i3c-hub support
Date: Wed, 12 Feb 2025 15:22:26 +0200
Message-Id: <20250212132227.1348374-1-aman.kumarpandey@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841) is multiport I3C hub
device which connects to a host CPU via I3C/I2C/SMBus bus on one
side and to multiple peripheral devices on the other side.

Signed-off-by: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Signed-off-by: Vikash Bansal <vikash.bansal@nxp.com>
---
 .../bindings/i3c/p3h2x4x_i3c_hub.yaml         | 404 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml

diff --git a/Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml b/Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
new file mode 100644
index 000000000000..33ea524e5432
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
@@ -0,0 +1,404 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024-2025 NXP
+
+%YAML 1.2
+
+$id: http://devicetree.org/schemas/i3c/p3h2x4x_i3c_hub.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: P3H2X4X I3C HUB
+
+maintainers:
+  - Vikash Bansal <vikash.bansal@nxp.com>
+  - Aman Kumar Pandey <aman.kumarpandey@nxp.com>
+
+description: |
+	P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841) are multiport I3C hub devices
+  that connect to:-
+  1. A host CPU via I3C/I2C/SMBus bus on one side and connect to multiple
+     peripheral devices on the other side.
+  2. Have two Controller Ports which can support either
+     I2C/SMBus or I3C buses and connect to a CPU, BMC or SOC.
+  3. P3H2840/ P3H2841 are 8 port I3C hub devices with eight I3C/I2C Target Port.
+  4. P3H2440/ P3H2441 are 4 port I3C hub devices with four I3C/I2C Target Port.
+     Target ports can be configured as I2C/SMBus, I3C or GPIO and connect to
+     peripherals.
+
+  Device tree node can be used for following configurations:-
+  1. Controller Port can be configured via dt entry to support
+  2. I2C/SMBus mode or I3C buses.
+  3. Enabling voltage compatibility across I3C Controller and
+     Target devices.
+  4. Up to eight target devices and their modes(I3C/I2C/SMbus modes).
+  5. To support MCTP device
+  6. To support In-band interrupts
+
+  Controller Port can be configured via dt entry to support I2C/SMBus mode or
+  I3C buses.
+
+  For I2C devices, use below format:
+      DT node: hub@static_address
+      reg: encodes the static I2C address.
+
+  For I3C devices, use below format:
+      DT node: hub@static_address,PID
+      reg: encodes the static I2C address (0 if the device does not have one), and the
+      Provisioned ID (PID) used to uniquely identify a device on a bus.
+      This PID contains information about the vendor, the part, and an instance ID so
+      that several devices of the same type can be connected on the same bus.
+      assigned-address: represents the dynamic address to be assigned to this device.
+
+allOf:
+  - $ref: i3c.yaml#
+
+properties:
+
+  cp0-ldo-en:
+    enum:
+      - disabled
+      - enabled
+    description: |
+      I3C HUB Controller Port 0 LDO setting for turning on and off. If enabled, the dedicated
+      pin will provide the voltage generated by the on-die LDO. It is an optional property,
+      the configuration remains default if it is not supplied.
+
+  cp1-ldo-en:
+    enum:
+      - disabled
+      - enabled
+
+    description: |
+      I3C HUB Controller Port 0 LDO setting for turning on and off. If enabled, the dedicated
+      pin will provide the voltage generated by the on-die LDO. It is an optional property,
+      the configuration remains default if it is not supplied.
+
+  tp0145-ldo-en:
+    enum:
+      - disabled
+      - enabled
+
+    description: |
+      I3C HUB Target Ports 0/1/4/5 LDO setting for turning on and off. If enabled, the dedicated
+      pin will provide the voltage generated by the on-die LDO. It is an optional property,
+      the configuration remains default if it is not supplied.
+
+  tp2367-ldo-en:
+    enum:
+      - disabled
+      - enabled
+
+    description: |
+      I3C HUB Target Ports 2/3/6/7 LDO setting for turning on and off. If enabled, the dedicated
+      pin will provide the voltage generated by the on-die LDO. It is an optional property,
+      the configuration remains default if it is not supplied.
+
+  cp0-ldo-volt:
+    enum:
+      - 1.0V
+      - 1.1V
+      - 1.2V
+      - 1.8V
+
+    description: |
+      Controller Port 0 voltage level is controlled by the I3C HUB Controller Port 0
+      LDO setting.
+      Since this parameter is optional, the configuration remains default if it is not supplied.
+
+  cp1-ldo-volt:
+    enum:
+      - 1.0V
+      - 1.1V
+      - 1.2V
+      - 1.8V
+
+    description: |
+    Controller Port 1 voltage level is controlled by the I3C HUB Controller Port 1
+    LDO setting.
+    Since this parameter is optional, the configuration remains default if it is not supplied.
+
+  tp0145-ldo-volt:
+    enum:
+      - 1.0V
+      - 1.1V
+      - 1.2V
+      - 1.8V
+
+    description: |
+      Target Port 0/1/4/5 voltage level is controlled by the I3C HUB Target Port 0/1/4/5
+      LDO setting.
+      Since this parameter is optional, the configuration remains default if it is not supplied.
+
+  tp2367-ldo-volt:
+    enum:
+      - 1.0V
+      - 1.1V
+      - 1.2V
+      - 1.8V
+
+    description: |
+      Target Port 2/3/6/7 voltage level is controlled by the I3C HUB Target Port 2/3/6/7
+      LDO setting.
+      Since this parameter is optional, the configuration remains default if it is not supplied.
+
+  tp0145-pullup:
+    enum:
+      - 250R
+      - 500R
+      - 1000R
+      - 2000R
+
+    description: |
+      Target Port 0/1/4/5 pull up setting is controlled by the I3C HUB Target Port 0/1/4/5
+      pull up resistance level.
+      Since this parameter is optional, the configuration remains default if it is not supplied.
+
+  tp2367-pullup:
+    enum:
+      - 250R
+      - 500R
+      - 1000R
+      - 2000R
+
+    description: |
+      Target Port 2/3/6/7 pull up setting is controlled by the I3C HUB Target Port 2/3/6/7
+      pull up resistance level.
+      Since this parameter is optional, the configuration remains default if it is not supplied.
+
+  cp0-io-strength:
+    enum:
+      - 20Ohms
+      - 30Ohms
+      - 40Ohms
+      - 50Ohms
+
+    description: |
+      To regulate the output driver strength at Controller Port 0, use the I3C HUB Controller
+      Port 0 IO strength setting.
+      It is an optional property, the configuration remains default if it is not supplied.
+
+  cp1-io-strength:
+    enum:
+      - 20Ohms
+      - 30Ohms
+      - 40Ohms
+      - 50Ohms
+    description: |
+      To regulate the output driver strength at Controller Port 1, use the I3C HUB Controller
+      Port 1 IO strength setting.
+      It is an optional property, the configuration remains default if it is not supplied.
+
+  tp0145-io-strength:
+    enum:
+      - 20Ohms
+      - 30Ohms
+      - 40Ohms
+      - 50Ohms
+
+    description: |
+      To regulate the output driver strength at Target port 0/1/4/5, use the I3C HUB Target
+      port 0/1/4/5 IO strength setting.
+      It is an optional property, the configuration remains default if it is not supplied.
+
+  tp2367-io-strength:
+    enum:
+      - 20Ohms
+      - 30Ohms
+      - 40Ohms
+      - 50Ohms
+
+    description: |
+      To regulate the output driver strength at Target port 2/3/6/7, use the I3C HUB Target
+      port 2/3/6/7 IO strength setting.
+      It is an optional property, the configuration remains default if it is not supplied.
+
+patternProperties:
+  "@[0-7]$":
+    type: object
+    description: |
+      I3C HUB Target Port child, should be named: target-port@<target-port-id>
+
+    properties:
+      mode:
+        enum:
+          - i3c
+          - smbus
+          - i2c
+          - gpio
+
+        description: |
+          I3C HUB Target Port mode setting to control Target Port functionality.
+          As per now it is oly supporting SMBus, i2c and i3c( i2c mode will work
+          with hub network).
+
+      pullup:
+        enum:
+          - disabled
+          - enabled
+        description: |
+          I3C HUB Target Port pull-up setting to disable/enable Target Port pull-up.
+          It is an optional property, the configuration remains default if it is not supplied.
+
+      ibi_en:
+        enum:
+          - disabled
+          - enabled
+        description: |
+          I3C HUB Target Port IBI setting to disable/enable IBI for Target Port.
+          This property is optional. If not provided, Target Port IBI will disabled.
+
+      local_dev:
+        description: |
+          SMBus Target Agent can discard transactions of downstream device and not generate an IBI to upstream I3C Hub
+          Controller Port. Up to 8 device (addresses) can be configured as local Devices.
+
+          This property is optional. If not provided, local device list will empty.
+
+      always-enable:
+        description: |
+          Add this field to enable hub network(Controller port -> target port).
+
+          This property is optional. If not provided, by default hub network will disabled for respective port.
+
+    patternProperties:
+      "@slave-address,pid$":
+        type: object
+        description: |
+          Adding this node to install the downstream devices.
+
+        properties:
+          compatible:
+            description:
+              Compatible of the I2C/SMBus downstream device.
+
+          reg:
+            description:
+              Downstream device addresses which are connected to target port.
+
+          I3c HUB driver supports standerd i2c/i3c DT entry as it passes DT node to respective driver for
+          downstream device.
+
+additionalProperties: true
+
+examples:
+  - |
+      i3c_hub: hub@70,236153000c2{
+          reg = <0x70 0x236 0x3000c2>;
+          assigned-address = <0x50>;
+          dcr = <0xC2>;
+
+          cp0-ldo-en = "disabled";
+          cp1-ldo-en = "disabled";
+          cp0-ldo-volt = "1.8V";
+          cp1-ldo-volt = "1.8V";
+          tp0145-ldo-en = "disabled";
+          tp2367-ldo-en = "disabled";
+          tp0145-ldo-volt = "1.8V";
+          tp2367-ldo-volt = "1.8V";
+          tp0145-pullup= "1000R";
+          tp2367-pullup = "1000R";
+          tp0145-io-strength = "20Ohms";
+          tp2367-io-strength = "20Ohms";
+          cp0-io-strength = "20Ohms";
+          cp1-io-strength = "20Ohms";
+          target-port@0 {
+            #address-cells = <1>;
+                #size-cells = <0>;
+            mode = "smbus";
+            pullup_en = "enabled";
+            ibi_en = "enabled";
+            local_dev = <0x30>, <0x40>, <0x50>;
+            backend@4c{
+              compatible = "i3c-hub";
+              reg = <0x4c>;
+            };
+            rtc@68 {
+              compatible = "dallas,ds3232";
+              reg = <0x68>;
+              interrupt-parent = <&gpio2>;
+              interrupts = <20 0>;
+              trickle-resistor-ohms = <250>;
+            };
+
+            eeprom@57 {
+              compatible = "atmel,24c32";
+              reg = <0x57>;
+              pagesize = <32>;
+              wp-gpios = <&gpio2 2 0>;
+              num-addresses = <8>;
+            };
+          };
+          target-port@1 {
+            #address-cells = <1>;
+                #size-cells = <0>;
+            mode = "smbus";
+            pullup_en = "enabled";
+            ibi_en = "enabled";
+              local_dev = <0x35>, <0x45>, <0x55>;
+          };
+          target-port@2 {
+            #address-cells = <1>;
+                #size-cells = <0>;
+            mode = "i3c";
+            pullup_en = "enabled";
+            hub-test@4c,25400000000{
+              reg = <0x4c 0x254 0x0000>;
+              assigned-address = <0x50>;
+            };
+          };
+          target-port@3 {
+            #address-cells = <1>;
+                #size-cells = <0>;
+            mode = "i3c";
+            pullup_en = "enabled";
+            always-enable;
+          };
+      };
+
+      i3c_hub: hub@70 {
+          compatible = "nxp,p3h2x4x";
+          reg = <0x70>;
+
+          cp0-ldo-en = "disabled";
+          cp1-ldo-en = "disabled";
+          cp0-ldo-volt = "1.8V";
+          cp1-ldo-volt = "1.8V";
+          tp0145-ldo-en = "disabled";
+          tp2367-ldo-en = "disabled";
+          tp0145-ldo-volt = "1.8V";
+          tp2367-ldo-volt = "1.8V";
+          tp0145-pullup= "1000R";
+          tp2367-pullup = "1000R";
+          tp0145-io-strength = "20Ohms";
+          tp2367-io-strength = "20Ohms";
+          cp0-io-strength = "20Ohms";
+          cp1-io-strength = "20Ohms";
+          target-port@0 {
+            #address-cells = <1>;
+                #size-cells = <0>;
+            mode = "smbus";
+            pullup_en = "enabled";
+            ibi_en = "enabled";
+            local_dev = <0x30>, <0x40>, <0x50>;
+
+            backend@4c{
+              compatible = "test-dvr";
+              reg = <0x4c>;
+            };
+            rtc@68 {
+              compatible = "dallas,ds3232";
+              reg = <0x68>;
+              interrupt-parent = <&gpio2>;
+              interrupts = <20 0>;
+              trickle-resistor-ohms = <250>;
+            };
+
+            eeprom@57 {
+              compatible = "atmel,24c32";
+              reg = <0x57>;
+              pagesize = <32>;
+              wp-gpios = <&gpio2 2 0>;
+              num-addresses = <8>;
+            };
+          };
+	    };
+-  |
diff --git a/MAINTAINERS b/MAINTAINERS
index af686e0bb6d7..20aa3e987ac5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17167,6 +17167,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
 F:	sound/soc/codecs/tfa989x.c
 
+NXP P3H2X4X I3C-HUB DRIVER
+M:	Vikash Bansal <vikash.bansal@nxp.com>
+M:	Aman Kumar Pandey <aman.kumarpandey@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
+
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
 M:	Jonas Malaco <jonas@protocubo.io>
 L:	linux-hwmon@vger.kernel.org
-- 
2.25.1


