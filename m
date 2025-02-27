Return-Path: <linux-kernel+bounces-536039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E38CA47ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0C57A4E96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB12288EA;
	Thu, 27 Feb 2025 10:50:07 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE63229B3D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653407; cv=none; b=Ep+DRxnWbdQyGWW/64P7Cfly6+nAvYm79F5jCdiaJvryP2b0AI7qTANteE9KhRJHuonLsY7iGR/GyNlA7ho45VRLkJfOHCWAZigUrON08SokQfgkCuq0W+ASwbGpln7sjI5zuAAS9FHeokPmV7tUu8jEs0lzAmILC7rS41fDTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653407; c=relaxed/simple;
	bh=8Kue5vKoWcrKUCPynboAO77snDty2/k6whOjPiw3T5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqvOJatuW2VG7pE0MJfyHgc3Uth3wnwQvihpXRAnvTpIh/NsaAI6V2ckQWVRv0m6WT+49ZrFnXpwyzLPpGhrBwnlbmrPN4Y16LyXirDPTjb0ssML6tj0ycub8R5z6nbwyxvSMWa3cUrmXCVrQz/TeMC0NxhE5hAgIkcUNixA//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z3Sbn5St3z9sSL;
	Thu, 27 Feb 2025 11:43:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C4gdvXulG1Jk; Thu, 27 Feb 2025 11:43:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z3Sbn4H0wz9sSK;
	Thu, 27 Feb 2025 11:43:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 821678B78B;
	Thu, 27 Feb 2025 11:43:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6TaA5rIuABxG; Thu, 27 Feb 2025 11:43:01 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E0CF28B77C;
	Thu, 27 Feb 2025 11:43:00 +0100 (CET)
Message-ID: <14193c98-fb30-4ee8-a19a-fe85d1230d74@csgroup.eu>
Date: Thu, 27 Feb 2025 11:43:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20250226]Build Failure
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>
References: <adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com>
 <20250227123804.5dd71cef@canb.auug.org.au>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250227123804.5dd71cef@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/02/2025 à 02:38, Stephen Rothwell a écrit :
> Hi Venkat,
> 
> CC Kees Cook for advice.  This is a result of the tests added in commit
> 
>    bbeb38b8487a ("string.h: Validate memtostr*()/strtomem*() arguments more carefully")
> 
> from the kspp tree.
> 
> I note that the comment about memtostr() says "Copy a possibly
> non-NUL-term string".

Can you tell more about your config and your environment ?

I just tested with ppc64_defconfig and ppc64le_defconfig, with gcc 12.4, 
gcc 13.2 and gcc 14.2 and didn't get that build error.

Christophe

