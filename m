Return-Path: <linux-kernel+bounces-235059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E244F91CF18
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 22:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2033BB216C8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56CF139CFE;
	Sat, 29 Jun 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="jhBBe2H+"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DA2032B
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719694428; cv=pass; b=CqqE4JsbNO09pYrR2y8HXiNQrjLsxoco2ILL3NGJcuBnD4YDMHdJqvUmSWVgUq59mZIAWpsk22VAzisXmtFkSy2PelzxkrVHwDD+YXBzLYwLhEyILySJ+h8uWHcy2Fk6nnURMXN1j9ibQEsCekQYULjHMKUYpvLTevoHCwY6N7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719694428; c=relaxed/simple;
	bh=es6AYE52PMoKw0LlBQjrEE+OYm8i0GKQ/uN3Jg0u/kI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Wc7hort3Cq0msJ/zM2U0Zquiu2V2ULIBIFt3DnzGxZtznaPJbMdnNUsbBlUbl9C3r809MMlLsfE5wYxDWVhs3ru2chGPrQAFckx8X3qeo0lYhJNltk48dNNHRGe5mXaI8LU56ROrIUexvbsQwTy4g8VIQejWGV3lZhnKSzwRTFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=jhBBe2H+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1719694411; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IekYf+xBSXCyY19UiRBa2+jOugJpn19Iekffndl3qydN3oELTGOF1zO5wrK8f3AC7g9v+58wQYEK2y+DQD5fYMF/Nl534NHapsdD7y2+sX1LltgqTixkeIbnGyGV5FQpRoAfjpngDK6R0nSxEhKQ7oUTES5qz8M9GdilyhvCDdo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1719694411; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mYIf2hD3tC8XwdxYRIYlcO/GDmxwIxeJGBYulQyfnRY=; 
	b=n28xoXz4kFTvaLsgxPcfbvYTQG6w5CXM0dMLz1UwRmZdjYPGPnPBDHpba0luPZtWAsXlu3RuBseznQ4jP7E5a23TOHD9SIuQp/Zxtr0y3cmHwzM+JeRs4fVqIEoy/4I+lQPRDXym5PgOB2ySDWqyDuApeBzAPHFGkclDejuwqEs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1719694411;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=mYIf2hD3tC8XwdxYRIYlcO/GDmxwIxeJGBYulQyfnRY=;
	b=jhBBe2H+sMnV1Rg0eHCeyykK4wq4MyTlX0QptJGziT5qk1xCGZm/a9JzT37p5IJK
	wSR0YaGE/d3F/GJxb7v9BGAfHXzVwfo3PkWnFSpmzI6ITkLJyqnRMOPwtsZ7+nujwbC
	A8kZFAwz5mXurnoGyP1nThABzO7vsSTQ+wmblinBczKlacDfv6Vr9RZJmu+EXNzcfkv
	ktGoYDQCl3we2tvapXf7xa/40KN4+8gt3npOgdIr9RItM3/x1Tttz+mNsch+y1hvmwi
	/N06YJNoVsiBZAS0J7/yIvAJ9qd1IA8eErqZCA8Ra91U+gSJbBKMWIiGUBr0wdX1WjR
	Gc4nWe3hhw==
Received: by mx.zohomail.com with SMTPS id 1719694409695962.8558976921961;
	Sat, 29 Jun 2024 13:53:29 -0700 (PDT)
Date: Sun, 30 Jun 2024 04:51:31 +0800
From: Icenowy Zheng <uwu@icenowy.me>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_2/2=5D_drm/ttm=3A_downgrade_cached?=
 =?US-ASCII?Q?_to_write=5Fcombined_when_snooping_not_available?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a143a2c3-c6f0-4537-acc6-94f229f14639@app.fastmail.com>
References: <20240629052247.2653363-1-uwu@icenowy.me> <20240629052247.2653363-3-uwu@icenowy.me> <a143a2c3-c6f0-4537-acc6-94f229f14639@app.fastmail.com>
Message-ID: <2760BA02-8FF8-4B29-BFE2-1322B5BFB6EC@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



=E4=BA=8E 2024=E5=B9=B46=E6=9C=8830=E6=97=A5 GMT+08:00 03:57:47=EF=BC=8CJi=
axun Yang <jiaxun=2Eyang@flygoat=2Ecom> =E5=86=99=E9=81=93=EF=BC=9A
>
>
>=E5=9C=A82024=E5=B9=B46=E6=9C=8829=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=
=E5=8D=886:22=EF=BC=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
>[=2E=2E=2E]
>> @@ -302,6 +302,10 @@ pgprot_t ttm_io_prot(struct ttm_buffer_object *bo,=
=20
>> struct ttm_resource *res,
>>  		caching =3D res->bus=2Ecaching;
>>  	}
>>=20
>> +	/* Downgrade cached mapping for non-snooping devices */
>> +	if (!bo->bdev->dma_coherent && caching =3D=3D ttm_cached)
>> +		caching =3D ttm_write_combined;
>Hi Icenowy,
>
>Thanks for your patch! You saved many non-coh PCIe host implementations a=
 day!=2E
>
>Unfortunately I don't think we can safely ttm_cached to ttm_write_comnine=
d, we've
>had enough drama with write combine behaviour on all different platforms=
=2E
>
>See drm_arch_can_wc_memory in drm_cache=2Eh=2E
>

Yes this really sounds like an issue=2E

Maybe the behavior of ttm_write_combined should furtherly be decided
by drm_arch_can_wc_memory() in case of quirks?

>Thanks=20
>
>> +
>>  	return ttm_prot_from_caching(caching, tmp);
>>  }
>>  EXPORT_SYMBOL(ttm_io_prot);
>> diff --git a/drivers/gpu/drm/ttm/ttm_tt=2Ec b/drivers/gpu/drm/ttm/ttm_t=
t=2Ec
>> index 7b00ddf0ce49f=2E=2E3335df45fba5e 100644
>> --- a/drivers/gpu/drm/ttm/ttm_tt=2Ec
>> +++ b/drivers/gpu/drm/ttm/ttm_tt=2Ec
>> @@ -152,6 +152,10 @@ static void ttm_tt_init_fields(struct ttm_tt *ttm,
>>  			       enum ttm_caching caching,
>>  			       unsigned long extra_pages)
>>  {
>> +	/* Downgrade cached mapping for non-snooping devices */
>> +	if (!bo->bdev->dma_coherent && caching =3D=3D ttm_cached)
>> +		caching =3D ttm_write_combined;
>> +
>>  	ttm->num_pages =3D (PAGE_ALIGN(bo->base=2Esize) >> PAGE_SHIFT) + extr=
a_pages;
>>  	ttm->page_flags =3D page_flags;
>>  	ttm->dma_address =3D NULL;
>> diff --git a/include/drm/ttm/ttm_caching=2Eh b/include/drm/ttm/ttm_cach=
ing=2Eh
>> index a18f43e93abab=2E=2Ef92d7911f50e4 100644
>> --- a/include/drm/ttm/ttm_caching=2Eh
>> +++ b/include/drm/ttm/ttm_caching=2Eh
>> @@ -47,7 +47,8 @@ enum ttm_caching {
>>=20
>>  	/**
>>  	 * @ttm_cached: Fully cached like normal system memory, requires that
>> -	 * devices snoop the CPU cache on accesses=2E
>> +	 * devices snoop the CPU cache on accesses=2E Downgraded to
>> +	 * ttm_write_combined when the snooping capaiblity is missing=2E
>>  	 */
>>  	ttm_cached
>>  };
>> --=20
>> 2=2E45=2E2
>

