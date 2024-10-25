Return-Path: <linux-kernel+bounces-381791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F03C19B047F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F59B22A87
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C61D9A66;
	Fri, 25 Oct 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAJzNytW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306344A1B;
	Fri, 25 Oct 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864207; cv=none; b=tyMvvbNnYQhfGr9qhWBBlHLGv6c8Y5NWapk0/K3iXQptftTQIiHfY2HchF7/Sn6+KCKyzQ6rw6B8Sv9pHK/jEH0kawi9cV+FoyH6k02JvNsNjSFHuwZYgUck6RQJtPPsJn3mJkmp7TNA7zDxhQLcds54/U2FE2TCVGgYuSPs+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864207; c=relaxed/simple;
	bh=wtg/Mg+3id26S9R42SknS3o1wThyyGsm4KNyz92R+GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEzRT34IhMRIJez3Iq8NU/WPUOxCD3/fAz/NuDM+lZuzT9mURmGWQUzeHRbHORD6iqnkYQs5vpKRg1RY4I8tNduTryibqWXghoiJZ3p/B9mKSOk1vEr2HqEnfsjUC3swpenHpWetospIyOuee3Njy9h2IfiTdYODnsT6+QURAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAJzNytW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFDFC4CEC3;
	Fri, 25 Oct 2024 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729864206;
	bh=wtg/Mg+3id26S9R42SknS3o1wThyyGsm4KNyz92R+GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAJzNytWSi+w5hr+2v6xe+jYrkGHfZEniPXR+zqNeK+zuTFb9DApUvXHRww9K147X
	 SHQb/JaD71wSx7FKXMReEvm0KssWc1vCm00ac2DNIOW+pdUSiBk9m5RWfBe5by3bdw
	 do61/r1U4LqELhYYW7fjBVgQLD6n7t8h+GlcyNVvVLrwkfyUQao7znKLmOZnLIszdO
	 61lIrkh0vbj5UdiF5ECXfyhy7v5SEZ6YTuSo+4bkJ7zkgTFkMaf5CVN8vx/juAymgG
	 ufALqhQmzp7Nkra0DjCmCaIf9cSSAJhr6BuRcM8u9QneYtrBWDUeQt0i140hhlAuuw
	 ohZR/UPsPQaWA==
Date: Fri, 25 Oct 2024 14:50:02 +0100
From: Simon Horman <horms@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	guodongtai@kylinos.cn, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com
Subject: Re: [PATCH 1/1] add comment for doi_remove in struct
 netlbl_lsm_secattr
Message-ID: <20241025135002.GX1202098@kernel.org>
References: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
 <20241025065441.1001852-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025065441.1001852-1-dongtai.guo@linux.dev>

On Fri, Oct 25, 2024 at 02:54:41PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>

Please don't post updated patches more frequently than once per 24h.
It makes reviewing quite cumbersome.

For comments on a (slightly) earlier version, please see:

https://lore.kernel.org/netdev/20241025065441.1001852-1-dongtai.guo@linux.dev/T/#mc951365b9ba02e3538efa0f0eb6a215199efc73b

-- 
pw-bot: changes-requested

