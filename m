Return-Path: <linux-kernel+bounces-549464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F1A552E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2613AEDC3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29D26B0AE;
	Thu,  6 Mar 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+780lnY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31125D8FA;
	Thu,  6 Mar 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281713; cv=none; b=mmI4b5fRCSzO4KOpya/PYhYb6ViRX0yLYXrLmFeY5001TObesTW3Eaag3Tj1yg3BMHkfIuTXozBmOz6wZf19YS+1i4fRvksy8qKBw77SAF/1h+MPro937dtw7sJhc8/CcNKDaNKyyx5alhVSXulqeva1nGoyACJl6c+McmCCL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281713; c=relaxed/simple;
	bh=DPtMDboM9iFU2eIO7Ttyi5z68cNcw94bUxI9i2bjpMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxDFH6FA79o/SpKcvsicfGIbQ/P3euisj3E1tYdxqI6SZF6Ar0MxoqajoWWsw2udvqUHOzDwb9baTeej6hho4GtgnAZYUf47B1xHFt2dg2gXkVdK83Vgu5afXOT5Lwd1Lo04VwxBhbHiuuiTDBRMzg+UpM0GlZfAkVs8u8/X4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+780lnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61942C4CEE0;
	Thu,  6 Mar 2025 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281713;
	bh=DPtMDboM9iFU2eIO7Ttyi5z68cNcw94bUxI9i2bjpMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+780lnYfb84BnFTke9EEJqZANmg8186dmNUxcE9hPbq53zp56qetEL/tYN+g6+iG
	 WZNn1KamREs4GTZMfWaGOPYWawAlcYWGj4YYZffuy5UUjwcZQno7h3BsuljrI/mv6n
	 tVQ1bkAvQVCqVUH3fqJ8mLfCQisSx728zfHoFKDXT9eC2pQXku4L8obttZPaeAFLjz
	 FR3fovaq8XARg3H9ThRiUCLlLp0JQUrOycAt2sreI7XWA4I9Q3CfFo4KUCVkcK8dZ6
	 C0GdER8Jo7lYsyPbD+WKEKLbpthUwb/X3tptChfVPmDYcl0FiUZpv1JFDSBzjRZlwt
	 CtxZ+wsMcciMA==
Date: Thu, 6 Mar 2025 09:21:51 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] lib/crc_kunit.c: update comment in crc_benchmark()
Message-ID: <20250306172151.GC1796@sol.localdomain>
References: <20250305015830.37813-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305015830.37813-1-ebiggers@kernel.org>

On Tue, Mar 04, 2025 at 05:58:30PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> None of the CRC library functions use __pure anymore, so the comment in
> crc_benchmark() is outdated.  But the comment was not really correct
> anyway, since the CRC computation could (in principle) be optimized out
> regardless of __pure.  Update the comment to have a proper explanation.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/crc_kunit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to
https://web.git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next

- Eric

