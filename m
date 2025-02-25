Return-Path: <linux-kernel+bounces-531854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B8EA445E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B833E16B94E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426418DB16;
	Tue, 25 Feb 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="x3jk79Mk"
Received: from smtp116.iad3a.emailsrvr.com (smtp116.iad3a.emailsrvr.com [173.203.187.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C121ABAB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500366; cv=none; b=qstmMuSpQCvTTCwZgoaZOYcbDCZDduD8kAOChrcwR+qBUOIMIuQRj3vODYFmliaUSz9RkxjKhf78KSLxsOWRMhA7S8LpgvBtHrKVaR7Q2+HxMWpuXErDEP2dP5Wt68lvvjGNzwetjlaMTjSZKyDZ9nilqkSjxFB4ix7dn3sULKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500366; c=relaxed/simple;
	bh=MIlfoTq3cpPNlqKt95zak0Gvvkg2kSKrp1gEQG5RJ3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgMRqsLEjvy+jeqh5z3fLKl4/ruTo08YQ5fbNzrYhf9bSVobW+bX5ILa2TN/3j4hqtCGmSEHHCZqtP+YQ9T0VlrTl7L1i7gdptML8B1pos7U4HyTQkhpsettSw2xAFMUpAzFMOcU7IUsTierGs4qd6BgfyAktrD56adol+sZvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=x3jk79Mk; arc=none smtp.client-ip=173.203.187.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1740495581;
	bh=MIlfoTq3cpPNlqKt95zak0Gvvkg2kSKrp1gEQG5RJ3g=;
	h=Date:Subject:To:From:From;
	b=x3jk79MkbkEF+b1MHrrQYMpcWG3wrdrxrOT5O1lo7Qmwgy+fBvwv8hZyy2fNyQTgm
	 QZFF2aaEh1YfY2jBcsKBFuhFFHZbqoTbrSzH5XIB3wYkwkM9Nf0qw+e/RomEvLiWTf
	 EoEYo4KW39gS4WYoOAvU03xU+qpgs98W35rncDyY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp15.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6FF4C4253;
	Tue, 25 Feb 2025 09:59:40 -0500 (EST)
Message-ID: <ad6bff81-5f8e-4f14-ab35-97b76edd8c82@mev.co.uk>
Date: Tue, 25 Feb 2025 14:59:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RESEND] comedi: ni_atmio: avoid warning for unused
 device_ids[] table
To: Arnd Bergmann <arnd@kernel.org>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <20250225145310.1110575-1-arnd@kernel.org>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20250225145310.1110575-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 75ed46d9-5491-4dea-85e3-a7d6dc623d5e-1-1

On 2025-02-25 14:53, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the driver is built-in, it produces a W=1 warning:
> 
> drivers/comedi/drivers/ni_atmio.c:209:35: error: 'device_ids' defined but not used [-Werror=unused-const-variable=]
>    209 | static const struct pnp_device_id device_ids[] = {
> 
> The actual probe() function has a different way of identifying
> the hardware, so just mark this one as __maybe_unused so it
> can be dropped when built-in.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sent this a year ago but there were no comments, resending now
> without changes.
> ---
>   drivers/comedi/drivers/ni_atmio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
> index 330ae1c58800..b4e759e5703f 100644
> --- a/drivers/comedi/drivers/ni_atmio.c
> +++ b/drivers/comedi/drivers/ni_atmio.c
> @@ -215,7 +215,7 @@ static const int ni_irqpin[] = {
>   
>   #include "ni_mio_common.c"
>   
> -static const struct pnp_device_id device_ids[] = {
> +static const struct pnp_device_id __maybe_unused device_ids[] = {
>   	{.id = "NIC1900", .driver_data = 0},
>   	{.id = "NIC2400", .driver_data = 0},
>   	{.id = "NIC2500", .driver_data = 0},

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

(Greg, would you be kind enough to commit this to one of your trees if 
OK with it? Thanks.)

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


