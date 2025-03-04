Return-Path: <linux-kernel+bounces-544302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F30A4DFF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43F6189CCD5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC9B204C25;
	Tue,  4 Mar 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QxiPpaI1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD2204876;
	Tue,  4 Mar 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096588; cv=none; b=YMkuYAkx7i/49wz855ZSSKCzqVUG/rrz2t5N4rnsGektsgCObDX3bE5UglZqwST6AlB7rg4PKfW4jZ/PVHLfvmpcFoBDh2A6QnpjmIlRQJSb8X88MstZ21Gvt7py960CNFkaHtP7fBNcTsnD5w8qsQOKBHilmZUadGcjM/b7oZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096588; c=relaxed/simple;
	bh=BYE1PMNXLmh6humc1AIGM9TE2xmShRPk4wpB/+IC4Io=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/PfCbpsBtyF9I4kh/DSW84NGAXZJSJjTj4bCC6DzPnj3yHxEPHm1FawcKrevyNXZn3aPMzP2wljhwTFnfVWoBDOjN0M2ylZzvMRhbG6H2I9Xzv/Xqqr/+7q7SIQP/Eg7nJ7rGJ8mVF3401Hb3ke9A3pBRi4pwtA1G9Pd+HB7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QxiPpaI1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741096584;
	bh=BYE1PMNXLmh6humc1AIGM9TE2xmShRPk4wpB/+IC4Io=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QxiPpaI1gQj9880lB5GeSnWv9GwWvx/teUExUau16QIQy3E8IMXe8lO3CUGrKPZSb
	 sT6kj9+chBIcxXE6lH7noxnJNI9fpSMcyWDY8ftrWXqfUWMePf4KpMwCuPS0h5ijZ3
	 +6AdX+R+qk02CTJ0728+othIa2MD/3gHvbK957DJXY/5BBNqSFsZ7m/jQoK8LAcG0W
	 U4zu+zm2sfC8zHXMlCH3vL7MsAM1cWpZXSMjmN6J2GDProNFX28/mPwXbJmRMEXJnT
	 ILO9AkVOAj41TIoqlWK5qnuiQQsTzSRxiHL1D1k9etwNqBqdN8Enfg/uO2KrQrsY9i
	 KVYwqaSaj+fhw==
Received: from apertis-1.home (2a01cb0892f2D600C8f85Cf092d4af51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0038A17E086B;
	Tue,  4 Mar 2025 14:56:23 +0100 (CET)
Message-ID: <3ee575154a95627b7ecaf33b2f52b6fa0ce4a352.camel@collabora.com>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI
 DSI port
From: Julien Massot <julien.massot@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	kernel@collabora.com, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	 <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Tue, 04 Mar 2025 14:56:23 +0100
In-Reply-To: <fc0a9471-da47-4f4f-a471-1b20f344ad22@collabora.com>
References: <20250226-radxa-panel-overlay-v1-0-9e8938dfbead@collabora.com>
	 <20250226-radxa-panel-overlay-v1-1-9e8938dfbead@collabora.com>
	 <fc0a9471-da47-4f4f-a471-1b20f344ad22@collabora.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Angelo,

On Mon, 2025-03-03 at 12:32 +0100, AngeloGioacchino Del Regno wrote:
> Il 26/02/25 15:35, Julien Massot ha scritto:
> > This board can use a MIPI-DSI panel on the DSI0 connector: in
> > preparation for adding an overlay for the Radxa Display 8HD,
> > add a pipeline connecting VDOSYS0 components to DSI0.
> >=20
> > Also add the backlight, and some pin definitions available
> > through the DSI0 port.
> >=20
> > Signed-off-by: Julien Massot <julien.massot@collabora.com>
> > ---
> > =C2=A0 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts=C2=A0=C2=A0=C2=A0=
=C2=A0 | 60 ++++++++++++++++++++++
> > =C2=A0 1 file changed, 60 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> > b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> > index 7184dc99296c7f5d749c7e6d378722677970b3b7..65c77e43d1cd4913b6741e2=
5130febd746ff753c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
> > @@ -48,6 +48,17 @@ memory@40000000 {
> > =C2=A0=C2=A0		reg =3D <0 0x40000000 0x1 0x0>;
> > =C2=A0=C2=A0	};
> > =C2=A0=20
> > +	backlight: backlight {
> > +		compatible =3D "pwm-backlight";
> > +		brightness-levels =3D <0 1023>;
> > +		default-brightness-level =3D <576>;
> > +		enable-gpios =3D <&pio 107 GPIO_ACTIVE_HIGH>;
> > +		num-interpolated-steps =3D <1023>;
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&dsi0_backlight_pins>;
> > +		pwms =3D <&disp_pwm0 0 500000>;
>=20
> This should be disabled, unless there is a display connected to the DSI c=
onnector.
>=20
> If there's no display, there's no point in enabling any backlight, as tha=
t pin
> may be reused somehow (with hardware hacks, maybe, yes, but still configu=
ring
> the PWM IP and the pin as PWM while unused is at least a waste of energy)=
.
>=20
Yes, I will keep it disabled in the board dts.

> > +	};
> > +
> > =C2=A0=C2=A0	wifi_vreg: regulator-wifi-3v3-en {
> > =C2=A0=C2=A0		compatible =3D "regulator-fixed";
> > =C2=A0=C2=A0		regulator-name =3D "wifi_3v3_en";
> > @@ -499,9 +510,20 @@ &mt6359_vsram_others_ldo_reg {
> > =C2=A0=C2=A0	regulator-max-microvolt =3D <750000>;
> > =C2=A0 };
> > =C2=A0=20
> > +&ovl0_in {
> > +	remote-endpoint =3D <&vdosys0_ep_main>;
> > +};
> > +
>=20
> This goes to the overlay that enables the DSI display.
Ok

>=20
> > @@ -912,6 +960,18 @@ &ssusb2 {
> > =C2=A0=C2=A0	status =3D "okay";
> > =C2=A0 };
> > =C2=A0=20
> > +&vdosys0 {
> > +	port {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		vdosys0_ep_main: endpoint@0 {
> > +			reg =3D <0>;
> > +			remote-endpoint =3D <&ovl0_in>;
> > +		};
> > +	};
> > +};
>=20
> If you enable this path, in the event that the DSI display overlay is not=
 added,
> the mediatek-drm driver will fail probing: even if a second path is enabl=
ed and
> that will succeed regardless of the first one failing, I don't see a reas=
on why
> whoever doesn't have a DSI display attached should see a miserable failur=
e in the
> kernel log :-)
>=20
> Besides, mediatek-drm failing will also slow down boot for no reason.... =
etc etc.
>=20
> Please move the display path setup to the DSI display overlay.
Sure will move the display path setup to the display overlay.

Thank you,
Julien

