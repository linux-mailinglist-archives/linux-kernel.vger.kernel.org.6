Return-Path: <linux-kernel+bounces-429105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454C9E176E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49411657A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982E1E008C;
	Tue,  3 Dec 2024 09:27:32 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2641DF72C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218051; cv=none; b=O7AgFU8kkNWU8pp+uOnvvELoYc8s/gTGRjagpvuTvC1ciS1EQAa6OW7ZwSQyqWX0smtBCuweIlnv/A/cRD+HdDZwEIWp2ddhza1TBSkd130X3w1cyviSmPBLm11y45uXNQGIJ1BhOK+EXZogzUQf/j66bhqb9sgVPYgI5p/+u6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218051; c=relaxed/simple;
	bh=UsfaS/q85LloFao5nUmEwKFTJE8VC8TF6aylBYu1uLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y36+Kw6PFqHGsOt9Es0ae2YqaQAb6CBvTGnrgpRw17f10UhktZ8AMER7Ppf7CkFWneAqCeNzXeR92uCh3uvG924gjKjJRr4si2Fj40C22KzwRtAuTgllGWzPfGmjk4D6lRW/cBLuIvJ1Q6L6nL/hAVAVcBzvU5zNm2TIEL3g5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id B607072C90D;
	Tue,  3 Dec 2024 12:27:21 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id A808736D0178;
	Tue,  3 Dec 2024 12:27:21 +0300 (MSK)
Date: Tue, 3 Dec 2024 12:27:21 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, james.morse@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, oliver.upton@linux.dev,
	mark.rutland@arm.com
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <20241203092721.j473dthkbq6wzez7@altlinux.org>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck>
 <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org>
 <86ser6t6fs.wl-maz@kernel.org>
 <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>

Marc,

On Tue, Dec 03, 2024 at 01:31:19AM +0300, Vitaly Chikunov wrote:
> On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> > On Mon, 02 Dec 2024 15:59:40 +0000,
> > Vitaly Chikunov <vt@altlinux.org> wrote:
> > > 
> > > Marc,
> > > 
> > > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > > >
> > > > What the log doesn't say is what the host is. Is it 6.13-rc1 as well?
> > > 
> > > No, host is 6.6.60.
> > 
> > Right. I wouldn't be surprised if:
> > 
> > - this v6.6 kernel doesn't hide the MPAM feature as it should (and
> >   that's proably something we should backport)
> 
> How to confirm this? Currently I cannot find any (case-insensitive)
> "MPAM" files in /sys, nor mpam string in /proc/cpuinfo, nor MPAM strings
> in `strace -v` (as it decodes some KVM ioctls) of qemu process.
> 
> > 
> > - you get a nastygram in the host log telling you that the guest has
> >   executed something it shouldn't (you'll get the encoding of the
> >   instruction)
> 
> I requested admins of the box for dmesg output since I don't have root
> access myself and nowadays dmesg is not accessible for a user.

This is what they reported:

  kvm [2502822]: Unsupported guest sys_reg access at: ffff80008003e9f0 [000000c5]
                   { Op0( 3), Op1( 0), CRn(10), CRm( 4), Op2( 4), func_read },

Thanks,

> 
> > 
> > Can you confirm these two things?
> 
> Also, I tried to reproduce on another Kunpeng box with slightly
> different HiSilicon CPU (presenting to the system as Cortex-A72) and the
> problem is not reproducible there.
> 
> While things are not resolved, is it possible to workaround the problem
> with some QEMU option, kernel command line, config option, or a patch?
> 
> Thanks,
> 
> > 
> > 	M.
> > 
> > -- 
> > Without deviation from the norm, progress is not possible.

