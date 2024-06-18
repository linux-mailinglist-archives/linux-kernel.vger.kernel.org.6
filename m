Return-Path: <linux-kernel+bounces-220313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88190DF92
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FCF2834C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B29117E46A;
	Tue, 18 Jun 2024 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LCBVJ+bh"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EA14D44D;
	Tue, 18 Jun 2024 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752028; cv=none; b=DwFBtqzdzUrvySX2wTWBKMEEPiPoOghu4VsadHFHSsSQ3y5CudKIXhhULPP1ksJZQh8wQ0HSUuLqq/hpL4A55Uye4FfdL3GnC9kB96dfeUFOhu5uFMtAyj0FfU8EnfVAmU16+Z3EU1eVVPMOeQdTswM00nLpL51aHocGS6pXuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752028; c=relaxed/simple;
	bh=rLHj80WUE2+fqZKOctbyThli+33cV0baGHwwVi3cLXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imEn61cMVXnLcudivqB06Q2RGmMY2fEmWAMBnJ2lUrNlvIARE3EPFffsodXzaGbJd6kFSYi6P0e99Ih/VptBThjKMzLNo/OG8B4OaugAQ4sbI51fCH6NL0CM8GFd/mg3fzyBvYlCCnebxaBnygN4mtSMKtRS+70Of/i02+PJHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LCBVJ+bh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4IXDZGrTHOCcVijFhNelt76fRUU2bbr5+gSV3CvtiIo=; b=LCBVJ+bh4tBuAHjdDGmmou7SM3
	MwksOS2BUYQykQcSDDFaUswwdG7U4uwIyKefauUnHRNUXIs60h4QofxhGlZeAil62MJSM+q3f/wc3
	MFmJYYBS445uM9UAyZ2lshOWqBJmQcwtoTV/+yddy7HIzNTKKD5PrmptCaRh5N3m+kH0+23Sn0pf1
	VkHRktbb1t/X0rCb6UYuYCcUTibHvfAkIxl2Oi1NMbnigNKC8XMA8T/sqUINFcRYZS3hD0pyDIRGb
	GxeKoBnHcjpIjE2V90sTSwhx1/7VzIXAGxzDAtAAtgzR+y4788uJqZZSJ/sUGcRNCIuhh7dVdPPMU
	hK7bO3Uw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJhul-0000000Gqb4-0Ly7;
	Tue, 18 Jun 2024 23:06:59 +0000
Message-ID: <b5c1536b-1d8e-4d57-aeda-c5d06a2793bd@infradead.org>
Date: Tue, 18 Jun 2024 16:06:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] arm64: add attrs and format to ptdump document
To: Maxwell Bland <mbland@motorola.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
 <2hhihkaeeyyy3xj22mjdx44zlied2sp4mfewj7y6ffrnakw7cy@3fuds6n7f4ew>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2hhihkaeeyyy3xj22mjdx44zlied2sp4mfewj7y6ffrnakw7cy@3fuds6n7f4ew>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,-

On 6/18/24 7:43 AM, Maxwell Bland wrote:
> Update the ptdump content with a precise explanation of the attribute
> symbols and the identical-entry coalescing implicit in the code.
> 
> Remove unnecessary layout example given the existing cat example,
> and opt instead for a precise, clear explantination of address markers,

                                       explanation

