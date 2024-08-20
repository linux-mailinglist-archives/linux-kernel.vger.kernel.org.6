Return-Path: <linux-kernel+bounces-294466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E271D958E09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E1728517B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77D149C55;
	Tue, 20 Aug 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="WhzRiwtq"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849A28F0;
	Tue, 20 Aug 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178640; cv=none; b=SX5AF+UT2WKqBXBgHRsFCnEN/lDaEAGkAdF2JkzWGoyWuDgURA9XyxUV0hOOdst87yN7ZeMdXnbzM/+sfmbkX2Nstrn2jbYXzuZG0okvwCBHJ8Kru43mUQha8snK7VqbKnpAkJHZLREc+dcEiqip6oryhEyl1OzKIr08iCiCX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178640; c=relaxed/simple;
	bh=lyONSAiHnO9A/uyqc2x+1bYbhIG90BN4LG/4mceQZUM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/wyBNdxNn/D0Wn9nCLV7O6zjxF0PhF3fKRFqXiaUmXar1/e5Bd4EZjKWhw+mHOCeiyo3JsG1b4Xd54Z+oE8C0agyBgzH+p8bCU1vRSKU70jXba0gnJgZ/UE+3kGA15sXjwgkRxlZe4R4uSoRC16slMonfIcg8mIXkpK5ocVYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=WhzRiwtq; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724178636; x=1724437836;
	bh=0n/oSaJkqjOdH7gRxT0hT5ott8K5LJiZdcjWBrNUqNM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WhzRiwtqoS4C6FaUcPPZ8IyWNnRtLxl5vmwaTnY7odY+cthgli2kZn19Q/MZ+GUDX
	 q9RzuxhCIXzDfPRC3fSS4zgtC6S/jv4xW7uFXQ/EcRR0PuJ8J8GrE0CPZMFfdXeGpe
	 +mlqKbfOeMNZyATSDD3ssTbL8nC+G8+qSXeyyS+v8LyccvVFTxx6z87FzTUVwtpBPg
	 fOqQwODxsTtOGib9bLVtK4L8dvNavnuEtbafi6JXPPp36qGSgsM/TtVKjYmRkQ7+6w
	 PDcfmu7CG5yeKr81qVwMDB2nZTOeOUvnyAKCtpS4ZLiCCx7WVIF5HHMrsrv/77HLxq
	 gNc2LY3LSHIVA==
Date: Tue, 20 Aug 2024 18:30:33 +0000
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 6/9] clk: clocking-wizard: add user clock monitor support
Message-ID: <D3KYBAJXSWWV.3S8LKAX01TCAM@protonmail.com>
In-Reply-To: <SA1PR12MB89477EFB7053170705AB6591818C2@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20240803105702.9621-1-hpausten@protonmail.com> <20240803105702.9621-7-hpausten@protonmail.com> <SA1PR12MB89477EFB7053170705AB6591818C2@SA1PR12MB8947.namprd12.prod.outlook.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 863b9df8a71802357742bf0467ff6b097a9960fe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Aug 19, 2024 at 1:39 PM BST, Datta, Shubhrajyoti wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
...
> >
> > -static const struct versal_clk_data versal_data =3D {
> > -       .is_versal      =3D true,
> > +static const struct clk_wzrd_data version_6_0_data =3D {
> > +       .is_versal              =3D false,
> > +       .supports_monitor       =3D true,
> >  };
>
> The clocking wizard monitor support is a design choice.
> This will enable it for all the designs.

But the interrupt still has to be described in devicetree for the auxiliary=
/UIO
device to be registered. The interrupt is only used by the core for the clo=
ck
monitor functionality, so if that functionality is not built into the hardw=
are,
then the interrupt description should be omitted. Does that not sound sensi=
ble
to you?

>
> >
> > +static const struct clk_wzrd_data versal_data =3D {
> > +       .is_versal              =3D true,
> > +       .supports_monitor       =3D true,
> > +};
>
>
> Same here.

Same reasoning as above.

Thanks for the review!
Harry

>
> > +
> > +static void clk_wzrd_unregister_adev(void *_adev) {
> > +       struct auxiliary_device *adev =3D _adev;
> > +
> > +       auxiliary_device_delete(adev);
> > +       auxiliary_device_uninit(adev);
> > +}
> > +
> > +static int clk_wzrd_setup_monitor(struct platform_device *pdev) {
> > +       struct device *dev =3D &pdev->dev;
> > +       const struct clk_wzrd_data *data =3D device_get_match_data(dev)=
;
> > +       struct clk_wzrd *clk_wzrd =3D dev_get_drvdata(dev);
> > +       struct auxiliary_device *adev =3D &clk_wzrd->adev;
> > +       int ret;
> > +
> > +       if (!data || !data->supports_monitor)
> > +               return 0;
> > +
> > +       adev->name =3D "clk-mon";
> > +       adev->dev.parent =3D dev;
> > +       adev->dev.platform_data =3D (__force void *)clk_wzrd->base;
> > +
> > +       ret =3D auxiliary_device_init(adev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D auxiliary_device_add(adev);
> > +       if (ret) {
> > +               auxiliary_device_uninit(adev);
> > +               return ret;
> > +       }
> > +
> > +       return devm_add_action_or_reset(dev, clk_wzrd_unregister_adev,
> > +adev); }
> > +
> >  static int clk_wzrd_register_output_clocks(struct device *dev, int
> > nr_outputs)  {
> >         const char *clkout_name, *clk_name, *clk_mul_name;
> >         struct clk_wzrd *clk_wzrd =3D dev_get_drvdata(dev);
> >         u32 regl, regh, edge, regld, reghd, edged, div;
> > -       const struct versal_clk_data *data;
> > +       const struct clk_wzrd_data *data;
> >         unsigned long flags =3D 0;
> >         bool is_versal =3D false;
> >         void __iomem *ctrl_reg;
> > @@ -1170,6 +1216,10 @@ static int clk_wzrd_probe(struct platform_device
> > *pdev)
> >                 return -EINVAL;
> >         }
> >
> > +       ret =3D clk_wzrd_setup_monitor(pdev);
> > +       if (ret)
> > +               return dev_err_probe(&pdev->dev, ret, "failed to setup
> > + monitor\n");
> > +
> >         ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs)=
;
> >         if (ret)
> >                 return ret;
> > @@ -1204,7 +1254,7 @@ static const struct of_device_id clk_wzrd_ids[] =
=3D {
> >         { .compatible =3D "xlnx,versal-clk-wizard", .data =3D &versal_d=
ata },
> >         { .compatible =3D "xlnx,clocking-wizard"   },
> >         { .compatible =3D "xlnx,clocking-wizard-v5.2"   },
> > -       { .compatible =3D "xlnx,clocking-wizard-v6.0"  },
> > +       { .compatible =3D "xlnx,clocking-wizard-v6.0", .data =3D
> > + &version_6_0_data },
> >         { },
> >  };
> >  MODULE_DEVICE_TABLE(of, clk_wzrd_ids);
> > --
> > 2.46.0
> >



