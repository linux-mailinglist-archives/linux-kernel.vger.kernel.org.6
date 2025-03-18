Return-Path: <linux-kernel+bounces-566382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A94A67731
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3EB19A6C16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4D020E70A;
	Tue, 18 Mar 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="D/sBUmOd"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADC20E716
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309842; cv=none; b=HCd9t/mTUR7u7LZDBs8APbmIXmrW0L1shl5i1mQXhAQXSgomWSsOhpFyF4HbgtKjlokTuA4qk7WLICGMJZUYgYfUL8LfKYEb+v4GEXfSd/rhi341VkYTYfkEXXGvMKvwHh2mwbbbFG4HRinrFqyyyQgr26HyVjIgJXftq2DKKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309842; c=relaxed/simple;
	bh=ZOrupfj3TMw6uOjftteDDGCFM/An/Fqa3zQeuxkmIrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab5Q/jRa8fIJ3/uxHvt8ySI7fXCHo9ReNeeAkp+cPK9eGGYuoVfNNNrF6HoCZTebDVETZElP8yCvpYnfi5NYxNpz/ipejNEM6e/nS4FmeD9a5rakqV8DC+xL3xGRnLrtQf7kTcYun3+DrYT8jKhVSJQyMe07AXf9+sAQt98LSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=D/sBUmOd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso34210555e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742309838; x=1742914638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JrbbTTYqsx2At8tXwwXV3DCT75Flxu7MLSme9mxvoE=;
        b=D/sBUmOd5SacUD8wHJ/G8+J7sKtO5pmP4KB2xJ6fFdjOC/2skknMV1343QZsBllnYP
         XcRFVHpwUR7Zf/DfCSorL25+2Z56aPgW05NQ33JJYOXyepDAq8MQGQXN1KMXRlza1ruH
         PrHu+rnTJmRxEbZzksaKwgn1y1oygBs93gSkTTEJBZfELsrKQejSI5CEpZ4MjdqU/g6h
         6EkAUpxRbnOBSGqixnBirBUIWSShew3JOsRgvH2lqC/AF1oxwyULE/oWUIcHyik8qgp/
         Sv/mds//HGi3fxD982aXTvZ7tmrOger3/KTSi+hwHCrh3i4KoFBaBRXyvAr7K9Hpk/Fs
         lwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309838; x=1742914638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JrbbTTYqsx2At8tXwwXV3DCT75Flxu7MLSme9mxvoE=;
        b=hhqV2zSKMMbSVy/4FKoQr+PmzpBWuy+vyHYwh5bQIvMaqAyqafhO16vp1J81PhlhjU
         2f53CoplyKxXjSLyBOFUX1COkfPnrdbMXx3rLAAPTfkCpuRtCEZsDuzgAdVrb+stiV39
         H4MOSHLOhVzT4w4gEgULpyOypj3PFFrhLZ3zgdX+GeMSU6jJ70z7yy9vyKQiprQDTpYe
         /VhiYf0IV3xINZc8KzXbyrliqE/4Zaf3zL7s/gf/X8QM4Fz97soOhOxEKcBF+ct9EWcK
         mouk2gG3+wdZ5xOTs1SoXyyb8t2njIr7x1Y8/CtDXVe1bLbEYEowFy90Aal6DNsDhX89
         YdpA==
X-Forwarded-Encrypted: i=1; AJvYcCVtuvpy9EDgll8ayOZBgbR1clFFWEKdsgWiREgcrswxSkEygtyiVTazhLYKokpcoRWZvzuwouoHidXpTlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeILPRZJNIMuF2rSfeVZeHk8XinyqVMW4l+y4vNcG86sNHlZCB
	sSpiOyOJC0Fp4qbaymp42gUWGDRLM0pm1O5B1vjbus0g5iEvAE1zrGdcXhi31cY=
