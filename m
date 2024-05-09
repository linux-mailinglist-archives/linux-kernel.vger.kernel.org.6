Return-Path: <linux-kernel+bounces-174181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F98C0B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF54F284272
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E31494CF;
	Thu,  9 May 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="HJ9zPNnf"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB038DE8;
	Thu,  9 May 2024 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235249; cv=none; b=FjeFCwVVvuIcjn4QuaiOmOZwVH7HwsEdK2aJtrNvpjwnZY3T1xtCX375xZ3nqTc2TUBhKY5ESpsQqEvX5+XVoo47hkHISyHB7xi+f5BHu62dILvKz+9pT3Lg+ufsRo4o12MB7QteCsvoKC6tNCVPBnsmFjUuL0POH0/a2ARuhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235249; c=relaxed/simple;
	bh=QYR7FQSzflMl02x3EHkzc1NCSjKQZS01IgABrg3Sr7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/is2jnGsCeID2jHggAYQFHgx5BGz7qgsrJ+pTWeZEqPG3GZCspowYAf3rfqrs5v8RBNSkOjVk+WgzJb2w/LCHT7yJTlO0fIvDf3USEcqE0BtCKIcqmjFv6DBeJ5yezMu2LlLtgs6jNaBAFtBcOKJHj0L3tkjenxjwTXGmGBSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=HJ9zPNnf; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id A9B711C3C22;
	Thu,  9 May 2024 08:14:04 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1715235244; bh=XnGVkB+JK91sRm39Se2mrNg2YZvLilXPU0QS5y1cFVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HJ9zPNnf8lEy+4nhlIBmwsFd9frmQiCOS9vjgrT6TUd8gcc8ZJ7zizF3iHRYXAWJk
	 mF1FWcdjfL87AFN40rAp5KlgzLCAyhQgHvPm5d+Y8QQw4fuY3IwjcYWy0ZQWTcq0da
	 SeSRnSliD59uktnfG8ey9HIKM+pn1KTxjX9twwyA7OLzoloOmdw/fZNaT9EI0WjRrX
	 MReMUmdD28edaGsTSyLyQNbcMDaj9LSzRZqi3wwWl3kL6BBwbh4rNd3J25LzyMSv71
	 QO+CKrUZkI4ENc1wXE48vS4KTaTzt8IgZbs/8BYtvQ8ZoT8/VgjxGF+bo1pmN9q5YG
	 e0wWUHmw8xszA==
Date: Thu, 9 May 2024 08:14:03 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet
 <corbet@lwn.net>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 mhklinux@outlook.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] doc: swiotlb: Document SWIOTLB areas parameter
Message-ID: <20240509081403.28c424d5@meshulam.tesarici.cz>
In-Reply-To: <20240507013502.3095744-2-tjmercier@google.com>
References: <20240507013502.3095744-1-tjmercier@google.com>
	<20240507013502.3095744-2-tjmercier@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 01:34:59 +0000
"T.J. Mercier" <tjmercier@google.com> wrote:

> Commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock") added
> the ability to specify the number of SWIOTLB areas, but boot-options.rst
> was not updated as part of that commit.
> 
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Fixes: 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  Documentation/arch/x86/x86_64/boot-options.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
> index a37139d1752f..18161657b301 100644
> --- a/Documentation/arch/x86/x86_64/boot-options.rst
> +++ b/Documentation/arch/x86/x86_64/boot-options.rst
> @@ -287,9 +287,11 @@ iommu options only relevant to the AMD GART hardware IOMMU:
>  iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
>  implementation:
>  
> -    swiotlb=<slots>[,force,noforce]
> +    swiotlb=<slots>[,<areas>,force,noforce]

This is not quite how this parameter is parsed. All the following
specifications are valid:

- swiotlb=512        // only slots
- swiotlb=,4         // only areas
- swiotlb=512,4      // slots and areas
- swiotlb=force      // default size
- swiotlb=512,force  // default areas
- swiotlb=512,4,force // explicitly specify everything

I believe the syntax should be somethig like:

  swiotlb={ | [<slots>][,<areas>],}{ force | noforce }

Petr T

>        <slots>
>          Prereserve that many 2K slots for the software IO bounce buffering.
> +      <areas>
> +        Number of SWIOTLB areas with their own lock. Must be a power of 2.
>        force
>          Force all IO through the software TLB.
>          Hardware IOMMU implementations can use SWIOTLB bounce buffering in


