Return-Path: <linux-kernel+bounces-441529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF33A9ECFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F86166C13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6F1D63C8;
	Wed, 11 Dec 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qysWSzRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71181AA1C4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930949; cv=none; b=uWyehWto2zSpJuRmQzdyx0Ck3hPOgXTYhbEauGDyVpw6BgmO9jaOsmS382USTXUeQDsJzFTSmQDB0U1hVs9HF/aLTrKBtj6tdt7qCEt3UM3X4pCh90uIsD+QCRmNdqBpeP/PnzyVJ9wjqZ60ANf9Or9N2tJWiRAp7qxWiTJz1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930949; c=relaxed/simple;
	bh=rkwQDpMysmHivnLSIZ3GemthozTMlUPliRC4tSjcAEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d59tce3MDgFkk+MscUQiuT6k8koQr+ypZNFlDnqUI3cRwCdzmaaONt1zxYTKHk1gIAzBpRh0AeBhAJxocx8D6oZ7X1JIAR2dpbGX0YS2tyeN2dPZhMNC0pB2wy2stx/g99Z7cpf/yCXG/klvdCx0yut2fqTo6qsOiUp0p63iEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qysWSzRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED31C4CED2;
	Wed, 11 Dec 2024 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733930948;
	bh=rkwQDpMysmHivnLSIZ3GemthozTMlUPliRC4tSjcAEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qysWSzRhG6kGtZEyZB9pS+uPvFDbrukqYpUnBXNYB7gIpF1cNCh0QmwJQuSndgw/y
	 FURauapPHfIid4f0VHDGvXFR5VYmU3UGxS+ibKndauCCyc5c13GLpInCZIYmGGtlmu
	 RUxVn7X34lNVVE243hNaEDPEDc06xsrT0UoXOC4Dz4MjFG1AXCf/HMozC3dXSGdxj7
	 wwzMHP0jG4ma7iUrvtrVcgqd3UUa6vo7SdWB9MZYA22X+VJHWXKyhUJhYM8KBZjkI0
	 NepsWXC5mJwLKrNtnO3IJ6vnNlodMZR4zxmSbfPXzeJ8aBbiT0Zk8VHJ7UNimeOtzJ
	 IKPrOvEBM9VUw==
Date: Wed, 11 Dec 2024 05:29:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH] MAINTAINERS: add me as reviewer for sched_ext
Message-ID: <Z1mvw1proKmPUvsD@slm.duckdns.org>
References: <20241211083945.832294-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211083945.832294-1-changwoo@igalia.com>

On Wed, Dec 11, 2024 at 05:39:45PM +0900, Changwoo Min wrote:
> Add me as a reviewer for sched_ext. I have been actively working on
> the project and would like to help review patches and address related
> kernel issues/features.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Applied to sched_ext/for-6.13-fixes.

Thanks.

-- 
tejun

