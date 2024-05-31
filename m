Return-Path: <linux-kernel+bounces-196763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3E8D6196
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4916DB246BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C51586C7;
	Fri, 31 May 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ijK3t7KH"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1682158218;
	Fri, 31 May 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158015; cv=none; b=VJFYmOiyGwkyRy7Faktk6sAyrAbjZViv3oP5WtTgzoh7hb7Sht8mumhNRquwJjRslX+9JDWyMcoJfFQtZuIk03eyC6PXcHHK6qhRE+NMpMlCdyFUr/36x5BPDTE8ZkNTtffLne1FJklVP0AWD7Iilj/iM+Fs7egTlFggRSQA2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158015; c=relaxed/simple;
	bh=qCFiUUCYk0b9VZYj16TxUMHUJrac8mN5G7MjSHzTxmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNaTPhem1Qp5r8yoPnMabpFL4+StLCOuR47wbgbO2JLiBBBgHdXR7mii+yB2NNVBTcLzVHRkTovDDMyLA71qo0IDIzNJhKDa3NErJ/cr83z0T0ALlIxIGzMoIPpIGhx5/QmBPeLhqufiyZjxE/vt1QHK0Qi1EqNivY40nfXGf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ijK3t7KH; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UWoe0J/16Ku5EFj3U5F77tdrpZFyvI4MmiD7hff0Nek=; b=ijK3t7KHG/ulEUpsXr+tbwgP6+
	U9ebG69XhpDE2Etb+WjS75mVDzD0qf0wWnDRsI2Ud4evfmLERFy8Aqc/y34UCD8sqzXUQ+uprf8fa
	0TwF7Y2apPVWv0oVbgfEhXar+7oVFtsNpszZadU1DyMWkEM6Z/Bddf0eex4IgCvVTYBm9g7sYBCVx
	tK936vYQHhl7OO9iX3lSlVfsgE65MJ8a/9k+lXY84PmeRlpQEEMR9KoSzgjoFgXo6QxRax0Dz3EGb
	3OCt+qMJ0mUBhFgpAcTsjckoqj/1kf4y3SvKItZ6zfN2xHdrYuiFM7NDeiCIoXdSB09eXBF+XqnZw
	I6VqifXw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sD1Ep-000AZA-SH; Fri, 31 May 2024 14:20:03 +0200
Received: from [87.49.42.81] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sD1Ep-0000n3-1f;
	Fri, 31 May 2024 14:20:03 +0200
From: Esben Haabendal <esben@geanix.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  linux-arm-kernel@lists.infradead.org,  Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a: add QUICC Engine node
In-Reply-To: <3380831.44csPzL39Z@steina-w> (Alexander Stein's message of "Fri,
	31 May 2024 08:32:44 +0200")
References: <20240530-arm-ls1021a-qe-dts-v1-1-2eda23bdf8c5@geanix.com>
	<3380831.44csPzL39Z@steina-w>
Date: Fri, 31 May 2024 14:20:02 +0200
Message-ID: <87frtynpfx.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27292/Fri May 31 10:31:14 2024)

Alexander Stein <alexander.stein@ew.tq-group.com> writes:

> Would you consider current converting into YAML format?

You mean converting Documentation/devicetree/bindings/soc/fsl/qe.txt and
Documentation/devicetree/bindings/soc/fsl/qe/*.txt into YAML?

I can consider that. I haven't done something like that before, but I
assume it might include some additional work other than trivially format
conversion. So I would prefer to do that after this patch, if that is
ok.

> Am Donnerstag, 30. Mai 2024, 16:22:54 CEST schrieb Esben Haabendal:
>> The LS1021A contains a QUICC Engine Block, so add a node to device
>> tree describing that.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 51 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
>> index e86998ca77d6..ff7be69acdd5 100644
>> --- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
>> +++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
>> @@ -460,6 +460,57 @@ gpio3: gpio@2330000 {
>>  			#interrupt-cells = <2>;
>>  		};
>>  
>> +		uqe: uqe@2400000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			device_type = "qe";
>> +			compatible = "fsl,qe", "simple-bus";
>> +			ranges = <0x0 0x0 0x2400000 0x40000>;
>> +			reg = <0x0 0x2400000 0x0 0x480>;
>
> Properties please in this order:
> * compatible
> * reg
> * #address-cells
> * #size-cells
> * ranges
> * device_type

Fixing.

>> +			brg-frequency = <150000000>;
>> +			bus-frequency = <300000000>;
>
> Mh, aren't these values depending on your actual RCW configuration?

Yes, you are right. The QE bus-frequency comes from platform_clk which
is controlled by various bits in RCW and sys_ref_clk.

So I guess it should be possible to derive bus-frequency from sysclk
clock-frequency attribute and RCW. But fsl,qe bus-frequency is a
required property...

Max bus-frequency for LS1021A is 300 MHz. But it should be possible to
set it lower, although I suspect that many/most/everyone is running it
at 300 MHz.

>> +			fsl,qe-num-riscs = <1>;
>> +			fsl,qe-num-snums = <28>;
>
> Current bindings defines:
>> fsl,qe-snums: This property has to be specified as '/bits/ 8' value,
>>   defining the array of serial number (SNUM) values for the virtual
>>   threads.
>
> So '/bits/ 8' is missing.

Ok, so you want me to add an array for fs,qe-snums attribute?
None of the existing fsl,qe devices has a fsl,qe-snums.
And qe_snums_init() has a fallback, so I don't think it is correct to
specify fsl,qe-snums to be a required property in the bindings. It
should be listed as optional.

>> +			qeic: qeic@80 {
>> +				compatible = "fsl,qe-ic";
>> +				reg = <0x80 0x80>;
>> +				#address-cells = <0>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <1>;
>> +				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
>> +					      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			ucc@2000 {
>> +				cell-index = <1>;
>> +				reg = <0x2000 0x200>;
>> +				interrupts = <32>;
>> +				interrupt-parent = <&qeic>;
>
> Move cell-index to last position.

Done.

>> +			};
>> +
>> +			ucc@2200 {
>> +				cell-index = <3>;
>> +				reg = <0x2200 0x200>;
>> +				interrupts = <34>;
>> +				interrupt-parent = <&qeic>;
>
> Same here.

Done.

>> +			};
>> +
>> +			muram@10000 {
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				compatible = "fsl,qe-muram", "fsl,cpm-muram";
>> +				ranges = <0x0 0x10000 0x6000>;
>
> Node address but no 'reg' property? I have no idea if this is okay.
> Also compatible (and possibly reg) first.

It is done in the same way for all existing fsl,qe-muram devices. So if
it is not okay, a tree-wide fixup would be in place.

/Esben