X-Gm-Gg: ASbGncvEqEwhxT5j5CtGtCqlllL2eFJRA6kfvdmbFWfX70g2CM2srG5pSsANEUs4jco
	gSxF4wDFaPmvGJf3vlvNWmGn/ljqzBESZLiKrLwrqONgmrcRHA+LsI25qGJJ4gDSfI29vPDJLHT
	O0UqPN9dgu5r05LAIuc+tIEl+dLaTV9U3FLi8d2s61sBUsQTv4Oa+xhpSWVcnIWAurNZzs9WqlR
	qGXrR2unGdiXcZ/s+oW8KKy4ptHzh+WgUjvf/S5ANPaF/KC8TXDJcI7pR995XPFXwiqDZKGjj3X
	8sWn9qG3s8brO62PxqcWQ5ee5NZql7xe
X-Google-Smtp-Source: AGHT+IHXZ79XlkqSRmU/Q/zKFFol20kZw5HxT+VTDXRKrU5Qs5y3sPBuGNxTg+Htb1G8NWUxJyz+Ig==
X-Received: by 2002:a05:600c:4e51:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-43d3b9ba9d4mr25669455e9.18.1742309838230;
        Tue, 18 Mar 2025 07:57:18 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe065b0sm136153105e9.14.2025.03.18.07.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:57:17 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:57:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, charlie@rivosinc.com, Anup Patel <apatel@ventanamicro.com>, 
	corbet@lwn.net
Subject: Re: [PATCH v3 7/8] riscv: Add parameter for skipping access speed
 tests
Message-ID: <20250318-58828155d9ca2801a21fa411@orel>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
 <20250304120014.143628-17-ajones@ventanamicro.com>
 <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>
 <20250318-1b03e58fe508b077e5d38233@orel>
 <20250318-61be6a5455ea164b45d6dc64@orel>
 <ee650a6c-eed8-4a2b-82ee-868a784f26b3@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee650a6c-eed8-4a2b-82ee-868a784f26b3@rivosinc.com>

On Tue, Mar 18, 2025 at 03:09:58PM +0100, Clément Léger wrote:
> 
> 
> On 18/03/2025 10:00, Andrew Jones wrote:
> > On Tue, Mar 18, 2025 at 09:48:21AM +0100, Andrew Jones wrote:
> >> On Mon, Mar 17, 2025 at 03:39:01PM +0100, Alexandre Ghiti wrote:
> >>> Hi Drew,
> >>>
> >>> On 04/03/2025 13:00, Andrew Jones wrote:
> >>>> Allow skipping scalar and vector unaligned access speed tests. This
> >>>> is useful for testing alternative code paths and to skip the tests in
> >>>> environments where they run too slowly. All CPUs must have the same
> >>>> unaligned access speed.
> >>>
> >>> I'm not a big fan of the command line parameter, this is not where we should
> >>> push uarch decisions because there could be many other in the future, the
> >>> best solution to me should be in DT/ACPI and since the DT folks, according
> >>> to Palmer, shut down this solution, it remains using an extension.
> >>>
> >>> I have been reading a bit about unaligned accesses. Zicclsm was described as
> >>> "Even though mandated, misaligned loads and stores might execute extremely
> >>> slowly. Standard software distributions should assume their existence only
> >>> for correctness, not for performance." in rva20/22 but *not* in rva23. So
> >>> what about using this "hole" and consider that a platform that *advertises*
> >>> Zicclsm means its unaligned accesses are fast? After internal discussion, It
> >>> actually does not make sense to advertise Zicclsm if the platform accesses
> >>> are slow right?
> >>
> >> This topic pops up every so often, including in yesterday's server
> >> platform TG call. In that call, and, afaict, every other time it has
> >> popped up, the result is to reiterate that ISA extensions never say
> >> anything about performance. So, Zicclsm will never mean fast and we
> >> won't likely be able to add any extension that does.
> >>
> >>>
> >>> arm64 for example considers that armv8 has fast unaligned accesses and can
> >>> then enable HAVE_EFFICIENT_ALIGNED_ACCESS in the kernel, even though some
> >>> uarchs are slow. Distros will very likely use rva23 as baseline so they will
> >>> enable Zicclsm which would allow us to take advantage of this too, without
> >>> this, we lose a lot of perf improvement in the kernel, see
> >>> https://lore.kernel.org/lkml/20231225044207.3821-1-jszhang@kernel.org/.
> >>>
> >>> Or we could have a new named feature for this, even though it's weird to
> >>> have a named feature which would basically  mean "Zicclsm is fast". We don't
> >>> have, for example, a named feature to say "Zicboz is fast" but given the
> >>> vague wording in the profile spec, maybe we can ask for one in that case?
> >>>
> >>> Sorry for the late review and for triggering this debate...
> >>
> >> No problem, let's try to pick the best option. I'll try listing all the
> >> options and there pros/cons.
> >>
> >> 1. Leave as is, which is to always probe
> >>    pro: Nothing to do
> >>    con: Not ideal in all environments
> >>
> >> 2. New DT/ACPI description
> >>    pro: Describing whether or not misaligned accesses are implemented in
> >>         HW (which presumably means fast) is something that should be done
> >> 	in HW descriptions
> >>    con: We'll need to live with probing until we can get the descriptions
> >>         defined, which may be never if there's too much opposition
> >>
> >> 3. Command line
> >>    pro: Easy and serves its purpose, which is to skip probing in the
> >>         environments where probing is not desired
> >>    con: Yet another command line option (which we may want to deprecate
> >>         someday)
> >>
> >> 4. New ISA extension
> >>    pro: Easy to add to HW descriptions
> >>    con: Not likely to get it through ratification
> >>
> >> 5. New SBI FWFT feature
> >>    pro: Probably easier to get through ratification than an ISA extension
> >>    con: Instead of probing, kernel would have to ask SBI -- would that
> >>         even be faster? Will all the environments that want to skip
> >> 	probing even have a complete SBI?
> 
> Hi Andrew
> 
> FWFT is not really meant to "query" information from the firmware,
> fwft_set() wouldn't have anything to actually set. The problem would
> also just be pushed away from Linux but would probably still require
> specification anyway.

