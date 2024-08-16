Return-Path: <linux-kernel+bounces-289338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D8954504
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213E31C23001
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F604127B57;
	Fri, 16 Aug 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Fo4qYqbK"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922613DDAB;
	Fri, 16 Aug 2024 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798957; cv=none; b=YdUklR7YJQiINpxoLlPOD7qMBlYMVOKXZpcG6UHsnMLT4dLBhm6CYj/lwXwzW3WUayHUXJplNejmK+WPRpn/k3o/iqoVQFQHpKbzSBaUZ9gaHvGUlnMaJqYpx/dGq1F3EyICnVFzOsv8C6FKPa9xsPXzYmFi4sUEEGA7c6FusQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798957; c=relaxed/simple;
	bh=mPkoqERZHJFYnQt0rUvmWi2CCBxzatnp4aFeT34szJE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UDr95UEIjtP91DkH+YnWDB4E8aSf/tlLAdd+SM4YGoYoTNNkYzwovUo3ETqTsLqDI5RXYfXIJ0DLh4t4SmD5HURMHAXlk86lzSSj5MLF2FVxSbicKDMpmA2AUqfBXhZUS40hbaPvndFTZRNU3U+It/x5bATbcwwH5LmgYhbAXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Fo4qYqbK; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723798947; x=1724058147;
	bh=FsbMCg+dDDJxYSgu2kRGR7XQ/jxNE9sgaAaItpQM44M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Fo4qYqbKFJ8o7Y9j1XgfVnyVi9Mp/WTtlaZPre15bWpbNQBVXbcowRa5dnpSd9dbc
	 AQD082uGDS4VO+ua2rGLsiGHf0XdA1p+kC9JF1M++rAMW/e4pTpbtc29mS+HVbCtnJ
	 fgXyGAZSuJOdIC+OiaIHunbsadMpppgIXMmLAcR97KOIEONHrTCNyuuhv7bZ4P8xRq
	 jb3B//DrcxTnWoGGIsSVo0ph4UhSEwk81Ls7Le49/LqhB5PQI/8YdRdesBFVXw28CC
	 sihnEIjezNJpmXXvIimP6DFOzl2MTB2nzPGVWHESLOuw886kORLLe1nF0FwgqFbWo3
	 Wh0aWqNcimMGg==
Date: Fri, 16 Aug 2024 09:02:22 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
From: Masanori Ogino <omasanori@proton.me>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Masanori Ogino <mogino@acm.org>
Subject: [PATCH] Documentation: msm-hsusb.txt: remove
Message-ID: <20240816090105.13651-2-omasanori@proton.me>
Feedback-ID: 82490182:user:proton
X-Pm-Message-ID: 050cd5228cd205175abeb9ef00d028dbb2d6b944
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Masanori Ogino <mogino@acm.org>

Commit a170a1e9ccc5 ("usb: phy: remove phy-msm-usb.c") removed the
device driver but left the corresponding documentation, delete it.

Signed-off-by: Masanori Ogino <mogino@acm.org>
---
 .../devicetree/bindings/usb/msm-hsusb.txt     | 110 ------------------
 1 file changed, 110 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/msm-hsusb.txt

