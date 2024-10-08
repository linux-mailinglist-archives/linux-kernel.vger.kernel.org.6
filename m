Return-Path: <linux-kernel+bounces-355794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA902995720
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747A91F2154C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA720ADC6;
	Tue,  8 Oct 2024 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnFnbSUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02409212D0E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413380; cv=none; b=aUd/tyqZyuoaTF8zLnI1IamIDOWsq0DwExar7v5/UooIZgT4gjG6+BjWKpzTHCo5R6hEESNUq/5L8Zgazhg9Wnb2rOAHLOAAD+VuCWHpGP37gwfdnlmmTKDm47Kg6EpcsvozLfM8tEJyUF7a3O50JQizbVkCC3FYjZapQr9wWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413380; c=relaxed/simple;
	bh=/+Z562pCSlCIS+zIXgrDvFUAxw7a3m6Wo/BKMRopzeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb+jXJpx6n2/fAuTrq1o5M9EaCneaxb8p0iq3BynTZN7vWRbjHji/dGlcM/6Oub4mqcnoh8pHjY9A929KM8VYpDoSVsEMG3NPk4p2K09jWD+RDOK1dxlHHLKoHElDCuvRXOfWm02xcN/URR24whRt3jP6DIrD5L/2ZjCBxW68+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnFnbSUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8FCC4CECE;
	Tue,  8 Oct 2024 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728413379;
	bh=/+Z562pCSlCIS+zIXgrDvFUAxw7a3m6Wo/BKMRopzeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnFnbSUKAF93KTcYMjY/8WkBjC1eNMkb69Qs23WVSCc189UOfFSFIMxPto+bzjwAn
	 M25kXR4jl0bhfu3yK3BDSfdT0CyXhvowv4elJgNQNvSsSR2mmAwZ+vHK45MDP6xt2K
	 JTwLiF89Zj2uzOOzBrbPw1d9pCQr8DyRs+pgIDT30kLjYf29ABVL/4QPNqEN81wial
	 WjFG/A1DshR/Psi+f9spXXUz6girO2Eo1cw/XL+/Vjn4KUB7RuKANGALxhYCtKfI3K
	 3ZcQwTIVGHG4wdyZsH1cfQIR+FYwmJoXxcL3r8fbTba+M+D76pAoKgFnD2LSWezcVt
	 6sBaMV9tu+Oaw==
Date: Tue, 8 Oct 2024 08:49:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Devaansh-Kumar <devaanshk840@gmail.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Documentation: Update instructions for
 running example schedulers
Message-ID: <ZwV-wohKcSwIhL_m@slm.duckdns.org>
References: <20241008142622.3601647-1-devaanshk840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008142622.3601647-1-devaanshk840@gmail.com>

On Tue, Oct 08, 2024 at 07:56:20PM +0530, Devaansh-Kumar wrote:
> Since the artifact paths for tools changed, we need to update the documentation to reflect that path.
> 
> Signed-off-by: Devaansh-Kumar <devaanshk840@gmail.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

