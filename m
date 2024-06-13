Return-Path: <linux-kernel+bounces-212606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57A9063E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCE7B2408A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9971369A7;
	Thu, 13 Jun 2024 06:15:44 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4170D534
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259343; cv=none; b=iTMAnyAWwJjr3nKNVKZZAoFfGqAkqoRhFbtKbVq41EDvcnIZsSaX9uDQ+1V5tJcLe/nffS+pZFEAuMCsyWdkgsirWCWxt0RMFO9jR+USHF8sHmSOR3OJxUBLFKM1zWFCWQne3WMEfAdk5DBpsry3TtGWtjgxXb4NZInsHiwlH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259343; c=relaxed/simple;
	bh=bSLGZUHHGxiubQVydZ2pNyPsndWQJAkvBQYtmGggH6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDgct9dUL3uzxRhEZrNHVQKbPGCKiSOYptzZuiVR9mX9DivxeilAfDV0N5uvNITe2BJOY8TZ0Nw3vPSUhYbud1deRiHcv/KQpz5zeVneKhBg78r5081XFNg/ndf3CEo4vxVHLzvEV+gGWsdGpLV9dUx0ipVCBjW6w4WkqXZobqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4ed0a343db6so227719e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718259340; x=1718864140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRvrcjPhR+q8m9kx6xe/eWTFXA9VMLUn5sh24E/DBw0=;
        b=AM3nXrTc+lv9rORKNn2itRoKTpm+9Hvmi/rQAMlRvz34ZYy34esJTzNlNRu5sMQeAH
         fngZT8+Groh767VpGBXgOm3J6UdPRGkYMQBH8+21WpvgTI8eEktuUF8D5zGdum4UGA88
         KYmlPDlX4c3vhbTMrJsj3igD7kESb38x2E3Euq1W7nyt/SSNOyWxeTBhve4zC/4L9hiB
         IBiMu4Ftm01Ovo2WCJW0uebal0zvMU+Jk+8JakkxswAiuwWtawOL/HIdDE5N/YOAL3cz
         Lx8rmglYnjaRqT8H169Lge1BLwFwPODxuA5toCoD8XTO1tcpHOHpd6nFqO0xXaZr/eMb
         2dUg==
X-Forwarded-Encrypted: i=1; AJvYcCVhmC0RocWL6p1J2blgKkkqDF02xeh21Vf3PsG9kJdtjPjKmnZGz48jqwmkV81cTZI1YmxGdkEeHhGR5VBdWRUwqwwWgt6tuSu8cMfL
X-Gm-Message-State: AOJu0Yx6RFAVXlCnuoNhjDZD2R/h+CSPotm46XnESY15Sh7PCjmyMBvo
	vZzewYoq8fKj+qGooRG0mW3io+8kRPOBwx9gDbhuIYvJF1gcUiPLPFV3YRab52UGwyNKG/QQtzz
	Zg6CfoCrZWosd281Zf1yme+ej3Ck=
X-Google-Smtp-Source: AGHT+IGIqmMCbiVe6uMn5U11DqIWVsuLRr+OsX5/SDqNPOf+pK1ldMb7w7imfdAuUXkVQnlu+dSPve3MemvK97R9vUI=
X-Received: by 2002:a05:6122:21ac:b0:4bd:32c9:acb with SMTP id
 71dfb90a1353d-4ed07b25702mr4771148e0c.7.1718259339547; Wed, 12 Jun 2024
 23:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612081216.1319089-1-zhai.he@nxp.com> <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
 <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com>
 <AS1PR04MB9559D82F720BC9A64077186AEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4zGRnGhn1zA1=H+TgqL8z59_Dy7x7YVKsKY0wRFt4tu9w@mail.gmail.com> <AS1PR04MB955915A33F184E141BCD69A2EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
In-Reply-To: <AS1PR04MB955915A33F184E141BCD69A2EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 13 Jun 2024 18:15:28 +1200
Message-ID: <CAGsJ_4w=MYMOoQnY7c9nE-iCdzP9amCyYTkje-PNGYe35u+1Kg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
To: Zhai He <zhai.he@nxp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhipeng Wang <zhipeng.wang_1@nxp.com>, 
	Jindong Yue <jindong.yue@nxp.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:32=E2=80=AFPM Zhai He <zhai.he@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Barry Song <baohua@kernel.org>