> 
> On Thu, 27 Feb 2025 06:30:12 +0530 Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com> wrote:
>>
>> I am seeing build failures with kernel next-20250226, on IBM Power8 systems.
>>
>> Failures:
>>
>> In file included from ./include/asm-generic/div64.h:27,
>>                    from ./arch/powerpc/include/generated/asm/div64.h:1,
>>                    from ./include/linux/math.h:6,
>>                    from ./include/linux/math64.h:6,
>>                    from ./include/linux/time.h:6,
>>                    from fs/ext4/file.c:22:
>> fs/ext4/file.c: In function 'ext4_sample_last_mounted':
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:418:6: note: in expansion of macro '__must_be_noncstr'
>>         __must_be_noncstr(dest) +  \
>>         ^~~~~~~~~~~~~~~~~
>> fs/ext4/file.c:869:2: note: in expansion of macro 'strtomem_pad'
>>     strtomem_pad(sbi->s_es->s_last_mounted, cp, 0);
>>     ^~~~~~~~~~~~
>> In file included from ./include/linux/build_bug.h:5,
>>                    from ./include/linux/container_of.h:5,
>>                    from ./include/linux/list.h:5,
>>                    from ./include/linux/module.h:12,
>>                    from drivers/message/fusion/mptsas.c:46:
>> drivers/message/fusion/mptsas.c: In function 'mptsas_exp_repmanufacture_info':
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/message/fusion/mptsas.c:2968:3: note: in expansion of macro 'memtostr'
>>      memtostr(edev->vendor_id, manufacture_reply->vendor_id);
>>      ^~~~~~~~
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/message/fusion/mptsas.c:2969:3: note: in expansion of macro 'memtostr'
>>      memtostr(edev->product_id, manufacture_reply->product_id);
>>      ^~~~~~~~
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/message/fusion/mptsas.c:2970:3: note: in expansion of macro 'memtostr'
>>      memtostr(edev->product_rev, manufacture_reply->product_rev);
>>      ^~~~~~~~
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/message/fusion/mptsas.c:2973:4: note: in expansion of macro 'memtostr'
>>       memtostr(edev->component_vendor_id,
>>       ^~~~~~~~
>> make[4]: *** [scripts/Makefile.build:203: fs/ext4/file.o] Error 1
>> make[3]: *** [scripts/Makefile.build:461: fs/ext4] Error 2
>> make[3]: *** Waiting for unfinished jobs....
>> In file included from ./include/linux/array_size.h:5,
>>                    from ./include/linux/kernel.h:16,
>>                    from drivers/scsi/mpt3sas/mpt3sas_base.c:46:
>> drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_display_ioc_capabilities':
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_base.c:4798:2: note: in expansion of macro 'memtostr'
>>     memtostr(desc, ioc->manu_pg0.ChipName);
>>     ^~~~~~~~
>> In file included from ./include/linux/build_bug.h:5,
>>                    from ./include/linux/container_of.h:5,
>>                    from ./include/linux/list.h:5,
>>                    from ./include/linux/module.h:12,
>>                    from drivers/scsi/mpt3sas/mpt3sas_transport.c:45:
>> drivers/scsi/mpt3sas/mpt3sas_transport.c: In function '_transport_expander_report_manufacture':
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_transport.c:461:3: note: in expansion of macro 'memtostr'
>>      memtostr(edev->vendor_id, manufacture_reply->vendor_id);
>>      ^~~~~~~~
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_transport.c:462:3: note: in expansion of macro 'memtostr'
>>      memtostr(edev->product_id, manufacture_reply->product_id);
>>      ^~~~~~~~
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_transport.c:463:3: note: in expansion of macro 'memtostr'
>>      memtostr(edev->product_rev, manufacture_reply->product_rev);
>>      ^~~~~~~~
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/scsi/mpt3sas/mpt3sas_transport.c:466:4: note: in expansion of macro 'memtostr'
>>       memtostr(edev->component_vendor_id,
>>       ^~~~~~~~
>> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/mpt3sas/mpt3sas_transport.o] Error 1
>> make[5]: *** Waiting for unfinished jobs....
>> make[5]: *** [scripts/Makefile.build:203: drivers/message/fusion/mptsas.o] Error 1
>> make[4]: *** [scripts/Makefile.build:461: drivers/message/fusion] Error 2
>> make[3]: *** [scripts/Makefile.build:461: drivers/message] Error 2
>> make[3]: *** Waiting for unfinished jobs....
>> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/mpt3sas/mpt3sas_base.o] Error 1
>> In file included from ./include/linux/array_size.h:5,
>>                    from ./include/linux/kernel.h:16,
>>                    from drivers/scsi/qla2xxx/qla_def.h:9,
>>                    from drivers/scsi/qla2xxx/qla_mr.c:6:
>> drivers/scsi/qla2xxx/qla_mr.c: In function 'qlafx00_fx_disc':
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/scsi/qla2xxx/qla_mr.c:1912:3: note: in expansion of macro 'memtostr'
>>      memtostr(vha->hw->model_number, pinfo->model_num);
>>      ^~~~~~~~
>> ./include/linux/compiler.h:197:62: error: static assertion failed: "must be non-C-string (not NUL-terminated)"
>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>> ^~~~~~~~~~~~~~
>> ./include/linux/compiler.h:226:2: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/string.h:468:26: note: in expansion of macro '__must_be_noncstr'
>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>                             ^~~~~~~~~~~~~~~~~
>> drivers/scsi/qla2xxx/qla_mr.c:1913:3: note: in expansion of macro 'memtostr'
>>      memtostr(vha->hw->model_desc, pinfo->model_description);
>>      ^~~~~~~~
>> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/qla2xxx/qla_mr.o] Error 1
>> make[5]: *** Waiting for unfinished jobs....
>> make[2]: *** [scripts/Makefile.build:461: fs] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>> make[4]: *** [scripts/Makefile.build:461: drivers/scsi/mpt3sas] Error 2
>> make[4]: *** Waiting for unfinished jobs....
>> make[4]: *** [scripts/Makefile.build:461: drivers/scsi/qla2xxx] Error 2
>> make[3]: *** [scripts/Makefile.build:461: drivers/scsi] Error 2
>> make[2]: *** [scripts/Makefile.build:461: drivers] Error 2
>> make[1]: *** [/root/linux-next/Makefile:1989: .] Error 2
>> make: *** [Makefile:251: __sub-make] Error 2
> 


