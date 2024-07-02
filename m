Return-Path: <linux-kernel+bounces-237519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A60923A3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1541F22F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C12153836;
	Tue,  2 Jul 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="XfhvYqGK"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5314D703
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913039; cv=pass; b=MZb9DhAl5ENdh/mZEPm/z3Ocuo6G3JiHXC0EQfENUuCFYhIkmRz8w9u1lio4zQOgFCEg5G1I2hk63Sg2Z1TYbCh19Ymq/WCk+ISqYuwM4LLHTGzDjzOojNCLhNISG7TtDSinnUSQh1cSj3/DOFO6Nrt9E7pzmfySGPXc2AS8bFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913039; c=relaxed/simple;
	bh=QkbBxtL1pjr5JAXMK5JMIawf9l+Nh32i24EretFeIpY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8+zLYb4YaGWdNo5vZc7kBmXCqwoefA8fKi++9evOL6gFoyj9FJr0/6GUnGn8MsKGf9Gi+/9F88XkOgBLV0Iit8ZYXsxnwrn3kJHeBt7z7l8oQUE286RwDMzA2Q4A/wnSUEqJSc6HXdNbBysU9gyh2UNSHMsxJwZnCWaWuvVDWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=XfhvYqGK; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1719913022; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X8LgETK34s5A8Dg+jocv1kHIn0tQX29XJ7NuMhwj9situblSQENSgC4GIVNfo8MwG4IAB543mwEJPoXq43Bmaebrbn5Wb0j0B8x2J1XrEXh3W5N6pPxLRhnlc9CoH53UNcm5Werox1l6pFM9Ji3+iMg/HXD/EAO2rQDri754BNk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1719913022; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QkbBxtL1pjr5JAXMK5JMIawf9l+Nh32i24EretFeIpY=; 
	b=UNGemUDHO9L1R1Tg0Bacalk0M92Wv7MN+NJkusLGkpDr876R65S4rRZly/LdiGni01SNBzsu7wY7obVAPK5U31RDGjwtxpy6P5/PijxhFuwPn9EAHSE1Q+0V8RGGKNRKdLhFAFSIRjKYvWDzyAg7dFEzyJDXDqxBlFni/oYzWEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1719913022;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=QkbBxtL1pjr5JAXMK5JMIawf9l+Nh32i24EretFeIpY=;
	b=XfhvYqGKtPB2MYBDrmrX+vfFsfBSkUcEhTGikG0g5COVYgBQe620JF9sRfN4+XIa
	1vh+CPcQBNFzCdrlN4S3GAM1NueYh15kgAHPDO+Yhb8n3hjxQBC1pQvE36wNIJOlyHn
	XgA/Sv8gUG+5ek0GOrWfoyp0dhRwU7GY3rNw9I8FLiiw1316ACULpC3V8k245GNlT4d
	/LReei1KlT+Ou05KPRNzF0tPHTjRtTs2GZQ82S81zfFV8aqepdwlk9RqaHNHVr+jJjH
	x8sE2SlFMXVHuufCa6rU3YQAcG4uCeljpgvxT3OEzsPfsADjPUJpLKY7G7sOgYklLjJ
	/7S0EI6rIA==
Received: by mx.zohomail.com with SMTPS id 17199130201901001.7755334433347;
	Tue, 2 Jul 2024 02:37:00 -0700 (PDT)
Message-ID: <c9d3a2fa523bef4da14c47bcc588cfd60b6fd6f6.camel@icenowy.me>
Subject: Re: [RFC PATCH 2/2] drm/ttm: downgrade cached to write_combined
 when snooping not available
From: Icenowy Zheng <uwu@icenowy.me>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Huang Rui <ray.huang@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 02 Jul 2024 17:36:55 +0800
In-Reply-To: <4e958aa5-2a56-4754-b3dd-273da95f1d14@amd.com>
References: <20240629052247.2653363-1-uwu@icenowy.me>
	 <20240629052247.2653363-3-uwu@icenowy.me>
	 <a143a2c3-c6f0-4537-acc6-94f229f14639@app.fastmail.com>
	 <2760BA02-8FF8-4B29-BFE2-1322B5BFB6EC@icenowy.me>
	 <7e30177b-ff13-4fed-aa51-47a9cbd5d572@amd.com>
	 <6303afecce2dff9e7d30f67e0a74205256e0a524.camel@icenowy.me>
	 <ff1bf596-83cb-4b3e-a33a-621ac2c8171c@amd.com>
	 <4e958aa5-2a56-4754-b3dd-273da95f1d14@amd.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-07-02=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 10:10 +0200=EF=BC=
