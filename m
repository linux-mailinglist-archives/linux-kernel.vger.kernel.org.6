Return-Path: <linux-kernel+bounces-423639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D199DAAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8542628167B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ADC1FF7DD;
	Wed, 27 Nov 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="naTabAUG"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE21E51D;
	Wed, 27 Nov 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721357; cv=none; b=grk7jxxFM30e6C7j96VngU0vvS4hkEp0nQ13hoGFrhQYbe+W+RVE/LOSG4JNE8FB1aachhWl+vYCXh8rOAZr+XaEwem0Y/IO8keUjwd7NGo2PfZe0JncM1ckfL4Ii00ZIGvJMCErYkBaLR9G4tNWlXLsV6VFn5Mch9PEEbsQZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721357; c=relaxed/simple;
	bh=OZazX9SClijNkZtzvTDnEqUsBjVVJ2z//UEvPGoAJ3I=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=AaFSOgfR79Jo/KvhQHP6Rx+RJqOJ3cOS2AWRz6gCu/b8QACziIHGSOW/o8NTPTefduejclySaXbvQjxO6hIIOO0HJpoAdu9eLJcjfw4cjWmO0lfbq+rZZFyC4N0+/n49Fbi+1DyBeBhplaTA+dcjciOwoYN9f3Tbm7Bn1HjL0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=naTabAUG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1732721341; x=1733326141; i=frank-w@public-files.de;
	bh=Bhy3lS5xBdtG3cFqlE00X8F14KPxS7oFT22PELuAg0s=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=naTabAUGlSEkFimSF8TxnK5xCkrQh4YbRqrFap3iHQ53cpmZSr/IUu8KeeXuLNf0
	 I/H1QptBMkKZS8mMEBdaA39kM2q9A0jfE2M3nC2Cuj21jeY65YAXCn+lgn0AYXXby
	 jlsfOnQAJlY6us9Hr80UA1CGA2T4Xu8qI/dJFlguC+4qzq42GCnuJX8dr0XcZJDMf
	 AAKTerT3uvIIxzPxuujtVoe9yuvono/1qPYmQudOf7P/AN+bsbfwFE1Wh4jqc0/yF
	 po4dOt+9Va9J9ZGvetvEc38Uyf5lZjQ9rCgsCGy2hfCYpQs9MzCqrovel+4ZW2aIr
	 RxttmMDXzCWWGp+7Qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.224.21] ([157.180.224.21]) by msvc-mesg-gmx103 (via
 HTTP); Wed, 27 Nov 2024 16:29:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-b73d119f-df34-4724-a327-be59ad3410bf-1732721341758@msvc-mesg-gmx103>
From: Frank Wunderlich <frank-w@public-files.de>
To: angelogioacchino.delregno@collabora.com, linux@fw-web.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [RFC v1 10/14] arm64: dts: mediatek: mt7988: add lvts node
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6725747d-2db4-4f80-be25-4b314e59ab9a@collabora.com>
Importance: normal
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-11-linux@fw-web.de>
 <6725747d-2db4-4f80-be25-4b314e59ab9a@collabora.com>
Sensitivity: Normal
Date: Wed, 27 Nov 2024 16:29:01 +0100
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:d5qngSojmeo1EodTOgFNr+aD5GS161u469K6Y1PSY2C0svHCDz9iHqSIj5xw8388HO+UN
 r/l7Y0vdvjqxh0qwOkykUBWoF72Bb9v7l+mzrVcWDd2n12YBRFOkzLsygaowpZFecObIgqcCYKk4
 bq1Z0eptPBV5n26He2pDKU1lnFKSVrTCcN4GyBaVYYY8kTE8cY9Ic64+ZlvlO9beic0LyEfI6jRf
 lhM4v8sF+brhfI66h56IgYjY0QFnGR+1z4ctAk/arSKvTqSMZUQN571VnQyHi1ZCoHxLcnwNdyMV
 cQ=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:43DHYM8XJJ4=;agufmWR33nlynwPgFtkwqB3pkMl
 OPhdL2a6Ggn2cWykbyxebkowWdUh/fFSEf7mFt9Z6woLyqFd8uSAXbhVTAoGe61rPcvmH36w0
 qrcrYA6lRbJZtDJYf9PSD0dnhOQF+AbeWAezLrL74sL9tbij9mUlUf1U1HlK4N+kloYi2tc2t
 n1i4Nk/K5dAhzAf3UlwcoWQXfFPAVLO8dABmvX23P97cg2c8NWl5xXPdLaKtVjC+DYSvMzj1+
 84p0R+E5ZANoeQh/1A0+t6cuerEV8Fwy0JNRUnKc3hRH81GsQRfk1jT/43BhE5hg1v2l3J/lZ
 F6kRwQRD/ig0FZuuSXBy8T9VZyYJ+LotK2ifJxCs7Ik9Ty0KyUd7I/LCKAW81U3bsamNdgpD8
 DPbhdwnFIpPoSWF/pzWKkTFynWWcetHWpIlRE7bAoRB3CM1zpYOjb39njx/YUMreac4Lex1c3
 16JcWAjzytmTrRXVTFgMPgvpJJo13qv/N50sigYIOyH7dWcN4iUaeXJpzbr/Vr+KxR8LVa/x7
 oAFCezLfS+0CEhSIzdOJphQWbCCoN/IfUIy8UHmr6tOaBL2N1azLa0zMHbmZcNpZfkQefCxZk
 n4R9PGuWgyNnsCRra/nsb4q32GIQj2Xkiq2OwRcHlRSmGULU/Ym0KKfCXKnU4noUynHG21EPr
 VFImQSitOrdl09SyGoCLnWRlf7dmBvSHgu5B+b1jdkpaSOWXQWwcS160w+nUrJybJ1s/gABgI
 D18a5AleXeB5fLPN71qC1XWEuS25MK6WRaKQQyGngnFu7ot1/fdCVBGLyagNUjnAvuDGC+y3J
 sEAS90vHgVzDIfZf5BFE3ADGYI7Jzqeet3iEh5/thTwsTjnYuDzkPCRiFCoqMUhbBefSGr/1S
 GEq0fYjAmizsm5SbyCBAQidqKgeWpAGOxZ5M=
