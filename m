Return-Path: <linux-kernel+bounces-532518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAC3A44EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410A23A3E72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17331A9B46;
	Tue, 25 Feb 2025 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7TGGKsf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528320FA9E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518901; cv=none; b=kvIVVCC9cbM1mNHcnNk9RtWzaIUd51XNjncD4faoAf2WRK9GDPE94600oBML17GLXciC+1cl1Ki6Fq0q1/7VUKTWvsBur1jmuLK1HQyUtDOvU5lVmJjXQDqXO91SJGYp8vKb+6OAbp0c1QT58LoOUEvMT+harsLNH5VOUZtou7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518901; c=relaxed/simple;
	bh=tGjkofuEIivMoNaX8ssUQFzlcHymMjbHgcL8gzhpL3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMZTmNeuloDCEBncHax3Cc0Hh8D+/PxXKS6u33d7T0/0T5OHcvcYOuv5bK4bAmg9eT2qFurT0SGAP1Dirq6hlqg+atSDPQye/3Wb6EhTnpo8DkjzFXa6WiovneYM3cWmKjgLtjVee103CWq8P/hyUK90/Y+XkSVJ/u5S4reR5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7TGGKsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB825C4CEE2;
	Tue, 25 Feb 2025 21:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740518900;
	bh=tGjkofuEIivMoNaX8ssUQFzlcHymMjbHgcL8gzhpL3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7TGGKsfCTkJdmSxZyRzaIDKpvWNjnL3R7TEVJUivR4JCbODKEeqJw7UN/PPUtztn
	 mlRPt91uG9cDeszd6o3qwUi8uN9DGg2aLNc0tYisW1CgDoX2fANrKVlU3a1OCbV2X8
	 mPReHSf2MUeCu+1G/i0TOz7/clTaAjUzubo7Gt4d2jMnXZKFz1otlfk8sgT0012itq
	 XVbXOTJADBf1FPWINL/nLE7jSvyHVuXSTHTsP3sRYfsXbk/cFElbRcgLWLRF6LF9Ex
	 l/WF6LeZWWty+OTCeSpDbny0CE8wgsUBFXNU7z55SNMWiKYt3Fu5HiEJdDpO9dPaPW
	 MGCRv3vngc8Fw==
Date: Tue, 25 Feb 2025 22:28:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux@treblig.org, Andrew Morton <akpm@linux-foundation.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
	tursulin@ursulin.net, x86@kernel.org, airlied@gmail.com,
	simona@ffwll.ch, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/iosf_mbi: Remove unused
 iosf_mbi_unregister_pmic_bus_access_notifier
Message-ID: <Z7416P1rZPNMHQq7@gmail.com>
References: <20241225175010.91783-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241225175010.91783-1-linux@treblig.org>


* linux@treblig.org <linux@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of iosf_mbi_unregister_pmic_bus_access_notifier() was
> removed in 2017 by
> commit a5266db4d314 ("drm/i915: Acquire PUNIT->PMIC bus for
> intel_uncore_forcewake_reset()")
> 
> Remove it.
> 
> Note the '_unlocked' version is still used.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  arch/x86/include/asm/iosf_mbi.h      |  7 -------
>  arch/x86/platform/intel/iosf_mbi.c   | 13 -------------
>  drivers/gpu/drm/i915/i915_iosf_mbi.h |  6 ------
>  3 files changed, 26 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

