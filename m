Return-Path: <linux-kernel+bounces-407404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5529C6D09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3CCB29937
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B81FE104;
	Wed, 13 Nov 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TP7jCWIz"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA111FB89A;
	Wed, 13 Nov 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494329; cv=none; b=g3jwqACMea0gympLPBP/mvMcTpPCxVfGOghT0br00FszEutI85giBfMuY2r3SLCc0iyQj1P8f3yaGzdReUoLbPlOEBdWafxuA03OYKPxjmvN4UWOt/OcHbn62cr9Tcilbe/ju1ebL2xb27N5sTTKuAtR7kA254iBUPaQkoLNQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494329; c=relaxed/simple;
	bh=XnyK2cUNddDaNwEG52WGnzjL8TynPLpzNBm8cJx3Jmw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HDoZ8ejKW16buSmz+P0vZwpbxsy5zf7kDJvjmce12w2GGgkDs6MpDSP8YA78UNppGGBxktWsVBXsDEdHdCTKx3ev13NFSAC3VTrZNwU1xKiKiM7Pi/+R73kD2fcLQgDhDlrtXArm5fjG9DTrwycSBKbP1vnlwWr63bzQRGBEBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TP7jCWIz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731494319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IF/vepkYLlzPa+ADSxysQyPEUO3lIiqkFDR8yTHUMM4=;
	b=TP7jCWIzDHOvG6IaVPJw1zfuuw2FKJ1Bh0h2H/+0gswy1ADCLGYi2WQoTvzZ9ssMgdIryY
	vIu232el3rCYgagbcyYlswLfXcQ2pWLLb7rBWrC6C8tlENyR7M8FHIYXDZvRiG/di/llH4
	WMgmzq9Wwuq3+IorsKn6hlakinn3tNSpUOaxEAgo8Ow6HqCCo+i7KD/W4XpP2CdfDSQESe
	qJto4tSlZESB1jp7tTw7La4pvWBCmrwsuagTnmmlYJ7esUk8/7JMfhqJ0HfZvTZXs6r7Wu
	VKuw19CI5tcn5LNyZfxXC5ty+YjPXelReeTEARGVXGYe/ryfajlFwbt6MnqFNA==
Date: Wed, 13 Nov 2024 11:38:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@linux.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki
 <naoki@radxa.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable UART8 on rock-3b
In-Reply-To: <CA+Gksr+E-tZe4sKVNa8zpATwdTW_DiOQxOf_Jujf5SURzhSPSg@mail.gmail.com>
References: <20241111181807.13211-1-tszucs@linux.com>
 <20241111181807.13211-4-tszucs@linux.com>
 <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se>
 <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
 <9330ebb370780c001fd2aaee49aec9e8@manjaro.org>
 <CA+GksrJjDPve29Vh7ZFhM+JFp058xmXZAPeuLuFth7v=JeiH2w@mail.gmail.com>
 <0eb19e4daf2cdf3d4a04935876c3d3b0@manjaro.org>
 <CA+Gksr+E-tZe4sKVNa8zpATwdTW_DiOQxOf_Jujf5SURzhSPSg@mail.gmail.com>
Message-ID: <dc628e6e50239aac65a4424738000612@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Tamas,

On 2024-11-13 11:24, Tamás Szűcs wrote:
> On Wed, Nov 13, 2024 at 12:25 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-11-12 22:04, Tamás Szűcs wrote:
>> > On Tue, Nov 12, 2024 at 4:07 PM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >> Please correct me if I'm wrong, but isn't this UART supposed to be
>> >> used for the Bluetooth part of an SDIO WiFi + Bluetooth module, in
>> >> form of a non-standard M.2 module that Radxa sells?
>> >
>> > UART8 is supposed to be used for any radio module connected to the M2E
>> > connector.
>> > It will typically be responsible for Bluetooth or BLE but it could be
>> > 802.15.4 or whatever. In any case, all wanting to use it will need the
>> > uart8 node enabled.
>> 
>> I see, but I'm still guessing what's the actual use of enabling the
>> UART8 when it will remain pretty much useless without the additional
>> DT configuration, such as in the WiFi+Bluetooth DT overlay that Jonas
>> sent a bit earlier?
> 
> The actual use is device enablement.

Hmm, I'll need to think more about how it fits together.

>> I think that the UART8 should be enabled together with something that
>> actually makes use of it, which in this case unfortunately cannot be
>> automatically detected and configured, so it belongs to a DT overlay.
>> I'll get back to this in my next response.
> 
> I agree, bluetooth blocks dedicated to specific modules should belong
> to DT overlays.
> 
>> >> With that in mind, I see very little sense in just enabling the UART,
>> >> without defining the entire Bluetooth interface, which AFAIK produces
>> >
>> > Defining a bluetooth node would hardwire idiosyncrasies of a given
>> > radio module's Bluetooth core. Sure you could add a sleep clock, all
>> > kind of sideband signals for wakeups, reset, power down, etc. But hey,
>> > some will use them, some won't. I think it's undesirable and
>> > unnecessary. You can hciattach from here and most will work just like
>> > that. Tighter integration or anything special, module specific on top
>> > should be handled individially, on a case-by-case basis. This is a dev
>> > board after all. I say trick of all trades.
>> >
>> >> nasty looking error messages in the kernel log when there's actually
>> >> nothing connected to the UART.
>> >
>> > My dmesg is clean as a whistle
>> > root@rock-3b:~# dmesg | grep -E 'fe6c0000|ttyS0'
>> > [    0.344818] fe6c0000.serial: ttyS0 at MMIO 0xfe6c0000 (irq = 26,
>> > base_baud = 1500000) is a 16550A
>> > What kind of nasty errors do you recall?
>> 
>> Those would be the kernel error messages produced with the Bluetooth
>> DT configuration in place, but with no SDIO module installed.
> 
> These are the kernel messages related to UART8 with the uart8 DT node
> enabled and an SDIO module installed.

Out of curiosity, what M.2 module are you testing it with?

