Return-Path: <linux-kernel+bounces-556905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F6A5D064
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C43217D188
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6555264617;
	Tue, 11 Mar 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LSlYGTiK"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98071E833F;
	Tue, 11 Mar 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723588; cv=none; b=fe1fe1bsPIbBEXcCK5+H1sAb4prtQmtFDPp7JGlMfmP7V1yQHXj3CvOUDBMTPuhmqSEqAFNaLPhYWSN9iZEqM2I0MOuJU4i1kjl4hQD0YEHlIdZ6wN9bKJ4O0aTOOXSEzoFs1yxBzcGwwhhZ0T9vaPzsgLsJowGx3/qNQqMgLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723588; c=relaxed/simple;
	bh=Gti7/A9BWac5/4NqS14sIP1I/ISfrQITkGaBNSl6lrE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WkVw/phbWu1IJFgXwO7+xPY0Vpl1do7fNYf+Clfy6XLbnYgtT7o3hfbcDJdYi97wMFzUQRQcs3s1ul8c37Zs0eQZgoH1VTPUKgjY56/uWYH3ORTO+NFxL98bxufq4rheRUocVIohOyA2RDSns/wdjQa7TRS5hyBWXNBhCcnDSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=LSlYGTiK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741723577; x=1742328377; i=w_armin@gmx.de;
	bh=DZBmXE3PhEOsVN8AoczAX6QJdKpQt5bApj5pggD05dA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LSlYGTiKojOEOqvsNuOOtCdrWnA2q8AEbTmMRgPfcVz3Al4w7qPQEdYlcCZqRpX8
	 G7t/hpGE8OfxU/ORkLNRYuiYyqwdC4Xx1tdQnVq2E/jegdEEZuD1C0e+tXxKV7e3U
	 /PK/11bI6Sw2n1Jpeew+gAPN9f0EIGkoBbOcrD5jkcNBl2+chFZvfR/VSzlugzx3h
	 eohyzTX7zVG64wxQ0mF3b8x4xWI3vinvJVIIsowZUbs357sHR6S45C1X6O2xKBbOZ
	 bnifa+NrKNp2hAgjHcBxq1RmSb6kiAjuOEWgjmEqaf86Vi1A2bOMrZa+DWVBpr2g7
	 cyWeJdeWFFuFbe3XOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1tnWVC1uN5-00VuUl; Tue, 11
 Mar 2025 21:06:17 +0100
