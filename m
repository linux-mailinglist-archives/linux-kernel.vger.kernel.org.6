Return-Path: <linux-kernel+bounces-518025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7DA388C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BAE3A9D87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9108225767;
	Mon, 17 Feb 2025 16:01:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CC21ADD3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808086; cv=none; b=RwcfYhGdTdrt8ikDiNf9dUVJnvC0cY+aQFVMqVJa0iW4w38nu6um1U/dZA1a5B20HwUHGR7p/4IjGIWcfZuoPUSVsorvW/RhLSaPfkOjlAISEYjx24bW+fz/Qyw5xfBidaOjLRBY5CTiVrWVK6hva4z1pNcesLp72r0lj3q0pfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808086; c=relaxed/simple;
	bh=r0QIMlwoya25c+HjOjrYyIAvdoQ1xo2/pvGD2Bvp+Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRgyoVzjGYS9RUlc87L9p554iaNEMdyfiSfs19I7BmsCsTJWlcbSXmzctYURsSN/XT25BrQ58un67Kdd0Q+C/uUiNtItSKVKcKZ21i90BfIeyYDxGBQaZ2KWIb2+J8i60Pmcr4vZdkG0ihOUpsaTMoEMFFj4QMAG98N/ieppdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5133C152B;
	Mon, 17 Feb 2025 08:01:43 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 677C03F5A1;
	Mon, 17 Feb 2025 08:01:22 -0800 (PST)
Date: Mon, 17 Feb 2025 16:01:19 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<catalin.marinas@arm.com>, <vincent.guittot@linaro.org>,
	<beata.michalska@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <dietmar.eggemann@arm.com>,
	<pierre.gondois@arm.com>
Subject: Re: [PATCH] arch_topology: init capacity_freq_ref to 0
Message-ID: <Z7NdT2OBJPRveDHQ@bogus>
References: <20240827154818.1195849-1-ionela.voinescu@arm.com>
 <Z7NPEic3jxLAQBTd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NPEic3jxLAQBTd@arm.com>

On Mon, Feb 17, 2025 at 03:01:23PM +0000, Ionela Voinescu wrote:
> Hi folks,
> 
> I just wanted to mention that this patch still applies cleanly on
> next-20250217 as well, and it still builds/boots/works as expected.
> 
> I've rechecked it given that the patches at [1] seem ready to be picked
> up, and those patches depend on this one.
>

Is there a dependency on [1] ?

Either way, if Catalin is happy to pick it up along with [1], that would
be best and easiest.

If not and there are not dependencies, then we can ask Greg to pick up.
Which means you need to repost with him cc-ed ? Lets wait and see if
Catalin is happy to pick up before reposting though.

--
Regards,
Sudeep

