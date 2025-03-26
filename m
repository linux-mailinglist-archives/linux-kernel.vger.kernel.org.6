Return-Path: <linux-kernel+bounces-576884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B8A71589
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FA73AB4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911181C84DE;
	Wed, 26 Mar 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="bBSvdtQg"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD91D5CE5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987693; cv=none; b=bdeQ5cbCIatuXjOvl2mbOHBqd8gGD+XSq781+GPMmmuBBcnQkN5fF2SLly9vrh7h4HCaMxmsmhfls5P/LQf1c5L7g87L5dYAzE0zerJ1Z6m0cfIhylvspPh8GWqL6HnZo54kkTieCYqr721IHhIzOXftYU8Q2Iw/GxAXajqowv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987693; c=relaxed/simple;
	bh=TdN3QNWNklmPMMOqBBAtTJCPMFORmjzrNpuLiu2kkaQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNokdCQ2yS8v1lqssfxkFXi5KZuoIvPnpqxe3Pg4nq8LLFBykRhsvm/sIqojm2Y6unHupwZkHBphMVMqXFzrdz1MxveDtt7asht05FwMnWKitEvu0MofRYSAPxlLbBtdi1h/UTgTNjgmujki6iWrgtHHMvk6Wco71tpsmuDxNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=bBSvdtQg; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742987676; x=1743592476; i=spasswolf@web.de;
	bh=TtX8w7PZ460w+dAIO+eZ8wQ4iftREJt7mCSbqGXkhL8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bBSvdtQgOa6ytu5IKsKBaJVHeTq53qfRk52EsWzQIqi6LMlc6LE1ZWdmMKmggy8I
	 MKzaMjOiV0vxHCqS1Q48BilzbuqDtSNTOrBQi7pyhHQVeijKZRqrtJG3tdANg5CVQ
	 TUT2PtYT0KHQikAd3avEklq8c0cXzhxj23EOzMQU0JpCyLed4DApDONrHStwftsYu
	 04UgGtK85Fm8jayisMOuMptE+RJdPQbK4L4bGc0pRkVzdVmahPjHVwib0fjHFVVp8
	 idGY86j2q5fSgOfJ9UlbDrEwOReqlBk1uDepbXz9WeVGIrdhN9sHjA97rKDonz+Nj
	 0cz0iBt38/vykACE4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rP8-1tzbdc1a6C-00Dfk2; Wed, 26
 Mar 2025 12:14:36 +0100
Message-ID: <d87680bab997fdc9fb4e638983132af235d9a03a.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Alex Deucher	
 <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Wed, 26 Mar 2025 12:14:35 +0100
