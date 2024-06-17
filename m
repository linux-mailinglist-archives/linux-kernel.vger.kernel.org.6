Return-Path: <linux-kernel+bounces-218219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E968D90BB48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9411A1F225B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C55717F397;
	Mon, 17 Jun 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N4d/aq3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC88187326
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653169; cv=none; b=OhbNa+5CzvePy6w7WTYvdnxshWkvPJG5CxwqgiHW8PquYoIhSTRLJO3h8ZPb5NuE4zdhmZHdyW6oMPf+Z+/+R1sucronoNn2jqouZACOxlkS/Sk1lF1u14RQN1F294j0QRTFwPnHf8/2IasqYTYbyw5C6BNPoPLu0FkoPwXYfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653169; c=relaxed/simple;
	bh=eifoVYumsdizkrAoyM6QgvMhpDqLMiStFLxX6KG1t64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekxAfoQezxwbAgCIz84NMKnmCQq8BtUlaLp3ZRjI9JJbc4653BfT+26Xrr16t6sGx4Ct65j2RBBDh62Ilm/pZxHzr4hHWrSFqU1DLwTc3kxvt1wO6eEy/8jxhP86/rUT99jyZLn06MLSAwSNEbspYc/Ba9l1ZQj0ZfqakdE46Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N4d/aq3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEFFC4AF1A;
	Mon, 17 Jun 2024 19:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718653169;
	bh=eifoVYumsdizkrAoyM6QgvMhpDqLMiStFLxX6KG1t64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4d/aq3noWi2duzNPZk1nDL3mUgGnUJSxcqCzdyIUFzCsqp6PMTm6aUHlTWQv3Ec6
	 054Fp8hBQqpPqvzS8c0oyWrosalN6jqs6mZTL+O0yIZMWmawEIWaRPICfsK/GXJRj2
	 97heaekywe1HoweuRn8ZERafGVplV7Ha/sx1pF7k=
Date: Mon, 17 Jun 2024 21:39:26 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc: "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI changes for v6.11-rc1
Message-ID: <2024061717-ninth-jigsaw-c625@gregkh>
References: <4726946cc4ece91b414994fcd696aebf69ee115b.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4726946cc4ece91b414994fcd696aebf69ee115b.camel@intel.com>

On Mon, Jun 17, 2024 at 02:08:58PM +0000, Winiarska, Iwona wrote:
> Hi Greg!
> 
> Please pull PECI update for Linux v6.11.
> 
> Thanks
> -Iwona
> 
> The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:
> 
>   Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git peci-next-6.11-rc1

Pulled and pushed out, thanks.

greg k-h

