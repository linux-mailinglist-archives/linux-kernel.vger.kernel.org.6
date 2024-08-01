Return-Path: <linux-kernel+bounces-271455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA43944E71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD1A1C222A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744311A71EA;
	Thu,  1 Aug 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pnvgvn8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79912F32;
	Thu,  1 Aug 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523758; cv=none; b=YAVxRYiKIByTu/WIDrIOwGj1saveOkp2/aEDjlstrXm2a2N8qKGZX63Z5oVRaUnt0WJIad3aZJnAVpanO7SddfHGvzYigrdtlUI3hC7foHIdKRLEWQw5q2XldgydTM3oBvrIjQLF6jebvkNYkZPupqLVCBZLWcdD8zKh9rfyxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523758; c=relaxed/simple;
	bh=vzyH6OgkHFahyzizx6mkWMFnekHvMp91Ck+iH8k1SVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fbkn3TtIARXASqB9IvDM3CI2M3cq9HRwgtb2MjQ9RiXzlDcnLjYh9Onx8M9gk5q+/glkJmUrHkG08aIELI8jKNwK74YRdPw1bibhUeScL3mXcIU0uaWGx6peYijrs/zFIRIGiWP3NYIZTwyA2y10d25zPMSkGFCifQTiBF34Ap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pnvgvn8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96390C32786;
	Thu,  1 Aug 2024 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722523758;
	bh=vzyH6OgkHFahyzizx6mkWMFnekHvMp91Ck+iH8k1SVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pnvgvn8FOv/edb4IrGvtTgp0GI4u10GvMFrkYRx9MJdrgBfxgJyhrLYQ96DbheXpo
	 KV0wR1ERDl8LgKjARVsIJyefj/R4Ht6356WWVqINOzbKa7AZUkksY2cJsGlYc3Bt3s
	 fjONBpMAKoaGswX7+Em22dBu89CwFq5A75ggVn/qpZ8En5/9VRlCpzwIY/1HyDQFoz
	 pHFf1QwraEIgNUKR1c2vUPzEO75WFvSgyp/SVCxjczy+77VAiFlTp8/kMFD5m52D0L
	 u7WayALIp4xrMoNoO2AbVy0xXko2UHFhz5R811WxK9W5rawgCXT6HxGSbUPVCWcZbj
	 XOBHSpUnf9FBg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f032cb782dso75878801fa.3;
        Thu, 01 Aug 2024 07:49:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyr5iswRbt7Kwh/XgMwKu1BJWTWzfFAuzlYhaOie9t05fml5W6UQ2U6CHAS113SOhB5sFpn4hvgj79xUVFksGoQA9WX5fQfiRR+k5aL5cJvfs7daFOKEQ9+mD62yfXTeHZozuwRxjXhQ==
X-Gm-Message-State: AOJu0Yy+xPzhYUWDlNMfEGugpgqaGWNJRIgUh7tcQSdWQMLSmGR+2kck
	w63pymcp6lut7ZbP58qgAGpMg5A9MXrpKooVHtHs6TcOBhxgDnVs7LkW3AZ8/jXQSxoAt/lJh1a
	Lum/7RsoVTZibZrMEfkbWb9XhLA==
X-Google-Smtp-Source: AGHT+IFhOE6NLKA1ffHukMgs6IA+lBCzhaXHSDKsXLEsl2g/ajP2Hgu8VD4gVg0/eJ4APZ0Mpu+DOIJa0sONnQ4Y0p4=
X-Received: by 2002:a2e:7a1a:0:b0:2f0:1e0a:4671 with SMTP id
 38308e7fff4ca-2f15aa836a4mr3979041fa.4.1722523756933; Thu, 01 Aug 2024
 07:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2046da39e53a8bbca5166e04dfe56bd5.squirrel@_> <CAL_JsqKpTKv-fthwD9bFHiVESJyNP6uMg7Px7Rh+-k583oz76g@mail.gmail.com>
 <1c7955e8b5f0cdb3c60381a9a7dbbf42.squirrel@_>
In-Reply-To: <1c7955e8b5f0cdb3c60381a9a7dbbf42.squirrel@_>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Aug 2024 08:49:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Wcag2Lzu_kLRb5ia=3hNUOs1Ny93Y541eOY-NZOA5qw@mail.gmail.com>
Message-ID: <CAL_Jsq+Wcag2Lzu_kLRb5ia=3hNUOs1Ny93Y541eOY-NZOA5qw@mail.gmail.com>
Subject: Re: [PATCH v2] of/irq: Make sure to update out_irq->np to the new
 parent in of_irq_parse_raw
To: WHR <whr@rivoreo.one>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:22=E2=80=AFPM WHR <whr@rivoreo.one> wrote:
>
> > On Mon, Jul 29, 2024 at 11:54=E2=80=AFPM WHR <whr@rivoreo.one> wrote:
> >>
> >> Commit 935df1bd40d43c4ee91838c42a20e9af751885cc has removed an
> >> assignment statement for 'out_irq->np' right after label 'skiplevel',
> >> causing the new parent acquired from function of_irq_find_parent didn'=
t
> >> being stored to 'out_irq->np' as it supposed to. Under some conditions
> >> this can resuit in multiple corruptions and leakages to device nodes.
> >
> > Under what conditions? Please provide a specific platform and DT.
>
> I have a previous email sent to you before I came up with the fix. The ke=
rnel
> log for debugging and the device tree blob are attached again.

Thanks. The patch needs to stand on its own with this detail, not
require that I've read (and remember) some other email among the
1000s.

"multiple corruptions and leakages to device nodes" is meaningless. Be
exact, it's device_node refcounts we're talking about. The issue is
out_irq->np is not updated from 'usbdrd' node to the real interrupt
parent, the 'plic' node. In the next iteration of the loop, we find
'interrupt-controller' in the plic node and return, but out_irq is not
pointing to the plic. Then of_irq_get() fails to get the irq host and
does a put on out_irq->np which is usbdrd, not plic node.

So please update the commit msg and provide your name, not initials.

>
> > Honestly, I think the DT is wrong if you get to this point. We'd have
> > to have the initial interrupt parent with #interrupt-cells, but not an
> > interrupt-controller nor interrupt-map property to get here. Maybe
> > that happens in some ancient platform, but if so, I want to know which
> > one and what exactly we need to handle.
>
> So you suggest the #interrupt-cells is erroneous in that node, and should=
 be
> removed?

Yes. dtc warns about this. dtschema would too if there was a schema
(there is, but not since you use a downstream binding).

The clint node has the same issue.

> This is a device vendor-provided DT, so any issue in it will have to be f=
ixed
> locally.

Complain to your vendor...

Rob

