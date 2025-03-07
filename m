Return-Path: <linux-kernel+bounces-550903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3EA5658D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820A81896190
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF0E20E02A;
	Fri,  7 Mar 2025 10:37:14 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E720D507
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343834; cv=none; b=M8DIp/FwjjXTyil1NtTZ13Ac+HBLA2bZOrxZ+2CiGsFcNMSnZAn4HkzP3f+V2t/7NgiKm3UAbFG9qGAdEfCZQFepMFiumSQb+xPTrIStpywHs3JCFBYj8q/ZgKl2tIGFYzUXIxORBIbYbpOpv8zfkkopKgmu3BWC24aJurCecpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343834; c=relaxed/simple;
	bh=iLn5oLlhbr0s4LMCzs8Lf3sDlErvpf9cLtNXgRVyzAo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxIsqm+5oPyH3CPkDnIJ5m7KoazKRcb8tox+NyzBLhSq9GTKeFl07yaIQvxbbHrFFchmtRD9EbOhZsa/8madvYOevYnPwWCVk9PkPZHedUS9lBq1RPYNU6bd3HyTR+sBSFnQVFfOxR4KONVJfdZhIPSBkNgXXySjhPN44ik1OFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 527AaPBY052202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Fri, 7 Mar 2025 18:36:25 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.11) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 18:36:25 +0800
Date: Fri, 7 Mar 2025 18:36:25 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tim609@andestech.com>
Subject: Re: [PATCH] riscv: add Andes SoC family Kconfig support
Message-ID: <Z8rMKZoDYmpNosSj@atctrx.andestech.com>
References: <20250305030526.1986062-1-ben717@andestech.com>
 <20250306-finale-chatroom-c620ff284d8c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306-finale-chatroom-c620ff284d8c@spud>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 527AaPBY052202

On Thu, Mar 06, 2025 at 04:40:49PM +0000, Conor Dooley wrote:
> [EXTERNAL MAIL]

> Date: Thu, 6 Mar 2025 16:40:49 +0000
> From: Conor Dooley <conor@kernel.org>
> To: Ben Zong-You Xie <ben717@andestech.com>
> Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
>  paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
>  alex@ghiti.fr
> Subject: Re: [PATCH] riscv: add Andes SoC family Kconfig support
> 
> On Wed, Mar 05, 2025 at 11:05:26AM +0800, Ben Zong-You Xie wrote:
> > The first SoC in the Andes series is QiLai. It includes a high-performance
> > quad-core RISC-V AX45MP cluster and one NX27V vector processor.
> 
> I'd expect a config option like this to come with the user, which in
> this case is the dts etc for a board using the QiLai SoC or drivers for
> the SoC. Without dts or drivers, there's no reason to ever enable this,
> so where are those patches?
> 
> Cheers,
> Conor.
> 

Hi Conor,

We are still preparing those patches for upstream, and we will add them
in the next patch series.

Thanks,
Ben

> > 
> > For further information, refer to [1].
> > 
> > [1] https://www.andestech.com/en/products-solutions/andeshape-platforms/qilai-chip/
> > 
> > Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> > ---
> >  arch/riscv/Kconfig.errata | 2 +-
> >  arch/riscv/Kconfig.socs   | 9 +++++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index e318119d570d..be76883704a6 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -12,7 +12,7 @@ config ERRATA_ANDES
> >  
> >  config ERRATA_ANDES_CMO
> >  	bool "Apply Andes cache management errata"
> > -	depends on ERRATA_ANDES && ARCH_R9A07G043
> > +	depends on ERRATA_ANDES && (ARCH_R9A07G043 || ARCH_ANDES)
> >  	select RISCV_DMA_NONCOHERENT
> >  	default y
> >  	help
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 1916cf7ba450..b89b6e0d1bc9 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -1,5 +1,14 @@
> >  menu "SoC selection"
> >  
> > +config ARCH_ANDES
> > +	bool "Andes SoCs"
> > +	depends on MMU && !XIP_KERNEL
> > +	select ERRATA_ANDES
> > +	select ERRATA_ANDES_CMO
> > +	select AX45MP_L2_CACHE
> > +	help
> > +	  This enables support for Andes SoC platform hardware.
> > +
> >  config ARCH_MICROCHIP_POLARFIRE
> >  	def_bool ARCH_MICROCHIP
> >  
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv




