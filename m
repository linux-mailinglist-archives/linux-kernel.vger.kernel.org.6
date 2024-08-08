Return-Path: <linux-kernel+bounces-279356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DF094BC33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014D81C21044
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F3018B475;
	Thu,  8 Aug 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="u575P61E"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5A12C7FD
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116269; cv=none; b=mjdRPgcdcnY/qoZBXC0jw3y+G/9mqfTKIbspLLAUlA8uHDWgU/o9x2Uf3ZaGB9c4ivM3ol34Pn8/ihJhD7aZFdLllxZRPwQPQWc1PFt6tRZcN1WzB8kmbe1XncT4xjI4v3dRxPs7zJUzojScpcLodgcZImxmOy2pPOXemxM3DWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116269; c=relaxed/simple;
	bh=VeVj0Piz/t4SI8SJ4CkIQJziHUTFj1bQqKnv/mDnf2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRGWpfK+d6+ovhYnJ0bD3Y6nR4ypPvbU76UphsSqCjr958GWi5VwfRPdxnEz3yA66HJ5dZfeqM3DO8M1UPaItnUUbOZHFaviqY3F7Jdr2V2dRpL8SGFo9yGS2PFAN0ROBW3SgNLb+M0Sml/SJFtWYI+Cj+ZNUY8vmeX1qC4J0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=u575P61E; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 477831D4DE1;
	Thu,  8 Aug 2024 13:24:24 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723116264; bh=oxYbYN2Mz8ixrMDkxJac4yjjhQ3W1I56nPlRCKBOi98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u575P61E87M/BWliYygQAQzNdqCpWX5mQfndINSrY9sqCM6Ih+NlOCPeUzzJ7LY9D
	 Guxqb0VT3HvrWgzxbA2zWw9CZ4UxMjVhJZII6HiRDG6DiTukh4FmZqTzGPtBMfrPCG
	 a5nkkuFSFNrSxmHgfKxA7PQJECNgHHin2ViNz/lIbhVmQZ7U+Jfc60tnQPzbzidTS4
	 DwQelkG0R9+71o6d4RuCUwFWLenWl+MOuHV7QiUV3SvbmH7zd/u8gcvEDPLYDtYpjR
	 w2lg8pOVlgsFNqOXDS8PF6mXg0itfu8eae9hVqFa6w1rraU9c8wS3jyhneU4NbRQ6a
	 Jnn1H/Cw4qzag==
Date: Thu, 8 Aug 2024 13:24:23 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: bhe@redhat.com, Hari Bathini <hbathini@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH] Document/kexec: Generalize crash hotplug description
Message-ID: <20240808132423.0f313ffe@meshulam.tesarici.cz>
In-Reply-To: <20240805050829.297171-1-sourabhjain@linux.ibm.com>
References: <20240805050829.297171-1-sourabhjain@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Sourabh,

sorry for late reply, was on vacation and then catching up...

On Mon,  5 Aug 2024 10:38:29 +0530
Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Commit 79365026f869 ("crash: add a new kexec flag for hotplug support")
> generalizes the crash hotplug support to allow architectures to update
> multiple kexec segments on CPU/Memory hotplug and not just elfcorehdr.
> Therefore, update the relevant kernel documentation to reflect the same.
> 
> No functional change.
> 
> Cc: Petr Tesarik <petr@tesarici.cz>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> 
> Discussion about the documentation update:
> https://lore.kernel.org/all/68d0328d-531a-4a2b-ab26-c97fd8a12e8b@linux.ibm.com/
> 
> ---
>  .../ABI/testing/sysfs-devices-memory          |  6 ++--
>  .../ABI/testing/sysfs-devices-system-cpu      |  6 ++--
>  .../admin-guide/mm/memory-hotplug.rst         |  5 ++--
>  Documentation/core-api/cpu_hotplug.rst        | 10 ++++---
>  kernel/crash_core.c                           | 29 ++++++++++++-------
>  5 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
> index a95e0f17c35a..421acc8e2c6b 100644
> --- a/Documentation/ABI/testing/sysfs-devices-memory
> +++ b/Documentation/ABI/testing/sysfs-devices-memory
> @@ -115,6 +115,6 @@ What:		/sys/devices/system/memory/crash_hotplug
>  Date:		Aug 2023
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:
> -		(RO) indicates whether or not the kernel directly supports
> -		modifying the crash elfcorehdr for memory hot un/plug and/or
> -		on/offline changes.
> +		(RO) indicates whether or not the kernel update of kexec
> +		segments on memory hot un/plug and/or on/offline events,
> +		avoiding the need to reload kdump kernel.

This sentence somehow lacks a verb. My suggestion:

  (RO) indicates whether or not the kernel updates relevant kexec
  segments on memory hot un/plug and/or on/offline events, avoiding the
  need to reload kdump kernel.

> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 325873385b71..f4ada1cd2f96 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -703,9 +703,9 @@ What:		/sys/devices/system/cpu/crash_hotplug
>  Date:		Aug 2023
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:
> -		(RO) indicates whether or not the kernel directly supports
> -		modifying the crash elfcorehdr for CPU hot un/plug and/or
> -		on/offline changes.
> +		(RO) indicates whether or not the kernel update of kexec
> +		segments on CPU hot un/plug and/or on/offline events,
> +		avoiding the need to reload kdump kernel.

Same as above.

Otherwise LGTM.

Petr T

