Return-Path: <linux-kernel+bounces-364402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0581299D433
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2735C1C22104
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C31AD3E5;
	Mon, 14 Oct 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0ky43CR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B3175B1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921944; cv=none; b=RaW8Nzeg/m5PWt5X0PWq513Zj0YShMGHGgRkyEt/fatg0egMjAsdC5AYF22pmr7hQ/fvxDgseSx0euw5aJl/DdB75UK/yIwI3N6GeWBdKQ8e3HDE/1mXbVK5//2EVCh2z+E8MfmhIXfil54UdmxboY/NOAcMdltgPUSSFxmxQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921944; c=relaxed/simple;
	bh=FUNAbuY9VUcTA6rdkAbpB+TVHERbMMF8fyXegm8bPCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpx9JQsM6bWQZXqMz/s/sj/muRvZRI53RJjVnBiyrJ6yjPU0mzQFFzTMaeWd0xt/VNFyiMl8020+kDCceg1ZqUc+2fyMQJL8suomxUglll/P9O5J47ov4pNhKxh9l+r8sj3bSV/eE/jgUBoyI8+iobIU2UmPXf9bv6dhCkndhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0ky43CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC5FC4CEC3;
	Mon, 14 Oct 2024 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728921944;
	bh=FUNAbuY9VUcTA6rdkAbpB+TVHERbMMF8fyXegm8bPCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0ky43CRdBYlLqSD4pVVStMEw9RnvSHgsyM+mNapUSvdEu/ji90zrTmNpCgUa+/TW
	 MQCFkR8RwUq3+1YuP2fLMfqIiWQczdDyV9sLl8OIjfwXA3leapGA1AwCXwnOA4fpcb
	 rmYf/t3h4stqk+7XYXpJ43hqU4dwo6vGosSn1F2dB4el0EuJKiHTosgz+viFwm4WFo
	 TCt6H1gigkORIonvsjmDlDr7oeY0uF+6V79A5QHOUno4x28czobP7qKfNSwBZX2IC/
	 xTH/k05IsgQZRGBCoo9s7+2yaxbrJl39R38LfaqxNW0JVxnRdoqxSntopY6OF/A4qC
	 40Wvn6S5+iuGA==
Date: Mon, 14 Oct 2024 17:05:39 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Ba Jing <bajing@cmss.chinamobile.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm-ccn: remove unused macros
Message-ID: <20241014160539.GA17809@willie-the-truck>
References: <20241012091629.2369-1-bajing@cmss.chinamobile.com>
 <ZwziGzex9RmVlcNa@J2N7QTR9R3>
 <24019386-6ecc-4715-9486-503ccc828113@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24019386-6ecc-4715-9486-503ccc828113@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Oct 14, 2024 at 04:40:52PM +0100, Robin Murphy wrote:
> On 14/10/2024 10:19 am, Mark Rutland wrote:
> > On Sat, Oct 12, 2024 at 05:16:29PM +0800, Ba Jing wrote:
> > > By reading the code, I found these marcos are never
> > > referenced in the code. Just remove them.
> > > 
> > > Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> > 
> > These are control bit values, so I don't see a strong reason to delete
> > them unless we're certain we're not going to use them in future.
> > 
> > Anyhow, Robin Murphy wrote this driver, so its up to him. Please Cc him
> > for any changes to this driver in future.
> 
> Er, this is CCN - FWIW I didn't claim this one, nor CCI, as supported in my
> maintainers entry largely because active development on them has long
> finished, but also because I *didn't* write them, so wouldn't claim to
> understand them much better than you or Will do ;)
> 
> However, I'd agree that there doesn't seem to be any significant benefit to
> removing these (certainly showing at a glance that ALL_ERRORS_DISABLE is
> composed equivalently to PMU_EVENTS_DISABLE seems like no bad thing.)

Yup. FWIW, I wasn't intending to take any of the patches removing unused
#defines in the PMU drivers. I'll pick the one removing an unused
'list_head', though, as that at least makes a structure a bit smaller.

Will

