Return-Path: <linux-kernel+bounces-423658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCFF9DAB01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8531628E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E2200114;
	Wed, 27 Nov 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="MLzmM+11"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C3193438;
	Wed, 27 Nov 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722519; cv=none; b=cn1uE+g49Ekyr3jUWnX9xss09JSKXQARY5HLbzBMFLW5UC4qqRv6zqAXIQJab5EzodsuFyVE+OGXyMtaTAVmbhb1byWKqPFeHLtoQhyyf4O06EEEMS+MFdtAdAbIlYDIrj6GDNLzYBEufIEHbr+EJO2Cc7EON0R1Y7jaoWHbJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722519; c=relaxed/simple;
	bh=QY09T2XfStw95X+h/dSH9rN1v2hXHvk6rlus17WyBgk=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=IHMLjRPxT3hm5VLFCAnH0JYt6hMSlb/MJhwKHMmFxO/U51f1EItqp4JbY7fq5G4ZvfY+HyzeFInKx94siKIayzC1TlSQsnEka6dRHrMN7DJuA+V33MnGCbstXWBy3PZz4Lxb2mhXlU/L+XWPmvy42hPrh2eMABsnsHcdf6Vszzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=MLzmM+11; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1732722504; x=1733327304; i=frank-w@public-files.de;
	bh=tyvV9MuFfFY78AK8WdtB4octGTi1d8nue98HhVGjty0=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MLzmM+11GcpwTgLzGlexZ/N1fMGp7S7KLv5kAvhvamhyz7FamMGw9vs2efNWSmwy
	 NkdlfV3C3+xf4c3yUefNABKhZGgMUyTL9AawRpY3QhcsfGHo/DUC1vnvLboMNmpjj
	 tmW3vBauSaqCW08+o/jSyuB9/9I+2nVdQAzMcOIAG8D8cgTmq5iaXf7biNe8Vfje2
	 JB68MS4rrTqIgAV9yw0hpVGmGcCymUpv01vIoyjt+8gLXd7GqzbfpqzeaCzf48tJQ
	 HpMEJMMK/yd32BZlQwl5pvr0F9H/sMjgf5aSCLdz0jIy7qjEML/fzCnuGYUw/y+dv
	 KxQCQR/c9Z7y5uCMMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.224.21] ([157.180.224.21]) by msvc-mesg-gmx024 (via
 HTTP); Wed, 27 Nov 2024 16:48:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-348f9544-267c-4730-ad93-23de7fef64be-1732722504104@msvc-mesg-gmx024>
From: Frank Wunderlich <frank-w@public-files.de>
To: angelogioacchino.delregno@collabora.com, linux@fw-web.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [RFC v1 12/14] arm64: dts: mediatek: mt7988: add reserved
 memory
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <369df136-220a-44c9-a48c-1307f3741d27@collabora.com>
Importance: normal
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-13-linux@fw-web.de>
 <369df136-220a-44c9-a48c-1307f3741d27@collabora.com>
