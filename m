Return-Path: <linux-kernel+bounces-236168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B291DE5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7811F24CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B713E41A;
	Mon,  1 Jul 2024 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Lns3VcSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVfk/c8N"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFE1422A6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834738; cv=none; b=bunqfM90ETfGF0b+IAs6kNH4eDwZtwF9+QW9CoTnNatRRnHSdhfrz2vc5W4r954Cze9/wUXTaFdwK4NC00yFLQjyYLubN7F6xGGjULnSznKl4k1oaKnOVfZllf4d5T1dIu4utHObfvbQwr4Y92ND9Sxw3qeOjSfzQqKVkiFfoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834738; c=relaxed/simple;
	bh=kNOY7/+Q/njqICMWa7+fJvzJfYXfzuWsQVLQL7JFPB4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Mp3mTxr9i5HRtRo+sQjmjD/vs4asN75Zq0/U6rqNJX3n74jlZU3xlmSUGdrYZ3dpi5R7c9T7pQbykfzNl7Y8lxbD7/T6tvYQD+zib2V/R3JrF7Z3FtGjLKgOhXZkkIYKIur+CKr9ZDd+M4X1myx9y99xuWwiXJFdPDd2xbSsxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Lns3VcSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVfk/c8N; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id DA8F513800E9;
	Mon,  1 Jul 2024 07:52:15 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Mon, 01 Jul 2024 07:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1719834735;
	 x=1719921135; bh=yQ2Uekak3fLHx8n+LIQh8xrvvbDHZHUg0ffeSdLr49M=; b=
	Lns3VcSBr6IuqkwNBwTJD/UceJam5b8r1ixsEwOmQ0AsYHx1HnmGCI5dK2XAPUpY
	lzlBHrHOLQva4n3mqw7BsPCDVxf/ZLyqypIjY60cIxHtsK9eu2JOzzgTQRHAw2T4
	37lt7zqdnoOyuQJjFJtKeR8r5b43qAbgdnscMa2+RRa2l1PO55Tjk+hyPmBTDN3m
	4oYGK8mvxk9QvyVEL/tnrHYZ5qedtzuDGEhG6f0jfeN6RVTU0OyvcRJiCTSbDBjJ
	/tftaeAgzuTX77wwxPWebdp24iQXf8rxci1Rd3/uBVPiimZcjivXhN6b/PZRBqZu
	Nd4pcOstA9gmJ0Klm7DVdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719834735; x=
	1719921135; bh=yQ2Uekak3fLHx8n+LIQh8xrvvbDHZHUg0ffeSdLr49M=; b=K
	Vfk/c8NgtsC3hHOjxxyDQKD+ohYkwlhH1BTRPyTKL0KLswHAZwRMkk+RBFpSl7E9
	k8JUE8L0IBDvebPTGrpo8r7leOJK6IE0kHTkj+FbnSuup4ORkbE7eLhaFeaGrCjv
	ZYKNAK169pwEvpESioTE2cmxUWlkk03ZCctZQLcc2g33wK6VH4iu5+FG+vBvwyv1
	5vE9WdVvfMVzf4zT9bpb9DDYvT7Poyicnnk+nowQxiDmjyMhBWWSj+jJT45c62hd
	fJuE8Hf+cs3/PXwVARRAbGFATpQyBdYzp8LwrZ9ASB7tQbf8zj2Jce+15lI+XZBl
	mC5oZ1RvZua/ASpPGAnGw==
X-ME-Sender: <xms:b5iCZlrA3_kht3xIlMIa5p3iKfZrGCUpWBJaoLogFnyegBYYJOMXyw>
    <xme:b5iCZnreAxLg4NsOHQ8BqcCFZFm0reYJ-HuWlPLlsVBjBVyUgw6kghNo4cJok2pBz
    hhK7Yyc3bWsdELFDfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:b5iCZiOuXwHzp7BnRddIDrWIEMXTuPKOmgr1Y_g-I58MvY-QpUTZtg>
    <xmx:b5iCZg4DWLPlw-lewLOlISxKY9sqhGrbDyIJVEBDKxMo2T5-8sMyYA>
    <xmx:b5iCZk6lY6B8iIGO9ZzvDtfP8vMfiQMAxsJnsZ5ndRxpkSAdlLPBPQ>
    <xmx:b5iCZogSwFkjfZe3H25_OmZ-u6V5PeANHk4awxEDaMeGeMOoGsotGg>
    <xmx:b5iCZlEDzPh3jrUvmpyMCVlSvsJ9FqoO7bM5NRN6HHmbLkbktBRpb4UJ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 160B836A0074; Mon,  1 Jul 2024 07:52:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9465468-b931-4171-8961-0f1ecd4a227e@app.fastmail.com>
