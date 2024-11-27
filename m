Return-Path: <linux-kernel+bounces-423376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF519DA67C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B783282E71
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B11A18BC3F;
	Wed, 27 Nov 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="DLXWtXFk"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A611EBFED;
	Wed, 27 Nov 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705320; cv=none; b=QSx2d+rEFKMiQBQNauwoAf51BQNJdevMAe3h6zZ8ksWVgbgQslxuD1b2JL7NZPJ2zNss8WaObJf3jF4M605wNSpe2M+WN17vJPGoam8oQSJRgJVWPTT+a2DfOk2Qs1fAgZdHbtjrA/kKqIYA63I806mkf6S9LMM6F5IBpzIiFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705320; c=relaxed/simple;
	bh=T6DgXkgqz6HZ36ZmsXSqt2fUlETXH1SYEt5e2pB4Jt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyvrqEcGpYLgVevZXscC95rPpFoP7NB93d9oyA9+HcqmPWSjLcvXeq6b+wQpY8EvLqiLYDRmNbUXBXQ6X7OqdMPqExbhEBZ9NcTRBlbgX5ZnWIUNv6pxRAkoLfNp5PQDiwON5tToWwUh7wce7b/tlFWQ2xu09JZYHGtUEON3AXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=DLXWtXFk; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WPNnkNusSbpQG7FakN9Ye2q95yHSoDQUaIuZWXayp+I=; b=DLXWtXFkj6e4fvq/C3RHTNR89S
	TsFawNMwRcQWuVLolTfJG5osTMUgN4XuWfL/YQYQCy9tYfpwjFnrCK0cp4sBMEdrR8J8uh5DSP5r+
	Gx58Qgbuk/3xwDwGiHWuIFHzqdGuUwWvz33ojwUMhGaFuO4y8z90TZZnVWhtjWdl5yXr8SR+x2o/g
	ctvef4iRcobweEyOF/BztOnJDTB2r2ejM1ZOTp+R+dckV/ZMN6lETuzOS/mUmxp/jpQvMT++rLMK+
	ADtwO+YGpzaivNQzhM0jM6AzEpQbpFm202dAXv07W8sNS+iQcGioUGvv4ExirYWV2F/EKri1BDwCM
	s0M4jHgA==;
Received: from [89.212.21.243] (port=49272 helo=[192.168.69.52])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tGFnw-007bvX-1g;
	Wed, 27 Nov 2024 12:01:56 +0100
Message-ID: <c2af397e-b1a0-4ec7-8ff0-60b9e36cd939@norik.com>
Date: Wed, 27 Nov 2024 12:01:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 09/15] arm64: dts: imx8mm: move bulk of rtc
 properties to carrierboards
To: Teresa Remmet <T.Remmet@phytec.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "robh@kernel.org" <robh@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 PHYTEC Upstream <upstream@lists.phytec.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20241125081814.397352-1-andrej.picej@norik.com>
 <20241125081814.397352-10-andrej.picej@norik.com>
 <67e55b1f18f2a676b890c9a4133575e8b90f6019.camel@phytec.de>
Content-Language: en-US
From: Andrej Picej <andrej.picej@norik.com>
Autocrypt: addr=andrej.picej@norik.com; keydata=
 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
 xtT/8OxBOVSHvA==
In-Reply-To: <67e55b1f18f2a676b890c9a4133575e8b90f6019.camel@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Teresa,

On 27. 11. 24 11:34, Teresa Remmet wrote:
> Hello Andrej,
> 
> Am Montag, dem 25.11.2024 um 09:18 +0100 schrieb Andrej Picej:
>> From: Yannic Moog <y.moog@phytec.de>
>>
>> Move properties from SoM's dtsi to carrierboard's dts as they are
>> actually defined by the carrier board design.
>>
>> Signed-off-by: Yannic Moog <y.moog@phytec.de>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts | 4 ++++
>>   arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi       | 4 ----
>>   arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts    | 4 ++++
>>   3 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-
>> rdk.dts b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
>> index 7aaf705c7e47..f5f503c3c6b9 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
>> @@ -221,6 +221,10 @@ &pcie_phy {
>>   
>>   /* RTC */
>>   &rv3028 {
>> +       interrupt-parent = <&gpio1>;
>> +       interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +       pinctrl-0 = <&pinctrl_rtc>;
> 
> You should also move the pinctrl settings to the carrier boards.
> As the pin can be used differently and should not be defined by the
> SoM.

Ok will fix this in v2. Thanks.

BR,
Andrej.

> 
> Thanks,
> Teresa
> 
>> +       pinctrl-names = "default";
>>          aux-voltage-chargeable = <1>;
>>          trickle-resistor-ohms = <3000>;
>>          wakeup-source;
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
>> index cced82226c6d..fdfe28780d6f 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
>> @@ -301,10 +301,6 @@ eeprom@51 {
>>          /* RTC */
>>          rv3028: rtc@52 {
>>                  compatible = "microcrystal,rv3028";
>> -               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> -               interrupt-parent = <&gpio1>;
>> -               pinctrl-names = "default";
>> -               pinctrl-0 = <&pinctrl_rtc>;
>>                  reg = <0x52>;
>>          };
>>   };
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
>> b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
>> index c9bf4ac254bb..b7b18d5a4f68 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
>> @@ -215,6 +215,10 @@ &pwm4 {
>>   
>>   /* RTC */
>>   &rv3028 {
>> +       interrupt-parent = <&gpio1>;
>> +       interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +       pinctrl-0 = <&pinctrl_rtc>;
>> +       pinctrl-names = "default";
>>          aux-voltage-chargeable = <1>;
>>          trickle-resistor-ohms = <3000>;
>>          wakeup-source;
> 