Content-Transfer-Encoding: quoted-printable

&gt; Gesendet: Mittwoch, 27. November 2024 um 14:34
&gt; Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabor=
a.com>
&gt; An: "Frank Wunderlich" <linux@fw-web.de>, "Rob Herring" <robh@kernel.=
org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt=
@kernel.org>, "Matthias Brugger" <matthias.bgg@gmail.com>
&gt; CC: "Frank Wunderlich" <frank-w@public-files.de>, devicetree@vger.ker=
nel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.or=
g, linux-mediatek@lists.infradead.org
&gt; Betreff: Re: [RFC v1 10/14] arm64: dts: mediatek: mt7988: add lvts no=
de
&gt;
&gt; Il 29/10/24 11:39, Frank Wunderlich ha scritto:
&gt; &gt; From: Frank Wunderlich <frank-w@public-files.de>
&gt; &gt;
&gt; &gt; Add Low Voltage Thermal Sensor (LVTS) node for mt7988 SoC.
&gt; &gt;
&gt; &gt; Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
&gt;
&gt; Please add the lvts_calibration nvmem entry in this commit instead.

and leaving the other (currently not linked) subnodes?

&gt; Cheers,
&gt; Angelo
&gt;
&gt; &gt; ---
&gt; &gt;   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 13 +++++++++++++
&gt; &gt;   1 file changed, 13 insertions(+)
&gt; &gt;
&gt; &gt; diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/ar=
m64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; index ed8ce1e6f68b..de9a9ff2edd8 100644
&gt; &gt; --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; @@ -4,6 +4,7 @@
&gt; &gt;   #include <dt-bindings interrupt-controller=3D"" arm-gic.h=3D""=
>
&gt; &gt;   #include <dt-bindings phy=3D"" phy.h=3D"">
&gt; &gt;   #include <dt-bindings pinctrl=3D"" mt65xx.h=3D"">
&gt; &gt; +#include <dt-bindings reset=3D"" mediatek,mt7988-resets.h=3D"">
&gt; &gt;
&gt; &gt;   / {
&gt; &gt;   	compatible =3D "mediatek,mt7988a";
&gt; &gt; @@ -103,6 +104,7 @@ infracfg: clock-controller@10001000 {
&gt; &gt;   			compatible =3D "mediatek,mt7988-infracfg", "syscon";
&gt; &gt;   			reg =3D &lt;0 0x10001000 0 0x1000&gt;;
&gt; &gt;   			#clock-cells =3D &lt;1&gt;;
&gt; &gt; +			#reset-cells =3D &lt;1&gt;;
&gt; &gt;   		};
&gt; &gt;
&gt; &gt;   		topckgen: clock-controller@1001b000 {
&gt; &gt; @@ -268,6 +270,17 @@ i2c2: i2c@11005000 {
&gt; &gt;   			status =3D "disabled";
&gt; &gt;   		};
&gt; &gt;
&gt; &gt; +		lvts: lvts@1100a000 {
&gt; &gt; +			compatible =3D "mediatek,mt7988-lvts-ap";
&gt; &gt; +			#thermal-sensor-cells =3D &lt;1&gt;;
&gt; &gt; +			reg =3D &lt;0 0x1100a000 0 0x1000&gt;;
&gt; &gt; +			clocks =3D &lt;&amp;infracfg CLK_INFRA_26M_THERM_SYSTEM&gt;;
&gt; &gt; +			interrupts =3D <gic_spi 138=3D"" irq_type_level_high=3D"">;
&gt; &gt; +			resets =3D &lt;&amp;infracfg MT7988_INFRA_RST1_THERM_CTRL_SW=
RST&gt;;
&gt; &gt; +			nvmem-cells =3D &lt;&amp;lvts_calibration&gt;;
&gt; &gt; +			nvmem-cell-names =3D "lvts-calib-data-1";
&gt; &gt; +		};
&gt; &gt; +
&gt; &gt;   		ssusb0: usb@11190000 {
&gt; &gt;   			compatible =3D "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
&gt; &gt;   			reg =3D &lt;0 0x11190000 0 0x2e00&gt;,
&gt;
&gt; </gic_spi></dt-bindings></dt-bindings></dt-bindings></dt-bindings></f=
rank-w@public-files.de></frank-w@public-files.de></frank-w@public-files.de=
></matthias.bgg@gmail.com></conor+dt@kernel.org></krzk+dt@kernel.org></rob=
h@kernel.org></linux@fw-web.de></angelogioacchino.delregno@collabora.com>