In-Reply-To: <c6d996b4-5e44-4066-964c-5a2a27dfaa6a@nvidia.com>
References: <20250322122351.3268-1-spasswolf@web.de>
	 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
	 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
	 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
	 <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
	 <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
	 <261e7069-9f65-4a89-95cb-25c224ff04f1@nvidia.com>
	 <eb041c610719c8275d321c4c420c0b006d31d9f4.camel@web.de>
	 <76672910-423c-4664-a1bd-da5c1d7d6afd@nvidia.com>
	 <a9f37e3b-2192-42d2-8d5d-c38c0d3fe509@nvidia.com>
	 <79a263b2af01e7ed6594ca5896048bd9d7aae35e.camel@web.de>
	 <c6d996b4-5e44-4066-964c-5a2a27dfaa6a@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tRQAcBuXLig8Fo34ovCODhOe8/fi/vlMgZfo5BvlPnmgTp0M0EY
 0WqC/LrYWdv9iL0H23C2pJwNFMjKgFdLVBnNzIzg6rVrkuhutFeDsV+dOOEhK4wYFMJXB9E
 ium+J61YJf/sXr/USR+15VUbKgPwrlMOB/uHaO42Zhi6l3rWJhd51Yyd7KHe1dThhpKJeus
 RnLDF9SxaX3TkzSVRaAzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0YYTUCAfOgY=;85WgL5YS+GYnyqfNQQxIw7IL78f
 0r1Vsbrl6OaGCy/hmuZZgfQFavhFZcOFxoCBvVjj0/bKV1ldIFluRC1H39zcf6eQU0n0XMt1U
 cF/IQnmWXffzHC11bPfRRPxHxJY2EPT3Ou3wiL/QxQba5TbPO3S1Q1kIKcqMRtBLuKx82kQOf
 sU7R9/KrQlMgbzyUewpc5xcHZVRg0JrHaYE4Hs3+dhJh/NPlPUmQpGS2egIZMmcXpkDPjxvIv
 X4Nn0RBETfnU0hs1JuvWkKQUAxNzgcciMh3VcNagIz5BEg/yEDn+fJPkAC1cypmGv+Hn3ut2N
 yvqHshyauJUR5QMdzfJNaeh8QPCB7boIalThCZHcfCEjeU/cmgqdVfqW8wSDuOTaTe45tKFAI
 I9CqWrVGW3Nx+4oF24/T9KjJS0k1ZnEZtlFhgLanw04HCqGxaQNrJUMbSN36G1ptA3EiefYMj
 acun36hfZtUn9BR3rkJ7dvl9CaZuzxotPuyMgtTeykj3T78wDbgskZmkSD19R2M0FMfk4dWrK
 u8oJq6jPR7f9tvpTH0+go+nxNrq4nbPiqhWu0c6rjkEnYJ0Ij4PnDXvvUBS3V9H833LMk6/9W
 dfKOWs1wsUfzkv2nMzBjN8gjWDEW+9yzzEUXTKVUX3v/V+wI8rCRuJ/j7DtDGsDJ7+xfYgtLM
 TTPvwkWyZp8fYUCybswwgOER+PE7/qsvVPfWRvB6OvQJd9n43lAEKay8hZYeIy0DAs47XsGcR
 mGEoEQkyz47+149p9FeCIy6Cl9M5oEURbM/eKQbI4zqOomavEnCTt6d6vLgtvh1URm7gr9r5l
 WDswJd7b2GrkuG8WfkuXpFS2HoKNKOtIxMdDbuZGvyXpFXH+ng+af/cVPkLdNq1J+UscqxL/y
 OxZSsNeR/KsUTHlKRmU6rk/TAQ5BTcmp0cyonlV8K81G2JpRqy6c3i6SVQs7ShW4Kxvi8yViZ
 EIL1Qjmj0QmzVt0qkEPzyDmD9rK+pSMV46LGMCPT+KmqaGMrby4/Yhyb4xrS0y6Xwm4ZolA+b
 qWOnlk+CZnrfttgTPy7l1d7FXxS/R2YxYO19k6Dch1++ADdflooV8YmxwXq3eegcbJxrL9Q/X
 5FCeg8zb4XKYvxka75u6HgXjs5vv5VZIJmA+028jRxkwKi2HTj8k5Ivmmvz9UdzqCFdKYke7c
 BV+5JjiufGhAwkXCSW14JxFd8BgnxpfsDjd27s4lYY64REaeLse9lb/D2bqyghrySSJRkUfdk
 1HLI4uQw49l4qIdxIkxG4RGqmMFrKIhzM0iSt3tDgfriXTX/l89TJbDAadpx3VE8WKL/Tbg56
 pQea8G88OKkTANyYvPmJtQ7pdOmWZVMyHFBvylxhh5ERjSO2B7ko82qZsPyf56LCcK50NbT9Y
 NBexHsG/GUFQW0aTKNsdiMBEYZF1ZLk77t17Koi8rNi3vNnoXiCa9efPZM4U2Y07XaJxyR6TY
 3qdc98phqXYR7Ta0uELETkglFhzY=

