Return-Path: <linux-kernel+bounces-210482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F58904430
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86CB283C69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522B79949;
	Tue, 11 Jun 2024 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZsbhNHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48689475;
	Tue, 11 Jun 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132633; cv=none; b=iOMDe6wW4m8GhjfamvsFzNGucsOs/e8mwFkPoTXWyFeWxNivLknvFhKJv8FB1MI0ubII9fvz7BeTvhjJ5F+Z9Vs251DrpVANZN/oHmrkegHcPTQhdwq/f7yGpbJmvfv1IuiDN4GFh9SDnDqpx4yXDhR9xBYlkTxCHeTAQd6XJPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132633; c=relaxed/simple;
	bh=STI3Z2oBLyI/kiqBf7MVVPvXPQQIbr88iwU6AoNRd2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=khZ1bB+RCaCHQ6ohD3YNS5iosHSL5WAWTQ+efHQOhKqqpiSnB/hQaB+Y/FDOi2r8+7huTCWs0wWOZoZdgxHRbwNXiLs4pWc9vSuspCr+oyMzaKLR3Nt4w/tdqR1VC/yRDdrUKP6g4BNeGljCKV3lqer01tdXXIbLk5CDrh5PoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZsbhNHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BA4C2BD10;
	Tue, 11 Jun 2024 19:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718132633;
	bh=STI3Z2oBLyI/kiqBf7MVVPvXPQQIbr88iwU6AoNRd2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KZsbhNHSNQWcqRHzWm4c5B/TWppJS6t42/aLtU2qjVzSSC0RjzlLb+P9zsKaDVUtN
	 wI310Evj9B3d8cULAvG3P30sIw2cagNtsKqBxN0qeh/KYclFKlWMMlZkrimWWFEBdS
	 KoPuuy8kLCpb8VTfvmfjtt6mYTqtbNd0TTk9tuW8JhZ9J57fYyCQIKudY5Ot5VzuV5
	 2lqSfuLMyOB2f8FDUlXKVKj2hKiIcXDB1WM5ir4s4EbKRC5b08UMiQbzP9AEIUkGx6
	 WLoSZv6tcqYKAC7iYxuHmm8ybXjmtxcWaUWaf+E6jixyEJYQkxRKQAGfy73aQi48i8
	 90L1I+yKq6i3A==
Date: Tue, 11 Jun 2024 14:03:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v6 12/49 RESEND] PCI: PM: Switch to new Intel CPU model
 defines
Message-ID: <20240611190351.GA992746@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611172816.352828-1-tony.luck@intel.com>

On Tue, Jun 11, 2024 at 10:28:16AM -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> Bjorn: You acked this. Are you planning to apply it this cycle? It
> hasn't shown up in linux-next yet.

I acked it because I assumed you were going to merge the whole series
together, sorry for the miscommunication.

I put it on pci/misc for v6.11.

>  drivers/pci/pci-mid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> index fbfd78127123..bed9f0755271 100644
> --- a/drivers/pci/pci-mid.c
> +++ b/drivers/pci/pci-mid.c
> @@ -38,8 +38,8 @@ pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
>   * arch/x86/platform/intel-mid/pwr.c.
>   */
>  static const struct x86_cpu_id lpss_cpu_ids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
> +	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_MID, NULL),
> +	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
>  	{}
>  };
>  
> -- 
> 2.45.0
> 

