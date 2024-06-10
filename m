Return-Path: <linux-kernel+bounces-208070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EA90203C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE14B22D49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF67BB17;
	Mon, 10 Jun 2024 11:20:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2818B1B80F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018450; cv=none; b=aSSLjAOfnSAxAuoVUR/rpKppkgqw8UGY/5FLGXhSE/qgf8Oy0G1kFm90ytObJaM9K9Bzzv8ia3BFYyNQaCcDPjRcYYpSXvYbeu5pHc4IZFTqRaBJCCLqXNzUHMH6WGrnm90mbdpULPJWsW5QRKPZ/wTAX4hcdmCvxpZJnxjVqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018450; c=relaxed/simple;
	bh=Ngu42IJRdakR8Hzvh0ArX4zbudLRcENSCZXeLgv7l2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFiZR4UlvgNkI2mEQTdEfhgsu43PuN+o2mXvGzDyaXgl0jmzfIHOhYH7qIHlSNBBi5dSOdbUyXwyf0NTwaBh2VokOPQaikfS7gvQBrsq9XHJedI5VARRvhMrnAQWEupEKyaMaSZmdohV7lr5M9Lk/586REO78SOA7LZtOqbibO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5244A12FC;
	Mon, 10 Jun 2024 04:21:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D91613F73B;
	Mon, 10 Jun 2024 04:20:47 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:20:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: gregkh@linuxfoundation.org
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, rafael@kernel.org,
	javier.carrasco.cruz@gmail.com, julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 0/2 v4 RESEND] drivers: arch_topology: introduce
 automatic cleanup feature
Message-ID: <ZmbhjYdRC4ucv7Mh@bogus>
References: <20240607163350.392971-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607163350.392971-1-vincenzo.mezzela@gmail.com>

On Fri, Jun 07, 2024 at 06:33:48PM +0200, Vincenzo Mezzela wrote:
> Hi,
> I am resending this patch series rebased on top of -rc2 as the old one [1] might 
> have got lost deep in the mailbox.
> 
> This patch series introduces the automatic cleanup feature using the __free
> attribute. With this modification, resources allocated with __free are 
> automatically released at the end of the scope.
> 
>

[...]

> changes in v2:
>     - check loop exit condition within the loop
>     - add cleanup.h header
> 
> changes in v3:
>     - split patch in two
>     - fix misalignment
>     - fix checkpatch warnings
>     - replace break with return statement where possible
> 
> changes in v4:
>     - fix commit subject
>     - fix coding style 

Hi Greg,

Can you please pick these couple of patches up directly for v6.11 as I
don't have anything else ATM ?

--
Regards,
Sudeep

