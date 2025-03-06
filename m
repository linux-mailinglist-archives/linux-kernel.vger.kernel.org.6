Return-Path: <linux-kernel+bounces-548102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE1A53FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3A83A9586
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65D617E473;
	Thu,  6 Mar 2025 01:32:45 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B361EB2A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224765; cv=none; b=nwlu037SNR/PX7bA42rHsCCTG7YHfO9RxC0X/GcgdigztC5puNFXeuicCN3xSRhYxk0CFWJKBohdKsLujtsKBYn2Y8+rrsmpYBAPBMSSjUsxDFLto+scX/GOqxO/4T7Mg+tgRZQCEhsxX3nlerM97VyCL7nly8MvfnW89bfDsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224765; c=relaxed/simple;
	bh=zKldQpPWeoSzOmeGmxYaFcn+fWjqCoxG+1gHFyXn2/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asdkBE5Q4XkNmid/93T5LBXvhhsO0+cK+tucbTrl0+3Qei02ebVMKmkY7K1W45VznFtFtPYVQXqPWpfDcLMD7dVlKQnudKW402AdaxCxJu4bfy5VFYjmiEc0h9OMQwhCcwD4ep9x1ftycVBxcuTytvo5cf3TBeJD5+LpeeJQtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e11f659cfa2a11efa216b1d71e6e1362-20250306
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d42586ec-b316-4fd5-a095-2db611931e7c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:20d8a490134ba7f827e10872660987bf,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e11f659cfa2a11efa216b1d71e6e1362-20250306
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1929729831; Thu, 06 Mar 2025 09:32:34 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 39947B807587;
	Thu,  6 Mar 2025 09:32:34 +0800 (CST)
X-ns-mid: postfix-67C8FB32-120793925
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id BFEFAB807587;
	Thu,  6 Mar 2025 01:32:31 +0000 (UTC)
Message-ID: <085b5684-1444-4684-b2e3-b25f2e0dc554@kylinos.cn>
Date: Thu, 6 Mar 2025 09:32:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/vmalloc: Remove unnecessary size ALIGN in
 __vmalloc_node_range_noprof
To: Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, hch@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250303094410.437985-1-liuye@kylinos.cn>
 <20250303094410.437985-2-liuye@kylinos.cn> <Z8X1U-3f35-JZTUr@pc636>
 <6701d375-8d7c-4e13-b0db-486a48088446@kylinos.cn>
 <Z8ghK22l7USzuBWY@MiWiFi-R3L-srv> <Z8giNq5CMtbYnlo-@pc636>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <Z8giNq5CMtbYnlo-@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/3/5 18:06, Uladzislau Rezki =E5=86=99=E9=81=93:
> On Wed, Mar 05, 2025 at 06:02:19PM +0800, Baoquan He wrote:
>> On 03/05/25 at 09:46am, liuye wrote:
>>>
>>> =E5=9C=A8 2025/3/4 02:30, Uladzislau Rezki =E5=86=99=E9=81=93:
>>>> On Mon, Mar 03, 2025 at 05:44:07PM +0800, Liu Ye wrote:
>>>>> The same operation already exists in the function __get_vm_area_nod=
e,
>>>>> so delete the duplicate operation to simplify the code.
>>>>>
>>>>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>>>>> ---
>>>>>  mm/vmalloc.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>>> index dc658d4af181..20d9b9de84b1 100644
>>>>> --- a/mm/vmalloc.c
>>>>> +++ b/mm/vmalloc.c
>>>>> @@ -3798,7 +3798,6 @@ void *__vmalloc_node_range_noprof(unsigned lo=
ng size, unsigned long align,
>>>>>  			shift =3D arch_vmap_pte_supported_shift(size);
>>>>> =20
>>>>>  		align =3D max(real_align, 1UL << shift);
>>>>> -		size =3D ALIGN(real_size, 1UL << shift);
>>>>>  	}
>>>>> =20
>>>>>  again:
>>>>> --=20
>>>>> 2.25.1
>>>>>
>>>> There is a mess with:
>>>>
>>>>  unsigned long real_size =3D size;
>>>>  unsigned long real_align =3D align;
>>>>
>>>> "real_size" and "real_align". Those are useless. What is about:
>>>
>>> Sorry, the order of the patches may be misleading.
>>>
>>> The correct order is as follows=EF=BC=9A
>>>
>>> PATCH1.=C2=A0 mm/vmalloc: Size should be used instead of real_size "
>>> PATCH2.=C2=A0 mm/vmalloc: Remove unnecessary size ALIGN in __vmalloc_=
node_range_noprof=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
>>> PATCH3.=C2=A0 mm/vmalloc: Remove the real_size variable to simplify t=
he code "
>>> PATCH4.=C2=A0 mm/vmalloc: Rename the variable real_align to original_=
align to prevent misunderstanding
>>>
>>> If=C2=A0PATCH1 is the correct fix, then consider=C2=A0PATCH2,=C2=A0PA=
TCH3, and=C2=A0PATCH4.
>>
>> Well, seems the patch split is done too subtly. It's only about the
>> size/align inside one function, maybe one patch is enough in this case=
.
>> My personal opinion.
>>
> I agree. One patch would be enough.
>=20

At first, I only wanted to use one patch, but to better understand, I spl=
it it up.
I can integrate it later and resend a new patch, and add a detailed descr=
iption in the commit message.

Thanks=EF=BC=8C
Liu Ye

> --
> Uladzislau Rezki

