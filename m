Return-Path: <linux-kernel+bounces-259137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152FE9391C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFACB2106E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89C16E870;
	Mon, 22 Jul 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="TuOswZE7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB816DEDC;
	Mon, 22 Jul 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662109; cv=none; b=ZxZfUprXbJmQMXxwlgS6EHg/fNs/Kj9SzK0RUhjBv3uRboIEtoyL1iI3T1NQgXj1qJIcHzMTlxVQ4byCkMcsbkbnSKwiL7ms84Ciy/SB2qfi7uH4pFNSrmE/TLziXj/5sJAkh1rMuKLlYL1OWUpfKRTkump/S7oV4hmW6ceXY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662109; c=relaxed/simple;
	bh=NW3BGeX6Aw+YNDaH/ML4okS799UMs5G9OYJ+NCOMUFU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uxmBOXWCQjgNA0Zmr8OV1bCu/SKTY8xOF/YVtpY606KHShEtYgcLO9Ml6eqzkvaWha6QTu4x1IChZRcK5VmQ4y6yrN1l22sbK8lxTF6NAMYOEW65IbkqZhDWT6I7Pn6qZ8lZ5oOE0miIVets4Z05Yr3rlc2YCuXUYni05650ueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=TuOswZE7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1721662085; x=1722266885; i=frank-w@public-files.de;
	bh=9zzQ9qsjOrJKYJgiEf+Hw1iQEuR/+oJDdIA6G8lNnBA=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TuOswZE7lxQA0wrf/MAx6jvQuGompBZifZdmZK/rvRFgKcohgY7xN3/2ryIixvZN
	 57QKRirDJQa0r4lCqfkwrE/fU5bfE3t3PfrdrpCGIWWE19mGHs6vu01qrnHwFiTXP
	 TbKPY/E9meLHv5TGg7JF+Y/jumEavDsodo6ELy0cDluj4EoK/j1xgwN6bhoewSYkP
	 fW3LBgnKxokXqb1HVMrHJjGtHrbS2/lKkXRUmFWziZ4d85BMPuvLF0levZZCZpGiN
	 mRf0+dX+cqwAlg+7qD6B9vPnOIDGrqsHkOOoVizxBiw9GKUdiQW++RF7ORCYtDDB6
	 6WWYFBBGzNKq1cH6xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.158.78]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1sgGqN1mF0-00Vvt5; Mon, 22
 Jul 2024 17:28:05 +0200
Date: Mon, 22 Jul 2024 17:28:05 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
CC: Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_arm64=3A_dts=3A_mediatek=3A_?=
 =?US-ASCII?Q?mt7988=3A_add_labels_for_different_nodes?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <89f6381b-8572-4d58-a8a9-0a3596efc627@collabora.com>
References: <20240709081614.19993-1-linux@fw-web.de> <89f6381b-8572-4d58-a8a9-0a3596efc627@collabora.com>
Message-ID: <C0F28241-DBD1-48F8-B09D-F41DB30E1678@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OS5lTSGxKOymZirZZWv/F/jIcjpywbSkBtsJkIf7dA2AW96XtoR
 BD+ta8ObDhoFgHw6UFejU8lURnQFELWBPyMtROyTjp7fxNlpxTpDA2qzcOCayYn42MauBzW
 dCD6BSe++J1SVf0F1Tuv8ZlTCuDidJKayAQLqKBwBB6+iFsFpkXHd5rdOEZ0sNeM2AVUCpi
 13rcb4837ot81IkpsuR5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fgvbCBc82oU=;o6Y3dPGAbn8l29Gh9/34m4QZ+a4
 bcCpe01vlSP9oAFdhLG8rAf6uFYud9aJT9sE1i0IRcowjZxwUFP3iKWMoH/XSmiOp87SDgLNW
 uf6Xs0P1O8/Lv8MFJqQGIfB82yXxRsiSEs6ZcON1Qdtv4qp/K/MZZN5UEg0gx8436+V0CT949
 5bEYL+jNwL1iZ70eP0HBfuonvMUiriqhq8RHpjWJNOCpL2InXRlWqNdghO2xggzTE86CntmB4
 hQmxPwVkUDOfYZydf+HEOqxV/Aw4Y7PcZkG2Y4rvHuFBLJ+i7qnhNuXctA880VaKxAeykJ24k
 xwN29VYmp6xQCigWgdVu7o9J4L0h0ZND8zWg8kMvRLafECr5Uo7sJl144KB4bKWvcu2+jTgig
 F6pIqdLFeW5W3DGtg/GtLvJvb9BeJQKYFB16nGqN/sACv9WFP3UXRHKFdOaFTO355B1BNR1PR
 tZRDq7bOVq/3qjrlrqVfvuFOZO6dYTi6qX3V/hOdhQykoFTrGRWCOukmvO/II+urPAKmXhsUi
 thRNT0B77+gjv+OB9+4kF/dEa8Xueu2c+n8BJIhV4RuU898t6mcKSZKYwfzWaFproGKsMNSzZ
 iAl5N8sDW3lLcBig2KfbyPosN+AOY5W/Ybj0Yti/oZmWICHKVzqaP8yiuvDRFWzHHTNV6gzwo
 jYgnL1P0vhbIjaFgiyy+w2lcZv0sqRFffcruhPcprRAwCIXEtI+dmrlSpMDX9QsqzaGlu1i0o
 1nVRon+HMGvceALGgwkrvI1FBWUCfxCXSF5g/DTzvpChT1N7HdOU2iI5Pi5bWwllIcO6qW+/o
 L0zBpYuEfwRRYfYOK9CW4JYQ==