diff --git a/Documentation/devicetree/bindings/usb/msm-hsusb.txt b/Document=
ation/devicetree/bindings/usb/msm-hsusb.txt
deleted file mode 100644
index afc30e98b123..000000000000
--- a/Documentation/devicetree/bindings/usb/msm-hsusb.txt
+++ /dev/null
@@ -1,110 +0,0 @@
-MSM SoC HSUSB controllers
-
-EHCI
-
-Required properties:
-- compatible:=09Should contain "qcom,ehci-host"
-- regs:=09=09=09offset and length of the register set in the memory map
-- usb-phy:=09=09phandle for the PHY device
-
-Example EHCI controller device node:
-
-=09ehci: ehci@f9a55000 {
-=09=09compatible =3D "qcom,ehci-host";
-=09=09reg =3D <0xf9a55000 0x400>;
-=09=09usb-phy =3D <&usb_otg>;
-=09};
-
-USB PHY with optional OTG:
-
-Required properties:
-- compatible:   Should contain:
-  "qcom,usb-otg-ci" for chipsets with ChipIdea 45nm PHY
-  "qcom,usb-otg-snps" for chipsets with Synopsys 28nm PHY
-
-- regs:         Offset and length of the register set in the memory map
-- interrupts:   interrupt-specifier for the OTG interrupt.
-
-- clocks:       A list of phandle + clock-specifier pairs for the
-                clocks listed in clock-names
-- clock-names:  Should contain the following:
-  "phy"         USB PHY reference clock
-  "core"        Protocol engine clock
-  "iface"       Interface bus clock
-  "alt_core"    Protocol engine clock for targets with asynchronous
-                reset methodology. (optional)
-
-- vdccx-supply: phandle to the regulator for the vdd supply for
-                digital circuit operation.
-- v1p8-supply:  phandle to the regulator for the 1.8V supply
-- v3p3-supply:  phandle to the regulator for the 3.3V supply
-
-- resets:       A list of phandle + reset-specifier pairs for the
-                resets listed in reset-names
-- reset-names:  Should contain the following:
-  "phy"         USB PHY controller reset
-  "link"        USB LINK controller reset
-
-- qcom,otg-control: OTG control (VBUS and ID notifications) can be one of
-                1 - PHY control
-                2 - PMIC control
-
-Optional properties:
-- dr_mode:      One of "host", "peripheral" or "otg". Defaults to "otg"
-
-- switch-gpio:  A phandle + gpio-specifier pair. Some boards are using Dua=
l
-                SPDT USB Switch, witch is controlled by GPIO to de/multipl=
ex
-                D+/D- USB lines between connectors.
-
-- qcom,phy-init-sequence: PHY configuration sequence values. This is relat=
ed to Device
-                Mode Eye Diagram test. Start address at which these values=
 will be
-                written is ULPI_EXT_VENDOR_SPECIFIC. Value of -1 is reserv=
ed as
-                "do not overwrite default value at this address".
-                For example: qcom,phy-init-sequence =3D < -1 0x63 >;
-                Will update only value at address ULPI_EXT_VENDOR_SPECIFIC=
 + 1.
-
-- qcom,phy-num: Select number of pyco-phy to use, can be one of
-                0 - PHY one, default
-                1 - Second PHY
-                Some platforms may have configuration to allow USB
-                controller work with any of the two HSPHYs present.
-
-- qcom,vdd-levels: This property must be a list of three integer values
-                (no, min, max) where each value represents either a voltag=
e
-                in microvolts or a value corresponding to voltage corner.
-
-- qcom,manual-pullup: If present, vbus is not routed to USB controller/phy
-                and controller driver therefore enables pull-up explicitly
-                before starting controller using usbcmd run/stop bit.
-
-- extcon:       phandles to external connector devices. First phandle
-                should point to external connector, which provide "USB"
-                cable events, the second should point to external connecto=
r
-                device, which provide "USB-HOST" cable events. If one of
-                the external connector devices is not required empty <0>
-                phandle should be specified.
-
-Example HSUSB OTG controller device node:
-
-    usb@f9a55000 {
-        compatible =3D "qcom,usb-otg-snps";
-        reg =3D <0xf9a55000 0x400>;
-        interrupts =3D <0 134 0>;
-        dr_mode =3D "peripheral";
-
-        clocks =3D <&gcc GCC_XO_CLK>, <&gcc GCC_USB_HS_SYSTEM_CLK>,
-                <&gcc GCC_USB_HS_AHB_CLK>;
-
-        clock-names =3D "phy", "core", "iface";
-
-        vddcx-supply =3D <&pm8841_s2_corner>;
-        v1p8-supply =3D <&pm8941_l6>;
-        v3p3-supply =3D <&pm8941_l24>;
-
-        resets =3D <&gcc GCC_USB2A_PHY_BCR>, <&gcc GCC_USB_HS_BCR>;
-        reset-names =3D "phy", "link";
-
-        qcom,otg-control =3D <1>;
-        qcom,phy-init-sequence =3D < -1 0x63 >;
-        qcom,vdd-levels =3D <1 5 7>;
-=09};
--=20
2.46.0



