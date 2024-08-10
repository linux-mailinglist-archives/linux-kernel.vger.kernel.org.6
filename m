Return-Path: <linux-kernel+bounces-281915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D406094DCEA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 14:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31984B214EC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F715886A;
	Sat, 10 Aug 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="dnrTkd9S"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552416DC17;
	Sat, 10 Aug 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723293600; cv=pass; b=mFsVYWWWCVliZl/yi+XBmkPPxW2MN1UiMHqxqx8oRqCYis6KuplHmd89tmAZcj+DnZGDgtNGju6bvKrsmW0wj7PxUeE4ymQA5sPIy0OxF3an8yAm52Imz2+9t7Ix9134adoLMTMPFIlwk0TX8L8ST3Lla0eX0ZC0UqMz4vQMlRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723293600; c=relaxed/simple;
	bh=x8CC5Hli2VvYPqemvO/qI3GDNvN29YYbcLL0ZYScO44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNRBTnsQXdv9VvMEw75Bigja7aQqHmmnAPyT/ktNoppqWJvTymLO9YSG8WLQw/+OgjnWiXwDyKnyJ9aR05liDCk9zgtNufMxFBBcYDmPbSDbAlhfERMBlvSNUrLHjxF2XbTIFPmzHvdzVXCsWEcN0XuoaNoXcDTfbzrilmpqS/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=dnrTkd9S; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: angelogioacchino.delregno@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723293583; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QyH4Jwd6Yg/lZk16RtIbLj59ifl+n7IAOWwawevdrzZkyGl1vf/HWs8oVam+J1/Y0O9e5YBfwYWfvvAsltY382lXRV1NeSnrAtEkXrxfxvWwt18aV3Mud78OTpOAcijmaiCbUuOrRI/Oe/nhTRmVVJGjQj/gH3Zstv0u/vwhVuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723293583; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x8CC5Hli2VvYPqemvO/qI3GDNvN29YYbcLL0ZYScO44=; 
	b=QlNoixQi4+N3pIHjUYAGhfZjBJsdQPo6yr08em3TTlsZGUDf6S0X7Ap91R3mcMV0/9Zs2/rBKMpKiBg+ctmqM/99FWzCsGhRv2TAsx791VA32X2UqTIFKzLO62E4IgT6Mje6Av2o4zR90sYPS3nw7WvY7tHqRHo7ZvVsBxEeths=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723293583;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=x8CC5Hli2VvYPqemvO/qI3GDNvN29YYbcLL0ZYScO44=;
	b=dnrTkd9SWhYGrJ+/Tk3ZPwexyIF2n15RKjCfxksh12KUze0cwI75TaqgT/t7W/td
	dvZ8NsNXuqDXbGA9rbMbUANzHfYttZl1YMtwK8TVRNPMGp5M8cbMMRQEHwHemP80poD
	ioKw+dOSz8vJVFaHEVfskxE34ya9ZK8JFHMjpjggv9klLmLCb9v4kFC61JLAeSF4Fr8
	fI8qQCNhCKRnmWYvVkGrRq2SlDEQ/rfPnEEk2wG0p4C9xpVu0Gf9XSc3nA57sfHXiJG
	znOxFqKoVNOcx1efLcfJX8OgeB4dhR4xSbuwuy8tae7KUHJd32r2rh9FKKz1279d/rJ
	J439K7+2HA==
Received: by mx.zohomail.com with SMTPS id 1723293581631329.92947824948465;
	Sat, 10 Aug 2024 05:39:41 -0700 (PDT)
Message-ID: <77dc97aa009ae6eb54c616ac03cd85817836f0cf.camel@icenowy.me>
Subject: Re: [PATCH 4/6] drm/imagination: Add compatible string entry for
 Series6XT
From: Icenowy Zheng <uwu@icenowy.me>
To: Frank Binns <Frank.Binns@imgtec.com>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>, Matt
 Coster <Matt.Coster@imgtec.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>,  "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "wenst@chromium.org"
 <wenst@chromium.org>,  "mripard@kernel.org" <mripard@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, 
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,  "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Date: Sat, 10 Aug 2024 20:39:31 +0800
In-Reply-To: <efdacd820d13368816973f57c4a817e039ec4a2d.camel@imgtec.com>
References: <20240530083513.4135052-1-wenst@chromium.org>
	 <20240530083513.4135052-5-wenst@chromium.org>
	 <efdacd820d13368816973f57c4a817e039ec4a2d.camel@imgtec.com>
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
X-ZohoMail-Owner: <77dc97aa009ae6eb54c616ac03cd85817836f0cf.camel@icenowy.me>+zmo_0_

=E5=9C=A8 2024-05-31=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 11:18 +0000=EF=BC=
=8CFrank Binns=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 2024-05-30 at 16:35 +0800, Chen-Yu Tsai wrote:
> > The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is
> > part
> > of the Series6XT, another variation of the Rogue family of GPUs.
> >=20
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > =C2=A0drivers/gpu/drm/imagination/pvr_drv.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/gpu/drm/imagination/pvr_drv.c
> > b/drivers/gpu/drm/imagination/pvr_drv.c
> > index 5c3b2d58d766..3d1a933c8303 100644
> > --- a/drivers/gpu/drm/imagination/pvr_drv.c
> > +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> > @@ -1475,6 +1475,7 @@ pvr_remove(struct platform_device *plat_dev)
> > =C2=A0
> > =C2=A0static const struct of_device_id dt_match[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "img,=
img-axe", .data =3D NULL },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "img,power=
vr-6xt", .data =3D NULL },
>=20
> I assume that by adding this to the list of supported devices we're
> essentially
> freezing the existing uapi. This concerns me, as we've not yet
> started running
> Vulkan conformance on any Series6XT GPUs and there's a chance we may
> need to
> make some tweaks.

Is there anything in the Series 6 XT GPUs that will affect conformance
test and need new ABI to drive? Well I think the GX6250 GPU has TLA
despite AXE (and BXE) has none, but what TLA does seems to be for
transfer jobs, which we already support by using fragment pipeline?

In addition, if we add bits to the ABI, we can recognize the new ABI by
raising the version number returned by the DRM driver.

And, if my understand is right, I think we're keeping the command
stream the same among different GPUs, so if the FWIF is changed, it's
quite possible that every GPU, not only S6XT but also AXE will be
affected too.

>=20
> I'm not really sure what the accepted approach is to hardware
> enablement /
> experimental support. I'm not sure if it's sufficient to hide support
> behind a
> Kconfig option and/or module parameter or whether we just have to
> hold this
> patch back for the time being.
>=20
> Thanks
> Frank
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> > =C2=A0};
> > =C2=A0MODULE_DEVICE_TABLE(of, dt_match);


