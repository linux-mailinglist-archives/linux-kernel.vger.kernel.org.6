Return-Path: <linux-kernel+bounces-565157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECE7A661EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9171E17823C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA491FE45F;
	Mon, 17 Mar 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BDkm0Wav"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E071F941;
	Mon, 17 Mar 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251566; cv=none; b=qtVJJdIs/S1+RyrIU+O44SRLp6pctfYv/sxJEEajTcSEWbgjXlLsZOLL/+4jhbBmr05VlPj5hw5s6kHlqikiiOL164OojX05Wg8ubHZYxKrvcxk6wxQjjLngvL/bOdJH4oUOWCdLlvU2CyYWhHXEX49m+16Rcv5Oi/c0ji3RzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251566; c=relaxed/simple;
	bh=t7bFOkiAGVi6XPW6GNWw26eWipIu6SUPj59NMISco94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KrEeMGkjVkTux3v+MdE2gOJUDZsSvG27t7M6JeyMGZU8KK4QN2maKwdrUpeb4OTx1LskyOcc36JrhWgINLO5s8NVDIR70hKp+5qhNZrsmhVp9X19L/Epj95nz8iB/NdE/mwh9l1kHMCDYZfCNQ4XxEfb0YpZ7E43rzgIu+wUbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BDkm0Wav; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 87AD141061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742251557; bh=HuAmXrHMyFgzYYzV4NEx6cMVyHaLuixo/yumJ8pls+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BDkm0WavK4tk3G7mOgJnsZ2QDLCXownkn3fOcCENfC4VEa1pQsSzFpMmkdJWbYwXI
	 4AV9IANTgkLzOhvy7Il1G4fs2mFvuy946W91GVf+QbV9oFMNQrFPGDXHC+cVtzmzmL
	 DKv0/K5WZk+Ii72s7/GWP1Sq2QmDW3OebqLBN/2nzemrKQJ+p1fK7Vt+f7AH28qe/7
	 RMtqBXMuhNwiWzuMeNKMRwltTLEzH9rAuF7cN5o1P8aSg1eij3N9qyK3kwVgdC/Wom
	 aGwPmbEPD8+mFezqh9lIqgJY0yMHEdlHz9W5m8872UdylxY8mznkAuREB+cbIhCkfq
	 m17uzs0f6VhIw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 87AD141061;
	Mon, 17 Mar 2025 22:45:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: kth <kangtaeho2456@gmail.com>
Cc: willy@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kth <kangtaeho2456@gmail.com>
Subject: Re: [PATCH v2] docs: Remove outdated highuid.rst documentation
In-Reply-To: <20250313145650.278346-1-kangtaeho2456@gmail.com>
References: <20250313145650.278346-1-kangtaeho2456@gmail.com>
Date: Mon, 17 Mar 2025 16:45:56 -0600
Message-ID: <87h63re0nv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kth <kangtaeho2456@gmail.com> writes:

> The highuid.rst document describes a transition that is outdated and no
> longer relevant. Additionally, it references filesystems (ncpfs and smbfs),
> which have been removed or replaced.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Kang Taeho <kangtaeho2456@gmail.com>
> ---
>  Documentation/admin-guide/highuid.rst | 80 ---------------------------
>  Documentation/admin-guide/index.rst   |  1 -
>  2 files changed, 81 deletions(-)
>  delete mode 100644 Documentation/admin-guide/highuid.rst

OK, I have applied this, but it was some work.  For future reference:

- When you do a v2 (or whatever), always include a description of what
  changed since the previous version under the "---" line.

- Before sending another patch, email it to yourself and be sure that
  you can apply what you receive.  This patch was whitespace damaged,
  but that is not all ...

>
> diff --git a/Documentation/admin-guide/highuid.rst b/Documentation/admin-guide/highuid.rst
> deleted file mode 100644
> index 9239067563a1..000000000000
> --- a/Documentation/admin-guide/highuid.rst
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -===================================================
> -Notes on the change from 16-bit UIDs to 32-bit UIDs
> -===================================================
> -
> -:Author: Chris Wing <wingc@umich.edu>
> -:Last updated: January 11, 2000
> -
> -- kernel code MUST take into account __kernel_uid_t and __kernel_uid32_t
> -  when communicating between user and kernel space in an ioctl or data
> -  structure.
> -
> -- kernel code should use uid_t and gid_t in kernel-private structures and
> -  code.
> -
> -What's left to be done for 32-bit UIDs on all Linux architectures:
> -
> -- Disk quotas have an interesting limitation that is not related to the
> -  maximum UID/GID. They are limited by the maximum file size on the
> -  underlying filesystem, because quota records are written at offsets
> -  corresponding to the UID in question.
> -  Further investigation is needed to see if the quota system can cope
> -  properly with huge UIDs. If it can deal with 64-bit file offsets on all 
> -  architectures, this should not be a problem.
> -
> -- Decide whether or not to keep backwards compatibility with the system
> -  accounting file, or if we should break it as the comments suggest
> -  (currently, the old 16-bit UID and GID are still written to disk, and
> -  part of the former pad space is used to store separate 32-bit UID and
> -  GID)
> -
> -- Need to validate that OS emulation calls the 16-bit UID
> -  compatibility syscalls, if the OS being emulated used 16-bit UIDs, or
> -  uses the 32-bit UID system calls properly otherwise.
> -
> -  This affects at least:
> -
> -	- iBCS on Intel
> -
> -	- sparc32 emulation on sparc64
> -	  (need to support whatever new 32-bit UID system calls are added to
> -	  sparc32)
> -
> -- Validate that all filesystems behave properly.
> -
> -  At present, 32-bit UIDs _should_ work for:
> -
> -	- ext2
> -	- ufs
> -	- isofs
> -	- nfs
> -	- coda
> -	- udf
> -
> -  Ioctl() fixups have been made for:
> -
> -	- ncpfs
> -	- smbfs
> -
> -  Filesystems with simple fixups to prevent 16-bit UID wraparound:
> -
> -	- minix
> -	- sysv
> -	- qnx4
> -
> -  Other filesystems have not been checked yet.
> -
> -- The ncpfs and smbfs filesystems cannot presently use 32-bit UIDs in

This line here     ^^^^^   contains your previous attempted fix; that,
too, caused the patch to fail to apply.  I had to hand edit it to get
past that.

Thanks,

jon

