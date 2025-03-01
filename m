Return-Path: <linux-kernel+bounces-540136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4CA4AE27
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 23:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874F31893968
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EC01D7E57;
	Sat,  1 Mar 2025 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="cJNSC7nX"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52394182D7;
	Sat,  1 Mar 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740869019; cv=pass; b=tXQto0nNENfIukwbAVpjasD72PbfkBg2iugfpFs66L8P7LizaUgo+uDBRdnQ4QlA+DlucKZW0lFtQrNNdT5iBroInNH4laBebA788oWJw7aL75W8s8VcLd/u+z4U8ZWdINozQh29rtf3cnjm0owrhcBEBj3k96IgSks0fB5GT/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740869019; c=relaxed/simple;
	bh=A/zV3sYwxL6IO0hV9Oj01F2jWG5e+MT6YQpRTCw+CeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjHKeU2F4a85OQeB0R9WbRwyd+26tqcHtbh5Y5QrmkxGnVVRdQZxCj78SPKql5dRoy7OOrrS4yZD3Tm4vfVlsFBJ09hZA7XR0Mu8wMKtdCaU8hwMCqKgdaiNiyTYPi7Qkj9/6SiN3qbF9XqwwAMI8tiN/93yspymmpLY2VeS3IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=cJNSC7nX; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740868978; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HOoqr/osSOaKvT8o2Io7hCB9+vMjfKp+Vxz+wC6cU7V2WGfEO4Y2tB5E2+F6y596XTIYPjVIA0b1qdzUgg/5lx37pBRvm+nFHdawzcG/PgQ4fHyf4uyupaNT7qx6ngwlFpYeOh+5neg1uZiYuy8bsgroTm3bTd4o8l30J3gUM1c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740868978; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zW+kI9H8nUloZ6eHB1DkjcubSEViqb6G6XtKpf3n82Y=; 
	b=SdCnN5L0Se/WRvtak09Lj2RVTms8EhiH7zBy9Y4k5UWUlcKY+65KfDqvvQnHOX3+ZtJBGN/OqgnoGQ9JhEkCwiOIOLFmeUJtCjAG2vdi+o0BipDcRpJVGVf0L6oGqxjtirowa4uyjLeaBNjO1JyWhXpnViqFJHIUdno7zEC72vQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740868978;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=zW+kI9H8nUloZ6eHB1DkjcubSEViqb6G6XtKpf3n82Y=;
	b=cJNSC7nXFRRPV/2ArOtGQznLI5kVXOvp5bVSXnIso4QTljBr66U1ZoQ20c1guMZ5
	YiQCmr1UrIc8zQ1SBDlJlhZG8jpDAMCf4PjPiCj4hdnWRQcmBxgdl6LjAV2uQdtA6Zj
	K0Lb5vnpdXwx9njruAJG2sZ2TXFNc5cLfjRqaYZU=
Received: by mx.zohomail.com with SMTPS id 1740868976063828.944423692306;
	Sat, 1 Mar 2025 14:42:56 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 8D3B018361F; Sat, 01 Mar 2025 23:42:51 +0100 (CET)
Date: Sat, 1 Mar 2025 23:42:51 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	FUKAUMI Naoki <naoki@radxa.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add USB-C support to ROCK 5B
Message-ID: <njeivdzwyy6qxome77asapmi3a3l34mpauk366f6zgpt2mvorz@ra77f5vjd5lf>
References: <20241210163615.120594-1-sebastian.reichel@collabora.com>
 <12e97e18.367e.19551b6aea2.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6gkbyudopqh4via"
Content-Disposition: inline
In-Reply-To: <12e97e18.367e.19551b6aea2.Coremail.andyshrk@163.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/240.839.39
X-ZohoMailClient: External


--i6gkbyudopqh4via
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add USB-C support to ROCK 5B
MIME-Version: 1.0

Hello Andy,

On Sat, Mar 01, 2025 at 08:38:01PM +0800, Andy Yan wrote:
> At 2024-12-11 00:36:01, "Sebastian Reichel" <sebastian.reichel@collabora.=
com> wrote:
> >Add hardware description for the USB-C port in the Radxa Rock 5 Model B.
> >This describes the OHCI, EHCI and XHCI USB parts, but not yet the
> >DisplayPort AltMode (bindings are not yet upstream).
> >
> >The fusb302 node is marked with status "fail", since the board is usually
> >powered through the USB-C port. Handling of errors can result in hard
> >resets, which removed the bus power for some time resulting in a board
> >reset.
> >
> >The main problem is that devices are supposed to interact with the
> >power-supply within 5 seconds after the plug event according to the
> >USB PD specification. This is more or less impossible to achieve when
> >the kernel is the first software communicating with the power-supply.
> >
> >Recent U-Boot (v2025.01) will start doing USB-PD communication, which
> >solves this issue. Upstream U-Boot doing USB-PD communication will also
> >set the fusb302 node status to "okay". That way booting a kernel with
> >the updated DT on an old U-Boot avoids a reset loop.
>=20
> Do you have any plans to continue working on this patch?
> I've been working on enabling the DP Alt Mode output recently
> and think the Rock 5b is a good starting point=E3=80=82

