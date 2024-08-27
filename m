Return-Path: <linux-kernel+bounces-303457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D1960C48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435D5B288A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2B1C2DCD;
	Tue, 27 Aug 2024 13:38:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77831A00EE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765897; cv=none; b=gl7rBqymr+ED8rvHi99fFodRRGRMOA+Qg8yU8e8oVadYt0PfqRqjM2CkK2DeAuNO1hJc/vWZcmlXakBOnLHL984Es34uOlxkgTm5R73nOYKZvqGEkXkKmt3+ZHfZ+nq41JyqkJUJs39pIZXoVXLOeoH6IYuZVVBMIdoYdu6/SEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765897; c=relaxed/simple;
	bh=ERLthtgB5hPtkdxFxq7l3sdLVXMzX7gZyoAKnGd3MU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxvOkoxj3RTJKBJT8Oe3GEyefk9ojABeM8NGqEYzSbZinwH3+A2wvV4z70I6bKjbgqUZUAKF4df4qyHDgnsrCLSTIXpbmN+NUuqNf3xkOOte6+Z5bF3eofocC9tpUCT1+Kz3NWNLwoL7lGTLFWdrF0xSh/MJ5waSqLWheJGBv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B1311FB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:38:41 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9D7F3F66E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:38:14 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:38:04 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Aryabhatta Dey <aryabhattadey35@gmail.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/gpu: Fix typo in
 Documentation/gpu/komeda-kms.rst
Message-ID: <Zs3WvKCbvqCrIO0G@e110455-lin.cambridge.arm.com>
References: <l5wzytcamcc43eadaquqbrfqilq6ajfnnseh37c77eceamtw35@hhtdipi4h22c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l5wzytcamcc43eadaquqbrfqilq6ajfnnseh37c77eceamtw35@hhtdipi4h22c>

On Tue, Aug 27, 2024 at 06:48:52PM +0530, Aryabhatta Dey wrote:
> Change 'indenpendently' to 'independently'.
> 
> Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patch!

Jonathan, is that something you can pick up in your tree?

Best regards,
Liviu

> ---
>  Documentation/gpu/komeda-kms.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/komeda-kms.rst b/Documentation/gpu/komeda-kms.rst
> index 633a016563ae..eaea40eb725b 100644
> --- a/Documentation/gpu/komeda-kms.rst
> +++ b/Documentation/gpu/komeda-kms.rst
> @@ -86,7 +86,7 @@ types of working mode:
>  -   Single display mode
>      Two pipelines work together to drive only one display output.
>  
> -    On this mode, pipeline_B doesn't work indenpendently, but outputs its
> +    On this mode, pipeline_B doesn't work independently, but outputs its
>      composition result into pipeline_A, and its pixel timing also derived from
>      pipeline_A.timing_ctrlr. The pipeline_B works just like a "slave" of
>      pipeline_A(master)
> -- 
> 2.46.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

