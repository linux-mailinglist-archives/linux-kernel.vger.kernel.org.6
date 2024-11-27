Return-Path: <linux-kernel+bounces-423612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F79DAA63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78EBB20BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F061FF60B;
	Wed, 27 Nov 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="oXr2+Bvs"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C051CCB4B;
	Wed, 27 Nov 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720010; cv=none; b=IBdRccgfyeHxw23UTsHzMkS7Zzbd6jMio8qncdiYazQ7wlR8eDrfGNtHmtaTCuB1n3FixCX6S97M6/ct4rxA5DsUTjdQywYFnS0WedCGcUNPpH3PTtiX9g/TFIYb0q/IYZHal3ZBy2D1UujCxN4SO8pJv7iqFDJfCjE1UBDp07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720010; c=relaxed/simple;
	bh=QVDgyd0wS+pupx8Akx95NxjOVOvSnfPyxnA8Pa1S+cc=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=L24ZkO1pzfzI3jd6Lv37tZWH5Jlek/gLaKNhgDBq/I8pIcqiR8tAoV2Ovqenv82ysSaKzJ675qYwTxe9Lrvc22tA7COCTMHp5jGjofEIfxx7niVyV9WpUSbBsvSvMe+1ZEpPOhJeG8XbRzE1+HKHpb0xoqjVt6RcNvW1tJOaZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=oXr2+Bvs; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1732719986; x=1733324786; i=frank-w@public-files.de;
	bh=OCzNHFa9I6qJOkZbyj9gMAOqUciHnfZo1B6Ths20CGs=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oXr2+BvsSMWgo8wU9x5FZyWZAxIqgXY3hjHi1amGQUAx+4jDy+czTzgmbv44SH7z
	 BubGtBVEtNNRPeDrqR1jefEl/ntIr0TC7hhgzoKzTTj2BhzZ5HQT1Z+SPy+v/LW1N
	 BkJebBo5IKRkgUckwU0shDESG+Fy75RoI7LXdJ2OEHqYPBuJRKiqBnnQptN0VmLLz
	 ZNMjt3cogp23gipO7lluYcOup2/+p+a6SasPqpUTSh2Jj4xu1yyuEl/DrPbLPdK3A
	 ir2RWWh6zbLpskuMm0zIYSub9InjC3SAXWVMe4exyCdR+B+kiJsQBoYu/uGXXry72
	 5XpqtYByqUfZHkB8DQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.224.21] ([157.180.224.21]) by
 trinity-msg-rest-gmx-gmx-live-5cd5dd5458-8s6ml (via HTTP); Wed, 27 Nov 2024
 15:06:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-888f5bdb-1e23-4b5f-83c3-f36ade039908-1732719986576@trinity-msg-rest-gmx-gmx-live-5cd5dd5458-8s6ml>
From: Frank Wunderlich <frank-w@public-files.de>
To: angelogioacchino.delregno@collabora.com, linux@fw-web.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [RFC v1 14/14] arm64: dts: mediatek: mt7988: add
 operating-points
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6660a681-c02a-443a-a1f2-14af5b4477eb@collabora.com>
Importance: normal
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-15-linux@fw-web.de>
 <6660a681-c02a-443a-a1f2-14af5b4477eb@collabora.com>
