Return-Path: <linux-kernel+bounces-234825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D30491CB2E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067971F237DD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977732233A;
	Sat, 29 Jun 2024 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fF0zb4uv"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352701878;
	Sat, 29 Jun 2024 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719637553; cv=none; b=CqdVOu8/A8ANAjE2GYu63Ofhe9T0r26PYPBcHm57PFGAa/D2B9ZqKpPmjnUGtw93GDXOA6FNDTLqLdTYPTlYmpcy9NIwVPNAxsj3Gc7HZm8h8uWKLSOxinoArNWK1eN7DmiD4uY27bZ9H5pOkVfIIR9PzJxqn6cs9gmYGRIxgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719637553; c=relaxed/simple;
	bh=e8b6twANdQhhJnHGZLu7xXSZ3FEgLhooVfreBuvC2+I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MkB1n7ZGK8HIiNJjEDI/Jdbb9dZ3PvJOTw/EBadzTdTPX7ibRNJPkEyJco3Tk7fazLtI5hQ/9mrCeLKUhUUmhmNRJpsY5IyumXMecP/Aw61Dx33ZW4w5yX31Ta6IGJQAo60Jry5D5wRQRAS9L1Lyxx8v8JnBk+0/4NSBikK3ndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fF0zb4uv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719637542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMwo9V8qLbkFXcqLqAUxMVPbvcdzo4YSJGNKNIvXkRc=;
	b=fF0zb4uvEgnZtxW8uojfDKDdIlcN8DBHzIRDoYO1jEixWBcuP6f2OHqCaFf3Npx/oFkDY5
	zKF/fIhbMJh1dx+Tbb8kw2YWXSGXEWcA14iSKGemkSa7mBxH69jyM4mQzBzvuySWBUw0ZG
	AZaaHxI32lXUED5sBi2Nz2EiCE9Mw+yYYKEZSu5wwda8TfRJEajmxd5JUYFdVNvPCOCBgp
	Ujf5hVauG4a9v6etZyISosh9mEPueww7a+mpUQAWEkcSlau8CYRv2s9OyjtJ/jSAJQo4cc
	Y+FbS7bTDQN5L0RY3o/yCk870O0SB4gu44SWBfwim0FFDwoQUKnLw3EeDf4EUg==
Date: Sat, 29 Jun 2024 07:05:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>, Chen-Yu Tsai
 <wens@kernel.org>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add dma-names to uart1 on
 quartz64-b
In-Reply-To: <20240628120130.24076-1-didi.debian@cknow.org>
References: <20240628120130.24076-1-didi.debian@cknow.org>
Message-ID: <bd137fb5f44b247d843e0d218a495c62@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-28 14:00, Diederik de Haas wrote:
> There have been several attempts to set the dma-names property on the
> SoC level (in rk356x.dtsi), but that appears to cause problems when set
> on channels without flow control.
> 
> Quoting part of a previous attempt for clarification:
> 
>> Nah, enabling it for bluetooth is fine because you have flow control.
>> My issues have been on channels without flow control. Without DMA it
>> simply drops messages or the channel hangs until you close and reopen
>> it. With DMA, when an overflow locks up the channel it is usually
>> unavailable until the board is rebooted.
> 
> Setting it on the board level for the bluetooth connection was deemed
> safe, so do so for the Quartz64 Model B.
> 
> This fixes the following error/warning:
> 
>   of_dma_request_slave_channel: dma-names property of node
>       '/serial@fe650000' missing or empty
>   dw-apb-uart fe650000.serial: failed to request DMA
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> Link: https://libera.irclog.whitequark.org/armlinux/2024-02-29
> Link: https://lore.kernel.org/linux-rockchip/18284546.sWSEgdgrri@diego/

Thanks for this patch, it's looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> index b908ce006c26..13e599a85eb8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -652,6 +652,7 @@ &tsadc {
>  };
> 
>  &uart1 {
> +	dma-names = "tx", "rx";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
>  	status = "okay";