> > Sent: Thursday, June 13, 2024 11:28 AM
> > To: Zhai He <zhai.he@nxp.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org;
> > linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>; Christoph
> > Hellwig <hch@lst.de>
> > Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when =
the
> > device-specified CMA memory is not enough.
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t this
> > email' button
> >
> >
> > On Thu, Jun 13, 2024 at 2:34=E2=80=AFPM Zhai He <zhai.he@nxp.com> wrote=
:
> > >
> > > > -----Original Message-----
> > > > From: Barry Song <baohua@kernel.org>
> > > > Sent: Thursday, June 13, 2024 5:37 AM
> > > > To: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Zhai He <zhai.he@nxp.com>; sboyd@kernel.org; linux-mm@kvack.org=
;
> > > > linux-kernel@vger.kernel.org; stable@vger.kernel.org; Zhipeng Wang
> > > > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>;
> > > > Christoph Hellwig <hch@lst.de>
> > > > Subject: [EXT] Re: [PATCH v2] Supports to use the default CMA when
> > > > the device-specified CMA memory is not enough.
> > > >
> > > > Caution: This is an external email. Please take care when clicking
> > > > links or opening attachments. When in doubt, report the message
> > > > using the 'Report this email' button
> > > >
> > > >
> > > > On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton
> > > > <akpm@linux-foundation.org>
> > > > wrote:
> > > > >
> > > > > On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" <zhai.he@nxp.com>
> > wrote:
> > > > >
> > > > > > From: He Zhai <zhai.he@nxp.com>
> > > > >
> > > > > (cc Barry & Christoph)
> > > > >
> > > > > What was your reason for adding cc:stable to the email headers?
> > > > > Does this address some serious problem?  If so, please fully
> > > > > describe that problem.
> > > > >
> > > > > > In the current code logic, if the device-specified CMA memory
> > > > > > allocation fails, memory will not be allocated from the default=
 CMA area.
> > > > > > This patch will use the default cma region when the device's
> > > > > > specified CMA is not enough.
> > > > > >
> > > > > > In addition, the log level of allocation failure is changed to =
debug.
> > > > > > Because these logs will be printed when memory allocation from
> > > > > > the device specified CMA fails, but if the allocation fails, it
> > > > > > will be allocated from the default cma area. It can easily misl=
ead
> > developers'
> > > > > > judgment.
> > > >
> > > > I am not convinced that this patch is correct. If device-specific
> > > > CMA is too small, why not increase it in the device tree?
> > > > Conversely, if the default CMA size is too large, why not reduce it
> > > > via the cmdline?  CMA offers all kinds of flexible configuration op=
tions based
> > on users=E2=80=99 needs.
> > > >
> > > > One significant benefit of device-specific CMA is that it helps
> > > > decrease fragmentation in the common CMA pool. While many devices
> > > > allocate memory from the same pool, they have different memory
> > > > requirements in terms of sizes and alignments. Occasions of memory
> > > > allocation and release can lead to situations where the CMA pool ha=
s
> > > > enough free space, yet someone fails to obtain contiguous memory fr=
om it.
> > > >
> > > > This patch entirely negates the advantage we gain from device-speci=
fic CMA.
> > > > My point is that instead of modifying the core code, please conside=
r
> > > > correcting your device tree or cmdline configurations.
> > > >
> > > Because we enabled secure heap to support widevine DRM, and secure
> > > heap requires security configuration, its starting address cannot be
> > > specified arbitrarily, which causes the default CMA to be reduced. So=
 we
> > reduced the CMA, but in order to avoid the impact of reducing the CMA, =
we
> > used a multi-segment CMA and gave one segment to the VPU.
> > >
> > > However, under our memory configuration, the device-specific CMA is n=
ot
> > enough to support the VPU decoding high-resolution code streams, so thi=
s patch
> > is added so that the VPU can work properly.
> > > Thanks.
> >
> > I don=E2=80=99t quite understand what you are saying. Why can=E2=80=99t=
 you increase VPU=E2=80=99s
> > CMA size?
> Thanks for your quick reply.
> Because we added a secure heap to support Widevine DRM, this heap require=
s hardware protection, so its starting address cannot be specified arbitrar=
ily. This causes the secure heap to occupy part of the default CMA, and the=
 default CMA is therefore reduced, so in order to avoid default CMA Shrinki=
ng introduces other problems. We added a specific CMA area for the VPU. How=
ever, due to the large size of the secure heap and default CMA, There is no=
 remaining memory available to increase specific CMA for VPU.

I assume the secure heap you are referring to is a section of memory
that should only be accessed by TrustZone and not be visible to Linux
running in non-secure mode. How do you allocate this secure heap from the
default CMA? Do you use the cma_alloc() APIs or the dma_alloc_coherent()
APIs? Given that the VPU has its own device-specific CMA, why is this
secure heap allocated from the default CMA instead of the VPU's CMA?

If this secure heap was allocated before the kernel booted, why did the
kernel(your dts) fail to mark this area as nomap/reserved to prevent
the default CMA from intersecting with it?

>
> > It seems you mean that only in some corner cases do you need a large CM=
A, but
> > most of the time, you don=E2=80=99t need it to be this big? So you have=
 to "borrow"
> > memory from the
> > default CMA. but why not move that portion from the default CMA to your
> > VPU=E2=80=99s CMA?
> >
> This is a method, but because for VPU, the continuous memory size allocat=
ed by the driver is based on the video stream, we cannot determine the maxi=
mum size of memory required by the VPU. This makes it impossible for us to =
determine the size of the specific CMA assigned to the VPU. Thanks.

I don't understand how this can happen. You should precisely know the
maximum size required for the VPU based on your multimedia pipeline
and resolutions.

I still don't understand your scenarios or the problem you are facing.

Thanks
Barry