This is still on my radar. I recently send an updates U-Boot series
with some TCPM improvements:

https://lore.kernel.org/u-boot/20250226184506.64114-1-sebastian.reichel@col=
labora.com/

Even with that there are more issues resulting in hard resets
happening in some circumstances (if they are happening depends a lot
on the specific powre supply being used). I'm still looking for the
root cause of these. It's also hard to tell when it is a good time
to apply this patch. Some people will probably see a regression due
to using power-supplies diverging too far from the standard :/

Greetings,

-- Sebastian

>     =20
> >
> >Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >---
> > .../boot/dts/rockchip/rk3588-rock-5b.dts      | 121 ++++++++++++++++++
> > 1 file changed, 121 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm6=
4/boot/dts/rockchip/rk3588-rock-5b.dts
> >index d597112f1d5b..cb5990df6ccb 100644
> >--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >@@ -5,6 +5,7 @@
> > #include <dt-bindings/gpio/gpio.h>
> > #include <dt-bindings/leds/common.h>
> > #include <dt-bindings/soc/rockchip,vop2.h>
> >+#include <dt-bindings/usb/pd.h>
> > #include "rk3588.dtsi"
> >=20
> > / {
> >@@ -84,6 +85,15 @@ rfkill-bt {
> > 		shutdown-gpios =3D <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
> > 	};
> >=20
> >+	vcc12v_dcin: regulator-vcc12v-dcin {
> >+		compatible =3D "regulator-fixed";
> >+		regulator-name =3D "vcc12v_dcin";
> >+		regulator-always-on;
> >+		regulator-boot-on;
> >+		regulator-min-microvolt =3D <12000000>;
> >+		regulator-max-microvolt =3D <12000000>;
> >+	};
> >+
> > 	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
> > 		compatible =3D "regulator-fixed";
> > 		enable-active-high;
> >@@ -142,6 +152,7 @@ vcc5v0_sys: regulator-vcc5v0-sys {
> > 		regulator-boot-on;
> > 		regulator-min-microvolt =3D <5000000>;
> > 		regulator-max-microvolt =3D <5000000>;
> >+		vin-supply =3D <&vcc12v_dcin>;
> > 	};
> >=20
> > 	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
> >@@ -264,6 +275,67 @@ regulator-state-mem {
> > 	};
> > };
> >=20
> >+&i2c4 {
> >+	pinctrl-names =3D "default";
> >+	pinctrl-0 =3D <&i2c4m1_xfer>;
> >+	status =3D "okay";
> >+
> >+	usbc0: usb-typec@22 {
> >+		compatible =3D "fcs,fusb302";
> >+		reg =3D <0x22>;
> >+		interrupt-parent =3D <&gpio3>;
> >+		interrupts =3D <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> >+		pinctrl-names =3D "default";
> >+		pinctrl-0 =3D <&usbc0_int>;
> >+		vbus-supply =3D <&vcc12v_dcin>;
> >+		/*
> >+		 * When the board is starting to send power-delivery messages
> >+		 * too late (5 seconds according to the specification), the
> >+		 * power-supply reacts with a hard-reset. That removes the
> >+		 * power from VBUS for some time, which resets te whole board.
> >+		 */
> >+		status =3D "fail";
> >+
> >+		usb_con: connector {
> >+			compatible =3D "usb-c-connector";
> >+			label =3D "USB-C";
> >+			data-role =3D "dual";
> >+			power-role =3D "sink";
> >+			try-power-role =3D "sink";
> >+			op-sink-microwatt =3D <1000000>;
> >+			sink-pdos =3D
> >+				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
> >+				<PDO_VAR(5000, 20000, 5000)>;
> >+
> >+			ports {
> >+				#address-cells =3D <1>;
> >+				#size-cells =3D <0>;
> >+
> >+				port@0 {
> >+					reg =3D <0>;
> >+					usbc0_role_sw: endpoint {
> >+						remote-endpoint =3D <&dwc3_0_role_switch>;
> >+					};
> >+				};
> >+
> >+				port@1 {
> >+					reg =3D <1>;
> >+					usbc0_orien_sw: endpoint {
> >+						remote-endpoint =3D <&usbdp_phy0_orientation_switch>;
> >+					};
> >+				};
> >+
> >+				port@2 {
> >+					reg =3D <2>;
> >+					dp_altmode_mux: endpoint {
> >+						remote-endpoint =3D <&usbdp_phy0_dp_altmode_mux>;
> >+					};
> >+				};
> >+			};
> >+		};
> >+	};
> >+};
> >+
> > &i2c6 {
> > 	status =3D "okay";
> >=20
> >@@ -423,6 +495,10 @@ usb {
> > 		vcc5v0_host_en: vcc5v0-host-en {
> > 			rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> > 		};
> >+
> >+		usbc0_int: usbc0-int {
> >+			rockchip,pins =3D <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> >+		};
> > 	};
> > };
> >=20
> >@@ -835,6 +911,14 @@ &uart2 {
> > 	status =3D "okay";
> > };
> >=20
> >+&u2phy0 {
> >+	status =3D "okay";
> >+};
> >+
> >+&u2phy0_otg {
> >+	status =3D "okay";
> >+};
> >+
> > &u2phy1 {
> > 	status =3D "okay";
> > };
> >@@ -866,6 +950,29 @@ &usbdp_phy1 {
> > 	status =3D "okay";
> > };
> >=20
> >+&usbdp_phy0 {
> >+	mode-switch;
> >+	orientation-switch;
> >+	sbu1-dc-gpios =3D <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
> >+	sbu2-dc-gpios =3D <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
> >+	status =3D "okay";
> >+
> >+	port {
> >+		#address-cells =3D <1>;
> >+		#size-cells =3D <0>;
> >+
> >+		usbdp_phy0_orientation_switch: endpoint@0 {
> >+			reg =3D <0>;
> >+			remote-endpoint =3D <&usbc0_orien_sw>;
> >+		};
> >+
> >+		usbdp_phy0_dp_altmode_mux: endpoint@1 {
> >+			reg =3D <1>;
> >+			remote-endpoint =3D <&dp_altmode_mux>;
> >+		};
> >+	};
> >+};
> >+
> > &usb_host0_ehci {
> > 	status =3D "okay";
> > };
> >@@ -874,6 +981,20 @@ &usb_host0_ohci {
> > 	status =3D "okay";
> > };
> >=20
> >+&usb_host0_xhci {
> >+	usb-role-switch;
> >+	status =3D "okay";
> >+
> >+	port {
> >+		#address-cells =3D <1>;
> >+		#size-cells =3D <0>;
> >+
> >+		dwc3_0_role_switch: endpoint {
> >+			remote-endpoint =3D <&usbc0_role_sw>;
> >+		};
> >+	};
> >+};
> >+
> > &usb_host1_ehci {
> > 	status =3D "okay";
> > };
> >--=20
> >2.45.2
> >

