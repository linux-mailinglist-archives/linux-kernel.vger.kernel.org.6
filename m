Return-Path: <linux-kernel+bounces-565774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17646A66EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC9D4200BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5252045A1;
	Tue, 18 Mar 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XZbSDZ3g"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887C2045BF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287708; cv=none; b=aHP56RHjgFeOOTy32pJRvovngqZR4LVdOEQ/P6sBtyBFO30WXw5sizY0HEqkZGSRKQtIRqxmK9fEFhGMhcYf33lVpAftCTV644mmuJmRkbNv0HN63n8+rH4DUSiL6J/8VEDBDutoQc5Mt30AqyyT4ROrXIKzCSy6yaEH9uj1PME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287708; c=relaxed/simple;
	bh=tPOWRh9KA6RVKShddx5j2LIfskgR6g37FspVTD7YrOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioj6R89Ay7yHswIluja2gE6qxdEKWOhiqu1PyxMdWJCEAglaeya4adIi1W24bnKyP0DnOXv4qgv5pBBJ9mkcEv+oKE8T7GV+q+n22YrSYZEXDqFGPLsYNK6rwRcRGiB+PdZbxj9hDPfjzI2GIr9tNmx3CSFnA8r8f6AwrhyVArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XZbSDZ3g; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab771575040so1199516966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742287701; x=1742892501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WqyNv0rkWuAmQG+zonKK152xqjaBxNEetZ8Fug7pRk0=;
        b=XZbSDZ3gv4AVrnGArtQn+OG8CqWNKesM9zgj/tjpM2YeNxrAOIxXKLj2jJJkhmQX04
         HTPppieoKwGQH3oNUfGBtk/Tfrh7ao24oH5UFHRFykmoFofKElYhcrl2ScbPgBnlPY7c
         +OyIkLh1sRSZ+yurZ9U4CRS7gRt4pvmW83AQBixLN42ciMcB/sOKgMDRxpHZHM4x7ZVG
         0JBGM+ihE7n7l77sHtt9KGT5reKct6e80v45Tt7D+ME9bSGFcudlg5zMWAMpt1UqkwWg
         aLPwA3VxAfCqHO9Qrj6IRAuV40W+ig3gDUuM175GKJFl8YuETz43RBz/OnzDzb2lIZPU
         dmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287701; x=1742892501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqyNv0rkWuAmQG+zonKK152xqjaBxNEetZ8Fug7pRk0=;
        b=G5z5JRf0cAgdutoQ6kKfGe/xd7Tnwq01qvTwr0HDLuCjxc4g+WCxvWKZtzaqQn0hjd
         +jUFsWV7ezsDl3VQ876rnispS1K0cuTSaEF8StcMit8x2JcbhBhyvSbU1L4S1oNOpHQs
         p29uFoPHJB0ZblBZAbjNZXI3zkaJO4QdctWBeSZvWwGNGrTZZa8cH0+LP3NIWuhqHpIZ
         Kk3vlNLs0izlqYORiROI6dFvUvh3hze09TQ7gdssbJyc/7uia985xWs35gS68+nEtY2c
         +KYPY+R23Ba+mgl7C8QWQm+Oil+MKRCXaxo7Y1St6rPSL6h/nYwF4kM/AdiT2lOynxd7
         X0VA==
X-Forwarded-Encrypted: i=1; AJvYcCWcdB1tDyXuMhwCkJP3xAyf2TprgPkWJrGRSoVOQsxJnFg3fhmcfY8/L8I8xFfXjn1MMaQDhzElFfPiY2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5vo/2L8So7irs54exzbqYvbteJzAtEoCOccBgKaMljjLmViC
	FPHCR8t1zuzRsbtnGovJ+mXRtVJc5J1fPIHJCdUmoJEOzrGlVQRGdf3F+8og3Ig=
X-Gm-Gg: ASbGncuasecFqfpjGLJmIVIn5lEd9we6HQvaq7KOTqEeHYSjOE4yRmSJofErz2pAl0d
	Ffzg/HJOo+Glcn3D5FNlrGOzEaT+waniwn3lx8AkzhWT3yXW2OgTC2/xhb7cLCTsT9hrZSYToMN
	UIIuivKXL0z3+3+O3HUxEOhtCxJZb5njMAfLgrzRvOaVtrBIlW7NqjPxaozoCtRBhKMyp5ouXQG
	FggcqdD8KMLFJ17WpwexEb0qt6AyRHupuQlaQK328pH6QbGG1Rj3ApqfcDemAYQiuuOcO+Qrurv
	9h+psolJzMTaRdYG1d7gvjuxlGRhSChJ
