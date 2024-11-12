Return-Path: <linux-kernel+bounces-406150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4529C5E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7177EB3EA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05BF203700;
	Tue, 12 Nov 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fqrrWSgJ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155D201254;
	Tue, 12 Nov 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424037; cv=none; b=s8x3GMWfY2XcC5N19yqZ8boBtL1Ql3TNhusoNpxcf8pJ9JxedsOex2A9G4aoABpiiSP46v0WNrNUg41c+z4MbAoEeGrpmTKLcJ6jpix027LbYJ9D8tZZYAcQSa8dn3vyn233XAWcVp5SJ3O5pTiZ64cmxWig02ki2ZgftX9su/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424037; c=relaxed/simple;
	bh=UgfHaQNJ/vZu+gvqoCH5hpkye2Wjg7yXuMPQhphPEos=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O/jaC6DCgm3X59H1AvIILo1huJAmHmatoNQUt0t5hrXHJc5TF5/Z0pSdpwDebVN0J9rQDwhMZGRY9dK+qbxGo+bbr3yIW/BIdR2N/9cr7cJH/K55D5NTsa0S2aAUkJG7mveHdq02txSCfFjrP3vMxds82s6KrKU4OORvVp5UXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fqrrWSgJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731424032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JzPROz1nsHbGEclfKh8jf9jsrbMpci++OmYF8hXYss=;
	b=fqrrWSgJDCXj9QX3GYICI4bGW449R0E70n9ccimyXlQonBWFc8GQnB/AFmy3YcZfR/h+Or
	Y7Y6fSJbiv0PNMjhKraNdLtn7kY0Q7GJtVES+zk333uiQZ5wVJnWQLQ/+KqEUuUQUyfzVP
	O1XpYYzJg/b/snCU7RndlbCaQ90yja24QDUCJ6jrE08UrjqP88d5nsmIDQMNJKZc2AabhS
	2mposGDaIvnsWzTKkrA943iqABdAQc0MslxbrNNUygk4nN+CzGXUSepa257eyNDkWP0Tnj
	A9/NKqiO+xHcSiutZpnSf4FW6Crb6yJ7SZDMSJT8d6pEy9wkcTtlWg54jiO8Mw==
Date: Tue, 12 Nov 2024 16:07:10 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@linux.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki
 <naoki@radxa.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable UART8 on rock-3b
In-Reply-To: <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
References: <20241111181807.13211-1-tszucs@linux.com>
 <20241111181807.13211-4-tszucs@linux.com>
 <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se>
 <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
Message-ID: <9330ebb370780c001fd2aaee49aec9e8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Tamas,

On 2024-11-12 15:35, Tamás Szűcs wrote:
> I agree; it's not possible to tell if the user will use a PCIe/USB,
> PCIe/UART, SDIO/UART, perhaps USB/UART device, or any other HIF
> combination. The way I see it is UART8 is hardwired to the M2E, so
> there is a reasonable expectation that it should work too if need be.

Please correct me if I'm wrong, but isn't this UART supposed to be
used for the Bluetooth part of an SDIO WiFi + Bluetooth module, in
form of a non-standard M.2 module that Radxa sells?

With that in mind, I see very little sense in just enabling the UART,
without defining the entire Bluetooth interface, which AFAIK produces
nasty looking error messages in the kernel log when there's actually
nothing connected to the UART.

As a side note, please use inline replying. [*]

[*] https://en.wikipedia.org/wiki/Posting_style

> On Mon, Nov 11, 2024 at 8:12 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>> 
>> Hi Tamás,
>> 
>> On 2024-11-11 19:17, Tamás Szűcs wrote:
>> > Enable UART lines on Radxa ROCK 3 Model B M.2 Key E.
>> >
>> > Signed-off-by: Tamás Szűcs <tszucs@linux.com>
>> > ---
>> >  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> > index b7527ba418f7..61d4ba2d312a 100644
>> > --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> > @@ -732,7 +732,7 @@ &uart8 {
>> >       pinctrl-names = "default";
>> >       pinctrl-0 = <&uart8m0_xfer &uart8m0_ctsn &uart8m0_rtsn>;
>> >       uart-has-rtscts;
>> > -     status = "disabled";
>> > +     status = "okay";
>> 
>> This should probably be enabled using an dt-overlay, there is no UART
>> device embedded on the board and the reason I left it disabled in
>> original board DT submission.
>> 
>> On second thought maybe they should be enabled, think PCIe and USB 
>> lines
>> on the M.2 Key E is already enabled by default. I probably only tested
>> with a pcie/usb wifi/bt card and not a sido/uart wifi/bt card.
>> 
>> >  };
>> >
>> >  &usb_host0_ehci {