Message-ID: <a18f2f93-c8ee-47af-9446-97e3714fc275@gmx.de>
Date: Tue, 11 Mar 2025 21:06:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "linux@weissschuh.net" <linux@weissschuh.net>, Kurt Borja
 <kuurtb@gmail.com>, akpm@linux-foundation.org, mcgrof@kernel.org,
 russ.weight@linux.dev, dakr@kernel.org
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Armin Wolf <W_Armin@gmx.de>
Subject: In-kernel parser for the BMOF format used by WMI-ACPI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pifAFIH/MdkCINMdtBpl9GRvvRacmhl8BBbuaAju7gpDOIML/vl
 EN1roCDbeoJEsIsrnSId9bH4e7Ttod2tPCRY7+cPHacdHHnWhXnY6DvPlnwmgltvhdjjcJg
 /4E2cFwyOg+9+Pmr7ISUz6Us5J7oxNSuGLCjg8IdRgu4UwuSMtSYDsD3PzevXCWXg51IdcK
 IuXP2FXcd7ke8qpF45GoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VpPaDzBZEeQ=;BjNxB/FzusFAZMkhAloUumPNcqf
 Gi4j6W73NeoLC8rn3sOCsdSjRJgYzbfE517CbkoJnFXeH8XuuSkeJEMLVuzs1T4lARzV/6uli
 bbRkJYcUe1eEBly0tJ+p3HHlq2iDZwkvLgPSVNJaRP801IMzDcVewxdYXpL7B9YULt5C4U5Ed
 pePHoNXZP+qjDCqZmdNMFHvA+hqPOtBu+Scm5eB4/dP06SPVMgJ/vt100/cZG2J+m1XK3lCRu
 gR0Ci4OxPGi/Gmh+FyMcO5uCu77jqWtyjOcnvApMLTSpYBmZIrttkf5LVu0kzfOKgvHGA9viT
 YMMRAh5l7ucpQsU48P4v3TClwPrfxnPabYJ8DEgB+7/oZJ+8kYraVdDJbCnmxndmmzAkyJFwO
 58H7TE7m9fBq+stTH1YIFO37DGooNpdRsQ+b5voyT+DcfX1SijvSh8KYE/UOqUUEq4zA55VD3
 a17ULh6zACM0TW7S2oxVrdgwAoZFh173nmPtSRqODloRNByg7v49Oaei35uLC+tx0mZ2l5G75
 Aaqp9aa6XSX2EJJHxB/lsj+0NbDXysNBSmxrqNqk4GQGJiTVm7iPi0zjspeFS1TpEDbGJCrh8
 LQlDXEJ0WIPxZme2uOuqc0+0PH53tPc/ml0gqJIcPKkM4oKmMAzBOnDn6dRudRCt0BBn/BlZJ
 liv/BrH1GwNMi96wLNiqMzLUeUFFjF3Bmngx2fXVCc2/zV3qlca2UmvruII3TcggA+TJv5kBV
 kYjPsszhmX6iZDC2T1o0VqR2hj/CxjCoR0zXTc4SJGc8fKJfb6ixKpI2gqevW9Tk+OZVNsuKp
 F99YdAOC0H/GDYWxneg6aaaqT1bh4WpQ/0aa2X00L4WOzqmpo9mVQzb/MCOk7UIAeXqfLmjoT
 rhCeT/nw3Ikj3r6CRg/coBz5zwThfw2dvYPBFYG35JVWv0+xePUw1pKl1KK0I2LRlfIjD6SOT
 cIvvsNX3wfBUIZsAj69eWzIt5tUDM73ZEgYJt2Fg1rJeOU5PTxOocLrXLBL4zVPRtAb/k6ZQE
 mmV8uIKv/2Iy1fe5SmHZOsxnKZsFmEd3bG728Eq2ZfyIvMasFg0lpMrhTpGcsfkWo85InOAKY
 didEYnMHfj3JikqMsaWSHOHnywKzyylBOiN4PUEfcC3d3557VLUTHsLEUzTzVu37lQtaGhrcm
 LkpIFaoCeekWl30p6oJQRSRdYIHwxerjpT/M3SDgHLZV8V0QwYbcOatPHGWrFPRcm8CQ6cQ5v
 aPukZ/XcLvpTLs4ERfcHAPgs5a0z2g9qvtkNCRAjxwrIGoJCSjqU2VVGNPzM7FBe3IY3tfXp3
 wu3Au2LdZC2bgamFzJUmvrDqfALQIiM2NDVIEbWRkcx8jayQdeudfmq/zoGfJCeUO8CCyqag3
 gJdDmxnQf8vudjirMO8vaIRwi38lLzmDhB/XVAYduaslRA4C8TviiRxaT2ngLXpGDvXbv5fml
 vuoZ3d8Dp9fI/9D0bWW/CyS+R5iEpvTku9rhZxqrg+BNLM/6hBpLTwXsqPu4Y7/CrgpyMLw==

Hello,

since around 2017 we are able to partially decode the Binary MOF (BMOF) da=
ta used to describe the interfaces of WMI-ACPI
devices found inside modern devices. This initial reverse-engineering was =
done by Pali Roh=C3=A1r and implementing a BMOF parser
inside the kernel was originally also proposed by him (see https://lore.ke=
rnel.org/lkml/201706041809.21573@pali/T/).

As part of my bachelor thesis i finished the reverse-engineering and creat=
ed yet another utility for parsing BMOF data.
This utility can be found at github (https://github.com/Wer-Wolf/tarkin) a=
nd i now intend to use it to finally implement
a BMOF parser inside the kernel.

There exists a growing list of WMI drivers using quirk tables for detectin=
g the presence of specific WMI methods on a given
device. This approach is maintenance-intensive and not exactly user friend=
ly (end users rarely send kernel patches). Because
of this we need this BMOF parser so that we can check which WMI methods ar=
e available.

My current idea for this BMOF parser looks like this:

  - support for the MS-DOS Doublespace compression algorithm (only decompr=
ession) lands in lib/ds/

  - WMI driver core moves into drivers/platform/x86/wmi/

  - a new component called the WMI repository will hold all BMOF data know=
n to the kernel (necessary to emulate the WMI infrastructure under Windows=
)

  - parsing of BMOF data is only done by the WMI repository which exposes =
a in-kernel API under include/linux/wmi/repository.h

  - BMOF data can be loaded into the WMI repository by the wmi-bmof driver=
 (for firmware-provided BMOF data) or by WMI drivers themself (for WMI dev=
ices with firmware-provided BMOF data)

The remaining questions are:

  - How to structure the library code inside /lib/ds/?

  - Is there any way to check whether the Doublespace compression algorith=
m is still encumbered by patents?

  - Can BMOF files used by WMI drivers be included inside linux-firmware e=
ven if they only hold configuration data?

I would be very happy if the relevant maintainers could comment on the abo=
ve questions.

Thanks,
Armin Wolf



