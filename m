Return-Path: <linux-kernel+bounces-391083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C20E9B8278
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6483E1C2140E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434701C9B7B;
	Thu, 31 Oct 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWH65IpZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1E1EA90;
	Thu, 31 Oct 2024 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398772; cv=none; b=B1MDx9Pc6FX3Ojj+69jFJN4NSS4J9BiO4u7A7AizH8CpONDQ7MrNT7sc4fM5ExmLt0vepGrWLJbYTTVEcZabJP4EeHHIhdG/pMsMTM3ztBGSpvglQlB0rRS6LEPWRrNifyH8rUWfMJfTwjYcjeqasdIFUVKoPjNR7Q+LaWmyrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398772; c=relaxed/simple;
	bh=zosPQdd9uTHjio/Nkmdyosvas90deIefUXBnmDug2Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctXLV/ESWE86bIZj8rQFuPHxbbdAV664GoVnNqBcH2bwZWpQQEdBEU5HX3Bgh9NU2gFfDCwqixaHV9OmQEBPa1pkfvY/9knbUlTRuys5jmmZv43akZ6vBy2St9RUeTkKUfGMlHE1dzF55pJCjmGhjBfYk51f5mG3bLaXK/VQ9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWH65IpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA444C4CEC3;
	Thu, 31 Oct 2024 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730398772;
	bh=zosPQdd9uTHjio/Nkmdyosvas90deIefUXBnmDug2Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWH65IpZT3Do0lgQPg6PuUMI+6u4yC94Bi+Ld3ZJFzQa+FAslp9HD+bCmOu7MmP1H
	 MYSWNJymG/XwwgewEVuR2zatp0QZZKhDU30wPrH1uYjITFflZWqIY5XPAip2Is+1Tt
	 HHt0zdmQljJMPY6cghtCxCWdtewMhxYkVlF3pRgmJZzIh/qIZMRyXQ6PE1Wq4dNFz7
	 2hiW3fvT+Aap8Iin1gfqy4QD/nulRuVfzxMeJHeDvKLbfpAyT+EsxCbMjUQBfNbSNS
	 LGNf7cIGdNFCqrRaSouSNbbuuTfjRSD+tne7acTh4B+SB7X3RUaW9kduh+7Yo+GXJ7
	 KU6uHNFjK4ypg==
Received: by pali.im (Postfix)
	id 2D4DE83D; Thu, 31 Oct 2024 19:19:24 +0100 (CET)
Date: Thu, 31 Oct 2024 19:19:24 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH v2 2/2] dell-wmi-base: Handle META key Lock/Unlock events
Message-ID: <20241031181924.zlx5d6lh5bv2v2le@pali>
References: <20241031154023.6149-2-kuurtb@gmail.com>
 <20241031154441.6663-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154441.6663-2-kuurtb@gmail.com>
User-Agent: NeoMutt/20180716

On Thursday 31 October 2024 12:44:42 Kurt Borja wrote:
> Some Alienware devices have a key that locks/unlocks the Meta key. This
> key triggers a WMI event that should be ignored by the kernel, as it's
> handled by internally the firmware.
> 
> There is no known way of changing this default behavior. The firmware
> would lock/unlock the Meta key, regardless of how the event is handled.
> 
> Tested on an Alienware x15 R1.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
> v2:
>  - Fixed entry style
>  - Commit message clarifies firmware behavior
>  - Commit message now has "Tested on"
> ---
>  drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> index 502783a7a..ce421e51b 100644
> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> @@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
>  static const struct key_entry dell_wmi_keymap_type_0000[] = {
>  	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
>  
> +	/* Meta key lock */
> +	{ KE_IGNORE, 0xe000, { KEY_RIGHTMETA } },
> +
> +	/* Meta key unlock */
> +	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
> +
>  	/* Key code is followed by brightness level */
>  	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
>  	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
> -- 
> 2.47.0
> 

