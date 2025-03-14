Return-Path: <linux-kernel+bounces-561618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C631AA61421
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D20A17F4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560920125B;
	Fri, 14 Mar 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcIqeTIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29231990BA;
	Fri, 14 Mar 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963884; cv=none; b=BGIOrJgpf1FUe64j/ya1n1jyloNIE1RP+nwJppwi3uVx8PAPanTJabS5r4ibWzW56eRrIKKbZ99H+sN6uw3OhZEQyD7hEJIONtrumySVb1a9flMsVpnh7qAiP1z0E3M/DPdgr1f9f1PHigUrUgAzT4ad1Dp2cyRQ4F6+fFINEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963884; c=relaxed/simple;
	bh=5gPnzD0GDq9FStP/meepINPu9bg61FYeib/5YwHS270=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf1hBBm6TCbU/4Oedl3Lakp4NUKDkgnu9C7uHUgBSJT/5+nwiLMMDD6dblGgSS0j3O+eQ2Fw86ZrmkulZlYsBAKxNtUbzmyV6PPSclkvH9KkWE1jbnE+Y+gW7w0bCgwDmTK+t47ZrghVLevkwefObnd5OuxCgW/EuEQXt3iHwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcIqeTIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC185C4CEE3;
	Fri, 14 Mar 2025 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963884;
	bh=5gPnzD0GDq9FStP/meepINPu9bg61FYeib/5YwHS270=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcIqeTIRacLyhmGOXRYMtoEpjZOkvtoxlCyZ1PwEqvYmoHWM1ejH0e5sidmFF/b+U
	 H9LaRPguudxnqk/mjNRa5Qot77DsHj5vr1WVURdx2OlUiGfcYxvTsjPEmBFynHgsHc
	 UcOBK4r1ovyqwjTGStoHCHGhfLQwwPbfaz60x0CF8RXZg1HMKYfXudb6M+oVZk2c3h
	 CtYaWosJRlKypHsioRRHjDD9Ai/2uzFwIfknehj1J+pvxp89V4CppSbIjJVAtBZYX/
	 Tu7fcF+cYJxZN9aOUb2HCShMW12y8NU2tyv5wHMGp3ZZVkQQbrmkSxTjPvmco1lGiv
	 wlI2tnTxP4mkw==
Date: Fri, 14 Mar 2025 16:51:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: fix struct ftpm_tee_private
 documentation
Message-ID: <Z9RCZ_L6HS0GZhWL@kernel.org>
References: <20250313093717.69270-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313093717.69270-1-sgarzare@redhat.com>

On Thu, Mar 13, 2025 at 10:37:17AM +0100, Stefano Garzarella wrote:
> The `state` member in `struct ftpm_tee_private` is in the documentation,
> but it has never been in the implementation since the commit 09e574831b27
> ("tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE") that
> introduced it.
> 
> Remove it to have a match between documentation and implementation.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
> index f98daa7bf68c..e39903b7ea07 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.h
> +++ b/drivers/char/tpm/tpm_ftpm_tee.h
> @@ -21,7 +21,6 @@
>  /**
>   * struct ftpm_tee_private - fTPM's private data
>   * @chip:     struct tpm_chip instance registered with tpm framework.
> - * @state:    internal state
>   * @session:  fTPM TA session identifier.
>   * @resp_len: cached response buffer length.
>   * @resp_buf: cached response buffer.
> -- 
> 2.48.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[applying next week]


BR, Jarkko

