Return-Path: <linux-kernel+bounces-408069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B399C7A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37F2284AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889ED201106;
	Wed, 13 Nov 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JUfzldrM"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472B200B84
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519438; cv=none; b=gO/uOGh2VX41b+K31insyT/BXHxHftmiZgjD1d8zSsCsoS0dbhMrnujUGp5ySEGf0qIJ+KOlk0sbA0zqg+mB4sIGP44EtQT7R9F5aAyCyUqbwO666vvlCpQRWpW9fCCtjY/w1FDpyotIPx/DlcLkWbcQfT3BEaeaIQ6YlE3Bsag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519438; c=relaxed/simple;
	bh=tpH7XlI6f2/x31O5KZTK/I5XrDRHjtJ2xxSwbrZeKiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzvWo34U41sLQ5OdudNhLbr8lo76c7r98zOFkRi7AOWit0wMzvnAIHTWJS1XOEw538R5LEXuOzMn2n40UeaO4cYPRKPasVOHTEdLY3muJR2uiEgy/UDO/X09u/npNzgx8Ndg7ZvtuS7xUY5BfIWtB35dywakLuo1H/PngoSdpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JUfzldrM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43169902057so58827555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731519435; x=1732124235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=im7VLv5kLVhNsb/0wE3S9j1YXytxDziWmwsT4UuEatg=;
        b=JUfzldrMIUhP553Cxg95mOp0pAWfebbwK5QzC3q5zFXDF63SExGh5xaiZM3fik8dIt
         o572TgGC4QI+EuRQtvXVcxTjvanhf21S0yoN9zYGFWr9Pu2SYDzhjSN0WfQgmbRaX5LG
         JkWbKW5MTvNOTCpH+J+JvV7VMihmsCVZvlx6NRX+SuUx0KBX1rJx02gQXnDrrG2Jsdmm
         V/ZYGdba6kBSKwyy4BpIFW2iBE8PQP+gGc1qtSAlo4/nHbM1xvaR+8LmlJvLdeK4IUCw
         TWHX8kSHegAGbN4Wc4MyzPm1eMUmNiln48nOR2uwgs0BPn99tNM5H8MULqt79QDmao8N
         tJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519435; x=1732124235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im7VLv5kLVhNsb/0wE3S9j1YXytxDziWmwsT4UuEatg=;
        b=QG6mbu9LQ87vGcaEVgwqejMowspdaWlfpxdFC1Dr8Frj+U17YEYW0eF/3nfXnsmiNE
         SUK/qEMGbPdEWQPAdUglmOZT/QSy6Eu5WzgKajR/iE5VAT661UFfQNYaTyaCWVPqItwZ
         oYg3w5kEpupx2378T7h1xSNQrHBlITY4iCFzPg5rBRVPmbupmKTAIOwcKIWIjG7QA8+t
         yPg+MQguOFmiqdvVB8XRnkwYTs5ax8g/rKmT/x1v0er7SPx+92z3CfAW1xtuioYo7zXV
         U6laA8oj/+OPo7q87oC/oJTuBIdWvOjymyZtxm0Xg+kxsGCMr4Qt7Cf5/0JhSE1L+V8j
         br2w==
X-Forwarded-Encrypted: i=1; AJvYcCXTs1t08Vdx0qW7lRsIsO2rJi6go4InpJ+dKsOnSzrMlF3XS9fh/C2FDtSJ9T02aS9pvyrWMiDHRZ9kEuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eMZ9eJ6xPdBRVw3/UdyWUSKZ1pNSBuPW9roRIAQSm8fzrOE7
	OCSCZ18/Vb+IXrDTNI312ay83NKh/qg/CfvP9TOJyg6UY0owZ8UoNF/OnXJTv6M=
X-Google-Smtp-Source: AGHT+IHzCwgR6nFayq9lZx6OFJtGnWn41SZ9+6i/I4rcB92bwXQ2Y7Ixz67I/Gp1Z88zhbCsztRx1w==
X-Received: by 2002:a05:6000:691:b0:37d:36f2:e2cb with SMTP id ffacd0b85a97d-382080817d9mr6391621f8f.0.1731519435006;
        Wed, 13 Nov 2024 09:37:15 -0800 (PST)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda036afsm19222464f8f.86.2024.11.13.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:37:14 -0800 (PST)
