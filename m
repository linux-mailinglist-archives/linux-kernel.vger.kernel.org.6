Return-Path: <linux-kernel+bounces-397373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FED9BDB24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB12283CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EFF10E5;
	Wed,  6 Nov 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="mYivpvwa"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1813418786C;
	Wed,  6 Nov 2024 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856343; cv=none; b=cpvrhc7gyxHLLedYJwR3lKFTfPqu27fiJ0TgDkxqK6PWKzSNyin4fwsSK2gD/ffnjdvzxWqMZj7Rir0PF53qUbiMWjsYCvhAujlaHzd4/v7d0WH8PeSasNJBZO0fyY0PM+Yl65x3qNu7dDXztNSuga05V5QiJ1t5d87Ts2CHgis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856343; c=relaxed/simple;
	bh=vrtPNrB6+0BcgO9J9p5RfsVNy2E+QVqTdpWFiiQrQoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gex9D5qyDE5SRsHOr/ogF7VnN627w5eTUaTUjsKNGtKTbfsUT+n5t+VYRWE3ZCZVfaMh1/JlnTVgFU3u6shJYEMsvy75+/9tqfUlp+GPvrvVLtnw6z8EQXl5QvCpJNq7chXZOFLz+C5YVGG2SMWRp4qYjBqGLEZBwpYV5eeIqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=mYivpvwa; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 78B3388D8D;
	Wed,  6 Nov 2024 02:25:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730856339;
	bh=Z1yoKzgo8+wbpL0mDUyPIejCTWSCHY6sxQ3QEw31KAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mYivpvwalNGXewCotlReMZWG1dRdUf1S1ohdtCbhS1fxo4ihlzs9T6d5R/MNBQ6AS
	 wUZg2iduzOO0MalQemqPOVhRec8AiaDU8G4DYFtzq2iCFo8bYuYetiypuN30WjmHnU
	 fHoaIYHmB0BE0vmVzSh+Ca3f8ZDxUrIg9crHRQxz/hDc1+daXd+f+aUeeIQRNzx0Lc
	 pWmbTgQas5CWMwnaM+uXci77LmiFoVaznHl9Hiw2N83FSqyH3BmQzgkbFLY67nADZ5
	 0TSCqxwQGO2liQh6vwn0qGU5bzfysD821pASO4NnzeUUe880EwBmLQn1cVufRbuPV3
	 gmgvOdxUzSHcg==
Message-ID: <35a05978-a83f-4746-92cd-108b6586ac08@denx.de>
Date: Wed, 6 Nov 2024 01:30:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: stm32: Describe M24256E write-lockable page
 in DH STM32MP13xx DHCOR SoM DT
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241017190933.131441-1-marex@denx.de>
 <b616628b-f9e3-42dd-b5dd-e7aa0235daae@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b616628b-f9e3-42dd-b5dd-e7aa0235daae@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/29/24 4:28 PM, Alexandre TORGUE wrote:
> Hi Marek
> 
> On 10/17/24 21:09, Marek Vasut wrote:
>> The STM32MP13xx DHCOR SoM is populated with M24256E EEPROM which has
>> Additional Write lockable page at separate I2C address. Describe the
>> page in DT to make it available.
>>
>> Note that the WLP page on this device is hardware write-protected by
>> R37 which pulls the nWC signal high to VDD_3V3_1V8 power rail.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: kernel@dh-electronics.com
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-stm32@st-md-mailman.stormreply.com
>> ---
>> V2: Fix up the M25256E in Subject
>> ---
>> DEPENDS:
>> - https://lore.kernel.org/linux-i2c/20241017184152.128395-1- 
>> marex@denx.de/
>> - https://lore.kernel.org/linux-i2c/20241017184152.128395-2- 
>> marex@denx.de/
>> ---
>>   arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi b/arch/ 
>> arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
>> index 5c633ed548f37..07133bd82efa6 100644
>> --- a/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
>> +++ b/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
>> @@ -202,6 +202,12 @@ eeprom0: eeprom@50 {
>>           pagesize = <64>;
>>       };
>> +    eeprom0wl: eeprom@58 {
>> +        compatible = "st,24256e-wl";    /* ST M24256E WL page of 0x50 */
>> +        pagesize = <64>;
>> +        reg = <0x58>;
>> +    };
>> +
> 
> You could have sorted nodes by I2C addresses.
Fixed in [PATCH] ARM: dts: stm32: Sort M24256E write-lockable page in DH 
STM32MP13xx DHCOR SoM DT

Sorry.

(I also wrote me a sorting tool in the meantime, but it still isn't too 
good)

