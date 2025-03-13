Return-Path: <linux-kernel+bounces-559613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BBA5F63A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DA217FFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B0267B15;
	Thu, 13 Mar 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jFO1P1ye"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2782673A4;
	Thu, 13 Mar 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873457; cv=none; b=TncnecbFue6/YgpQM2AYk4QnlFDDSgStV8tF3Q28cJxaiftqz9gfgPf1nrcIIcoG9mewz/Fi7WYXBJq1HzBMxFKVknwUpgstHZM/9EkCM3ioaGA4xNb3nkziEwLcLncoM7wASixGr9/BoBHMq/5JhJpou28CRfxe2K2+Rpbi3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873457; c=relaxed/simple;
	bh=CT6wlOPpNHCYWIJ/2e/j3A8JwuCfLUN6mF49wnM5xX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NHGz0ssNxWF+nqexz3xocONREbZgSIe2pt366Fu9GaKSoknAQNuZ+0NNRw/1RiltPh/DMo0X4dWoy0NkqOtoH6SlINzn6W2MzULBjexRl+v+KM6Gch0N3cFhm7eIpqN1upgnb3TJAPJIz9F/M3cbXRz28yXFK8JsQKu14HsuyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jFO1P1ye; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0CBD44107C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741873455; bh=k2/agbzDqKUzBDvE+7KPIy6SKclCTv5ArfE1MIoAEpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jFO1P1yekmY8vtYCf5g9C65BG3ee3LlQbembIdSYPj7KpuaIUVzVr0TTq8xkxWMEG
	 A2RezUV4e02NLK82VF59t+95xgR4ERumb6/5++A53y08QxAll15sM33ajx8JiIK2XW
	 TnMVZtmqztYhFel7D2qynIItPhGlPnrFhJEnHuXSrnRwZGGExa392iqM8Ly6YA/rfS
	 8cDUhP9uLZ82xxDSLaA6mATBdUaSAr2jMN9rDCH3DizleX/yQwROZaLMNUA9iMK86n
	 ZA9lubh6ioXCPK9Vi6S7dYt76XdxVTVRAbVGUqGZ4O6eHiuX/Kl73gNnZ3NGtPnco5
	 uAjmpoAaJjO9g==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0CBD44107C;
	Thu, 13 Mar 2025 13:44:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: kth <kangtaeho2456@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kth
 <kangtaeho2456@gmail.com>
Subject: Re: [PATCH] docs: Remove outdated highuid.rst documentation
In-Reply-To: <20250313051252.18471-1-kangtaeho2456@gmail.com>
References: <20250313051252.18471-1-kangtaeho2456@gmail.com>
Date: Thu, 13 Mar 2025 07:44:14 -0600
Message-ID: <87tt7xjb9t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kth <kangtaeho2456@gmail.com> writes:

> The highuid.rst document describes a transition that is outdated and no longer relevant. Additionally, it references filesystems (ncpfs and smbfs) that have been removed or replaced.
>
> Signed-off-by: Kang Taeho <kangtaeho2456@gmail.com>
> ---
>  Documentation/admin-guide/highuid.rst | 80 ---------------------------
>  1 file changed, 80 deletions(-)
>  delete mode 100644 Documentation/admin-guide/highuid.rst

We're getting closer, but:

- Please wrap your changelog at <80 columns
- You should copy Willy and put a Suggested-by tag as well
- You need to fix index.rst as well or you'll break the docs build.

Thanks,

jon

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
> -  all ioctl()s. Some new ioctl()s have been added with 32-bit UIDs, but
> -  more are needed. (as well as new user<->kernel data structures)
> -
> -- The ELF core dump format only supports 16-bit UIDs on arm, i386, m68k,
> -  sh, and sparc32. Fixing this is probably not that important, but would
> -  require adding a new ELF section.
> -
> -- The ioctl()s used to control the in-kernel NFS server only support
> -  16-bit UIDs on arm, i386, m68k, sh, and sparc32.
> -
> -- make sure that the UID mapping feature of AX25 networking works properly
> -  (it should be safe because it's always used a 32-bit integer to
> -  communicate between user and kernel)
> -- 
> 2.48.1