=8CChristian K=C3=B6nig=E5=86=99=E9=81=93=EF=BC=9A
> Am 02.07.24 um 10:08 schrieb Christian K=C3=B6nig:
> > Am 02.07.24 um 03:46 schrieb Icenowy Zheng:
> > > =E5=9C=A8 2024-07-01=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 13:40 +0200=
=EF=BC=8CChristian K=C3=B6nig=E5=86=99=E9=81=93=EF=BC=9A
> > > > Am 29.06.24 um 22:51 schrieb Icenowy Zheng:
> > > > > =E4=BA=8E 2024=E5=B9=B46=E6=9C=8830=E6=97=A5 GMT+08:00 03:57:47=
=EF=BC=8CJiaxun Yang
> > > > > <jiaxun.yang@flygoat.com>=C2=A0 =E5=86=99=E9=81=93=EF=BC=9A
> > > > > > =E5=9C=A82024=E5=B9=B46=E6=9C=8829=E6=97=A5=E5=85=AD=E6=9C=88 =
=E4=B8=8A=E5=8D=886:22=EF=BC=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > [...]
> > > > > > > @@ -302,6 +302,10 @@ pgprot_t ttm_io_prot(struct
> > > > > > > ttm_buffer_object *bo,
> > > > > > > struct ttm_resource *res,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0caching =3D res->bus.caching;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > > > >=20
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Downgrade cache=
d mapping for non-snooping
> > > > > > > devices */
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!bo->bdev->dma=
_coherent && caching =3D=3D
> > > > > > > ttm_cached)
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0caching =3D ttm_write_combined;
> > > > > > Hi Icenowy,
> > > > > >=20
> > > > > > Thanks for your patch! You saved many non-coh PCIe host
> > > > > > implementations a day!.
> > > > Ah, wait a second.
> > > >=20
> > > > Such a thing as non-coherent PCIe implementation doesn't exist.
> > > > The
> > > > PCIe
> > > > specification makes it mandatory for memory access to be cache
> > > > coherent.
> > > Really? I tried to get PCIe spec 2.0, PCI spec 3.0 and PCI-X
> > > addendum
> > > 1.0, none of this explicitly requires the PCIe controller and the
> > > CPU
> > > being fully coherent. The PCI-X spec even says "Note that PCI-X,
> > > like
> > > conventional PCI, does not require systems to support coherent
> > > caches
> > > for addresses accessed by PCI-X requesters".
> >=20
> > See the very first PCI specification, AGP 2.0 and the PCIe
> > extension=20
> > for non-snooped access.
> >=20
> > Originally it wasn't well defined what the PCI 1.0 spec meant with=20
> > coherency (e.g. snooping vs uncached).
> >=20
> > AGP was the first specification which explicitly defined that all
> > AGP=20
> > memory accesses must be non-snooped and all PCI accesses must snoop
> > the CPU caches.
> >=20
> > PCIe then had an extension which defined the "No Snooping
> > Attribute"=20
> > to allow emulating the AGP behavior.
> >=20
> > For the current PCIe 6.1 specification the non-snoop extension was=20
> > merged into the base specification.
> >=20
> > Here see section "2.2.6.5 No Snoop Attribute", e.g. "Hardware
> > enforced=20
> > cache coherency expected"
> >=20
> > As well as the notes under section 7.5.3.4 Device Control Register:
> >=20
> > Enable No Snoop - If this bit is Set, the Function is permitted to
> > Set=20
> > the No Snoop bit in the Requester
> > Attributes of transactions it initiates that do not require
> > hardware=20
> > enforced cache coherency (see Section 2.2.6.5 ).
> >=20
> > To summarize it: Not snooping caches is an extension, snooping
> > caches=20
> > is mandatory.
> >=20
> > > In addition, in the perspective of Linux, I think bypassing CPU
> > > cache
> > > of shared memory is considered as coherent access too, see
> > > dma_alloc_coherent() function's naming.
> >=20
> > Yes that's correct, but this is for platform devices. E.g. other
> > I/O=20
> > from drivers who doesn't need to work with malloced system memory
> > for=20
> > example.
> >=20
> > We have quite a bunch of V4L, sound and I also think network
> > devices=20
> > which work like that. But those are non-PCI devices.
> >=20
> > > > There are a bunch of non-compliant PCIe implementations which
> > > > have
> > > > broken cache coherency, but those explicitly violate the
> > > > specification
> > > > and because of that are not supported.
> > > Regardless of it violating the spec or not, these devices work
> > > with
> > > Linux subsystems that use dma_alloc_coherent to allocate DMA
> > > buffers
> > > (which is the most common case), and GPU drivers just give out
> > > cryptic
> > > error messages like "ring gfx test failed" without any mention of
> > > coherency issues at all, which makes the fact that Linux DRM/TTM
> > > subsystem currently requires PCIe snooping CPU cache more
> > > obscure.
> >=20
> > No, they don't even remotely work. You just got very basic tests
> > working.
> >=20
> > Both the Vulkan as well as the OpenGL specification require that
> > you=20
> > can import "normal" malloced() system memory into the GPU driver.
> >=20
> > This is not possible without a cache coherent platform
> > architecture.=20
> > So you can't fully support those APIs.
> >=20
> > We exercised this quite extensively already and even have a=20
> > confirmation from ARM engineers that the approach of attaching just
> > any PCIe root to an ARM IP core is not supported from their side.
> >=20
> > And if I'm not completely mistaken the RISC-V specification was
> > also=20
> > updated to disallow stuff like this.
>=20
> Googling helps:
> https://github.com/riscv/riscv-platform-specs/issues/83

