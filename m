Return-Path: <linux-kernel+bounces-342385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF285988E52
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 09:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77FD1C20FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A619DFBF;
	Sat, 28 Sep 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNeuCQRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38095C156;
	Sat, 28 Sep 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727510300; cv=none; b=MCMlK8+s/62GWPMVzls03p4TE/Luvnu8ZvDFCvj4m2vDKD6otoMEQE/FRETLK/wMptAN6ucqibHFsSLFEyWiVjCUf/RgsoQPfzw3B3K+Y5Jojh8nYIhMpHzHu+S/57dGQpt3psDXbsnnkbfhvQi5FqrYywMIAVZzNnBkCDSW0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727510300; c=relaxed/simple;
	bh=dfz34C74TnXsl7MdiRil4pwzxh/vMcgFOPpvbrYVZuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxNlR7DZuNbKPSFcbrrkaxpApUf+bwArvLu+hXL5sYRgfu3U7DzBj/QWOjR9aaW+KLP+z1gIx1H7cg4ju5GwJ3cLHxjOfIh2HoXfxegUr0IHzfTvQdrTREI1SLj1/ibMGUcnjnGjh7WL3CjJg9/MLRfkuUdlylJ6mEx3jcLeoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNeuCQRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1052C4CEC3;
	Sat, 28 Sep 2024 07:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727510299;
	bh=dfz34C74TnXsl7MdiRil4pwzxh/vMcgFOPpvbrYVZuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lNeuCQRxphlQUfWef8fLwYLCu5O92ONkqltcPKLEkGmp6LfYZqshS0m4v5YzTIgrE
	 R2xm39P9TtfsshIUjApXjaZ3gMKxqlLaGgpFS177u9FumFtxU6bNStOGmrLQp/aPDH
	 R4JgKcqoJgghmfsUmFu7SwJj5LDo6dmOdvdphjxD8tdePRv96d68RbgpaPA423ZbfX
	 wRHb1jks4kHSW+xtLtalqO+igO+D3FcAEzg2uH712D3MXntAbKIIcPxgNeulzMV+UG
	 LQ6PKq4shJs3HDBWcBTV9rI3cviVVrv8TTqh3wF8NgfrET9Ibjxurbg36U3FzwRRvg
	 8Zc3t8lKom9Tg==
Message-ID: <0c71ef80-0a4a-490b-be61-bb7641b9ac88@kernel.org>
Date: Sat, 28 Sep 2024 10:58:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: add missing compatible arraylist
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <ZvBNLRc8xnAoGvoc@Emma>
 <a02e472c-f206-44d3-9a6b-d921e73110fd@kernel.org>
 <CAEDjzLK1juaOCogWgyDudOn9B1EqbE-vMuGYPxnR9B35y+uAOQ@mail.gmail.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CAEDjzLK1juaOCogWgyDudOn9B1EqbE-vMuGYPxnR9B35y+uAOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/09/2024 10:39, Karan Sanghavi wrote:
> On Mon, 23 Sept 2024 at 17:23, Roger Quadros <rogerq@kernel.org> wrote:
>>
>> On 22/09/2024 20:00, Karan Sanghavi wrote:
>>> Added the vice versa order for compatible property in the yaml file so
>>> that the dtb can parse for the order mentioned in the dts file
>>> k3-am642-sk.dts for ti,j721e-usb.yaml
>>
>> k3-am642-sk.dts does not introduce any nodes with the said compatibles.
>>
>> "ti,am64-usb" compatible is introduced by k3-am642-main.dtsi.
>> There is only one compatible introduced so there is nothing to do about
>> order here.
>>
>> i.e.
>>         usbss0: cdns-usb@f900000 {
>>                 compatible = "ti,am64-usb";
>>                 reg = <0x00 0xf900000 0x00 0x100>;
>>
>> What is the functional problem you are facing? Maybe then someone
>> can point you in the right direction.
>>
> 
> Sorry for mentioning the wrong file name; yes,
> the problem is in k3-am64-main.dtsi file as mentioned below
> 
>  usbss0: cdns-usb@f900000 {
>  766                 compatible = "ti,am64-usb", "ti,j721e-usb";
>  767                 reg = <0x00 0xf900000 0x00 0x100>;
> 

Which tree are you looking at?

https://elixir.bootlin.com/linux/v6.11/source/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L761

	usbss0: cdns-usb@f900000 {
		compatible = "ti,am64-usb";
		reg = <0x00 0xf900000 0x00 0x100>;

> Due to this, it gives an error as in the YAML file the order is in
> reverse order.
> Also, I cloned the repo yesterday and still found the same error in
> the dtsi file.
> So have I done something wrong? as I see I might be out of sync with
> latest changes

You seem to be looking at some old tree. Please refer to latest kernel
tree when submitting changes upstream.

-- 
cheers,
-roger

