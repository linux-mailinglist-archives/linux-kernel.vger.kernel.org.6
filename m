Return-Path: <linux-kernel+bounces-439268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675359EACE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6F816BAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AAD1DC988;
	Tue, 10 Dec 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vPqeDVKo"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88291DC990;
	Tue, 10 Dec 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823885; cv=none; b=F6PBj0vWWvDipGeh18Jr0MXqeaHQXQivmfhGoEdPPjVjpGc5Rzmgmad9G/DLrAbi1sSQmmJOPicohqIA9a2hOTA+hZ8RKgcJmn/tI+RXy5s/hmYgPkq8xfrJ5AivIsoijNYP/amhDbaH68NDMNJKTTErbyffSaMAddT3ZbKCcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823885; c=relaxed/simple;
	bh=e4u2714Btd5HDg6xOeh0GIX/gEGUmICMubVqVTDnYr0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cDjnmaFJQfPe1wlt2BWhVRycqPxrOYIxXv3YknZUKu2uRdk/UV0TOHG8NKgVnNRIKt9s3de7t1gcOu2V4srEUufjN2VdIJALalxe+R57J072k8sEQzK8reAUIhWflz5xv5b2ZOILR9YbniU315ZaADh7fNYa8yDh608JusPoTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vPqeDVKo; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733823881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YiF7ThrDbAWeKuRCOAFsJKBbN+BqrzeViLR+WJYBGs=;
	b=vPqeDVKo1NuK++72WGjDs5Xgi2ccTif6seKQoz8N1jraAKbxWjh1xsj9p9fKxk5kBtjak2
	Y0B1KqAk1QaPGV5y0Bqd+soG2AtWYXWIrJbmta/TgRIVhvZLJ/ns29XXX8SWyYB7M+Eflw
	Da005oSFEzy3hU2FQv23SHrYlsihCE7MeEh7+AKgmGUOiXjJT8EgskvFMQlIGAd3+yf0Wf
	b7SRLYf8BrVNeZ0qWQUWqtPK7qyN8LE8sTA9K6E1DEIYEumta8tQ9J9vcdFHl1w8n1mhPA
	DVS2QvvTyoYO25N25eQKgyPZkp6KJX8sDp5iBtSU+UY+4VusU/zoSF7GvfrqJQ==
Date: Tue, 10 Dec 2024 10:44:40 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang
 <zhangqing@rock-chips.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/6] clk: rockchip: fix wrong clk_ref_usb3otg parent for
 rk3328
In-Reply-To: <20241210013010.81257-3-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-3-pgwipeout@gmail.com>
Message-ID: <0d11705121f29ccfb7cfa342505a6e35@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Peter,

On 2024-12-10 02:30, Peter Geis wrote:
> Correct the clk_ref_usb3otg parent to fix clock control for the usb3
> controller on rk3328. Verified against the rk3328 trm and usb3 clock 
> tree
> documentation.
> 
> Fixes: fe3511ad8a1c ("clk: rockchip: add clock controller for rk3328")
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
> 
>  drivers/clk/rockchip/clk-rk3328.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3328.c
> b/drivers/clk/rockchip/clk-rk3328.c
> index 3bb87b27b662..cf60fcf2fa5c 100644
> --- a/drivers/clk/rockchip/clk-rk3328.c
> +++ b/drivers/clk/rockchip/clk-rk3328.c
> @@ -201,7 +201,7 @@ PNAME(mux_aclk_peri_pre_p)	= { "cpll_peri",
>  				    "gpll_peri",
>  				    "hdmiphy_peri" };
>  PNAME(mux_ref_usb3otg_src_p)	= { "xin24m",
> -				    "clk_usb3otg_ref" };
> +				    "clk_ref_usb3otg_src" };
>  PNAME(mux_xin24m_32k_p)		= { "xin24m",
>  				    "clk_rtc32k" };
>  PNAME(mux_mac2io_src_p)		= { "clk_mac2io_src",

Sorry, but I was unable to verify this in the part 1 of the
RK3328 TRM, in both versions 1.1 and 1.2, which is all I have
when it comes to the RK3328 TRM.  Is that maybe described in
the part 2, which I've been unable to locate for years?

Moreover, the downstream kernel source from Rockchip does it
the way [1] it's currently done in the mainline kernel, which
makes me confused a bit?  Could you, please, provide more
details about the two references you mentioned in the patch
description, or maybe even you could provide the links to
those two references?

[1] 
https://raw.githubusercontent.com/rockchip-linux/kernel/refs/heads/develop-4.4/drivers/clk/rockchip/clk-rk3328.c

