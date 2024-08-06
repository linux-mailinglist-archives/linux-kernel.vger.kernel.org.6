Return-Path: <linux-kernel+bounces-276149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D3948F18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438BF1F2308A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91F81C4611;
	Tue,  6 Aug 2024 12:37:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB9A1BD507;
	Tue,  6 Aug 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947851; cv=none; b=sZO1N9MI5yuCFC7CZmymbidhhgzLtw4qD9htrWrFs6x8zspJ5MJ0g+owJfVx8aijGxXjN8TUV50c+/9IU/UAtHsWlfQB+76JP+6WHfTsH+ivHp/NxRr+cNJOspBBNXYEBUMf+fjZtfFll8a13pZRNEaJW8mNk4n9d4pSUYR60d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947851; c=relaxed/simple;
	bh=4pUDZr3FbiuaycMG/Q848c6oZLN1YC9SHrlNtMts3lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrsP1EkognUr4nqHZSUfLRm5PGQHnlUGR6AbUW0mSmUqzIVr4wy29/RkZI3b6G/A3rlbjxkhmeN9Jvv34wnCzEuKjzjXBGG2mgrCAKcTKwlnQH5MzpANNisvJGd8x/s8Gzs/1ZjqrvsNGgcK7dUkEYLAsZWGbKOASLhUcll+XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940F0FEC;
	Tue,  6 Aug 2024 05:37:54 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4D373F766;
	Tue,  6 Aug 2024 05:37:27 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:37:25 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 0/5] Add per-transport SCMI communication debug
 statistics
Message-ID: <ZrIZBeliMvV-__8f@bogus>
References: <20240805131013.587016-1-sudeep.holla@arm.com>
 <ZrDr1tDPE2A593s9@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrDr1tDPE2A593s9@pluto>

On Mon, Aug 05, 2024 at 04:12:33PM +0100, Cristian Marussi wrote:
> On Mon, Aug 05, 2024 at 02:10:07PM +0100, Sudeep Holla wrote:
> > This series adds support for SCMI communication debug metrict tracking.
> > I am just sending on behalf of Luke with minor reworks in his absense.
> > 
> > Cristian,
> > 
> > I have retained your review tags, please shout if you disagree.
> > 
> > Regards,
> > Sudeep
> > 
> 
> Hi,
> 
> LGTM.
> 
> If this is what was on Fri on your next, I gave it a go on my setup
> too.
> 
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> 

Thanks, I think I also modified some Kconfig text and scmi_inc_count()
but nothing that affects testing 😉.

-- 
Regards,
Sudeep

