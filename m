Return-Path: <linux-kernel+bounces-385542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999EF9B385E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8641C223E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35451DF735;
	Mon, 28 Oct 2024 17:57:52 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C021106;
	Mon, 28 Oct 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138272; cv=none; b=gGUgxlGmGbSzly/809vuPd9I8232OBfOf1YLoY2HK3mwCtIXQZMjNvT0rrhn0LoYjiSk94JTnUU2ck4nWoJGqROjErZxlhE3pye++om/uTaid1u6lbbymA/GMZm7q89C6boUdZy4JzyUBaZI19kqYaXPH3F0Gjf8vdpiu6Xk5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138272; c=relaxed/simple;
	bh=9n2kql9SOdKu6PRWDOsoEfPHOf5PZ6YTER7Rby7nT7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l21Dv8pBgsp74uwYpoVG2kdHS4UXEo7NVJJHR5VyDOkl67bXIaP9lGhebpZGf63YSPMesZ6jMvASZ7W9SZSUPL3lpyoUzVYx/3yCNA30H6HYSHubF0k/Rbrbi/thvIqyjcgdiFLkdo9tbNEzkBeGRkrLKFT1LxZ9iI61/BM8kns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e39bf12830so33479927b3.1;
        Mon, 28 Oct 2024 10:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730138269; x=1730743069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLLFa6WS4xfeiEtOHxziXZIgc98NLKWXcmokIkVFE5s=;
        b=HD4f62auDOV6tIoIc3VNKjQ0SvnFTSgeL8Sbfk8E8faCxY+ZEP2diithaH7ewUMElf
         HSujJYwuSVk/FNPOJ5FdLPd8DaQZsNgDSKg4yEsa7Kyex9D+5SR+pvf4Rd55Qh2qCsGa
         p+YeCoDXgPSfk4rhuhfbogZ14+xkJflH6ln/Uc3m55XJQnYgWOBIVuBcGISoTExlFnDC
         vorOkOHa/TYx3iWtkww06A/s0Pl3aPsgsZ5co9gJKyDjVo9Dyiovf6UHvi+w2iaamg0r
         ASphSPwBXxUSD/WIf3dPEqIC39OBTW7UvKT1eRyuKvnRVg9kXyZw9Muj1e9vcv3LbYQQ
         NI+A==
X-Forwarded-Encrypted: i=1; AJvYcCWdjY6wJhtL/6vGNxrjW7S7Jr3WQMC2loUkeJnN5NDxc5T4EwHP27GA6lwHAUsR1T10SX1CywNuf7xrL7E+@vger.kernel.org, AJvYcCXM9lzVz5o854fS3Kfkv9kziqFLu6YSa3N/+Tj/wb7FKDAnUa3bL4QtxfFv8m4Q3K4fTnatQYnEZ3bC@vger.kernel.org
X-Gm-Message-State: AOJu0YzAegJCWiGgy8CWxLbJI83GQXWXFjl0PrQRc4JsAS3NI090Z1OI
	jURLWKr1S9S1MpfL+9Id2yBOtgUgOChZ2m+pePDdjq+sFbJgpmz5mIo8Gks+
X-Google-Smtp-Source: AGHT+IHsa1ltsWOZLCvylljjjxP+724mRZ7QqT/iP5IFvx09mgnH+ZSgO6WfTgWDk5eFoEN18icaxA==
X-Received: by 2002:a05:690c:60c3:b0:64b:b7e:3313 with SMTP id 00721157ae682-6ea22daffadmr7117777b3.13.1730138268569;
        Mon, 28 Oct 2024 10:57:48 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c18650sm15121487b3.64.2024.10.28.10.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:57:48 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e330b7752cso39391987b3.1;
        Mon, 28 Oct 2024 10:57:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpbrxBHHgkOc9OvGBOWH/Qu4Uk2bclOQWt6t/bnwVj/uaHdFBkVHD55KPJqkDIFB+afiBP60353PMOkUN3@vger.kernel.org, AJvYcCWvrNJSuxIK85dKmKerlWQuoyMRWBBuSJsqqpZ7Y3vVwhFq9XqTp5jZQAeXFUmZUL20u4C9/nh4DIC7@vger.kernel.org
