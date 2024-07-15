Return-Path: <linux-kernel+bounces-252269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F89310C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DBD1F22008
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A118508B;
	Mon, 15 Jul 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VuaxaiBV"
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A75223
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034209; cv=none; b=CgnCM28P1KSlVfhnjNpq2mB1Rls/WQtyuL89Z3Pkl1QflgFEonsFf2EayuAuG2899ftXJ1x4K9lqYapCSoE5LzMyjzrBzoWhZv3Z1B0b4H8zbXx/PaXSUThOXfurRzo9sPCSqWhOOYU2XkFOM2MiemYUziFYn2GIeeCSN6QzSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034209; c=relaxed/simple;
	bh=m7mpypT7A9lWrLUE6kRCZiELxHoexNB2ed/Ybvjb/Jo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4c3FjsZICxRM0h8zWKjrNd8x4hjWZJbE6lqW3786fvhSdyuR/GqM54yehNtS6kcGMxpjL9uKQSvaU8O3SBaSC6Whq2BZKC68ZCjsq4tZoONvchAYKTKhe2qwZnVaKKbmYz1I6P+lBdjtG+zLR1ALA0LE2c7gcNCjrYgvbvike0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VuaxaiBV; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721034201; x=1721293401;
	bh=Rh1XXh7/ik0ZL1L+T+LFAMCIx/2EPcBnpQD45dMNZiY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VuaxaiBVEjkjw0tbhFFVh6ZgqgU5uACo4wEd+LC9J/dOz+2D+xJhp97nJwbUcUZIj
	 c2USWHb7kOivSXEDxhN66tdO02I66aPtSQif9S1OiuIOO3EOdt5DE8puLXMXaicXJ6
	 ub/QfeK7nLcLwfC0yuAtIN5qj6UvycKXsTFfjXLvshrQYVGvGWK3K4FNHnE9KoLX5L
	 yPrFTQXcvokBjPi0VHZZOAx5r+7lkBUI/ohPHGr9hU0cEilN01nKovEMplAvPhH50/
	 oBflqCf9fbQGAwGolFYJFG6HVy9h5g0nKed3tTLpu+NbfUm4LnEFZaiUCIeCeFBjM8
	 dZU76kan33zPw==
Date: Mon, 15 Jul 2024 09:03:17 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Tj <tj.iam.tj@proton.me>
Cc: Marek Olsak <Marek.Olsak@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "1075713@bugs.debian.org" <1075713@bugs.debian.org>
Subject: Re: Regression: firmware/sysfb.c device path
Message-ID: <-sJINpD9sbYc288gXp2-Tf5w6diSusXAP8mM8l0mnLWfIXgjuNe1LBgkqQ2indMJOehVrPUPO3UMQ-AvObgCWUW9h_TepvcNy9gnqfvoyvM=@proton.me>
In-Reply-To: <1eb659d8-536e-401b-a427-19709a98953a@suse.de>
References: <lLyvPFC_APGHNfyGNHRpQy5izBikkaTPOpHooZIT3fFAoJPquSI31ZMueA99XTdr8ysir3X7O7IMdc6za-0m79vr_claeparHhoRouVgHOI=@proton.me> <1eb659d8-536e-401b-a427-19709a98953a@suse.de>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: e3740516a51fef1e5d353400cc34a44ba77c7f87
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, 15 July 2024 at 07:44, Thomas Zimmermann <tzimmermann@suse.de> w=
rote:

> > See hw/xfree86/fbdevhw/fbdevhw.c::fbdev_open()
> >
> > https://gitlab.freedesktop.org/xorg/xserver/-/blob/master/hw/xfree86/fb=
devhw/fbdevhw.c?ref_type=3Dheads#L381
>
>
> Amazing debugging skills!
>
> The patch that causes the regression in X sets the PCI device as parent
> for the VESA framebuffer. That means that the PCI device won't be
> unplugged or suspended while the VESA framebuffer is still in use.
> Without, results are undefined.
>
> Therefore, could this be fixed in X' fbdev driver?

I was in two minds about this one. On the 'perfection' side I agree Xorg sh=
ould not rely on a symbolic link at all - though that is easy to say; I was=
n't the one that had to find a way to do what fbdevhw has to do at the time=
!

But the other me argues that kernel ought not to break userspace and as it =
is a pretty common scenario across distros that userspace stays relatively =
stable (sans security bugs) but kernels can and do move on quite rapidly an=
d frequently the kernel ought to play nice here :)

With this in mind I can foresee many systems that work perfectly fine will =
break when only the kernel is upgraded and thus it'll have the finger of bl=
ame pointed at it.

Since this is more likely to strike in automated test harness scenarios (du=
e to it being relatively obscure) as well there may well be circumstances w=
here changing a userspace library immediately is extremely problematical.

I wonder if there's some half-way deprecation measure here that would allow=
 a period of transition?

I can imagine one way would be a custom udev rule (for systemd-udevd hosts =
- not sure about non-udevd) that replaces the new symlink with the old - bu=
t if a distro does that it's almost as easy to patch and rebuild fbdevhw - =
and far more brittle.

> A fix could look like this:
>
> 1) readlink /sys/class/graphics/fb0/device/subsystem
>  2) strcmp to "bus/pci"

This works and doesn't cause a regression in v6.8.12:

