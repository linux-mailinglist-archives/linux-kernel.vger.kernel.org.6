Return-Path: <linux-kernel+bounces-423609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 087739DAA54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6161FB21E26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C0E1442E8;
	Wed, 27 Nov 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="RCjIA4UE"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE761FF7BB;
	Wed, 27 Nov 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719878; cv=none; b=YQ5NxrqbXxmrB/Bcz+jCobgc++iFX+wX9qp6ynJiseHu+3VIBtXpeJdKAff7cCvujWGrZ2boC4iHEnBemG/dTErROePLdLxkwLPifF3vhtuIG/P8M2Qtzh8wlVzDPUT/0xNN5khiqGo7lrsuxIdERWlavVkelcShki14oxDnoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719878; c=relaxed/simple;
	bh=Hty2NFEAjx7RGkBiYyyqR/7uWjyvj1h0ds3vRJxOREQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=mARcyttphS/W4danoloJvW/AZfv3xLM4fx4f0wtqzNtnrkUQmyCksrZ8ckjfELf3CKi0SNpE9493nmLCVQZiULz8mrFVyQ/iDWVXGITb7J8QatUdn9ADHTMCYBL/bp+hbm4FUmYSVdjoRkUfZCE8BySo5DnXfs7IFIWJPGNnNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=RCjIA4UE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1732719843; x=1733324643; i=frank-w@public-files.de;
	bh=chnjNiuENGgY44cCvyv4JXxrXfS8o1GhWJbEsmfSw9c=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RCjIA4UEE1Rr/8dYbnl+ikDHL495gYUAX14bI3x0M9UIZYgkDL9cLhSdSfrAI9F+
	 wCIi4ilD0vwVKDWk1EcFm32cpBlfT6q9K9FnP7Vs1cf68df8KblGBbjz9wNsXmWl1
	 K3summw0OtFxahaTFEAJ7dTsSlSlWIMxAppXQQX1U5epQv1RyhX+++tr50/rxVgPR
	 dMYEedNJAilx4dc2VAgHUl7hYmB6HlpL6WQs61+jGPw8g6jB1OTbdl9hHg/eC6dho
	 39smxSTbF99kRnvH2lDEB2GtJ2xMm36KYmkDREKwbuRuq+ue2sIUOYT64JXLLRrg5
	 TI43Aeei4juiJPmMhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.224.21] ([157.180.224.21]) by
 trinity-msg-rest-gmx-gmx-live-5cd5dd5458-pz7pz (via HTTP); Wed, 27 Nov 2024
 15:04:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-78347fc1-fe38-4035-a681-ff72fd4411cf-1732719843709@trinity-msg-rest-gmx-gmx-live-5cd5dd5458-pz7pz>
From: frank-w@public-files.de
To: angelogioacchino.delregno@collabora.com, robh+dt@kernel.org,
 matthias.bgg@gmail.com
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, daniel@makrotopia.org, linux@fw-web.de,
 leith@bade.nz
Subject: Aw: Re: Aw: Re: Aw: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs
 with applied overlays for bpi-r3
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <4549f33c-90d2-4b28-ab7a-1576c587c8cf@collabora.com>
Importance: normal
References: <20240608080530.9436-1-linux@fw-web.de>
 <20240608080530.9436-2-linux@fw-web.de>
 <trinity-82c94d49-2a78-4470-83cd-3c6747e01849-1719434738199@3c-app-gmx-bs52>
 <726f2ed3-675f-45e8-94f0-d392181e7f92@collabora.com>
 <951E802C-1B53-45C4-B3E6-4A3400F47214@public-files.de>
 <CAPDEroWUeR3iUFnjVr6WFLg3=dkML+5cbRPph9bj64F=zc1UWA@mail.gmail.com>
 <trinity-ef654aa8-f10a-4195-82c8-65b3ea654c7b-1730918975868@trinity-msg-rest-gmx-gmx-live-c75c5fb4b-p29nc>
 <4549f33c-90d2-4b28-ab7a-1576c587c8cf@collabora.com>
Date: Wed, 27 Nov 2024 15:04:03 +0000
Sensitivity: Normal
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:BPoFVFm6JHLsWszWY69a+4cyOqrEDA+cKi27DZ6aviyJELU8tIvXA93+W91odNLNw297W
 MygNGVTLZu3wFSrIHxHm0AMW+DkA/swV/oeZnbs3MStebzO7h2r+RazN3ITWiqdaLQWRPUoVM3pX
 8f9PUsneMQ7FGFHeO5u9dkvgUSiJ78RATXpNJfOn+Ct9U5l8JhXncKj66yjUju3Ia2biEXX0yZcE
 6MtA9ozOYIEA2D1523HnDrQznMVi4mPrn2YcvlWRWZUBnt7u/CR0T+aP8SW0Ueu/mAPx9T5OdpE8
 U1xzeAySKmlagkwrq2Rqz6eVG9LkxNT5gPibV0nZyGh0VG6z38jLkvpes6+gO7QSd4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RBccAI9PjjU=;i9JD5OfCgPRbWa2LnBTkhl5iYRl
 yNO1vzZVZe9hS2PT3zba+iIcBMgu1tx6M2td5wfvirTVMlddGBs6zqMkfjhzmfwnb5mfZE6SD
 AqJeCeKliIXd8JpnigEBx5+Rt/GibZ/E4DGnsXuLvTjJkVqohvKM56TFqhHDmr2PSLtfsSamc
 tVX0HrQ2LouXQTtnfxVwqP731+/OgrNTDZguEqndcfgWk8Ls3xMykmGp/Bq4RX2HkxpombIf6
 2CoHqAXbx1fh3WQSr43NP16z+FIbgh0cz+AnZ3c5USXLdHCidimZuzRrDvLS6PWmQ5jKDOWdg
 IvaS4rz9nc8AJyHoJIIimVrnifT0RqqFFxDGJlmYMkMp1irDr4vCGmh6ksq/g1KOyJyoRIsd5
 VsP3SFv41+LpAHJSSxyrLADB1DsOheFv7MS2XvzVIIhOTQtTyHu9ZsynIeBJiyrosBzyipTyl
 +9AZT3hNCzMKwr9ICzHSkoQATBTsve6EbSR4buieMo8YH9OgRINbnct4BAPRTSZnob0IYksTz
 xtDuxCKya+HhrbAwqlsBZfj8YWXpKdg0V9ST4f3dPV6zdgQJAe2Yw/i518gtLeDyxwhn6uCQL
 Z0dVSQOoHhWqo+xbEKGiDCTYtwP26S3mMHGaspfk5DUVWRlHUCS8seHjS9JVYluqzEMK7UPac
 Wald1VOnFfIj2TaDWiUYnsc6J4yycJ40Y8X8u91EfHVJJnt6IkHjTWYxStZfV5pHnF4m71fme
 potjCUJyNIWpXPGuoQunIbLuvpsN66WdgEri4XN9XSjDtoikeYBvZvQD2h6xZ6mT//wIBroEr
 S/6Abnfi80XNLulsdnAHHvDw5srSuDI55PXecU8QXK+F2A05Y25u5jnc8TTeqdJiumgzreUeP
 K7o7892zvokCawW7tdVN9qMeWnffClt97QSA=