> format, attributes.
> 
> Update example to match the new cosmetic and intermediate-directory
> printing changes.
> 
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
>  Documentation/arch/arm64/ptdump.rst | 126 ++++++++++++++--------------
>  1 file changed, 61 insertions(+), 65 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
> index 5dcfc5d7cddf..fee7600dd4d1 100644
> --- a/Documentation/arch/arm64/ptdump.rst
> +++ b/Documentation/arch/arm64/ptdump.rst
> @@ -29,68 +29,64 @@ configurations and mount debugfs::
>   mount -t debugfs nodev /sys/kernel/debug
>   cat /sys/kernel/debug/kernel_page_tables
>  
> -On analysing the output of ``cat /sys/kernel/debug/kernel_page_tables``
> -one can derive information about the virtual address range of the entry,
> -followed by size of the memory region covered by this entry, the
> -hierarchical structure of the page tables and finally the attributes
> -associated with each page. The page attributes provide information about
> -access permissions, execution capability, type of mapping such as leaf
> -level PTE or block level PGD, PMD and PUD, and access status of a page
> -within the kernel memory. Assessing these attributes can assist in
> -understanding the memory layout, access patterns and security
> -characteristics of the kernel pages.
> -
> -Kernel virtual memory layout example::
> -
> - start address        end address         size             attributes
> - +---------------------------------------------------------------------------------------+
> - | ---[ Linear Mapping start ]---------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xfff0000000000000-0xfff0000000210000  2112K PTE RW NX SHD AF  UXN  MEM/NORMAL-TAGGED |
> - | 0xfff0000000210000-0xfff0000001c00000 26560K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
> - | ..................                                                                    |
> - | ---[ Linear Mapping end ]------------------------------------------------------------ |
> - +---------------------------------------------------------------------------------------+
> - | ---[ Modules start ]----------------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xffff800000000000-0xffff800008000000   128M PTE                                      |
> - | ..................                                                                    |
> - | ---[ Modules end ]------------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> - | ---[ vmalloc() area ]---------------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xffff800008010000-0xffff800008200000  1984K PTE ro x  SHD AF       UXN  MEM/NORMAL   |
> - | 0xffff800008200000-0xffff800008e00000    12M PTE ro x  SHD AF  CON  UXN  MEM/NORMAL   |
> - | ..................                                                                    |
> - | ---[ vmalloc() end ]----------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> - | ---[ Fixmap start ]------------------------------------------------------------------ |
> - | ..................                                                                    |
> - | 0xfffffbfffdb80000-0xfffffbfffdb90000    64K PTE ro x  SHD AF  UXN  MEM/NORMAL        |
> - | 0xfffffbfffdb90000-0xfffffbfffdba0000    64K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
> - | ..................                                                                    |
> - | ---[ Fixmap end ]-------------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> - | ---[ PCI I/O start ]----------------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xfffffbfffe800000-0xfffffbffff800000    16M PTE                                      |
> - | ..................                                                                    |
> - | ---[ PCI I/O end ]------------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> - | ---[ vmemmap start ]----------------------------------------------------------------- |
> - | ..................                                                                    |
> - | 0xfffffc0002000000-0xfffffc0002200000     2M PTE RW NX SHD AF  UXN  MEM/NORMAL        |
> - | 0xfffffc0002200000-0xfffffc0020000000   478M PTE                                      |
> - | ..................                                                                    |
> - | ---[ vmemmap end ]------------------------------------------------------------------- |
> - +---------------------------------------------------------------------------------------+
> -
> -``cat /sys/kernel/debug/kernel_page_tables`` output::
> -
> - 0xfff0000001c00000-0xfff0000080000000     2020M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
> - 0xfff0000080000000-0xfff0000800000000       30G PMD
> - 0xfff0000800000000-0xfff0000800700000        7M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
> - 0xfff0000800700000-0xfff0000800710000       64K PTE  ro NX SHD AF   UXN    MEM/NORMAL-TAGGED
> - 0xfff0000800710000-0xfff0000880000000  2089920K PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
> - 0xfff0000880000000-0xfff0040000000000     4062G PMD
> - 0xfff0040000000000-0xffff800000000000     3964T PGD
> +``/sys/kernel/debug/kernel_page_tables`` provides a line of information
> +for each group of page table entries sharing the same attributes and
> +type of mapping, i.e. leaf level PTE or block level PGD, PMD, and PUD.
> +Assessing these attributes can assist in determining memory layout,
> +access patterns and security characteristics of the kernel pages.
> +
> +Lines are formatted as follows::
> +
> + <start_vaddr>-<end_vaddr> <size> <type> <attributes>
> +
> +Note that the set of attributes, and therefore formatting, is not
> +equivalent between leaf and non-leaf entries. For example, PMD entries
> +can support the PXNTable permission bit and do not share that same set
> +of attributes as leaf level PTE entries.
> +
> +The following attributes are presently supported::
> +
> +F		Entry is invalid
> +USER		Memory is user mapped
> +ro		Memory is read-only
> +RW		Memory is read-write
> +NX		Memory is privileged execute never
> +x               Memory is privileged executable

Please use tabs above for indentation, like the other lines.

Why lower case x and ro but upper case for the others?

> +SHD		Memory is shared
> +AF		Entry accessed flag is set
> +NG		Entry Not-Global flag is set
> +CON		Entry contiguous bit is set
> +UXN		Memory is unprivileged execute never
> +GP		Memory supports BTI

Most of the abbreviations make some sense, but not that one (IMHO). ;)

> +TBL		Entry is a table descriptor
> +BLK		Entry is a block descriptor
> +NXTbl		Entry's referenced table is PXN
> +UXNTbl		Entry's referenced table is unprivileged execute never
> +DEVICE/*	Entry is device memory, see ARM reference for types
> +MEM/*		Entry is non-device memory, see ARM reference for types
> +
> +The beginning and end of each region is also delineated by a single line
> +tag in the following format::
> +
> + ---[ <marker_name> ]---
> +
> +With supported address markers including the kernel's linear mapping,
> +kasan shadow memory, kernel modules memory, vmalloc memory, PCI I/O
> +memory, and the kernel's fixmap region.
> +
> +Example ``cat /sys/kernel/debug/kernel_page_tables`` output::
> +
> +---[ Linear Mapping start ]---
> +0xffff000000000000-0xffff31ffffffffff                  50T PGD
> +0xffff320000000000-0xffffffffffffffff                 206T PGD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +    0xffff320000000000-0xffff3251ffffffff             328G PUD
> +    0xffff325200000000-0xffff32523fffffff               1G PUD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +      0xffff325200000000-0xffff3252001fffff             2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +        0xffff325200000000-0xffff3252001fffff           2M PTE       RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
> +      0xffff325200200000-0xffff3252003fffff             2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +        0xffff325200200000-0xffff32520020ffff          64K PTE       RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
> +        0xffff325200210000-0xffff3252003fffff        1984K PTE       ro NX SHD AF NG     UXN    MEM/NORMAL
> +      0xffff325200400000-0xffff325201dfffff            26M PMD   BLK     ro SHD AF NG     NX UXN                 MEM/NORMAL
> +      0xffff325201e00000-0xffff325201ffffff             2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
> +        0xffff325201e00000-0xffff325201e0ffff          64K PTE       ro NX SHD AF NG     UXN    MEM/NORMAL
> +        0xffff325201e10000-0xffff325201ffffff        1984K PTE       RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED

-- 
thanks.
~Randy

