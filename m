Return-Path: <linux-kernel+bounces-536558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C382A48179
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE22819C3D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618F2356BB;
	Thu, 27 Feb 2025 14:20:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F023537B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666006; cv=none; b=C9nPJlkUsycCF/wOJZtkw+WgooEJYsXwLT9TisHTjFZ4jufDeMQeALMuShuBP42vFyG93iCqlkE4s7cgYJT7GK1Mdctz5IB2+MK55e9qXWcCj5NgJRcZJJXsJNE3/0aTL2GNRsVSYyqK/lJkYhZoaESyVrnJB7XwsbVjQEThRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666006; c=relaxed/simple;
	bh=VJ9a2I2tdri2oG7eNa0CP97r/I72geitmY2RwREjDNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqHXqUpL8FzVHvgay0d9iF7uodyzZ3pxBTzSVVgKWjkKG33biDZ2wZYq5UjY/0oJJTLhc+LMMmyj5VrfAah4LvWGRaVqBoqoMamlVqjvEJSK5QxeHmS34mP6ciP2bEmpwbC9TdRs/JKMm0gaQn4RazahHt6/ilnphjKZTEsRbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z3Y843xhSz9sSN;
	Thu, 27 Feb 2025 15:07:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FP5Z442qQhRv; Thu, 27 Feb 2025 15:07:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z3Y842nk2z9sSC;
	Thu, 27 Feb 2025 15:07:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C49D8B78B;
	Thu, 27 Feb 2025 15:07:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id cZKqapAsXdTe; Thu, 27 Feb 2025 15:07:48 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AE4CE8B77C;
	Thu, 27 Feb 2025 15:07:47 +0100 (CET)
Message-ID: <be7782a1-5e92-46c1-a315-c1edbd0746d9@csgroup.eu>
Date: Thu, 27 Feb 2025 15:07:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20250226]Build Failure
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com>
 <20250227123804.5dd71cef@canb.auug.org.au>
 <14193c98-fb30-4ee8-a19a-fe85d1230d74@csgroup.eu>
 <cdd5dc55-4674-40fa-80d3-f6a6688c0d97@linux.vnet.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <cdd5dc55-4674-40fa-80d3-f6a6688c0d97@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/02/2025 à 14:47, Venkat Rao Bagalkote a écrit :
> Hello,
> 
> 
> Attached is the .config file.
> 
> This is being run on IBM Power8 system in PowerVM mode, as a full system 
> LPAR.

Ah ok so you are using a quite old version of GCC, that is GCC 8.5

I get the same problem when building ppc64_defconfig with GCC 8.5

Kees, can you have a look ?

Regards
Christophe

