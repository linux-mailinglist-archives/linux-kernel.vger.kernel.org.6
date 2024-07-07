Return-Path: <linux-kernel+bounces-243468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D87F9296A8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CC32820CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 04:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9828473;
	Sun,  7 Jul 2024 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Snr9COEM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08257322B;
	Sun,  7 Jul 2024 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720327636; cv=none; b=aiqarA5gD+YfThsm10X+0I6ad0hZVfF7UuQTaezKVWyKR9S3v35uPu+hxsqc+jV9fdd/KvtKGyOPET1VUSpzMf7nwlyXHxfasUTVUbDMoYORoZBl/YnIK3W52ynk9sdiTEcxI8rL4tX7yVER4BIt7pJfnFXPn93J3YwVSPN1GhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720327636; c=relaxed/simple;
	bh=43JkUclB88IiUoC+g0EJi3X7ARRYadtz1vKRIzPz4IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XDutGkezkQAfD+ugdh5PwJniGZEDM9FMaeW5kUSnqK9C4bStJWUh6g0hGj1eUWFrxMVejEI/0C5jPAkrY9qBgjvqFHQcu3wFPOpnYeyrGTzSiIzAF/4uKJKeHOzhSh/YX9hU/e41ZNgRNmnpKIaUIUudJLXA/88R4hJqoEBXJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Snr9COEM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=lfQOYRS8NmfKAfyRcGOWelVsJYvRctZsejOc13va95c=; b=Snr9COEMIen02VJN5OHSGs2nyj
	cgUuxOYPkT8GGIYbh5L2Jh3kIkEsDu0dAKxjQ1VpWVQ8LAklp0IgT2Tl/4oHd1jY/B0DGimrizV9y
	p/gM8bbR8slnjzyIkyOO4Pu+qUxmL/Q+dzSkCoaUGeIh9F1ZX/4NeGx+Q5gSSBUmKG3Z0KxhtJ3PJ
	1g8qC+n7K4309wWje+s9z+S/w3zHPpr0nJnla+XkykLdxVOiLgGBdE1eeTSbEG/fLkoDHUteu9n2B
	GT2Agf7gpM89evU1otGMojo5CebtPGFdKGjyHMxPGu30kmZyVTQtQ4OTXVawDOmF6GuOl0nkK/5vm
	pFN6TccQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQJnr-00000001LNK-2S2N;
	Sun, 07 Jul 2024 04:47:11 +0000
Message-ID: <bb18f151-2c38-4dfa-95a9-cb674d169343@infradead.org>
Date: Sat, 6 Jul 2024 21:47:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
To: Gold Side <goldside000@outlook.com>, "perex@perex.cz" <perex@perex.cz>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <DM4P223MB054139F737887D40A2CA396FF7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <DM4P223MB054139F737887D40A2CA396FF7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi--

On 7/6/24 9:14 PM, Gold Side wrote:
> From 33dc0aa3973913f310840cc8f7d5d599d573c297 Mon Sep 17 00:00:00 2001
> From: Steven Davis <goldside000@outlook.com>
> Date: Tue, 2 Jul 2024 23:43:15 -0400
> Subject: [PATCH 2/3] Removed unnecessary comment end
> 
> It still works the same without that comment end, so why is it in there?

Building with clang should report a warning similar to this:

error: '/*' within block comment [-Werror,-Wcomment]

which is not acceptable.

> Signed-off-by: Steven Davis <goldside000@outlook.com>
> ---
>  include/memory/renesas-rpc-if.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/memory/renesas-rpc-if.h b/include/memory/renesas-rpc-if.h
> index b8fa30fd6b500c..591dd86f55f879 100644
> --- a/include/memory/renesas-rpc-if.h
> +++ b/include/memory/renesas-rpc-if.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0
>  /*
>   * Renesas RPC-IF core driver
>   *
> 

-- 
~Randy

