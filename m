Return-Path: <linux-kernel+bounces-185854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1C38CBBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0961F22588
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB9E7D41C;
	Wed, 22 May 2024 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OI2y7haS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138847D08F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362774; cv=none; b=Rxr5362fWsAfwWiy5dsvPSUL55oc9GXWuxLrWp3K4poBfBLZhg9N/7VM9W33YeNYPVGWF9xkEZJ/MeOLw7MNdAqiau8ktOAbtfqAZ5l44emBu8Iaj2zjD4iyjy7y+eZXs39jyY0QrNnOR+jDJ0qO+ADvDy0o7gw9HB6nOSYiftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362774; c=relaxed/simple;
	bh=B2CDPNitYGaoZk2uhokzaiodnwqXGZy926AOhJ4VnBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O38PifvKc6Y70eh5Hj8eAOwDHFLpMQEetr2yz2vUFb9s9hnfskwJDGKohv782dC7zFZnEIOWgPIicIiZEgCVFgUOnMJbJ8ZFLmgKlXBH7ek/n9fohsHPtWqc1dayHZDnWhJAn6DQBxdbanGal65ffpEG+8hS0RCMCDNrCdJ/wjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OI2y7haS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a0e4b773so927464166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716362769; x=1716967569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=otCVHUs3Nwj+ovQYLyF48k7PQwF+3UYRrO9JIydnJro=;
        b=OI2y7haSLgtUNsqIdQ0SwX+50vvyVQKqdz/r5p9v9fNSotnjOWf9HfntSMIClVikFk
         HN4ftKzsR25VlB+0JfwUjkvFrq4uh5reoLOVoIuhnMgIQmXzid7VyKCLkhqrEbji0efI
         IAXTsUzQRhXiIgerlU1tQt02wqtKVQP2XVyORXsbfNtykl8CAhJ6KbHSpcrkXbd1Nahn
         7OE93i3S4FSUjTLFU6RNw5CnEVLNO4cKBEgbQuXOSUOrdBP0JMEmAENDRUBcY5lfiBzz
         er7mqEZsxpu80z+j51tlKH3FTCW0NxcuEYg3WXxBXaUO316usBdzD4DESbzp3pwaRpBe
         8K1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716362769; x=1716967569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otCVHUs3Nwj+ovQYLyF48k7PQwF+3UYRrO9JIydnJro=;
        b=Pp2vcW/8WBhd0uudz/aSP4h/CGuGyIAQuwPIjh8U8HdmXfDNAWCU3aerPK1F4+sKKy
         Z1ZWo41XDjo5uNMnrQ+35JC3XFBfCc6Pg0+Ec1cTve0TCuRZDPkiT4gLSVzCzzx4dyAp
         l/oYN39awqHNTtX+bS2uLiSUdLmAWjWmyrYZ8chI22iiybhyuBC6Vhkfmzo+IVYnaBX1
         rHRxCuhRLt/Dsn1CKaILLq+B1dRrvKJ67tN+YbD0xU9SrA3F/88nZlMJK7xzQ/WZ4Ofh
         HqEMKr3UFP37htyzQXpReBlAPy735BXaFV+3baXHE535jMGvkjxiExpLvqI2Z9DuSkJV
         XTRw==
X-Forwarded-Encrypted: i=1; AJvYcCWP4EWv86zX7stj7mXsQOx2GsfcXNTwxLbRTR6PQqprxmzr1JtZEmwZqrAlkpoGsmheBD3OxfD9VUpL5JtJ0HCdznXmc4LBXi32RIrW
X-Gm-Message-State: AOJu0YzucIqDdkQxICXngMmDTin+CEAHEZoGtmzVyuK8vEWv95TVM3NK
	nhXW88gUWw5I35lCQnr6vpQnIZCLDHUit/HktKzP3yzXarLx36oAmEN0oeAkDUE=
X-Google-Smtp-Source: AGHT+IF6EAxEE0WmF0iEa+XtzugLxuIFj5baBsfbvmbG+5Y6OKzYuSLxthr/qXaZVtPWpKfIPBryBg==
X-Received: by 2002:a17:906:3a90:b0:a59:9b52:cfc5 with SMTP id a640c23a62f3a-a62280a05a2mr61439366b.37.1716362769340;
        Wed, 22 May 2024 00:26:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01399sm1765616766b.172.2024.05.22.00.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 00:26:08 -0700 (PDT)
