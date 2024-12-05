Return-Path: <linux-kernel+bounces-432496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470509E4C24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83BC1691C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7911369B6;
	Thu,  5 Dec 2024 02:09:52 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D554C96
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733364592; cv=none; b=qnuiJXADNIuKoOOBJzFswO4TcoU/MKfqJ7kHEli0AzwZc6KZehz2NMDzQrMx/wtGN1mMVPlPyQqBT6H6+FfSKAiEFyjLALl+FskGdMnAfg+kvj5Dok9de10c/On8IBlC5MsM8nPZdbj3sAsYqHV76IurkdQ5snOnf7frfm/++9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733364592; c=relaxed/simple;
	bh=eCsXK+inz01hctskovwnKepxB9sJXRhIO8W91EsmIiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdxX3GCNKBDLBc8/asp0jJSl63+AhsKZAIFOlR8wb0+oIPtWIC2X/QN8BCf2pm+0Da+0DuWbI5B1dF0CB6+W6ijNGOWLnEQnHMAUfUh3dH3dbH43ppVBX3ggdLzDkFOUsErPYKg5/Ulkhc/xPsiGXLns2jG7R9AAiRB0doQZUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id CEBB372C980;
	Thu,  5 Dec 2024 05:09:46 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id BFFB236D0178;
	Thu,  5 Dec 2024 05:09:46 +0300 (MSK)
Date: Thu, 5 Dec 2024 05:09:46 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <20241205020946.yf6xdieoswsrmvi5@altlinux.org>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck>
 <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org>
 <86ser6t6fs.wl-maz@kernel.org>
 <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
 <Z05cuuMMurzp1jx5@linux.dev>
 <20241203040350.4soyvaeqs75kjqoj@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20241203040350.4soyvaeqs75kjqoj@altlinux.org>

Oliver,

On Tue, Dec 03, 2024 at 07:03:50AM +0300, Vitaly Chikunov wrote:
> On Mon, Dec 02, 2024 at 05:19:54PM -0800, Oliver Upton wrote:
> > On Tue, Dec 03, 2024 at 01:31:19AM +0300, Vitaly Chikunov wrote:
> > > Marc,
> > > 
> > > On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> > > > On Mon, 02 Dec 2024 15:59:40 +0000,
> > > > Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > > 
> > > > > Marc,
> > > > > 
> > > > > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > > > > >
> > > > > > What the log doesn't say is what the host is. Is it 6.13-rc1 as well?
> > > > > 
> > > > > No, host is 6.6.60.
> > > > 
> > > > Right. I wouldn't be surprised if:
> > > > 
> > > > - this v6.6 kernel doesn't hide the MPAM feature as it should (and
> > > >   that's proably something we should backport)
> > > 
> > > How to confirm this? Currently I cannot find any (case-insensitive)
> > > "MPAM" files in /sys, nor mpam string in /proc/cpuinfo, nor MPAM strings
> > > in `strace -v` (as it decodes some KVM ioctls) of qemu process.
> > 
> > If you can attach to the QEMU gdbstub of the VM, info registers will
> > dump ~everything.
> > 
> > If the value of ID_AA64PFR0_EL1.MPAM (bits 43:40) is nonzero then the
> > host KVM is erroneously advertising MPAM to the guest.
> 
> I don't find such register. There is what I get:

Thanks to ArmCpuInfo.efi I can confirm MPAM is advertised.

  Shell> ArmCpuInfo.efi
  ID_AA64PFR0_EL1  = 0x1100010011111111
  ...
  PFR0  | MPAM         | 43:40 |  0001 | FEAT_MPAM v1.0 implemented.

I prepared the kernel with Marc's patch (backport of 6685f5d572c22e10 to
6.6) and am waiting for the admins to boot it, hopefully today or tomorrow.

Thanks,