Agreed. Actually, if we had HW descriptions for every feature in FWFT,
and allowed each feature to have implementation-defined reset values,
then we wouldn't need the get function. The OS would only call the
set function if it disagreed with the value it saw in the HW description.
But this is getting off-topic and we can just agree that FWFT isn't the
right approach.

> 
> >>
> >> 6. ??
> > 
> > I forgot one, which was v1 of this series and already rejected,
> > 
> >  6. Use ID registers
> >     pro: None of the above cons, including the main con with the command
> >          line, which is that there could be many other decisions in the
> > 	 future, implying we could need many more command line options.
> >     con: A slippery slope. We don't want to open the door to
> >          features-by-idregs. (However, we can at least always close the
> > 	 door again if better mechanisms become available. Command
> > 	 lines would need to be deprecated, but feature-by-idreg code
> > 	 can just be deleted.)
> 
> My preferred option would have been option 2. BTW, what are the
> arguments to push away the description of misaligned access speed out of
> device-tree ? that's almost exactly what the device-tree is meant to do,
> ie describe hardware.

Actually, I don't know. Maybe Palmer can point to something.

Thanks,
drew

> 
> As a last resort solution, I'm for option 3. There already exists a
> command line option to preset the jiffies. This is almost the same use
> case that we have, ie have a faster boot time by presetting the
> misaligned access probing.
> 
> IMHO, skipping misaligned access probing speed is orthogonal to
> EFFICIENT_UNALIGNED_ACCESS. one is done at runtime and allows the
> userspace to know the speed of misaligned accesses, the other one at
> compile time to improve kernel speed. Depending on which system we want
> to support, we might need to enable EFFICIENT_UNALIGNED_ACCESS as a
> default, allowing for the most Linux "capable" chips to have full
> performances.
> 
> Thanks,
> 
> Clément
> 
> > 
> > Thanks,
> > drew
> > 
> >>
> >> I'm voting for (3), which is why I posted this patchset, but I'm happy
> >> to hear other votes or other proposals and discuss.
> >>
> >> Thanks,
> >> drew
> 