--i6gkbyudopqh4via
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfDjV0ACgkQ2O7X88g7
+pp++w//WeNwj9c0G5In57hTyHoUnPf6fCDFB4OGmg8aP4VS9GWDZYKYSgeJ6l0Q
HQgjzWRdQC8hHnst8XGrMNrcjBqQzfr0vtcgDG5MEem4ygAHMHmPFAqJwnR6uXI0
tJPErhmwPB/GTtxXviSNhfyeoGGXmsN8TGhAOcSw+AXXLfgqEeIMv+yKOab4TXFh
qyasj1kh/5bYIbEqTRIInQEk73tmwqgnSxPp1P0Duv60nBJo54C4ZroaZcEpJPRV
87cjJnVWnYCnwTEp/7QvywD5mZMLY4ghhS2E8wqVDgr5nNyDCVhjl2yycuXylsOh
EQqZDQWAPaS6ATBPY1HUmPGqVDhdKQ09+62A9Mvds00wFzEJ1U/RHJIopQ4Ahqbl
job5Jn5kcKLuZlt0t2fwYVlw969HYtTK62UUHwYaNl8Qkt+SW59nurkcXNYdjQCT
UPC/LaSx+vw7/M9Radq1UJ8VtJkZKgfIrWWBbtcTjRmkV7snyQwoGEkdvgPB3Ts3
XF3R/Rf07DyAxDJ8kmg4P5mj2qa2GxWoaIG97nFZpYUEXM123npXBnL0zqZXJKJm
em2eFaLWEnXMj8bOqmopp9/Z7HlJ0lxJyge6W0HyzuLM8668nMrYrz2DJZ3gjFd7
sd3KtSg4wfK7cWJa7J7baMmp1nL7FI8p7lKl9imhwaeZBuoETcg=
=10bJ
-----END PGP SIGNATURE-----

--i6gkbyudopqh4via--