riscv-platform-specs is a deprecated repository, and the specs are
never ratified by RVI. According to its content, it should be moved to
riscv-non-isa/, but the move didn't even happen. The successor of this
specific part, which is reduced to "server" context, is placed at
riscv-non-isa/server-soc, in a more specific form; however server-soc
is also not ratified yet either, and its CCS_040 item uses "SHOULD"
instead of "MUST" on "hardware enforced cache coherency".

>=20
> Regards,
> Christian.
>=20
> >=20
> > So yes you can have boards which implement non-snooped PCIe, but
> > you=20
> > get exactly zero support from hardware vendors to run software on
> > it.
> >=20
> > Regards,
> > Christian.
> >=20
> > > > Regards,
> > > > Christian.
> > > >=20
> > > > > > Unfortunately I don't think we can safely ttm_cached to
> > > > > > ttm_write_comnined, we've
> > > > > > had enough drama with write combine behaviour on all
> > > > > > different
> > > > > > platforms.
> > > > > >=20
> > > > > > See drm_arch_can_wc_memory in drm_cache.h.
> > > > > >=20
> > > > > Yes this really sounds like an issue.
> > > > >=20
> > > > > Maybe the behavior of ttm_write_combined should furtherly be
> > > > > decided
> > > > > by drm_arch_can_wc_memory() in case of quirks?
> > > > >=20
> > > > > > Thanks
> > > > > >=20
> > > > > > > +
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return =
ttm_prot_from_caching(caching, tmp);
> > > > > > > =C2=A0=C2=A0 }
> > > > > > > =C2=A0=C2=A0 EXPORT_SYMBOL(ttm_io_prot);
> > > > > > > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c
> > > > > > > b/drivers/gpu/drm/ttm/ttm_tt.c
> > > > > > > index 7b00ddf0ce49f..3335df45fba5e 100644
> > > > > > > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > > > > > > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > > > > > > @@ -152,6 +152,10 @@ static void
> > > > > > > ttm_tt_init_fields(struct
> > > > > > > ttm_tt *ttm,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum ttm_caching cachin=
g,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long
> > > > > > > extra_pages)
> > > > > > > =C2=A0=C2=A0 {
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Downgrade cache=
d mapping for non-snooping
> > > > > > > devices */
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!bo->bdev->dma=
_coherent && caching =3D=3D
> > > > > > > ttm_cached)
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0caching =3D ttm_write_combined;
> > > > > > > +
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ttm->nu=
m_pages =3D (PAGE_ALIGN(bo->base.size) >>
> > > > > > > PAGE_SHIFT) + extra_pages;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ttm->pa=
ge_flags =3D page_flags;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ttm->dm=
a_address =3D NULL;
> > > > > > > diff --git a/include/drm/ttm/ttm_caching.h
> > > > > > > b/include/drm/ttm/ttm_caching.h
> > > > > > > index a18f43e93abab..f92d7911f50e4 100644
> > > > > > > --- a/include/drm/ttm/ttm_caching.h
> > > > > > > +++ b/include/drm/ttm/ttm_caching.h
> > > > > > > @@ -47,7 +47,8 @@ enum ttm_caching {
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/**
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @ttm=
_cached: Fully cached like normal system
> > > > > > > memory,
> > > > > > > requires that
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices snoop t=
he CPU cache on accesses.
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices snoop t=
he CPU cache on accesses.
> > > > > > > Downgraded
> > > > > > > to
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ttm_write_combi=
ned when the snooping
> > > > > > > capaiblity is
> > > > > > > missing.
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ttm_cac=
hed
> > > > > > > =C2=A0=C2=A0 };
> > > > > > > --=20
> > > > > > > 2.45.2
> >=20