In-Reply-To: <7e30177b-ff13-4fed-aa51-47a9cbd5d572@amd.com>
References: <20240629052247.2653363-1-uwu@icenowy.me>
 <20240629052247.2653363-3-uwu@icenowy.me>
 <a143a2c3-c6f0-4537-acc6-94f229f14639@app.fastmail.com>
 <2760BA02-8FF8-4B29-BFE2-1322B5BFB6EC@icenowy.me>
 <7e30177b-ff13-4fed-aa51-47a9cbd5d572@amd.com>
Date: Mon, 01 Jul 2024 12:52:00 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Icenowy Zheng" <uwu@icenowy.me>, "Huang Rui" <ray.huang@amd.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] drm/ttm: downgrade cached to write_combined when snooping
 not available
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B47=E6=9C=881=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=8812:40=EF=BC=8CChristian K=C3=B6nig=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> Ah, wait a second.
>
> Such a thing as non-coherent PCIe implementation doesn't exist. The PC=
Ie=20
> specification makes it mandatory for memory access to be cache coheren=
t.

There are some non-PCIe TTM GPU being hit by this pitfall, we have non-c=
oherent
Vivante GPU on some devices.

Handling it at TTM core makes more sense on reducing per-driver effort o=
n dealing
platform issues.

>
> There are a bunch of non-compliant PCIe implementations which have=20
> broken cache coherency, but those explicitly violate the specification=20
> and because of that are not supported.

I don't really understand, "doesn't exist" and "bunch of" seems to be co=
ntradicting
with each other.

>
> Regards,
> Christian.
>
>>>
>>> Unfortunately I don't think we can safely ttm_cached to ttm_write_co=
mnined, we've
>>> had enough drama with write combine behaviour on all different platf=
orms.
>>>
>>> See drm_arch_can_wc_memory in drm_cache.h.
>>>
>> Yes this really sounds like an issue.
>>
>> Maybe the behavior of ttm_write_combined should furtherly be decided
>> by drm_arch_can_wc_memory() in case of quirks?

IMO for DMA mappings, use dma_pgprot at mapping makes more sense :-)

Thanks=20
- Jiaxun
>>
>>> Thanks
>>>
>>>> +
>>>>   	return ttm_prot_from_caching(caching, tmp);
>>>>   }
>>>>   EXPORT_SYMBOL(ttm_io_prot);
>>>> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm=
_tt.c
>>>> index 7b00ddf0ce49f..3335df45fba5e 100644
>>>> --- a/drivers/gpu/drm/ttm/ttm_tt.c
>>>> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
>>>> @@ -152,6 +152,10 @@ static void ttm_tt_init_fields(struct ttm_tt *=
ttm,
>>>>   			       enum ttm_caching caching,
>>>>   			       unsigned long extra_pages)
>>>>   {
>>>> +	/* Downgrade cached mapping for non-snooping devices */
>>>> +	if (!bo->bdev->dma_coherent && caching =3D=3D ttm_cached)
>>>> +		caching =3D ttm_write_combined;
>>>> +
>>>>   	ttm->num_pages =3D (PAGE_ALIGN(bo->base.size) >> PAGE_SHIFT) + e=
xtra_pages;
>>>>   	ttm->page_flags =3D page_flags;
>>>>   	ttm->dma_address =3D NULL;
>>>> diff --git a/include/drm/ttm/ttm_caching.h b/include/drm/ttm/ttm_ca=
ching.h
>>>> index a18f43e93abab..f92d7911f50e4 100644
>>>> --- a/include/drm/ttm/ttm_caching.h
>>>> +++ b/include/drm/ttm/ttm_caching.h
>>>> @@ -47,7 +47,8 @@ enum ttm_caching {
>>>>
>>>>   	/**
>>>>   	 * @ttm_cached: Fully cached like normal system memory, requires=
 that
>>>> -	 * devices snoop the CPU cache on accesses.
>>>> +	 * devices snoop the CPU cache on accesses. Downgraded to
>>>> +	 * ttm_write_combined when the snooping capaiblity is missing.
>>>>   	 */
>>>>   	ttm_cached
>>>>   };
>>>> --=20
>>>> 2.45.2

--=20
- Jiaxun

