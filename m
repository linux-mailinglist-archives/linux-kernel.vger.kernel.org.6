Return-Path: <linux-kernel+bounces-439055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6849EAA30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DD12839CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC711C5CBA;
	Tue, 10 Dec 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BsEW4Zpc"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F04964F;
	Tue, 10 Dec 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817718; cv=none; b=P1kB/9Ba7jA2ef8aLx1c5Ov0rjUCprg0PjuLjb4PE+4QVk+IWTwxUHuJ646/JzYpUMnNuh4NTGq4WM9VnZGieC5SVjrfBJS0JO1zCgXMiB3iRioqiKgU9LYCZ1lsgmy0C5fne9ewrPccfAlt5guUVL396hAi9fpwZtcxHtpB1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817718; c=relaxed/simple;
	bh=VvxFakbrl2WAmFaY+Eh05CMYewqVB4xjuQVUxDr5XcY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BkcZ1p449ps8Xobgi0pej2rkDhMSlbjV1zYw2VXm/VbAJSainR+odSjX/metmfKRksb8Ptdid7PiJq8pJLSgYnNwE159GljXApY/Ei+FHWyYtQQMfZhli+n+vWIId5ihj2XFE+j8D9RjS/4hLd1skzIP6FfI+GNU8S3W5jpewOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BsEW4Zpc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733817714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GJywCfHdvdwHDP5uXNzefsQ0GJ0yUR4X2Zmb8a5Y6g=;
	b=BsEW4Zpc7tYFRnA/eaiEQ3pYNQXqR0g71UhiABbge+ZG1g8Gc3Yi5Rd+DE0SxCB4hzsVjF
	6eKOaixnFsoB8OUAYmXfkOG9/+xxvqtobm7vp7ca/5tXkpqaSrDNEMPV/Vi8MGe39ahPUm
	qC5nTFVc0Vuyrd+5ycS1z6m+rHOIMcf3YtcfUMS4JFB5JWQdMb24AcViZQTjUNJN/GaSL5
	/X4Z8W5X3/3gcM8GsVY/k5fSFFMyKBs5+tA1H17JatXHIRM6n3A8rYCY8bkUXvhdXePG1G
	NEEvUIBJMSqDfrmyWQvKDrdA32lh2MVR1l61YeKmrZ+d7BT9ydUEbpQtTxiGIg==
Date: Tue, 10 Dec 2024 09:01:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, Johan Jonker <jbx6244@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/6] arm64: dts: rockchip: remove ethernet alias from
 rk3328-roc
In-Reply-To: <20241210013010.81257-4-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-4-pgwipeout@gmail.com>
Message-ID: <20693a7b7cb1aaed2c21b84fd57c4b72@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-12-10 02:30, Peter Geis wrote:
> Remove the ethernet alias added back in during the rk3328-roc dtsi
> conversion.

I just checked again the dtsi parent conversion I performed in
the commit f3c6526d6fb2 ("arm64: dts: rockchip: Convert dts files
used as parents to dtsi files"), and both rk3328-roc-cc.dts and
rk3328-roc-pc.dts had the ethernet0 alias defined before the
conversion.  Thus, the alias wasn't added back by mistake during
the conversion, it was there before.

Moreover, I don't see why would we want to delete the ethernet0
alias(es) in the first place?  It's usual for Rockchip board dts
files to have ethernetX aliases defined, and both ROC-RK3328-CC
and ROC-RK3328-PC have their gmac2io DT nodes enabled, and the
boards have wired Ethernet ports, so they should also have the
ethernet0 alias(es) defined.

Am I missing something?

> Fixes: f3c6526d6fb2 ("arm64: dts: rockchip: Convert dts files used as
> parents to dtsi files")
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> index b5bd5e7d5748..f782c8220dd3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> @@ -9,7 +9,6 @@
> 
>  / {
>  	aliases {
> -		ethernet0 = &gmac2io;
>  		mmc0 = &sdmmc;
>  		mmc1 = &emmc;
>  	};

