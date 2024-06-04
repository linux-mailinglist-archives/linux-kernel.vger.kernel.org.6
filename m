Return-Path: <linux-kernel+bounces-201307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BB8FBCD7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7453B1F23BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BD014A4F4;
	Tue,  4 Jun 2024 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UylMGIDg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701D13D24F;
	Tue,  4 Jun 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531167; cv=none; b=mZDvZmJGvgufcdIAKb8kP4H4jYsClJr60OPmvwpIXomLx9ubRicPfmSwdrK6BZj2hQu7qsCyTLNJw0wpQXVJAL15OQ1AQTvKI2bKrgxT7OeGMRYL2/FCmLriTSGEayQocGdcJl+5B8Uf/a7nu/24PTWvP3vDurM+DiDVpHDIkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531167; c=relaxed/simple;
	bh=adyoGD8HAr9AhEMKf45Q/gY8eQHlMUzh9eGEMTWGPQM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TQITkgYyldEcRQ9eoEfOD/0l8CkKFfmMTy554v6OihXaJxuE7ZBgqP0HxxLYXB24MtqxAcWPduYsmQOaW/8mX0liP3sHXAVyqFf5BwTZae9BV2G9TdF9oeZF7SIWUvPc35kSfKf5Sx5sa6rO/FZ+A+G/ys2d//fZoNELPOE/utU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UylMGIDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0531C2BBFC;
	Tue,  4 Jun 2024 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531165;
	bh=adyoGD8HAr9AhEMKf45Q/gY8eQHlMUzh9eGEMTWGPQM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UylMGIDgJLWEehf+t7DF8NuRbR6al89Udi4ScfRrcCa2QN0ZXVNFmTkSK5wTztvr2
	 NPOlR+8M00XKQtNcDmaiJr3i5nPOmYl2mBjyjqEcAvCPE8TPr/otpaL1Lo0gcC9PX3
	 w5KXCw87V8jzkSqye0G1at/h5bm7RzEp5q8fAQgH9bbswEZsL3S4VO0uRf8TsUl+28
	 hoDj1ploWFj8pNatF0LpslXrlmLpObjIYjD06OhdTVooXTSo858Cwt4oD09HY7BxqJ
	 oRYksTt5fFT/JzwCbV3gvkvT5cGMS6Lx53wXep24/DEJRVdyxUHYkg2371SpV9TdbD
	 zD9HDl21l34aQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 22:59:18 +0300
Message-Id: <D1RHZDG3HJNK.ZWTFLXDBEXD1@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-10-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch()
> routine during early kernel boot. After determining what platform is
> present, various operations specific to that platform occur. This
> includes finalizing setting for the platform late launch and verifying
> that memory protections are in place.
>
> For TXT, this code also reserves the original compressed kernel setup
> area where the APs were left looping so that this memory cannot be used.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/kernel/Makefile   |   1 +
>  arch/x86/kernel/setup.c    |   3 +
>  arch/x86/kernel/slaunch.c  | 525 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel/dmar.c |   4 +
>  4 files changed, 533 insertions(+)
>  create mode 100644 arch/x86/kernel/slaunch.c
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 5d128167e2e2..b35ca99ab0a0 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_X86_32)		+=3D tls.o
>  obj-$(CONFIG_IA32_EMULATION)	+=3D tls.o
>  obj-y				+=3D step.o
>  obj-$(CONFIG_INTEL_TXT)		+=3D tboot.o
> +obj-$(CONFIG_SECURE_LAUNCH)	+=3D slaunch.o

Hmm... should that be CONFIG_X86_SECURE_LAUNCH?

Just asking...

BR, Jarkko