~ # uname -r; grep fbdev /var/log/Xorg.0.log
6.9.7-amd64
[    31.376] (=3D=3D) Matched fbdev as autoconfigured driver 2
[    31.377] (II) LoadModule: "fbdev"
[    31.377] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    31.377] (II) Module fbdev: vendor=3D"X.Org Foundation"
[    31.377] (II) FBDEV: driver for framebuffer: fbdev
[    31.410] fbdev trace: FBDevPciProbe()
[    31.410] (II) Loading sub module "fbdevhw"
[    31.410] (II) LoadModule: "fbdevhw"
[    31.410] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    31.410] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
[    31.410] fbdev trace: FBDevPciProbe() return
[    31.410] (WW) Falling back to old probe method for fbdev
[    31.410] fbdev trace: FBDevProbe()
[    31.410] (II) Loading sub module "fbdevhw"
[    31.410] (II) LoadModule: "fbdevhw"
[    31.410] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    31.410] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
[    31.410] fbdev: FBDevProbe() for() numDevSection=3D0
[    31.410] fbdev: FBDevProbe() isPci0 isISA=3D0
[    31.410] fbdev: FBDevProbe() calling fbdevHWProbe(NULL, '(null)', NULL)
[    31.410] (II) fbdev_open(scrnIndex=3D-1, dev=3D(null), namep=3D(nil))
[    31.410] (II) fbdev_open() using dev from env FRAMEBUFFER=3D(null)
[    31.410] (II) fbdev_open() using default dev=3D/dev/fb0
[    31.410] (II) fbdev_open() sysfs_path=3D/sys/class/graphics/fb0/device/=
subsystem
[    31.410] (II) fbdev_open() buf=3D../../../../bus/platform
[    31.410] (II) fbdev_open() returning file descriptor 11
[    31.410] fbdev trace: FBDevProbe() fbdevHWProbe()
[    31.410] fbdev trace: FBDevProbe() else xf86ClaimFbSlot()
[    31.410] fbdev trace: FBDevProbe() return
[    31.410] (II) UnloadModule: "fbdev"
[    31.410] (II) UnloadSubModule: "fbdevhw"
[    31.410] fbdev: PreInit 0
[    31.410] (II) FBDEV(0): fbdev_open(scrnIndex=3D0, dev=3D(null), namep=
=3D(nil))
[    31.410] (II) FBDEV(0): fbdev_open() using dev from env FRAMEBUFFER=3D(=
null)
[    31.410] (II) FBDEV(0): fbdev_open() using default dev=3D/dev/fb0
[    31.410] (II) FBDEV(0): fbdev_open() sysfs_path=3D/sys/class/graphics/f=
b0/device/subsystem
[    31.410] (II) FBDEV(0): fbdev_open() buf=3D../../../../bus/platform
[    31.410] (II) FBDEV(0): fbdev_open() returning file descriptor 12

~ # uname -r; grep fbdev /var/log/Xorg.0.log
6.8.12-amd64
[    14.225] (=3D=3D) Matched fbdev as autoconfigured driver 2
[    14.225] (II) LoadModule: "fbdev"
[    14.225] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    14.225] (II) Module fbdev: vendor=3D"X.Org Foundation"
[    14.225] (II) FBDEV: driver for framebuffer: fbdev
[    14.252] fbdev trace: FBDevPciProbe()
[    14.252] (II) Loading sub module "fbdevhw"
[    14.252] (II) LoadModule: "fbdevhw"
[    14.252] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    14.252] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
[    14.253] fbdev trace: FBDevPciProbe() return
[    14.253] (WW) Falling back to old probe method for fbdev
[    14.253] fbdev trace: FBDevProbe()
[    14.253] (II) Loading sub module "fbdevhw"
[    14.253] (II) LoadModule: "fbdevhw"
[    14.253] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    14.253] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
[    14.253] fbdev: FBDevProbe() for() numDevSection=3D0
[    14.253] fbdev: FBDevProbe() isPci0 isISA=3D0
[    14.253] fbdev: FBDevProbe() calling fbdevHWProbe(NULL, '(null)', NULL)
[    14.253] (II) fbdev_open(scrnIndex=3D-1, dev=3D(null), namep=3D(nil))
[    14.253] (II) fbdev_open() using dev from env FRAMEBUFFER=3D(null)
[    14.253] (II) fbdev_open() using default dev=3D/dev/fb0
[    14.253] (II) fbdev_open() sysfs_path=3D/sys/class/graphics/fb0/device/=
subsystem
[    14.253] (II) fbdev_open() buf=3D../../../bus/platform
[    14.253] (II) fbdev_open() returning file descriptor 11
[    14.253] fbdev trace: FBDevProbe() fbdevHWProbe()
[    14.253] fbdev trace: FBDevProbe() else xf86ClaimFbSlot()
[    14.253] fbdev trace: FBDevProbe() return
[    14.253] (II) UnloadModule: "fbdev"
[    14.253] (II) UnloadSubModule: "fbdevhw"
[    14.253] fbdev: PreInit 0
[    14.253] (II) FBDEV(0): fbdev_open(scrnIndex=3D0, dev=3D(null), namep=
=3D(nil))
[    14.253] (II) FBDEV(0): fbdev_open() using dev from env FRAMEBUFFER=3D(=
null)
[    14.253] (II) FBDEV(0): fbdev_open() using default dev=3D/dev/fb0
[    14.253] (II) FBDEV(0): fbdev_open() sysfs_path=3D/sys/class/graphics/f=
b0/device/subsystem
[    14.253] (II) FBDEV(0): fbdev_open() buf=3D../../../bus/platform
[    14.253] (II) FBDEV(0): fbdev_open() returning file descriptor 12

I'll propose this patch in Debian Xorg for Unstable/Testing but not sure if=
 it'll be accepted for Stable.

