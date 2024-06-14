Return-Path: <linux-kernel+bounces-215468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 133A4909333
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE68B24B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95BA1A3BB2;
	Fri, 14 Jun 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="32N5DGh/"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998419D07B;
	Fri, 14 Jun 2024 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395763; cv=none; b=l+9v+dNvKj6TNtKkhqetoF3XyCo4/pWTHWNqtDprS7NLjsOh+izEvQ7CmOisODXs1vBFnJkW6u2KBCyM4UG/pCfPPQlmCXwtNK09nPm3z/Na7XtHg4UXq4V4ymcTqlN0YXrELlcTs4bdL84kReO5xLME7mmM4lYwEKEHXsIcThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395763; c=relaxed/simple;
	bh=NQ1+I7H6g1HJVnqrPK31doiyQDEadhBACK6vAZij3AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sU9gmbdTt6O/CJBhSyc4c4VWslV94hNBTA1eRjeQ49mGB/ACmfLXVHAR2pxrH9wtnKmvWF23cX88YwafYLvBzZcT2I5s0jJuaQbZCATGn6/O6g4J+c8ZPhgZ3cl5C/tvWQtghYc3uDEGXwoqkZHyIjBbczhYpzyLvNZSxuq5edw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=32N5DGh/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=l3lNYKR1L7w3mEw1XoiTN28FqkTkymXTBgQQ68foobc=; b=32N5DGh/6McUeDwwb78pUo2+rm
	GeZ59n95IMvOjlkYzat+RtLVpA/8tApZiku8nTk2/KFxx5ZrLeNL9ZcnFvlCuO3ikJwBvuxPTNTAB
	+/xENIPqeJhrqxbx9IQyNbYmRAZLhXSAlVCY9BYafDKafO1XcxlWgbLGozJPmdEjpa12phZF/fKO/
	dMIcVDdOITrLQq7KEPu8cbMk/oNcMAtg9RRI50+7vH+qKbyRFcsufs7BRRLQFDzFj3uitkgf1qyUS
	XjO7KlPpbHnWyJlDMt5+7Lbw8LW6ijhfcMyFRjsUpxCuyA92zQ+qGbcICIkyUmx+5DiTPofoH5ceB
	me2rIivA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIDEf-00000003x5E-0ql1;
	Fri, 14 Jun 2024 20:09:21 +0000
Message-ID: <e459e0eb-40a7-406b-b5d4-cfd937796177@infradead.org>
Date: Fri, 14 Jun 2024 13:09:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Remove unused "nps_mtm_hs_ctr" from
 kernel-parameters.txt
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org,
 Vineet Gupta <vgupta@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-snps-arc@lists.infradead.org
References: <20240614190804.602970-1-thuth@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240614190804.602970-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/14/24 12:08 PM, Thomas Huth wrote:
> The "nps_mtm_hs_ctr" parameter has been removed in commit dd7c7ab01a04
> ("ARC: [plat-eznps]: Drop support for EZChip NPS platform"). Remove it
> from the documentation now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.


> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index dd8436c98735..f58001338860 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4143,15 +4143,6 @@
>  			parameter, xsave area per process might occupy more
>  			memory on xsaves enabled systems.
>  
> -	nps_mtm_hs_ctr=	[KNL,ARC]
> -			This parameter sets the maximum duration, in
> -			cycles, each HW thread of the CTOP can run
> -			without interruptions, before HW switches it.
> -			The actual maximum duration is 16 times this
> -			parameter's value.
> -			Format: integer between 1 and 255
> -			Default: 255
> -
>  	nptcg=		[IA-64] Override max number of concurrent global TLB
>  			purges which is reported from either PAL_VM_SUMMARY or
>  			SAL PALO.

-- 
~Randy