X-Google-Smtp-Source: AGHT+IH0qrrdRDWB/aWr2KgdxO/sTiN4xjisSw2joUvqvleAHMb/eh591Phxpukd/P9DfWxekAP8Eg==
X-Received: by 2002:a17:907:7ba4:b0:ac2:3a1:5a81 with SMTP id a640c23a62f3a-ac38fab7961mr200393166b.26.1742287701201;
        Tue, 18 Mar 2025 01:48:21 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9ab1sm817130566b.52.2025.03.18.01.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:48:20 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:48:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	charlie@rivosinc.com, cleger@rivosinc.com, Anup Patel <apatel@ventanamicro.com>, 
	corbet@lwn.net
Subject: Re: [PATCH v3 7/8] riscv: Add parameter for skipping access speed
 tests
Message-ID: <20250318-1b03e58fe508b077e5d38233@orel>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
 <20250304120014.143628-17-ajones@ventanamicro.com>
 <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>

On Mon, Mar 17, 2025 at 03:39:01PM +0100, Alexandre Ghiti wrote:
> Hi Drew,
> 
> On 04/03/2025 13:00, Andrew Jones wrote:
> > Allow skipping scalar and vector unaligned access speed tests. This
> > is useful for testing alternative code paths and to skip the tests in
> > environments where they run too slowly. All CPUs must have the same
> > unaligned access speed.
> 
> I'm not a big fan of the command line parameter, this is not where we should
> push uarch decisions because there could be many other in the future, the
> best solution to me should be in DT/ACPI and since the DT folks, according
> to Palmer, shut down this solution, it remains using an extension.
> 
> I have been reading a bit about unaligned accesses. Zicclsm was described as
> "Even though mandated, misaligned loads and stores might execute extremely
> slowly. Standard software distributions should assume their existence only
> for correctness, not for performance." in rva20/22 but *not* in rva23. So
> what about using this "hole" and consider that a platform that *advertises*
> Zicclsm means its unaligned accesses are fast? After internal discussion, It
> actually does not make sense to advertise Zicclsm if the platform accesses
> are slow right?

This topic pops up every so often, including in yesterday's server
platform TG call. In that call, and, afaict, every other time it has
popped up, the result is to reiterate that ISA extensions never say
anything about performance. So, Zicclsm will never mean fast and we
won't likely be able to add any extension that does.

> 
> arm64 for example considers that armv8 has fast unaligned accesses and can
> then enable HAVE_EFFICIENT_ALIGNED_ACCESS in the kernel, even though some
> uarchs are slow. Distros will very likely use rva23 as baseline so they will
> enable Zicclsm which would allow us to take advantage of this too, without
> this, we lose a lot of perf improvement in the kernel, see
> https://lore.kernel.org/lkml/20231225044207.3821-1-jszhang@kernel.org/.
> 
> Or we could have a new named feature for this, even though it's weird to
> have a named feature which would basically  mean "Zicclsm is fast". We don't
> have, for example, a named feature to say "Zicboz is fast" but given the
> vague wording in the profile spec, maybe we can ask for one in that case?
> 
> Sorry for the late review and for triggering this debate...

No problem, let's try to pick the best option. I'll try listing all the
options and there pros/cons.

1. Leave as is, which is to always probe
   pro: Nothing to do
   con: Not ideal in all environments

2. New DT/ACPI description
   pro: Describing whether or not misaligned accesses are implemented in
        HW (which presumably means fast) is something that should be done
	in HW descriptions
   con: We'll need to live with probing until we can get the descriptions
        defined, which may be never if there's too much opposition

3. Command line
   pro: Easy and serves its purpose, which is to skip probing in the
        environments where probing is not desired
   con: Yet another command line option (which we may want to deprecate
        someday)

4. New ISA extension
   pro: Easy to add to HW descriptions
   con: Not likely to get it through ratification

5. New SBI FWFT feature
   pro: Probably easier to get through ratification than an ISA extension
   con: Instead of probing, kernel would have to ask SBI -- would that
        even be faster? Will all the environments that want to skip
	probing even have a complete SBI?

6. ??

I'm voting for (3), which is why I posted this patchset, but I'm happy
to hear other votes or other proposals and discuss.

Thanks,
drew