> 
> Regards,
> 
> Venkat.
> 
> On 27/02/25 4:13 pm, Christophe Leroy wrote:
>>
>>
>> Le 27/02/2025 à 02:38, Stephen Rothwell a écrit :
>>> Hi Venkat,
>>>
>>> CC Kees Cook for advice.  This is a result of the tests added in commit
>>>
>>>    bbeb38b8487a ("string.h: Validate memtostr*()/strtomem*() 
>>> arguments more carefully")
>>>
>>> from the kspp tree.
>>>
>>> I note that the comment about memtostr() says "Copy a possibly
>>> non-NUL-term string".
>>
>> Can you tell more about your config and your environment ?
>>
>> I just tested with ppc64_defconfig and ppc64le_defconfig, with gcc 
>> 12.4, gcc 13.2 and gcc 14.2 and didn't get that build error.
>>
>> Christophe
>>
>>>
>>> On Thu, 27 Feb 2025 06:30:12 +0530 Venkat Rao Bagalkote 
>>> <venkat88@linux.vnet.ibm.com> wrote:
>>>>
>>>> I am seeing build failures with kernel next-20250226, on IBM Power8 
>>>> systems.
>>>>
>>>> Failures:
>>>>
>>>> In file included from ./include/asm-generic/div64.h:27,
>>>>                    from ./arch/powerpc/include/generated/asm/div64.h:1,
>>>>                    from ./include/linux/math.h:6,
>>>>                    from ./include/linux/math64.h:6,
>>>>                    from ./include/linux/time.h:6,
>>>>                    from fs/ext4/file.c:22:
>>>> fs/ext4/file.c: In function 'ext4_sample_last_mounted':
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:418:6: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>         __must_be_noncstr(dest) +  \
>>>>         ^~~~~~~~~~~~~~~~~
>>>> fs/ext4/file.c:869:2: note: in expansion of macro 'strtomem_pad'
>>>>     strtomem_pad(sbi->s_es->s_last_mounted, cp, 0);
>>>>     ^~~~~~~~~~~~
>>>> In file included from ./include/linux/build_bug.h:5,
>>>>                    from ./include/linux/container_of.h:5,
>>>>                    from ./include/linux/list.h:5,
>>>>                    from ./include/linux/module.h:12,
>>>>                    from drivers/message/fusion/mptsas.c:46:
>>>> drivers/message/fusion/mptsas.c: In function 
>>>> 'mptsas_exp_repmanufacture_info':
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/message/fusion/mptsas.c:2968:3: note: in expansion of macro 
>>>> 'memtostr'
>>>>      memtostr(edev->vendor_id, manufacture_reply->vendor_id);
>>>>      ^~~~~~~~
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/message/fusion/mptsas.c:2969:3: note: in expansion of macro 
>>>> 'memtostr'
>>>>      memtostr(edev->product_id, manufacture_reply->product_id);
>>>>      ^~~~~~~~
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/message/fusion/mptsas.c:2970:3: note: in expansion of macro 
>>>> 'memtostr'
>>>>      memtostr(edev->product_rev, manufacture_reply->product_rev);
>>>>      ^~~~~~~~
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/message/fusion/mptsas.c:2973:4: note: in expansion of macro 
>>>> 'memtostr'
>>>>       memtostr(edev->component_vendor_id,
>>>>       ^~~~~~~~
>>>> make[4]: *** [scripts/Makefile.build:203: fs/ext4/file.o] Error 1
>>>> make[3]: *** [scripts/Makefile.build:461: fs/ext4] Error 2
>>>> make[3]: *** Waiting for unfinished jobs....
>>>> In file included from ./include/linux/array_size.h:5,
>>>>                    from ./include/linux/kernel.h:16,
>>>>                    from drivers/scsi/mpt3sas/mpt3sas_base.c:46:
>>>> drivers/scsi/mpt3sas/mpt3sas_base.c: In function 
>>>> '_base_display_ioc_capabilities':
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/scsi/mpt3sas/mpt3sas_base.c:4798:2: note: in expansion of 
>>>> macro 'memtostr'
>>>>     memtostr(desc, ioc->manu_pg0.ChipName);
>>>>     ^~~~~~~~
>>>> In file included from ./include/linux/build_bug.h:5,
>>>>                    from ./include/linux/container_of.h:5,
>>>>                    from ./include/linux/list.h:5,
>>>>                    from ./include/linux/module.h:12,
>>>>                    from drivers/scsi/mpt3sas/mpt3sas_transport.c:45:
>>>> drivers/scsi/mpt3sas/mpt3sas_transport.c: In function 
>>>> '_transport_expander_report_manufacture':
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/scsi/mpt3sas/mpt3sas_transport.c:461:3: note: in expansion 
>>>> of macro 'memtostr'
>>>>      memtostr(edev->vendor_id, manufacture_reply->vendor_id);
>>>>      ^~~~~~~~
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/scsi/mpt3sas/mpt3sas_transport.c:462:3: note: in expansion 
>>>> of macro 'memtostr'
>>>>      memtostr(edev->product_id, manufacture_reply->product_id);
>>>>      ^~~~~~~~
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/scsi/mpt3sas/mpt3sas_transport.c:463:3: note: in expansion 
>>>> of macro 'memtostr'
>>>>      memtostr(edev->product_rev, manufacture_reply->product_rev);
>>>>      ^~~~~~~~
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/scsi/mpt3sas/mpt3sas_transport.c:466:4: note: in expansion 
>>>> of macro 'memtostr'
>>>>       memtostr(edev->component_vendor_id,
>>>>       ^~~~~~~~
>>>> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/mpt3sas/ 
>>>> mpt3sas_transport.o] Error 1
>>>> make[5]: *** Waiting for unfinished jobs....
>>>> make[5]: *** [scripts/Makefile.build:203: drivers/message/fusion/ 
>>>> mptsas.o] Error 1
>>>> make[4]: *** [scripts/Makefile.build:461: drivers/message/fusion] 
>>>> Error 2
>>>> make[3]: *** [scripts/Makefile.build:461: drivers/message] Error 2
>>>> make[3]: *** Waiting for unfinished jobs....
>>>> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/mpt3sas/ 
>>>> mpt3sas_base.o] Error 1
>>>> In file included from ./include/linux/array_size.h:5,
>>>>                    from ./include/linux/kernel.h:16,
>>>>                    from drivers/scsi/qla2xxx/qla_def.h:9,
>>>>                    from drivers/scsi/qla2xxx/qla_mr.c:6:
>>>> drivers/scsi/qla2xxx/qla_mr.c: In function 'qlafx00_fx_disc':
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/scsi/qla2xxx/qla_mr.c:1912:3: note: in expansion of macro 
>>>> 'memtostr'
>>>>      memtostr(vha->hw->model_number, pinfo->model_num);
>>>>      ^~~~~~~~
>>>> ./include/linux/compiler.h:197:62: error: static assertion failed: 
>>>> "must be non-C-string (not NUL-terminated)"
>>>>    #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct 
>>>> {_Static_assert(!(e), msg);}))
>>>> ^~~~~~~~~~~~~~
>>>> ./include/linux/compiler.h:226:2: note: in expansion of macro 
>>>> '__BUILD_BUG_ON_ZERO_MSG'
>>>>     __BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
>>>>     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/string.h:468:26: note: in expansion of macro 
>>>> '__must_be_noncstr'
>>>>     const size_t _src_len = __must_be_noncstr(src) +  \
>>>>                             ^~~~~~~~~~~~~~~~~
>>>> drivers/scsi/qla2xxx/qla_mr.c:1913:3: note: in expansion of macro 
>>>> 'memtostr'
>>>>      memtostr(vha->hw->model_desc, pinfo->model_description);
>>>>      ^~~~~~~~
>>>> make[5]: *** [scripts/Makefile.build:203: drivers/scsi/qla2xxx/ 
>>>> qla_mr.o] Error 1
>>>> make[5]: *** Waiting for unfinished jobs....
>>>> make[2]: *** [scripts/Makefile.build:461: fs] Error 2
>>>> make[2]: *** Waiting for unfinished jobs....
>>>> make[4]: *** [scripts/Makefile.build:461: drivers/scsi/mpt3sas] Error 2
>>>> make[4]: *** Waiting for unfinished jobs....
>>>> make[4]: *** [scripts/Makefile.build:461: drivers/scsi/qla2xxx] Error 2
>>>> make[3]: *** [scripts/Makefile.build:461: drivers/scsi] Error 2
>>>> make[2]: *** [scripts/Makefile.build:461: drivers] Error 2
>>>> make[1]: *** [/root/linux-next/Makefile:1989: .] Error 2
>>>> make: *** [Makefile:251: __sub-make] Error 2
>>>
>>
>>