Date: Wed, 13 Nov 2024 18:37:13 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>, Conor Dooley <conor@kernel.org>, 
	punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, cleger@rivosinc.com, charlie@rivosinc.com, evan@rivosinc.com, 
	samuel.holland@sifive.com, andybnac@gmail.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] RISC-V: Enable Zicbom in usermode
Message-ID: <20241113-ec9f91d62f4845df79bb21f3@orel>
References: <20241025091527.57825-1-cuiyunhui@bytedance.com>
 <20241025-puritan-sank-b8a828ef5872@spud>
 <3CCBB0AB-169D-4677-9A44-53E4148908D5@jrtc27.com>
 <CAEEQ3wmn9W8A5y37aFisQqd=8Ke7Lt6nY6am99j0O2cNbsVj-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmn9W8A5y37aFisQqd=8Ke7Lt6nY6am99j0O2cNbsVj-A@mail.gmail.com>

On Thu, Oct 31, 2024 at 04:29:49PM +0800, yunhui cui wrote:
> Hi Jessica,
> 
> On Sat, Oct 26, 2024 at 12:32 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> >
> > On 25 Oct 2024, at 11:16, Conor Dooley <conor@kernel.org> wrote:
> > > On Fri, Oct 25, 2024 at 05:15:27PM +0800, Yunhui Cui wrote:
> > >> Like Zicboz, by enabling the corresponding bits of senvcfg,
> > >> the instructions cbo.clean, cbo.flush, and cbo.inval can be
> > >> executed normally in user mode.
> > >>
> > >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > >> ---
> > >> arch/riscv/kernel/cpufeature.c | 2 +-
> > >> 1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > >> index 1992ea64786e..bc850518ab41 100644
> > >> --- a/arch/riscv/kernel/cpufeature.c
> > >> +++ b/arch/riscv/kernel/cpufeature.c
> > >> @@ -924,7 +924,7 @@ unsigned long riscv_get_elf_hwcap(void)
> > >> void __init riscv_user_isa_enable(void)
> > >> {
> > >> if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
> > >> - current->thread.envcfg |= ENVCFG_CBZE;
> > >> + current->thread.envcfg |= ENVCFG_CBIE | ENVCFG_CBCFE | ENVCFG_CBZE;
> > >
> > > I believe we previously decided that userspace should not be allowed to
> > > use zicbom, but that not withstanding - this is wrong. It should be
> > > checking for Zicbom, not Zicboz.
> >
> > Allowing clean/flush is safe but has the same problems as fence.i with
> > regards to migrating between harts. Allowing invalidate, unless mapped
> > to flush, is not safe in general unless the kernel does a lot of
> > flushing to avoid userspace accessing data it shouldn’t be able to see.
> >
> > Also, ENVCFG_CBIE is a mask for a multi-bit field, which happens to
> > have the same value as ENVCFG_CBIE_INV (i.e. really is making cbo.inval
> > be an invalidate). I note that the KVM code, which this likely copied
> > from(?), makes the same mistake, but there that is the intended
> > behaviour, if misleading about what the field really is.
> >
> > So, with suitable caveats, allowing clean/flush could be a reasonable
> > thing to do (maybe useful for userspace drivers so long as they pin
> > themselves to a specific hart?), but invalidate should only ever be
> > allowed if mapped to flush.
> >
> > Jess
> >
> Yes. The original intention is to enable clean/flush/invalid. So
> ENVCFG_CBIE | ENVCFG_CBCFE is added. When one core initiates an
> invalidation, other cores will also invalidate the corresponding cache
> line. So do we not need to worry about this problem? Moreover,
> invalidation is not found in the logic of disabling preemption in the
> kernel. Or perhaps binding cores belongs to the user-space's own
> logic. Can this patch be fixed as RISCV_ISA_EXT_ZICBOM and then a v2
> be sent?

Jessica points out that CBIE should only be set if it's 0b01 but it's
currently 0b11, so just changing RISCV_ISA_EXT_ZICBOM is insufficient
for v2.

Is there a use case for usermode to have an invalidate without a clean?
If so, then is that use case not present on Arm platforms or is there a
workaround for Arm platforms? Because Arm's 'DC IVAC' is only allowed for
EL1 and higher. To be consistent with Arm we can add cbo.flush and
cbo.clean (CBCFE) since Arm does allow exposing 'DC CIVAC' and 'DC CVAC'
to EL0. Since it looks like CBIE=0b01 would just make cbo.inval an alias
of cbo.flush, then I'm not sure it makes sense to set it, in fact it may
just confuse things.

Thanks,
drew

