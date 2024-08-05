Return-Path: <linux-kernel+bounces-274668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7E947B49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8FA2809A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EA6158DD1;
	Mon,  5 Aug 2024 12:53:40 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51961E495
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862420; cv=none; b=gquu93AJl9NgUsKKvg0+k2At0DpIKGBne31nKlCUyotwKZL8S/qOSAoT39v1zQ/gxvPg8Db6+Vgq1XkRfl8wWCAqK4h1fD3H96PQP2ddqH5kK4saFCrSwToPnvGWvPO9dIx94Tu6LJDeDfCnvYwwfv44HzI7VV/JpYbVKtuldmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862420; c=relaxed/simple;
	bh=qQi8KJaOfN2EbqzNu27f2VEbvDGUHgkgxQKPZ+MGnFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+MlhIpC4shYqKGY1tGWK/1tsVazoYDeIvL5sV6BdiQOpop9KbhoRXh0FPGaP3e7saLClqvlIOV6/Psk6Rl9dcOW9+IpBiVswIA/0h/VrQcRqXo/u4s/ks7xsi+VpRLGCeTjWxnV9rZWZunsSIs2ophnS4t0NoxG6T2x3AY2EvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so9514053a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862417; x=1723467217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WraVC5+9H/alIBOTzai3ehAf97V9Mijb7uzflYMj8jg=;
        b=w7nrVTbtdIaoJ5GIZyJucjNJzQMtWR/3B2YQuSvmiBm7hciaHyxg/vsfOdl0UocE84
         ozjCIkfmT0LJOUO1ljhtFlU+u6Ubpk6Bu07oZMcGiGdAvSDM2CNM/Rm1ATz5+c3goqrv
         X9HghM9vdBo1ljdgMp5HlqEHOY3IMgPZzDg98pRRL+Y+1hx1SHV1dxOiKe9c1u2O1HOd
         2jbLe8i3FRLYqRepr50QCkth1Ec4XKSTiUd/ztAoZRX1gJtE+wm59U83igY9p44dR0Cm
         OySGUsgXIlXmLsNRtcTAa4PkyE4b8hTvtyrZrdvTcCfQbybNhcql6KGlvZ95tS9xpQN3
         t77g==
X-Gm-Message-State: AOJu0Ywo2W4p3lsEqY3vn3TAMxtT0ISM43EVENEpRaNiVlEm1WWNdDcr
	eXgYc88l0dykb6f4Z+QS3M9KqocsiWSYX8+Nh+k6n0Zt7IgbSfW4
X-Google-Smtp-Source: AGHT+IF8h9Ueixj5S9j6FxR+8Ijspq1GWBWt84cLLf7mHbbvUcao0sB9QchBpzZyiV/s6sIeveurIQ==
X-Received: by 2002:a17:907:318a:b0:a7d:c382:bcdf with SMTP id a640c23a62f3a-a7dc3840a58mr962909366b.10.1722862416536;
        Mon, 05 Aug 2024 05:53:36 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dd074ec36sm420592966b.57.2024.08.05.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:53:36 -0700 (PDT)
Date: Mon, 5 Aug 2024 05:53:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch 01/15] x86/ioapic: Handle allocation failures gracefully
Message-ID: <ZrDLTtN2kiPtpY1l@gmail.com>
References: <20240802155038.556977544@linutronix.de>
 <20240802155440.275200843@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802155440.275200843@linutronix.de>

On Fri, Aug 02, 2024 at 06:15:34PM +0200, Thomas Gleixner wrote:
> Breno observed panics when using failslab under certain conditions during
> runtime:
> 
>    can not alloc irq_pin_list (-1,0,20)
>    Kernel panic - not syncing: IO-APIC: failed to add irq-pin. Can not proceed
> 
>    panic+0x4e9/0x590
>    mp_irqdomain_alloc+0x9ab/0xa80
>    irq_domain_alloc_irqs_locked+0x25d/0x8d0
>    __irq_domain_alloc_irqs+0x80/0x110
>    mp_map_pin_to_irq+0x645/0x890
>    acpi_register_gsi_ioapic+0xe6/0x150
>    hpet_open+0x313/0x480
> 
> That's a pointless panic which is a leftover of the historic IO/APIC code
> which panic'ed during early boot when the interrupt allocation failed.
> 
> The only place which might justify panic is the PIT/HPET timer_check() code
> which tries to figure out whether the timer interrupt is delivered through
> the IO/APIC. But that code does not require to handle interrupt allocation
> failures. If the interrupt cannot be allocated then timer delivery fails
> and it either panics due to that or falls back to legacy mode.
> 
> Cure this by removing the panic wrapper around __add_pin_to_irq_node() and
> making mp_irqdomain_alloc() aware of the failure condition and handle it as
> any other failure in this function gracefully.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/ZqfJmUF8sXIyuSHN@gmail.com

Tested-by: Breno Leitao <leitao@debian.org>

Thanks Thomas!

--breno