Am Mittwoch, dem 26.03.2025 um 21:36 +1100 schrieb Balbir Singh:
> On 3/26/25 21:10, Bert Karwatzki wrote:
> > Am Mittwoch, dem 26.03.2025 um 12:50 +1100 schrieb Balbir Singh:
> > > On 3/26/25 10:43, Balbir Singh wrote:
> > > > On 3/26/25 10:21, Bert Karwatzki wrote:
> > > > > Am Mittwoch, dem 26.03.2025 um 09:45 +1100 schrieb Balbir Singh:
> > > > > >
> > > > > >
> > > > > > The second region seems to be additional, I suspect that is HM=
M mapping from kgd2kfd_init_zone_device()
> > > > > >
> > > > > > Balbir Singh
> > > > > >
> > > > > Good guess! I inserted a printk into kgd2kfd_init_zone_device():
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > > > > b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > > > > index d05d199b5e44..201220e2ac42 100644
> > > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > > > > @@ -1049,6 +1049,8 @@ int kgd2kfd_init_zone_device(struct amdgpu=
_device *adev)
> > > > >                 pgmap->range.end =3D res->end;
> > > > >                 pgmap->type =3D MEMORY_DEVICE_PRIVATE;
> > > > >         }
> > > > > +       dev_info(adev->dev, "%s: range.start =3D 0x%llx ranges.e=
nd =3D 0x%llx\n",
> > > > > +                       __func__, pgmap->range.start, pgmap->ran=
ge.end);
> > > > >
> > > > >         pgmap->nr_range =3D 1;
> > > > >         pgmap->ops =3D &svm_migrate_pgmap_ops;
> > > > >
> > > > >
> > > > > and get this in the case without nokaslr:
> > > > >
> > > > > [    T367] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_d=
evice:
> > > > > range.start =3D 0xafe00000000 ranges.end =3D 0xaffffffffff
> > > > >
> > > > > and this in the case with nokaslr:
> > > > >
> > > > > [    T365] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_d=
evice:
> > > > > range.start =3D 0x3ffe00000000 ranges.end =3D 0x3fffffffffff
> > > > >
> > > >
> > > > So we should ignore the second region then for the purposes of thi=
s issue.
> > > >
> > > > I think this now boils down to
> > > >
> > > > Why is the dma_get_required_mask set to all of addressable memory =
(46 bits)
> > > > when we have nokaslr
> > > >
> > >
> > > I think I know the root cause of the required_mask going up and henc=
e the
> > > use of DMA32
> > >
> > > 1. HMM calls add_pages()
> > > 2. add_pages calls update_end_of_memory_vars()
> > > 3. This updates max_pfn and that causes required_mask to go up to 46=
 bits
> > >
> > > Do you have CONFIG_HSA_AMD_SVM enabled? Does turning it off, fix the=
 issue?
> > >
> > > The actual issue is the update of max_pfn.
> > >
> > > Balbir Singh
> > >
> >
> > Yes, turning off CONFIG_HSA_AMD_SVM fixes the issue, the strange memor=
y
> > resource=C2=A0
> > afe00000000-affffffffff : 0000:03:00.0
> > is gone.
> >
> > If one would add a max_pyhs_addr argument to devm_request_free_mem_reg=
ion()
> > (which return the resource addr in kgd2kfd_init_zone_device()) one cou=
ld keep
> > the memory below the 44bit limit with CONFIG_HSA_AMD_SVM enabled.
> >
>
> Thanks for reporting the result, does this patch work
>
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 01ea7c6df303..14f42f8012ab 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -968,8 +968,9 @@ int add_pages(int nid, unsigned long start_pfn, unsi=
gned long nr_pages,
>  	WARN_ON_ONCE(ret);
>
>  	/* update max_pfn, max_low_pfn and high_memory */
> -	update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
> -				  nr_pages << PAGE_SHIFT);
> +	if (!params->pgmap)
> +		update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
> +					  nr_pages << PAGE_SHIFT);
>
>  	return ret;
>  }
>
> It basically prevents max_pfn from moving when the inserted memory is zo=
ne_device.
>
> FYI: It's a test patch and will still create issues if the amount of pre=
sent memory
> (physically) is very high, because the driver need to enable use_dma32 i=
n that case.
>
> If you could try this with everything back to the original config with b=
oth kaslr/nokaslr that
> would be very helpful
>
> Thanks,
> Balbir Singh

Yes, this fixes the issue with stellaris and Civilization6. The memory sti=
ll
shifts as usual in /proc/iomem:
afe00000000-affffffffff : 0000:03:00.0 without nokaslr
3ffe00000000-3fffffffffff : 0000:03:00.0 with nokaslr
but without the change in max_pfn the this has no impact on the required d=
ma
mask.

Bert Karwatzki

