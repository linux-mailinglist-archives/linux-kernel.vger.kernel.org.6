Return-Path: <linux-kernel+bounces-400318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D96309C0BCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C141F2384B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C5212D2F;
	Thu,  7 Nov 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K+qNSljo"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F3215F6C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997324; cv=none; b=B6fF7qjKPuCCnMmw9Ljss73k7hBuGxo67NQ+Ej57GtLXo1H7hgJnaZChAe9+/bzTHZ7KvNY0C7kOdP9CFckDsKo6EAslQVD0Rbkjh9S4VDAIjpIU/nh+c7ycLcZuSB0VWDVI4/3XhmbrEd4sLJlgYfFnENOd+4r3wXq1KabZsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997324; c=relaxed/simple;
	bh=eUCeCaJ9PfD3zyQFxA6TaQ67CanzLnw3Tdtqk26WJFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRoMmf+dTg78Zm0vDgwgMz1RN4gLqsgSOmBKszndkM+Iioo2GP/XO7FUE+QN2ZmD/jdQphHCO4chkbyFOFecFunYocBm2wl/+5G+GDJQc69DRs0DhhCSmEMGxVBzE/bYs9r0adR8a3/0MEqKMMqoPstMLnQGFTEIau4M6jGPnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K+qNSljo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so1757414a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730997321; x=1731602121; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JmDtn4eHHwzfqsO66Tv5ritJL4qD/TpJe1GQgggVHNw=;
        b=K+qNSljoYoI2xRq7jPFJ23rWYKiv3Kex4fH1UWTwrnEOo4HirqqeJBGeFk+kgYSShj
         zI40ojK3pYoP9ZIiNRMOxbG3cHelpJkaPRo8nB2aCZIqdoCqLyzCXLTd1gjAeS2Izg1F
         qZbwX+6eX4f/ndtxbxBRpIvIc2iLdTaXPOmUbF7jHZsvjonfXMghN5TqKYj+lAidYVrt
         RJn5Aosp1ew2l18ANwZXJhp2k5zLyEQHW14g1Yulx6hIROCAiDCoTQfoTajo7pEhgR2i
         rl2G35nDW8ycpr+ywT12VDDKQGWNe/C0BdSNrGr+fljLH9TyItgmRHGv21N2Xppc2VEL
         qjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730997321; x=1731602121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmDtn4eHHwzfqsO66Tv5ritJL4qD/TpJe1GQgggVHNw=;
        b=kKYHDf2pYUYzjPWVI1Ue/LHn+InS+aPYh0cYnMPQIoDqLRARJXiUZfmK4+jcJNEcBx
         F9klpyJIzeP5aAw5o5exBKAulnBrWnq90iw75Rj8X7n47Dy4GMeZ+sFSS5dOSNreW5OU
         5lTmR590vhqX/Z2cZnYphFw6I8A7en1cKo60QEn9CdeOItvCUO8jagQTzPjb3cO8nXuH
         3fFHJ/u7r7tvqmzAkwEs07/XJ6Yqvnz+Bi/urHQSjSxmlXlIuMeLC6i4yKs9hsSOmWZS
         doZAfBwbgXrn9JxEwaHWaha5m4Mq4u9BT/oQrIdBIawi0IB9N9Tbm54v3edfC7ln/BaG
         0uvA==
X-Forwarded-Encrypted: i=1; AJvYcCUu4qjljAKTJz5OQmmhTwgtERsHYrTGwcXwHkRFEhBFfdTw+Rbcq55889uyTw5m1iqbJQRtTigYXi0xJmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZT0GnIHDNf+zn4uW2x1Ab/ph2Q1ie/qXzCFzHVSWuZWzOAup
	oIt0C/4QjHrtgWv8JKPmKQgFbHmJWPUhVMnHeHnFBcNredyHYbW4hi8gqkeb0Lw=
X-Google-Smtp-Source: AGHT+IFtmxkLlGT8OxA9KTMenPWNAzzstmI7WJwkpa92ObcSE8IEPgx11H+XPafWA5cenT2npaB1EA==
X-Received: by 2002:a05:6402:27c8:b0:5cb:7877:a633 with SMTP id 4fb4d7f45d1cf-5cf098cdc8amr23197a12.33.1730997320658;
        Thu, 07 Nov 2024 08:35:20 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ed68sm951155a12.63.2024.11.07.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:35:20 -0800 (PST)
Date: Thu, 7 Nov 2024 17:35:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH 1/2] iommu/riscv: Free irq vectors on pci remove
Message-ID: <20241107-4570ae5b32599c6ff96b5241@orel>
References: <20241106175102.219923-4-ajones@ventanamicro.com>
 <20241106175102.219923-5-ajones@ventanamicro.com>
 <CAH2o1u5ttY+0d4v8U=H-PwLUHZo5uMxxCQ5NAXudOQvUUMcpfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2o1u5ttY+0d4v8U=H-PwLUHZo5uMxxCQ5NAXudOQvUUMcpfA@mail.gmail.com>

On Wed, Nov 06, 2024 at 11:00:55AM -0800, Tomasz Jeznach wrote:
> On Wed, Nov 6, 2024 at 9:51 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > riscv_iommu_pci_probe() calls pci_alloc_irq_vectors() which
> > states pci_free_irq_vectors() must be called on cleanup.
> >
> > Fixes: 68682e9578fb ("iommu/riscv: Add RISC-V IOMMU PCIe device driver")
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  drivers/iommu/riscv/iommu-pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
> > index c7a89143014c..25a27e627a0e 100644
> > --- a/drivers/iommu/riscv/iommu-pci.c
> > +++ b/drivers/iommu/riscv/iommu-pci.c
> > @@ -99,6 +99,7 @@ static void riscv_iommu_pci_remove(struct pci_dev *pdev)
> >         struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
> >
> >         riscv_iommu_remove(iommu);
> > +       pci_free_irq_vectors(pdev);
> >  }
> >
> >  static const struct pci_device_id riscv_iommu_pci_tbl[] = {
> > --
> > 2.47.0
> >
> 
> Andrew, interrupt release call pci_free_irq_vectors() should already
> be called by device
> managed resources framework, with unwind action callback pcim_msi_release().
> 
> Callback is registered during vectors allocation:
>  pci_alloc_irq_vectors_affinity()
>   __pci_enable_msix_range()
>    pci_setup_msi_context()
>     pcim_setup_msi_release()
> 
> This driver enables device resources management with initial call to
> pcim_enable_device().

Ah, thank you for the education and inspiration to look closer at how this
works. It was easy to confirm with a WARN in pci_free_irq_vectors() and an
echo 1 to the IOMMU device's remove sysfs node.

> 
> Are there any conditions / testing sequence the release function is not called?

No, not that I know of, this was just my knee jerk decision to mimic the
call pairing I was doing on the platform side to the pci side. Sorry for
the noise, this patch can be dropped.

Thanks,
drew

