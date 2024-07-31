Return-Path: <linux-kernel+bounces-268524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2820D9425C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73D3285516
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB8A2905;
	Wed, 31 Jul 2024 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YN3nd1Nm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D804AECE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722403806; cv=none; b=b6dLwQlZI2Sj5zSqouyvOBRsiEOoGIwRmB7aD2yFYIxSF717ID6AjZzz8pU/xjYaKMo4hnbbJOnIRHlXq6zzQc4JLvST6BhZd317s3nWfp2QnRBpdux0zeObKTWnaal0C185w8nYBliapFYNqSv/sce2gDaE9xBuTMxxHyxtLos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722403806; c=relaxed/simple;
	bh=/78uwHbiHAZv44gJCVfoVjIv9Qa6Tk7I/UhVINFv52g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOc5gQAdGN6xEYWeRRsMAHcF42hNCpfgV9FyrjOqSM2VlI1UZUcRHFE0d24YaegF0IT2C3yl2Maxtw5KvCPw28eZBwpGVx1m2Pfes2WWqxpLPli3Nw5piRsYLrfCMdD0RRtja7YTDKKS1H0mAApJ3DDgmR4XEVsGKceGqqJ1YPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YN3nd1Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179EBC116B1;
	Wed, 31 Jul 2024 05:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722403805;
	bh=/78uwHbiHAZv44gJCVfoVjIv9Qa6Tk7I/UhVINFv52g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YN3nd1NmbpFWUihi+9k/i7PvAhUPbhyjzcbQEP3ayewqTAU39pdfdZ30sjA6NtXzh
	 QdiZq9aeUl9sLKSBA1kBj9biDN25D3HIgJCd5bcV3Bbh9WG8VQHfAWGVxuml2HinGS
	 +EKxLZc9sC8daKTWrf/cUtjatp9XNdBHVZ6NIFGU=
Date: Wed, 31 Jul 2024 07:30:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alissa Guo <guoalissa@gmail.com>
Cc: skhan@linuxfoundation.org, akpm@linux-foundation.org,
	brauner@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] documentation: key header files: fix member variable
 description warnings
Message-ID: <2024073138-attest-onset-473e@gregkh>
References: <20240731043609.9762-1-guoalissa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731043609.9762-1-guoalissa@gmail.com>

On Tue, Jul 30, 2024 at 09:35:59PM -0700, Alissa Guo wrote:
> Signed-off-by: Alissa Guo <guoalissa@gmail.com>

For obvious reasons, we can't take changes with no changelog text at
all.  Please fix up and resend.

thanks,

greg k-h

