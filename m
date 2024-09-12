Return-Path: <linux-kernel+bounces-326646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA0976B45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45D7B21A13
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33C1B4C3F;
	Thu, 12 Sep 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="jMv9AlFS"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266B1B2ECD;
	Thu, 12 Sep 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149233; cv=none; b=uG78u7FnK/T3GB1n2vKe3kk9LWN592lhno75qlzMRS2FuQlFLKpiuj7j1cGLH+rduVyNMeudJBqZYIJRxq23zyygqMvGZrD/rKZc920imrGFYOyzysuURo+zJiZIokkyN3wPmj7vKNmhNEJ55zaaxqwaILEm9GnxxTOFcSwfU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149233; c=relaxed/simple;
	bh=tcW2MGxIyjfg3SAuEmU59Agkom8lK5Y5Fp1ozgyiOb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOhm0HLc1OkiMNPYkce0vE1n2GFTVfNc23hW4kyRyIfR3sEhj9PqMD0t8P9bLE2E+fE6XtpTgu2M6oeThvfHa8DRzDHWtbaMAwXsEQP1IPWMLcBFQUFITcKTpYk53A8hW12DXVt5mxkeKZ4toQWPilF2wgmzk+BoqDLU8lsVcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=jMv9AlFS; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from [192.168.0.160] (unknown [220.162.71.16])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id C8CB67892D;
	Thu, 12 Sep 2024 21:53:36 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn C8CB67892D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1726149220;
	bh=8k+BLzuxKweSdS2kHP5jwMhPOyQcKLoWB7/Tll4vowk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jMv9AlFS5pRapyqCNfhgyF8Pebj4dX5KrWC/pluelM2Uhs0FLVzCq6Fjjkhb4qvRL
	 1YfEzKmy7G+htbk1fkcEeOrOUDzkib8XVegr/gbQXa8alO/9a4jLrpTMfM+P3p42jR
	 7hSQp91HHJ09+/pStfGAKBWgYFfr/mTgxBZnhy08=
Message-ID: <1a7d017a-8317-462b-8698-03cc7099a74f@classfun.cn>
Date: Thu, 12 Sep 2024 21:53:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dsimic@manjaro.org,
 heiko@sntech.de, jonas@kwiboo.se, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Junhao Xie <bigfoot@classfun.cn>
References: <20240911122809.1789778-5-bigfoot@classfun.cn>
 <20240912023018.23986-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Junhao Xie <bigfoot@classfun.cn>
In-Reply-To: <20240912023018.23986-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/9/12 10:30, Chukun Pan wrote:
> Hi Junhao,
> 
>> ...
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
>> ...
> 
>> +	rfkill-modem {
>> +		compatible = "rfkill-gpio";
>> +		label = "M.2 USB Modem";
>> +		radio-type = "wwan";
>> +		reset-gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
>> +		shutdown-gpios = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
>> +	};
> 
> gpio0 RK_PB0 conflicts with xin32k, please add:
> 
> &xin32k {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&clk32k_out1>;
> };

I added it and it currently works fine

> 
>> +	vccin_5v: regulator-5v0-vcc-in {
>> +	vcc_sysin: regulator-5v0-vcc-sysin {
>> +	vcc_syson: regulator-5v0-vcc-syson {
>> +	vcc5v0_usb30_otg0: regulator-5v0-vcc-usb-host {
> 
> obviously (

I seem to have misunderstood the rules in dt-bindings before.
The following looks better:

vcc5v0_usb30_otg0: regulator-vcc5v0-usb30-otg0 {
vccin_5v: regulator-vccin-5v {
vcc_sysin: regulator-vcc-sysin {
vcc_syson: regulator-vcc-syson {

> 

Thanks for your review, I will fix all problems in next version!

Best regards,
Junhao