Hi
Am 22=2E Juli 2024 17:14:07 MESZ schrieb AngeloGioacchino Del Regno <angel=
ogioacchino=2Edelregno@collabora=2Ecom>:
>Il 09/07/24 10:16, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Current devicetree-nodes missing a label which allows to add apropertie=
s
>> or phandles to them, so add them=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> Fixes: 660c230bf302 ("arm64: dts: mediatek: mt7988: add I2C controllers=
")
>> Fixes: 09ff2216a035 ("arm64: dts: mediatek: mt7988: add PWM controller"=
)
>> Fixes: 09346afaba0a ("arm64: dts: mediatek: mt7988: add XHCI controller=
s")
>> Fixes: b616b403cbff ("arm64: dts: mediatek: mt7988: add clock controlle=
rs")
>> Fixes: 6c1d134a103f ("arm64: dts: mediatek: Add initial MT7988A and BPI=
-R4")
>
>You're just only adding node labels, what does this actually fix?!?
>
>Besides, I could tell you to remove the Fixes tags, but then, there's sti=
ll nothing
>using those node labels - so there's nothing justifying this addition, at=
 all=2E
>
>I guess that you want to use those (bar the cpu[0-3] labels, which you're=
 adding
>because=2E=2E=2E uhh=2E=2E why?) from some board DT=2E=2E=2E so please ju=
st do that: send a commit
>adding your board DT and adding the required node label(s) here as a cons=
equence=2E

Currently i need these labels in uboot to add additional properties (e=2Eg=
=2E hwver to cpu-nodes) and linking the existing nodes (clocks to eth node)=
 to some added in uboot overlay=2E

Currently we face some hen-egg issue as support is in mainline uboot and w=
e forced to move to of_upstream to add pcie support and maybe more,but in m=
ainline linux we miss nearly all nodes we have in our private repos=2E=2E=
=2Ebut i'm busy in getting of_upstream in uboot working basicly=2E

>Cheers,
>Angelo
>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt7988a=2Edtsi | 32 +++++++++++---------=
---
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a=2Edtsi b/arch/arm64/b=
oot/dts/mediatek/mt7988a=2Edtsi
>> index aa728331e876=2E=2E9ced005b1595 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7988a=2Edtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a=2Edtsi
>> @@ -14,28 +14,28 @@ cpus {
>>   		#address-cells =3D <1>;
>>   		#size-cells =3D <0>;
>>   -		cpu@0 {
>> +		cpu0: cpu@0 {
>>   			compatible =3D "arm,cortex-a73";
>>   			reg =3D <0x0>;
>>   			device_type =3D "cpu";
>>   			enable-method =3D "psci";
>>   		};
>>   -		cpu@1 {
>> +		cpu1: cpu@1 {
>>   			compatible =3D "arm,cortex-a73";
>>   			reg =3D <0x1>;
>>   			device_type =3D "cpu";
>>   			enable-method =3D "psci";
>>   		};
>>   -		cpu@2 {
>> +		cpu2: cpu@2 {
>>   			compatible =3D "arm,cortex-a73";
>>   			reg =3D <0x2>;
>>   			device_type =3D "cpu";
>>   			enable-method =3D "psci";
>>   		};
>>   -		cpu@3 {
>> +		cpu3: cpu@3 {
>>   			compatible =3D "arm,cortex-a73";
>>   			reg =3D <0x3>;
>>   			device_type =3D "cpu";
>> @@ -43,7 +43,7 @@ cpu@3 {
>>   		};
>>   	};
>>   -	oscillator-40m {
>> +	system_clk: oscillator-40m {
>>   		compatible =3D "fixed-clock";
>>   		clock-frequency =3D <40000000>;
>>   		#clock-cells =3D <0>;
>> @@ -86,7 +86,7 @@ infracfg: clock-controller@10001000 {
>>   			#clock-cells =3D <1>;
>>   		};
>>   -		clock-controller@1001b000 {
>> +		topckgen: clock-controller@1001b000 {
>>   			compatible =3D "mediatek,mt7988-topckgen", "syscon";
>>   			reg =3D <0 0x1001b000 0 0x1000>;
>>   			#clock-cells =3D <1>;
>> @@ -99,13 +99,13 @@ watchdog: watchdog@1001c000 {
>>   			#reset-cells =3D <1>;
>>   		};
>>   -		clock-controller@1001e000 {
>> +		apmixedsys: clock-controller@1001e000 {
>>   			compatible =3D "mediatek,mt7988-apmixedsys";
>>   			reg =3D <0 0x1001e000 0 0x1000>;
>>   			#clock-cells =3D <1>;
>>   		};
>>   -		pwm@10048000 {
>> +		pwm: pwm@10048000 {
>>   			compatible =3D "mediatek,mt7988-pwm";
>>   			reg =3D <0 0x10048000 0 0x1000>;
>>   			clocks =3D <&infracfg CLK_INFRA_66M_PWM_BCK>,
>> @@ -124,7 +124,7 @@ pwm@10048000 {
>>   			status =3D "disabled";
>>   		};
>>   -		i2c@11003000 {
>> +		i2c0: i2c@11003000 {
>>   			compatible =3D "mediatek,mt7981-i2c";
>>   			reg =3D <0 0x11003000 0 0x1000>,
>>   			      <0 0x10217080 0 0x80>;
>> @@ -137,7 +137,7 @@ i2c@11003000 {
>>   			status =3D "disabled";
>>   		};
>>   -		i2c@11004000 {
>> +		i2c1: i2c@11004000 {
>>   			compatible =3D "mediatek,mt7981-i2c";
>>   			reg =3D <0 0x11004000 0 0x1000>,
>>   			      <0 0x10217100 0 0x80>;
>> @@ -150,7 +150,7 @@ i2c@11004000 {
>>   			status =3D "disabled";
>>   		};
>>   -		i2c@11005000 {
>> +		i2c2: i2c@11005000 {
>>   			compatible =3D "mediatek,mt7981-i2c";
>>   			reg =3D <0 0x11005000 0 0x1000>,
>>   			      <0 0x10217180 0 0x80>;
>> @@ -163,7 +163,7 @@ i2c@11005000 {
>>   			status =3D "disabled";
>>   		};
>>   -		usb@11190000 {
>> +		ssusb0: usb@11190000 {
>>   			compatible =3D "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
>>   			reg =3D <0 0x11190000 0 0x2e00>,
>>   			      <0 0x11193e00 0 0x0100>;
>> @@ -177,7 +177,7 @@ usb@11190000 {
>>   			clock-names =3D "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
>>   		};
>>   -		usb@11200000 {
>> +		ssusb1: usb@11200000 {
>>   			compatible =3D "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
>>   			reg =3D <0 0x11200000 0 0x2e00>,
>>   			      <0 0x11203e00 0 0x0100>;
>> @@ -191,21 +191,21 @@ usb@11200000 {
>>   			clock-names =3D "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
>>   		};
>>   -		clock-controller@11f40000 {
>> +		xfi_pll: clock-controller@11f40000 {
>>   			compatible =3D "mediatek,mt7988-xfi-pll";
>>   			reg =3D <0 0x11f40000 0 0x1000>;
>>   			resets =3D <&watchdog 16>;
>>   			#clock-cells =3D <1>;
>>   		};
>>   -		clock-controller@15000000 {
>> +		ethsys: clock-controller@15000000 {
>>   			compatible =3D "mediatek,mt7988-ethsys", "syscon";
>>   			reg =3D <0 0x15000000 0 0x1000>;
>>   			#clock-cells =3D <1>;
>>   			#reset-cells =3D <1>;
>>   		};
>>   -		clock-controller@15031000 {
>> +		ethwarp: clock-controller@15031000 {
>>   			compatible =3D "mediatek,mt7988-ethwarp";
>>   			reg =3D <0 0x15031000 0 0x1000>;
>>   			#clock-cells =3D <1>;
>
>


regards Frank

