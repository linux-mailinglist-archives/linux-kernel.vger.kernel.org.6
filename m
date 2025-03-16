Return-Path: <linux-kernel+bounces-563145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3973A63786
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6187A4849
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5645019CC22;
	Sun, 16 Mar 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="CoaPC3au"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378738635D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742160372; cv=none; b=s3dmm/Oi0HaiTcVst/Hy6Y2aMZQNSW+/EIRbmcOO9ejBsSWZwieTxuRUwpZ/PNPkDAMBpuq8ckyYtkG3Z66qIvQveiEF27zKJF7/4Ays2+o7FwZ1yLL/TxnDuacnenY4SdCypL4ls886UK5nDn4A1q+bWiFYDGU05F9U6WzaUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742160372; c=relaxed/simple;
	bh=Yjp3nfPJZc+av2pjdirSnSey+6zj6TeappTOJRuKm6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJXvB2s0Km1snoOIZIQxqTSWPZy7vTLDvom+xwouqE1Xs5lddkswDXGV9slda4rGFZ1gouOhOE1O66sTZb19C3zJS1O2hAonC6lKS5IJdHIK5Gc4Q6AC1n93VMA/L7RrRL6blGJgrOXlkbZl1eYE2rWDJfsnZoKCglPR1wrq4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=CoaPC3au; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1742160361;
 bh=W3BUKa9QvnPlmXnONvzXA2ROEjOwfnjtdg2uvv5bZM8=;
 b=CoaPC3auy41NiniSsk5AsYwoaXlCOEkNf4l0qvHisPj3/uJKJ5db3ItvpqGTAaQ5tt5qFijPO
 laNOsCFSqx8R0Sf8Ij/PObpl+iWkQvaHFbYzCqdBwYuwQ1Z+pfJpcHWzVhgGucCSTGMY8+ONRgW
 fpZQEmEeVGpv/uDe3AhYVGI/SvvJBJpdRUiQvrkUT7bczSgOjqwaY6//mDoVO1Kh/qGNnm00mB8
 QPfrqTVQJPj6hqL9DAiA3wlIbaGBfaJuKdLle9Kk+WYDcqNustg6SNZnRqeYu21/y41yK9SFLOR
 UHaid7xNVFjVKhVW1P0QrnnHGY9HaHtkrym3qByQ1HLg==
X-Forward-Email-ID: 67d741e6615b196bfb50dc90
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7e5ff689-c013-47c2-982b-e7f4c1d233ca@kwiboo.se>
Date: Sun, 16 Mar 2025 22:25:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvmem: rockchip-otp: Add support for rk3562
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 Finley Xiao <finley.xiao@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250227110804.2342976-1-kever.yang@rock-chips.com>
 <20250227110804.2342976-3-kever.yang@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250227110804.2342976-3-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kever,

On 2025-02-27 12:08, Kever Yang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This adds the necessary data for handling otp on the rk3562.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/nvmem/rockchip-otp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
> index a04bce89ecc8..6f86cf8ec390 100644
> --- a/drivers/nvmem/rockchip-otp.c
> +++ b/drivers/nvmem/rockchip-otp.c
> @@ -341,6 +341,17 @@ static const struct rockchip_data px30_data = {
>  	.reg_read = px30_otp_read,
>  };
>  
> +static const char * const rk3562_otp_clocks[] = {
> +	"usr", "sbpi", "apb_pclk", "phy",
> +};

These are the same clocks as used for rk3568 below.

> +
> +static const struct rockchip_data rk3562_data = {
> +	.size = 0x80,
> +	.clks = rk3562_otp_clocks,
> +	.num_clks = ARRAY_SIZE(rk3562_otp_clocks),
> +	.reg_read = rk3568_otp_read,
> +};
> +
>  static const char * const rk3568_otp_clocks[] = {
>  	"usr", "sbpi", "apb_pclk", "phy",
>  };
> @@ -372,6 +383,10 @@ static const struct of_device_id rockchip_otp_match[] = {
>  		.compatible = "rockchip,rk3308-otp",
>  		.data = &px30_data,
>  	},
> +	{
> +		.compatible = "rockchip,rk3562-otp",
> +		.data = &rk3562_data,

Here we can use rk3568_data directly without having to add a new
rk3562_data struct.

Regards,
Jonas

> +	},
>  	{
>  		.compatible = "rockchip,rk3568-otp",
>  		.data = &rk3568_data,