Date: Wed, 22 May 2024 09:26:08 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Evan Green <evan@rivosinc.com>
Cc: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org, 
	Elliott Hughes <enh@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: riscv: hwprobe: Clarify misaligned keys are
 values not bitmasks
Message-ID: <20240522-d110bb16f54eebb725e943c2@orel>
References: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
 <tencent_338DF690631BAE788C4CC858233E9FBAE006@qq.com>
 <CALs-HssGcNso6vTfbcsiWX1h_46jgDDRcEWcfZCTpxXYnubcng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HssGcNso6vTfbcsiWX1h_46jgDDRcEWcfZCTpxXYnubcng@mail.gmail.com>

On Tue, May 21, 2024 at 11:36:06AM GMT, Evan Green wrote:
> On Sat, May 18, 2024 at 9:00 AM Yangyu Chen <cyy@cyyself.name> wrote:
> >
> > The original documentation says hwprobe keys are bitmasks, but actually,
> > they are values. This patch clarifies this to avoid confusion.
> >
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> 
> Hm, we also have this problem in the code, since
> hwprobe_key_is_bitmask() returns true for KEY_CPUPERF_0. This results
> in wrong information being returned for queries using the WHICH_CPU
> flag. If usermode asked for the set of CPUs that was specifically SLOW
> or EMULATED, the returned cpuset would also include cpus that were
> FAST. I believe all other queries are okay.
> 
> The one-liner fix is to just not return true for that key in
> hwprobe_key_is_bitmask(). But that's technically user-visible: if some
> software relied on the buggy behavior of FAST cpus being swept up in
> the query for SLOW or EMULATED cpus, this change would expose that.
> The grownups-eat-their-vegetables thing to do would be to define a new
> key that returns this same value, but doesn't return true in
> hwprobe_key_is_bitmask(). What do people think?

Even though I actually enjoy eating vegetables, I think it's unlikely
that we need to be so cautious for this. I feel like kernel updates
provide a bit of freedom to change results of hardware query syscalls,
even when run on the same hardware. Particularly the EMULATED query,
which I guess could change with a firmware update. And, even the SLOW
query could change if the probing was modified directly or indirectly.
IOW, applications that use the which-cpus syscall shouldn't freak out
if they don't get the same cpuset after a kernel update, which means
we can drop the FAST cpus from the result.

Thanks,
drew

> 
> -Evan
> 
> > ---
> >  Documentation/arch/riscv/hwprobe.rst | 31 ++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > index 239be63f5089..4abfa3f9fe44 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -188,25 +188,30 @@ The following keys are defined:
> >         manual starting from commit 95cf1f9 ("Add changes requested by Ved
> >         during signoff")
> >
> > -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
> > +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A value that contains performance
> >    information about the selected set of processors.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> > -    scalar accesses is unknown.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_MASK`: The bitmask of the misaligned
> > +    access performance field in the value of key `RISCV_HWPROBE_KEY_CPUPERF_0`.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
> > -    emulated via software, either in or below the kernel.  These accesses are
> > -    always extremely slow.
> > +    The following values (not bitmasks) in this field are defined:
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
> > -    slower than equivalent byte accesses.  Misaligned accesses may be supported
> > -    directly in hardware, or trapped and emulated by software.
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> > +      scalar accesses is unknown.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
> > -    faster than equivalent byte accesses.
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
> > +      emulated via software, either in or below the kernel.  These accesses are
> > +      always extremely slow.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
> > -    are not supported at all and will generate a misaligned address fault.
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
> > +      slower than equivalent byte accesses.  Misaligned accesses may be supported
> > +      directly in hardware, or trapped and emulated by software.
> > +
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
> > +      faster than equivalent byte accesses.
> > +
> > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
> > +      are not supported at all and will generate a misaligned address fault.
> >
> >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
> >    represents the size of the Zicboz block in bytes.
> > --
> > 2.43.0
> >

