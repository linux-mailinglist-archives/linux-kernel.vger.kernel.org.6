Return-Path: <linux-kernel+bounces-355577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF41995445
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF921C2556A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06B1E0B6F;
	Tue,  8 Oct 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYs+GQnd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527E42AB7;
	Tue,  8 Oct 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404507; cv=none; b=fp6GspwKwZhbm2AO8rIbTAyf+d3WP7TC0HwEo47K5VRZMNdqmUxdjyNJ7gwsIxEuxRQYYgU0d+b0CYTz/5KpzEy8K8tujqQNvYLU/5eIjN2+APH4U9qnwOkXFy3QyNWZiu+zpXB86GDoOSVAuTSYGyUs40EDzuMC1p3NI6V2mDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404507; c=relaxed/simple;
	bh=zXf059UWoQ550+54yMiocdr/6qK+9tzdhFNKDz8O4yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om8t5cn9uWZqQsNpfYeBjSR6ldVhf/mnG9kCrc2ZH9L+WxDNOTJ9pHvab3JMTqAxJAnpHEnGMQWSIngErHwO8nYdR7K6C9KuyuNPU5tNc0EhATz1hlC6oIE9aDEKa3TuQwc/duHfC68m2gC8py7S9QnPK25+DiPKeBbwA5GcHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYs+GQnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703B4C4CEC7;
	Tue,  8 Oct 2024 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728404505;
	bh=zXf059UWoQ550+54yMiocdr/6qK+9tzdhFNKDz8O4yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYs+GQndbIL+o8ZiSkYinwyScXiHp+4GxhsFM97pTPW0qxc0YT43BnD/8UYHMZlNi
	 D36Os/0Yd2i75G2N/rqlNBvALFq3L52otkTEF4gukEJ6bL8fFvatKPzxqM4c20vw94
	 Rz3tjnGTNEcukkLGl8QRavyuBG+oeWk2c+KTtxgMxT6qNazwCZpfZKriaUe7etDfv1
	 Q4W/8c99AVCeRiXzO6dR2shnxrWT8isG0xv7gKXlglPv6r8xZsi9PcndkieogOpcIE
	 nYBrG0A8ht/P3Cj8S55pF5ixFKXEI/8ZVpDVCXw4a6uwWrLhz/LvUXJR1/HmiRfnxs
	 62doIaW/4vg+w==
Date: Tue, 8 Oct 2024 19:18:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pengyu Zhang <zpenya1314@gmail.com>
Cc: corbet@lwn.net, linus.walleij@linaro.org, fmdefrancesco@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Docs/mm: Fix a mistakes for pfn in page_tables.rst
Message-ID: <ZwVbSSBf2NM_yq1H@kernel.org>
References: <20241008161050.14732-1-zpenya1314@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008161050.14732-1-zpenya1314@gmail.com>

On Wed, Oct 09, 2024 at 12:10:50AM +0800, Pengyu Zhang wrote:
> The documentation incorrectly calculate the pfn value as 0x3fffff,
> which should be 0x3ffff instead.It is obtained by right-shifting
> 0xffffc000 by 14 bits.
> 
> This patch corrects the value to prevent any potential confusion
> for developers referencing this document.
> 
> Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  Documentation/mm/page_tables.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
> index be47b192a596..e7c69cc32493 100644
> --- a/Documentation/mm/page_tables.rst
> +++ b/Documentation/mm/page_tables.rst
> @@ -29,7 +29,7 @@ address.
>  With a page granularity of 4KB and a address range of 32 bits, pfn 0 is at
>  address 0x00000000, pfn 1 is at address 0x00001000, pfn 2 is at 0x00002000
>  and so on until we reach pfn 0xfffff at 0xfffff000. With 16KB pages pfs are
> -at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3fffff.
> +at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3ffff.
>  
>  As you can see, with 4KB pages the page base address uses bits 12-31 of the
>  address, and this is why `PAGE_SHIFT` in this case is defined as 12 and
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

