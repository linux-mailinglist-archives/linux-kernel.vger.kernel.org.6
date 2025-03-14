Return-Path: <linux-kernel+bounces-560680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5613A60811
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DD117FCB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6C82F4A;
	Fri, 14 Mar 2025 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZH2PMqCj"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5B34545;
	Fri, 14 Mar 2025 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741927507; cv=none; b=PauvHAfuYVRbskrPqNY0Trbrpb5NwcnYNUZ+jVd4QtARjlK70WkQ98dWDFiZ1k4Venv6YIW70gtlLfCEmh5oiWYo98KXtkU0BTs8ssiz0AJI87WI9Ff8qDDWYD8huiOUmtCranlgg9zTZzH3AltGNcXN7hF/L0CA2P085nxm/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741927507; c=relaxed/simple;
	bh=On8Fp6Dm7cJ9fltNuWZYtw9Y0HJo95ESFzwA1/U9BLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBA0X9+nZr3s139AgxmPmiYD1gEp6JOzwYAKVF+5bvuQNRqTxE8WkKh+BdRRfzJtjW2Qg3fJI4GIgTHX4iN2e9/ERiEH4CLY/aJh3RbWpiEdewk/+t6YeRCjd960lFPIzqLS6NVHfAE4lWVzYvOwKbHDD+J2giBhgDEkauxbtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZH2PMqCj; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.172.69.54] (1.general.ikepanhc.us.vpn [10.172.69.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 21DF93FF1C;
	Fri, 14 Mar 2025 04:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741927104;
	bh=6ceCZYPC+C8h/gchHlxhhHchfKUdf9ms+lIX7+qjn9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=ZH2PMqCjfHrsEpLgJUakSGPXbtdZmoLxrF2x8byu9x9dy11n1C2xSZjTv+kruZS9a
	 XNJgijYZiAkCMum+8JduQfgPqzYqMPgHX/vs/fY0lSTvCzT98ApGS/F9K3ZG51bxLs
	 4/tQ4TpFdNLqsn65dW8wV3oMcwrOCHYFBynttXK9m6xx5IeDwMvfXix2DaDX31fO/0
	 xd2F0nNZihbBVn2U9+w4s9y1xbLdqHQHh1/l+htA0cs2sNezZLGVZOKRnGYjaA4lNd
	 I8MdNON0gJI087r1aDhk4QhYDzsQvqUMs+LxTCz/pCRx9Zdf9KkMiBO6wei/ZjNFzt
	 VodmgZH3pDo0w==
Message-ID: <4f1d9817-60b1-433d-b7a8-f37057e0980a@canonical.com>
Date: Fri, 14 Mar 2025 12:38:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixed ideapad-laptop driver to support Yoga 9 2 in 1
 14imh9 unknown keys
To: =?UTF-8?Q?Ga=C5=A1per_Nemgar?= <gasper.nemgar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <20250313151744.34010-1-gasper.nemgar@gmail.com>
Content-Language: en-US
From: Ike Panhc <ike.pan@canonical.com>
In-Reply-To: <20250313151744.34010-1-gasper.nemgar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/13/25 23:17, Gašper Nemgar wrote:
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 30bd366d7..af124aafe 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1308,6 +1308,14 @@ static const struct key_entry ideapad_keymap[] = {
>  	/* Specific to some newer models */
>  	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
>  	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> +	/*Star- (User Asignable Key)*/
> +	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
> +	/*Eye*/
> +	{ KE_KEY,	0x45 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
> +	/*Performance*/
> +	{ KE_KEY,	0x3d | IDEAPAD_WMI_KEY, { KEY_SPORT } },
> +	/*shift + prtsc*/
> +	{ KE_KEY,	0x2d | IDEAPAD_WMI_KEY, { KEY_PROG3 } },
>  
>  	{ KE_END },
>  };
> 

Acked-by: Ike Panhc <ike.pan@canonical.com>