Date: Wed, 27 Nov 2024 15:06:26 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:Exmc3suBEbYFxes52bhTlxtJMDNr4l7FL9SH7h+/VQ0syTJpV3uxFGxpPePdLd0KZKpAX
 3GmoRmCXJkg+mhhauNgnEoOhXjyU5w8F9Bcl3s7S69DbPfeF7Z+NnXxNkNQJ6/HShf0GMrdIp8K+
 tVAh4Tc9WedHBDnDWkV43Y54bVVGl7mEzM5Mq68d7Jtj2JW3bVAQKq/EPJMBjnesych4C231wUAI
 RI02vDtCyw7W8k2P78AVoxgfrCEefMbOFlIbVyE9VSadaNXTcW6p4Esg3cbtlLnl3pnXbhc4g9hu
 m4ACFiCkEyA5tPIvIMgp7vVCybw/gC8GqqKfGfVisVUOYYn5IO9/OpE9omlHSZLX9M=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QOVQPzO/mOc=;XQzCyxdnoDtUTc1S6Va0JGAcHd5
 7op34K0+FcHB24rjL3QTOzWn+P+xffrgx5QoW0jId3RedgtcZJRKFqeGxS/U1cyFGO+WnmEpg
 oOVYc2zOPdjOiVksTxkARBNls6jYW3okeg4+6oMVTZ+Ty7cbfkY8MLj1g/4NE8SlWYccGY4pt
 MR78ZWdASgCkcUzsI5HbL4c/dPj++nNAcfqYw3xoeugUcXOSoNQcQznjn135x8JifA96GBdug
 7uYgi7fuE8YLegNHa+oU4CcFVdWVPxnZj09sQWeX5hRocQArhZB0A9f8FaLQHb3F5oAwLy0hn
 MofI3ADYtRwgTtCYmLzdy5QY84GPVc9t1+R9TK4ZSD7fVJCGpNWLxqiSHhMhgj/d101kKvQaJ
 LyqZozYNc5AB+IbpiHVtzGOW8H+v/XRVgxmCkWoE8V9vzEmcgdaf3IDb8NEShJOq5yzHoB1+/
 pWsi3ciootvLrhWZueqVdewpTbKot64jfIVPqTuKL1INWna+SOqATIZmz5VMa18fIJaQaUWxZ
 x0SgkiRLX/1aN4PW95wxBkhlE2jiaE+T2PxhbGSS7zgntQ76pMYN9Ics0YX97L6CtYIJLWu4r
 hbMqlKEyioZ2Etfq1cfz4kM3ZAIf6BjeyKt5mbALc5EW22zXurroFUWYAXFS1oVHoAiWOPi7x
 WBILdYVVuiMDMQtLz8zELrfZuBfIcLL8JHQX0Sax2LkomozX+tZU2MhRnECOVG/9ClwdFwnrC
 qdORNAwuioKOBFUywIg8qfzxk9LVP3WYc9vfmLvTCaZDx9UZ8wkEH/z/XuUNXsX3HKZEbiyis
 0GXmyrf0sylXItBkLHIywoOWrRhmLc487x5xIXZ66+X+rviwIX0ytTWesK+viNJ8Q9Cw/UKTq
 8BgJRTI+bAqXjwdsFpTVtoQFKvpeh6XY4cl0=
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
&gt; Betreff: Re: [RFC v1 14/14] arm64: dts: mediatek: mt7988: add operati=
ng-points
&gt;
&gt; Il 29/10/24 11:39, Frank Wunderlich ha scritto:
&gt; &gt; From: Frank Wunderlich <frank-w@public-files.de>
&gt; &gt;
&gt; &gt; Add operating points defining frequency/voltages of cpu cores.
&gt; &gt;
&gt; &gt; Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
&gt; &gt; ---
&gt; &gt;   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 45 +++++++++++++++=
++++++--
&gt; &gt;   1 file changed, 41 insertions(+), 4 deletions(-)
&gt; &gt;
&gt; &gt; diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/ar=
m64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; index e037854666c1..25669d498617 100644
&gt; &gt; --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
&gt; &gt; @@ -16,32 +16,69 @@ cpus {
&gt; &gt;   		#address-cells =3D &lt;1&gt;;
&gt; &gt;   		#size-cells =3D &lt;0&gt;;
&gt; &gt;
&gt; &gt; -		cpu@0 {
&gt; &gt; +		cpu0: cpu@0 {
&gt;
&gt; Where are those cpuX labels used? I don't see any usage.

these are used in later patch and needed in uboot when we want to switch t=
o OF_UPSTREAM.

&gt; &gt;   			compatible =3D "arm,cortex-a73";
&gt; &gt;   			reg =3D &lt;0x0&gt;;
&gt; &gt;   			device_type =3D "cpu";
&gt; &gt;   			enable-method =3D "psci";
&gt; &gt; +			clocks =3D &lt;&amp;mcusys CLK_MCU_ARM_DIV_SEL&gt;,
&gt; &gt; +				 &lt;&amp;topckgen CLK_TOP_XTAL&gt;;
&gt; &gt; +			clock-names =3D "cpu", "intermediate";
&gt; &gt; +			operating-points-v2 =3D &lt;&amp;cluster0_opp&gt;;
&gt; &gt;   		};
&gt; &gt;
&gt; &gt; -		cpu@1 {
&gt; &gt; +		cpu1: cpu@1 {
&gt; &gt;   			compatible =3D "arm,cortex-a73";
&gt; &gt;   			reg =3D &lt;0x1&gt;;
&gt; &gt;   			device_type =3D "cpu";
&gt; &gt;   			enable-method =3D "psci";
&gt; &gt; +			clocks =3D &lt;&amp;mcusys CLK_MCU_ARM_DIV_SEL&gt;,
&gt; &gt; +				 &lt;&amp;topckgen CLK_TOP_XTAL&gt;;
&gt; &gt; +			clock-names =3D "cpu", "intermediate";
&gt; &gt; +			operating-points-v2 =3D &lt;&amp;cluster0_opp&gt;;
&gt; &gt;   		};
&gt; &gt;
&gt; &gt; -		cpu@2 {
&gt; &gt; +		cpu2: cpu@2 {
&gt; &gt;   			compatible =3D "arm,cortex-a73";
&gt; &gt;   			reg =3D &lt;0x2&gt;;
&gt; &gt;   			device_type =3D "cpu";
&gt; &gt;   			enable-method =3D "psci";
&gt; &gt; +			clocks =3D &lt;&amp;mcusys CLK_MCU_ARM_DIV_SEL&gt;,
&gt; &gt; +				 &lt;&amp;topckgen CLK_TOP_XTAL&gt;;
&gt; &gt; +			clock-names =3D "cpu", "intermediate";
&gt; &gt; +			operating-points-v2 =3D &lt;&amp;cluster0_opp&gt;;
&gt; &gt;   		};
&gt; &gt;
&gt; &gt; -		cpu@3 {
&gt; &gt; +		cpu3: cpu@3 {
&gt; &gt;   			compatible =3D "arm,cortex-a73";
&gt; &gt;   			reg =3D &lt;0x3&gt;;
&gt; &gt;   			device_type =3D "cpu";
&gt; &gt;   			enable-method =3D "psci";
&gt; &gt; +			clocks =3D &lt;&amp;mcusys CLK_MCU_ARM_DIV_SEL&gt;,
&gt; &gt; +				 &lt;&amp;topckgen CLK_TOP_XTAL&gt;;
&gt; &gt; +			clock-names =3D "cpu", "intermediate";
&gt; &gt; +			operating-points-v2 =3D &lt;&amp;cluster0_opp&gt;;
&gt; &gt; +		};
&gt; &gt; +
&gt; &gt; +		cluster0_opp: opp-table-0 {
&gt; &gt; +			compatible =3D "operating-points-v2";
&gt; &gt; +			opp-shared;
&gt; &gt; +			opp00 {
&gt;
&gt; ...But you can also be consistent with other devicetrees and follow t=
he pattern
&gt; for the node names of the OPP entries.
&gt;
&gt; opp-800000000
&gt; opp-1100000000
&gt; ...etc

ok, will change this..so just adding the opp-hz value to the name (or labe=
l)?

&gt; Cheers,
&gt; Angelo
&gt;
&gt; &gt; +				opp-hz =3D /bits/ 64 &lt;800000000&gt;;
&gt; &gt; +				opp-microvolt =3D &lt;850000&gt;;
&gt; &gt; +			};
&gt; &gt; +			opp01 {
&gt; &gt; +				opp-hz =3D /bits/ 64 &lt;1100000000&gt;;
&gt; &gt; +				opp-microvolt =3D &lt;850000&gt;;
&gt; &gt; +			};
&gt; &gt; +			opp02 {
&gt; &gt; +				opp-hz =3D /bits/ 64 &lt;1500000000&gt;;
&gt; &gt; +				opp-microvolt =3D &lt;850000&gt;;
&gt; &gt; +			};
&gt; &gt; +			opp03 {
&gt; &gt; +				opp-hz =3D /bits/ 64 &lt;1800000000&gt;;
&gt; &gt; +				opp-microvolt =3D &lt;900000&gt;;
&gt; &gt; +			};
&gt; &gt;   		};
&gt; &gt;   	};
&gt; &gt;
&gt;
&gt;
&gt; </frank-w@public-files.de></frank-w@public-files.de></frank-w@public-=
files.de></matthias.bgg@gmail.com></conor+dt@kernel.org></krzk+dt@kernel.o=
rg></robh@kernel.org></linux@fw-web.de></angelogioacchino.delregno@collabo=
ra.com>

