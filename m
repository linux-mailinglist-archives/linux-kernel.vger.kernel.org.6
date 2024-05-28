Return-Path: <linux-kernel+bounces-192717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A08D2132
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D52850E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB48171E72;
	Tue, 28 May 2024 16:06:51 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536516D4E6;
	Tue, 28 May 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912411; cv=none; b=OyDmKXVV9XNxJhvjkjdmbgzCNquk9u5hWnfZm/Ap1NDM8kajlOJxatFphRPdU0w3nqEHkKwxVdV/gyAe2116xRmGvAvrQJ7Gmk6EnrCH8LiUIBadVbc4k+vP1wJ0aEpQpPVdb+PBRFsetr/dD8Pabs0ai3CgpvAf5xYlsOujtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912411; c=relaxed/simple;
	bh=Zpd8VaZ4kpve3RgfgE7Y6EHE5OBche0E0cu/WMORRHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWurVj4mGH17DtF/bIeLQBtXwxkSRSlYhNvbDXiXSsRhB9SSWKBFeLPD1Uw8cEBse3dYTETQZXNApvPojM5n/Q2d3XGDd0z7olZc6k3AiF41yB50l0Y+RCp+RyzS8/6PvkyJge7PveLOR92yMQte9V52vSFDu3o5Ut/fk+L+Po0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e95a60dfcdso11271631fa.1;
        Tue, 28 May 2024 09:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716912407; x=1717517207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiWUEGRw3sA0Rlo7cpstCK8d71HbP2QWoWmJdKUJYOs=;
        b=l0qX2LH+aaGN3l6P0mfRvOPmrQV5yALbUuqAFjUBmgrxshaOHdbrmLop4CoJoVxB1/
         WF0pHqd+uDgLaGLZwRcH0BwPjmxVlqZCpyOp5Tp6VNKnsdi4DqnYdMGsIauQ7XxfxKok
         Zwcn23mnFrYEP/qgW5twyXpuXpW+8YSTtQhT0z1Q73Vxa/HOt3ZB7UKuC7tfyEYXoL2X
         XcOgdQIkKrHOgRVGBrifRbaxS6lnylmGL6sBBGstMNlWabHJQW5AqfcckoYMm+OZmPoq
         dN77BQMaacHxEBaP/A+QB8h6kMm0lBQJdc8z78g6PjQ34P5e/zdEUm+sPgGwVxqLiekD
         cc+g==
X-Forwarded-Encrypted: i=1; AJvYcCXBBiEV9xcmiXfJw6T8IZ/ycjsTC6GjInR01P2+ticmDeBBy4+y7dtpXiINUB1mTf0rVhE37mD7IKJF/K9RgtbtctsVyqPAqST+RmulU9Ga5/qIgzFbGKhS66KZVtb7Y77D5UsCUvRbyg==
X-Gm-Message-State: AOJu0YzNrTkk7avRCCI+AfQ7XglF7+lsxeds+nmp+98nkro6Tarom2hU
	QPkpRrVwwwmjVoP5xas5VdoPlAmPDMLhGTTxit140hZTE//xOCEXbWXcJnMe
X-Google-Smtp-Source: AGHT+IFbAHcPYi/1oC0uxr3yZMxBIABWlJ6f4ZDnAxB+o9V04JdRMcakscsJeUAj/kNN3TkVyfhJCA==
X-Received: by 2002:a05:651c:234:b0:2e9:8471:f88e with SMTP id 38308e7fff4ca-2e98471fd3cmr25212971fa.19.1716912407013;
        Tue, 28 May 2024 09:06:47 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e98446942csm3616421fa.8.2024.05.28.09.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:06:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e95a60dfcdso11271241fa.1;
        Tue, 28 May 2024 09:06:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/wauuiRHgt92ywtyEM7JPaT/cmd9Ae1r2RVR7R28YzakQM3fPPM7Xf1QiGrP7bknKZO9Mct4d+ZwrTKTnQgUVmyoOzGbUGKGMCDzs/55sxyolhUXwKY/zTUQJBUEIsQ4LFEP9Op+QiQ==
X-Received: by 2002:a2e:2e0d:0:b0:2e9:5966:790a with SMTP id
 38308e7fff4ca-2e95b1cc478mr74542041fa.15.1716912406795; Tue, 28 May 2024
 09:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
 <171691117471.681554.6744393893618279840.b4-ty@csie.org> <CAGb2v64ETOtHxQf1D9n+c9bGivsRTC=O8swDru+2cX2UT=o0qw@mail.gmail.com>
 <803a939c62b3ac4ced7ac49f18efd723@manjaro.org>
In-Reply-To: <803a939c62b3ac4ced7ac49f18efd723@manjaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 29 May 2024 00:06:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v66vFh4twtsT_ZojGe14k_kvAm8Y9AHBRikDLp626u8iOg@mail.gmail.com>
Message-ID: <CAGb2v66vFh4twtsT_ZojGe14k_kvAm8Y9AHBRikDLp626u8iOg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
To: Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:02=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Chen-Yu,
>
> On 2024-05-28 17:56, Chen-Yu Tsai wrote:
> > On Tue, May 28, 2024 at 11:46=E2=80=AFPM Chen-Yu Tsai <wens@csie.org> w=
rote:
> >>
> >> On Sun, 28 Apr 2024 13:40:36 +0200, Dragan Simic wrote:
> >> > Add missing cache information to the Allwinner H6 SoC dtsi, to allow
> >> > the userspace, which includes lscpu(1) that uses the virtual files p=
rovided
> >> > by the kernel under the /sys/devices/system/cpu directory, to displa=
y the
> >> > proper H6 cache information.
> >> >
> >> > Adding the cache information to the H6 SoC dtsi also makes the follo=
wing
> >> > warning message in the kernel log go away:
> >> >
> >> > [...]
> >>
> >> Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!
> >>
> >> [1/1] arm64: dts: allwinner: Add cache information to the SoC dtsi for
> >> H6
> >>       https://git.kernel.org/sunxi/linux/c/c8240e4b0fd2
> >
> > OK, that's weird. Somehow b4 thought this patch was v2 of the A64 patch
> > [1].
> > Looks like they are threaded together because this patch has
> > "In-Reply-To".
> >
> > Please avoid it in the future.
>
> I'm sorry for that.  I noticed that back when I sent the patches to the
> mailing list, but didn't want to make some noise about that.  The root
> cause was some missing configuration for "git send-email", which
> resulted
> in adding troublesome threading-related headers to the messages for the
> individual .patch files that in fact were correctly created by running
> "git format-patch".
>
> Do I need to resend the patches?

No. I figured it out.