Content-Transfer-Encoding: quoted-printable

Hi,

&gt; Gesendet: Mittwoch, 27. November 2024 um 14:23
&gt; Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabor=
a.com>
&gt; An: frank-w@public-files.de, robh+dt@kernel.org, matthias.bgg@gmail.c=
om
&gt; CC: krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel=
.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead=
.org, devicetree@vger.kernel.org, daniel@makrotopia.org, linux@fw-web.de, =
leith@bade.nz
&gt; Betreff: Re: Aw: Re: Aw: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs =
with applied overlays for bpi-r3
&gt;
&gt; Il 06/11/24 19:49, frank-w@public-files.de ha scritto:
&gt; &gt; Hi
&gt; &gt;
&gt; &gt; any new state on this??
&gt; &gt;
&gt; &gt; https://patchwork.kernel.org/project/linux-mediatek/patch/202406=
08080530.9436-2-linux@fw-web.de/
&gt; &gt;
&gt; &gt; regards Frank
&gt;
&gt; I had a look at this one - and this is the situation:
&gt;
&gt;   1. Your bootloader supports loading DTBO, so you can indeed use DTB=
Os
&gt;   2. Validation of the DTSO can still be done during kernel build wit=
hout adding
&gt;      all of those possible X+Y+Z pre-joined DTBs
&gt;   3. What if your hardware had more than 20 possible configurations?
&gt;      Would you write 20 different Makefile entries? "sd+nand+nor",
&gt;      "sd+nand-withoutnor", "emmc+nand+nor", "emmc+nand-withoutnor",
&gt;      "emmc+sd+nor", "emmc+sd-withoutnor", "ufs+emmc", "ufs+emmc+sd",
&gt;      "ufs+sd+nor", "ufs+emmc-withoutnor", "ufs+sd-withoutnor", ......
&gt;
&gt; Looks messy and unfeasible.

right, if we add all possible combinations...that was my point on first ro=
und of this patch after robs suggestion. So you have same opinion :)

imho rob is afraid that dtso are not checked during build-time and this is=
 noticed at runtime where it can be checked earlier.

maybe we can find a way in the middle (i tried it in this patch doing the =
full dtb only for the core functionality, not adding e.g. sata).

&gt; However, this is not a *global* no: I'm happy that your bootloader do=
es support
&gt; loading DTBOs and, as far as I remember, even uses straps to vary the=
 DTB(o) to
&gt; actually load - which is something proper and great... so it's a *no*=
 for you,
&gt; but more than just a no, this is "why are you treating your proper bo=
otflow
&gt; like it was a broken one?!?!" :-)

i still use the dtbos in a fit i created and build off-tree where i add th=
e possible combinations like here as config options and add additional con=
figs for e.g. sata to be combined by bootloader.

currently we use a "full dtb" in uboot where we can probe for emmc vs. sdc=
ard (mmc partprobe) and the spi-device (nand/nor via "sf probe"). We can r=
ead the bootstrap pins defining the device from which board was booted, bu=
t this is only the half way for hw-detection.

&gt; If anyone finds themselves in a situation in which there's no way to =
update a
&gt; bootloader (and that unfortunately happens more often than anyone wou=
ld like
&gt; to see...) and in which the only way to apply DTBOs is to pre-overlay=
 them
&gt; during the kernel build, then that's fine and I would (if nice and cl=
ean)
&gt; accept that.
&gt;
&gt; But again, you're not in this kind of situation - and you're lucky th=
at you're
&gt; dealing with a fully open device with a proper bootloader and bootflo=
w: don't
&gt; ruin it like that!

the patch does not break ability to use the dtbos, it only adds second way=
 to create fuill dtbs from them, that of course should not be done extensi=
vely....4 full dtbs are enough in my PoV and should not be exceeded.

&gt; Instead, if necessary, update the userspace tools that you're using t=
o deal with
&gt; multiple DTBOs during system upgrades: that's the right thing to do a=
t this point.

i simply replace/add the fit image which contains base dtb and all dtbo wi=
th config options ;)

&gt; Cheers,
&gt; Angelo

so i would resend the sata-patch alone when rc1 is out, right?

regards Frank</angelogioacchino.delregno@collabora.com>

