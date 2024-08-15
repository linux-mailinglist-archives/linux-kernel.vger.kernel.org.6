Return-Path: <linux-kernel+bounces-287854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2724952D44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD8A1F2506F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C231AC8B8;
	Thu, 15 Aug 2024 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SdkgwD72"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02257DA62
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720398; cv=none; b=m0VlOcQGcLKN/Oy5MYIZGksasSlqkXtahEmUS8ezQAfbPDQHQtcIFF6lIK5wgJKrFK5chQu5FLwTyUohWZjjmn4PUoXcwP2Q8WEO8YAA1tgHvTJafty25plpiYR4CEzZfS7rgyIeHhdDIyCxMC3CXkZUv23ndUtE3C1gA8UlNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720398; c=relaxed/simple;
	bh=mPkoqERZHJFYnQt0rUvmWi2CCBxzatnp4aFeT34szJE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HggQ+TytOmIXucezEcAVN+tkmu/mcbj1C0kQ0o+Ysc3fvkq5SBnikDPH/Klf0QElU3YP54IOkR95g/1tR5S6GWLi4tX95VbhQGaiZF7D+1a6pmAR8IiPM25mmV/IInSITHm5NaX+gxbDfM6Ocjq2dSJSn22PdSMLVrwuYvwqxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SdkgwD72; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723720393; x=1723979593;
	bh=FsbMCg+dDDJxYSgu2kRGR7XQ/jxNE9sgaAaItpQM44M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SdkgwD72NSYGSh3KKNb8de13CJN8mYPjAQncbesPa5ewV3xw+VV6Z33g1c23d9GZ4
	 PyTBqUBNegXyEsP6AIKr6Wvf05Rm3CWAp3bdm96fxmR1o9S5TuljNNpH0e0zNkF5Hy
	 K//qSpieHd2r7V4spJJSFpGqmK2+ZfgV297wbApGALQIBC29V/vDvbyVoMgD3H9+Ow
	 ktUteMbHzmd5t8Ohkb2v0rU4gXaeXjJSSBcn4qdakN0kzeqJ5vW+iibbYOJOgI7JTU
	 yS+AgvHuUWYWnfBucb5Y9Aw0CFIJpZ94TGqZxM0NnKz4/t0u0U2ZQ3WuYGo1NW7JMS
	 GR1k+Y5BodyTg==
Date: Thu, 15 Aug 2024 11:13:11 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Masanori Ogino <omasanori@proton.me>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Masanori Ogino <mogino@acm.org>
Subject: [PATCH] Documentation: msm-hsusb.txt: remove
Message-ID: <20240815111107.10561-1-omasanori@proton.me>
Feedback-ID: 82490182:user:proton
X-Pm-Message-ID: 6e83495661d2c5360ca705ee6c6970bb52f61e47
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



