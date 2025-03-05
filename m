Return-Path: <linux-kernel+bounces-545938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A51A4F408
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F95916BCDA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339C60B8A;
	Wed,  5 Mar 2025 01:46:56 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E894A1D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741139215; cv=none; b=B6uQh9kCrZoi0BBHQRZpNKnHN2DwCwgDL3XPZfs/C7UmWpP7TKTpZLEF17EKr1ZYfDgOXP9zH0TJOFc053xazUGohODuhATc4zH/SaYHY0AXFBQS0+ab0Ixo7obnjtSfVvoo3I0nfnDcUaKCON+o3wJdKRnBVgVzeQbBruyWgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741139215; c=relaxed/simple;
	bh=7T+5etCgfnUAukDKEq7LcsKl8YCMYHJSr1gt3BvYHUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWAWv3Dw/Qk9bbqQJ3Ec3MoCzq9jeFu914I8o2zlrGyKD9dquriVwsOlEsMphbCh0RS1zASkeE0wGn8+csL2kWySL5wh1AFeAHgdkT/maq9lHgkC1LhlX2IWl4UnSkdso6Z4PJTg/BFAN699xcEI95mELYNu+UDJxkLXesPDwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b1647710f96311efa216b1d71e6e1362-20250305
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c983ef01-c9d0-4c42-b584-391113908001,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ace68c1fb23253b0dbb91357b6d45cfe,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b1647710f96311efa216b1d71e6e1362-20250305
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1244931171; Wed, 05 Mar 2025 09:46:44 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 53C30B803CA3;
	Wed,  5 Mar 2025 09:46:44 +0800 (CST)
X-ns-mid: postfix-67C7AD04-213778295
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id C8FB3B803CA3;
	Wed,  5 Mar 2025 01:46:42 +0000 (UTC)
Message-ID: <6701d375-8d7c-4e13-b0db-486a48088446@kylinos.cn>
Date: Wed, 5 Mar 2025 09:46:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/vmalloc: Remove unnecessary size ALIGN in
 __vmalloc_node_range_noprof
To: Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, hch@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250303094410.437985-1-liuye@kylinos.cn>
 <20250303094410.437985-2-liuye@kylinos.cn> <Z8X1U-3f35-JZTUr@pc636>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <Z8X1U-3f35-JZTUr@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/3/4 02:30, Uladzislau Rezki =E5=86=99=E9=81=93:
> On Mon, Mar 03, 2025 at 05:44:07PM +0800, Liu Ye wrote:
>> The same operation already exists in the function __get_vm_area_node,
>> so delete the duplicate operation to simplify the code.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>  mm/vmalloc.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index dc658d4af181..20d9b9de84b1 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3798,7 +3798,6 @@ void *__vmalloc_node_range_noprof(unsigned long =
size, unsigned long align,
>>  			shift =3D arch_vmap_pte_supported_shift(size);
>> =20
>>  		align =3D max(real_align, 1UL << shift);
>> -		size =3D ALIGN(real_size, 1UL << shift);
>>  	}
>> =20
>>  again:
>> --=20
>> 2.25.1
>>
> There is a mess with:
>
>  unsigned long real_size =3D size;
>  unsigned long real_align =3D align;
>
> "real_size" and "real_align". Those are useless. What is about:

Sorry, the order of the patches may be misleading.

The correct order is as follows=EF=BC=9A

PATCH1.=C2=A0 mm/vmalloc: Size should be used instead of real_size "
PATCH2.=C2=A0 mm/vmalloc: Remove unnecessary size ALIGN in __vmalloc_node=
_range_noprof=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
PATCH3.=C2=A0 mm/vmalloc: Remove the real_size variable to simplify the c=
ode "
PATCH4.=C2=A0 mm/vmalloc: Rename the variable real_align to original_alig=
n to prevent misunderstanding

If=C2=A0PATCH1 is the correct fix, then consider=C2=A0PATCH2,=C2=A0PATCH3=
, and=C2=A0PATCH4.

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5c88d0e90c20..a381ffee1595 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3771,8 +3771,6 @@ void *__vmalloc_node_range_noprof(unsigned long s=
ize, unsigned long align,
>  	struct vm_struct *area;
>  	void *ret;
>  	kasan_vmalloc_flags_t kasan_flags =3D KASAN_VMALLOC_NONE;
> -	unsigned long real_size =3D size;
> -	unsigned long real_align =3D align;
>  	unsigned int shift =3D PAGE_SHIFT;
> =20
>  	if (WARN_ON_ONCE(!size))
> @@ -3781,7 +3779,7 @@ void *__vmalloc_node_range_noprof(unsigned long s=
ize, unsigned long align,
>  	if ((size >> PAGE_SHIFT) > totalram_pages()) {
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, exceeds total pages",
> -			real_size);
> +			size);
>  		return NULL;
>  	}
> =20
> @@ -3798,19 +3796,18 @@ void *__vmalloc_node_range_noprof(unsigned long=
 size, unsigned long align,
>  		else
>  			shift =3D arch_vmap_pte_supported_shift(size);
> =20
> -		align =3D max(real_align, 1UL << shift);
> -		size =3D ALIGN(real_size, 1UL << shift);
> +		align =3D max(align, 1UL << shift);
>  	}
> =20
>  again:
> -	area =3D __get_vm_area_node(real_size, align, shift, VM_ALLOC |
> +	area =3D __get_vm_area_node(size, align, shift, VM_ALLOC |
>  				  VM_UNINITIALIZED | vm_flags, start, end, node,
>  				  gfp_mask, caller);
>  	if (!area) {
>  		bool nofail =3D gfp_mask & __GFP_NOFAIL;
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, vm_struct allocation failed%s",
> -			real_size, (nofail) ? ". Retrying." : "");
> +			size, (nofail) ? ". Retrying." : "");
>  		if (nofail) {
>  			schedule_timeout_uninterruptible(1);
>  			goto again;
> @@ -3860,7 +3857,7 @@ void *__vmalloc_node_range_noprof(unsigned long s=
ize, unsigned long align,
>  	    (gfp_mask & __GFP_SKIP_ZERO))
>  		kasan_flags |=3D KASAN_VMALLOC_INIT;
>  	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
> -	area->addr =3D kasan_unpoison_vmalloc(area->addr, real_size, kasan_fl=
ags);
> +	area->addr =3D kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
> =20
>  	/*
>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> @@ -3878,8 +3875,6 @@ void *__vmalloc_node_range_noprof(unsigned long s=
ize, unsigned long align,
>  fail:
>  	if (shift > PAGE_SHIFT) {
>  		shift =3D PAGE_SHIFT;
> -		align =3D real_align;
> -		size =3D real_size;
>  		goto again;
>  	}
> =20
> ?
>
> --
> Uladzislau Rezki