Sensitivity: Normal
Date: Wed, 27 Nov 2024 16:48:24 +0100
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:2iARTZWpNEYtOPACxRtic/vjoViwUek8BmmSyDBvp9OhOn8d61XTOsC025x2k/+tNS/tb
 /BlkHo/x1rDHHxvBDICItqYERHWFpIdRpS7vFZpUzSJgYrSHXUgKCPqElTd4+IpiftFetCzt1+EP
 08I4Z5F8u0CZCIJ0hQqTAxRrlDaVY411W1oMCL0dHyqKA/5fTrUfmxNFJx0sVlZVJfjjWIMadNMs
 WSakJIxgRb6v9lpd+K+AJU3sClew+97zNPL/ePvD1AScbNtn5vutrz33BOdouODehecPpCwxMh9V
 VY=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zK2MdYQ62Pc=;XDg14FAZIP+g330jELB5eYMga2X
 i+dHkPn/p1iD1yGWketVqDQhfZD9s63fmtNJx944wsq2EtFCfA71SMN8tmyt9ddsB2fwEmpZ7
 BKd+bsoFjQqP23AjJAP+JatMavjloSILpnrO09yUq/JbMlrvb/QRKFUeOyNqChdjeo0aZu7no
 uJ5uXX4XV5XpITU9po5l+Fr9PF48qIX278ajOmMKZcyYyLGSKN2t3TYAa+vkFVp2IMPnXC2jt
 QlSzZTSub7SYqsWL0+FMF4dJ3Z05lRkEPGITBnwgnxkZjVQAEr3cSwbOhyFD5lMO+zpFskY2e
 2CbUO+ft5MamMYlaIguX2pPXtIc9+OSADLYG/h0PCC5GlVRM2MDw5VMHZnCNzWWpl7JGmW2O6
 TodLrI/XDbyxWEfF75HCE0Mod9NkoWO6Uh36U6fxCqln5GluNwC4YKFSRHz4hw9z7/4a7L8LA
 i+qmr8wX+mrPcQcbkOkKH7vbVpExR77YeGuabOL0MXCQFVJzNgdSRVzRnTO7t/uaujWO/yZJ6
 Vy5yK8ZRuFJ708iuiKEXbk6Ovt0Dk8fiBvxH3Z+1cKV1AIU3Wm68Cp1ICz/bNvikJwD5XZ33H
 G0lyWoAoO32O1rZqinHtTlHFbQqpl04Dx98MvhxkiTeW9HzNQmTtZGy+nnCSUoYXrQAqW+J6B
 gjlbfaQTTQEky7tNsE9yIg5yjG3qDNkCtMXL9RIwVAhaE3xYl9mBUiy1dS9ftMIWYaYjqKkA1
 rRLfGJ0LdbLVhVtuL4zchBgunEA0lbb0DyPKMCOOHiUGQovVJJnUqkH1yYTCvmSzRp7MIh36h
 FO0vgtqeh1VLVD1iH30cwxRSz1eq+S0sfgeVStSUkoFi93kh+S7GxlQ8H14sSd6oUFLgfMTNF
 SkIMiXhlBovN3HsMPSI861XemC5yn9l2Ug6k=
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
&gt; Betreff: Re: [RFC v1 12/14] arm64: dts: mediatek: mt7988: add reserve=
d memory
&gt;
&gt; Il 29/10/24 11:39, Frank Wunderlich ha scritto:
&gt; &gt; From: Frank Wunderlich <frank-w@public-files.de>
&gt; &gt;
&gt; &gt; Add memory range handled by ATF to not be touched by linux kerne=
l.
&gt; &gt;
&gt; &gt; Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
&gt;
&gt; If you are really sure that this is always the same for all boards ba=
sed on MT7988,
&gt; I will trust you and give you my R-b once this series gets out of RFC=
 state.

I'm not sure, but ATF is SoC specific and so it should be a SoC specific r=
ange, not board specific

&gt; Cheers,
&gt; Angelo
&gt;
&gt; &gt; ---
&gt; &gt;   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 12 ++++++++++++
&gt; &gt;   1 file changed, 12 insertions(+)
&gt; &gt;
&gt; &gt; diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/ar=
m64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; index a3a7deda35a5..7721d2ec06ee 100644
&gt; &gt; --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; @@ -81,6 +81,18 @@ reg_3p3v: regulator-3p3v {
&gt; &gt;   		regulator-always-on;
&gt; &gt;   	};
&gt; &gt;
&gt; &gt; +	reserved-memory {
&gt; &gt; +		#address-cells =3D &lt;2&gt;;
&gt; &gt; +		#size-cells =3D &lt;2&gt;;
&gt; &gt; +		ranges;
&gt; &gt; +
&gt; &gt; +		/* 320 KiB reserved for ARM Trusted Firmware (BL31 and BL32) =
*/
&gt; &gt; +		secmon_reserved: secmon@43000000 {
&gt; &gt; +			reg =3D &lt;0 0x43000000 0 0x50000&gt;;
&gt; &gt; +			no-map;
&gt; &gt; +		};
&gt; &gt; +	};
&gt; &gt; +
&gt; &gt;   	soc {
&gt; &gt;   		compatible =3D "simple-bus";
&gt; &gt;   		ranges;
&gt;
&gt; </frank-w@public-files.de></frank-w@public-files.de></frank-w@public-=
files.de></matthias.bgg@gmail.com></conor+dt@kernel.org></krzk+dt@kernel.o=
rg></robh@kernel.org></linux@fw-web.de></angelogioacchino.delregno@collabo=
ra.com>