X-Received: by 2002:a05:690c:9a06:b0:6e3:1d8c:1224 with SMTP id
 00721157ae682-6ea22e5e851mr6027417b3.20.1730138268189; Mon, 28 Oct 2024
 10:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
 <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com> <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
 <a65e17e9-0055-4e5a-902f-8ee2807a86df@ti.com> <299b6b75-beef-46aa-9203-b96009226677@solid-run.com>
In-Reply-To: <299b6b75-beef-46aa-9203-b96009226677@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Oct 2024 18:57:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW6p-xp96rXqt_dhSNkJSmyQCrh+EOmHv9vgiAWyioMOQ@mail.gmail.com>
Message-ID: <CAMuHMdW6p-xp96rXqt_dhSNkJSmyQCrh+EOmHv9vgiAWyioMOQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
To: Josua Mayer <josua@solid-run.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Mon, Oct 28, 2024 at 6:19=E2=80=AFPM Josua Mayer <josua@solid-run.com> w=
rote:
> Am 28.10.24 um 16:31 schrieb Vignesh Raghavendra:
> > On 25/10/24 19:27, Geert Uytterhoeven wrote:
> >> On Mon, Feb 19, 2024 at 4:05=E2=80=AFPM Josua Mayer <josua@solid-run.c=
om> wrote:
> >>> HummingBoard-T features two M.2 connectors labeled "M1" and "M2".
> >>> The single SerDes lane of the SoC can be routed to either M1 pci-e
> >>> signals, or M2 usb-3 signals by a gpio-controlled mux.
> >>>
> >>> Add overlays for each configuration.
> >>>
> >>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >> Thanks for your patch, which is now commit bbef42084cc170cb ("arm64:
> >> dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3") in v6.=
9.
> >>
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
> >>> @@ -0,0 +1,44 @@
> >>> +// SPDX-License-Identifier: GPL-2.0+
> >>> +/*
> >>> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
> >>> + *
> >>> + * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +/plugin/;
> >>> +
> >>> +#include <dt-bindings/phy/phy.h>
> >>> +
> >>> +#include "k3-serdes.h"
> >>> +
> >>> +&serdes0 {
> >>> +       #address-cells =3D <1>;
> >>> +       #size-cells =3D <0>;
> >>> +
> >>> +       serdes0_link: phy@0 {
> >>> +               reg =3D <0>;
> >>> +               cdns,num-lanes =3D <1>;
> >>> +               cdns,phy-type =3D <PHY_TYPE_USB3>;
> >>> +               #phy-cells =3D <0>;
> >>> +               resets =3D <&serdes_wiz0 1>;
> >>> +       };
> >>> +};
> >>> +
> >>> +&serdes_ln_ctrl {
> >>> +       idle-states =3D <AM64_SERDES0_LANE0_USB>;
> >>> +};
> >>> +
> >>> +&serdes_mux {
> >>> +       idle-state =3D <0>;
> >>> +};
> >>> +
> >>> +&usbss0 {
> >>> +       /delete-property/ ti,usb2-only;
> >> /delete-property/ (and /delete-node/) to delete something in the base =
DTS
> >> does not work.
>
> My understanding is that flags are equivalent to boolean, i.e:
>
> ti,usb2-only =3D <true>;
> ti,usb2-only;
>
> are equivalent.
>
> If so, can we assign <false> within the overlay?

Unfortunately not. My first thought was "it depends on the actual code
in the driver", but that turns out to be wrong:

    static inline bool of_property_read_bool(const struct device_node *np,
                                             const char *propname)
    {
            const struct property *prop =3D of_find_property(np, propname, =
NULL);

            return prop ? true : false;
    }

    static inline bool of_property_present(const struct device_node
*np, const char *propname)
    {
            return of_property_read_bool(np, propname);
    }

So both methods just check if the property is present, and do not use
its value, when present (i.e. the former does not "read" the bool).

drivers/usb/cdns3/cdns3-ti.c uses device_property_read_bool:

    static inline bool device_property_read_bool(const struct device *dev,
                                                 const char *propname)
    {
            return device_property_present(dev, propname);
    }

so (at least for DT) that should map to the above.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

