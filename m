Return-Path: <linux-kernel+bounces-339612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EDE9867C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D821C2147D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231414EC77;
	Wed, 25 Sep 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+0rqwTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299014D430
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297347; cv=none; b=lDadxw3OfmyCw+l3d4zPlOc45LKfYW+wSiSUaIr4Sd/akmAv4WOB9N0/WZx1I12h4UiwW2hkLJd5+6xn2Z7tCAGdru4mzOp++GkOPgRcLdmqwEUNWss0IbrabkpCKDt+bEjVPDDggySQRMznoQ+ir9ZAATFQcUmzb9W/u6qzARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297347; c=relaxed/simple;
	bh=K0IpuhudkElpDENhphmqT1QchizmjGdp6KxfOC7J5kc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VKqKRv1vJNRXYXmhhXOjQVWgqMeRb7KGKFtvvMcA4FLBPqh3gdbnfId0lYH5pD7Svrhou6Cg9vjENm8Fyt+ZF5eWBhGAuxNBxyQP2jNarWUddTbovQPtbw+09yyoIZvnIVzyvxsFPYOgBHcI+gh9NLtzX/YzLNRbowoTwNB17vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+0rqwTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D90C4CEC3;
	Wed, 25 Sep 2024 20:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727297347;
	bh=K0IpuhudkElpDENhphmqT1QchizmjGdp6KxfOC7J5kc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=k+0rqwTqvXCjxNUc9eU6ji1aDWEVlXjw+bMIB9O9P9ssjAXyhRN378v73I4Ign11z
	 g3V3ajQj8Q5Fk+A1SR3uViepKgLiYLQdGLGxRltDVVFdwLmFmTuHsqNomTS6CboaWv
	 gESecEGm4TwPwD8YJgjlk/0AAFpPjqQl4ZydyM6U2vL4DeONAFNS6uZdJdWbC+eNAL
	 H2HolWIOK4Cj3p5B4Jvcr0tBcLKomLQLc0/gS2G/xJ8bhX+eZnkVKxbKyGYJg5Bvhx
	 u5phHXlgULj29M1MgWDdi5MefGH74acvc2r7xay1HdhPP12FPomh88E32ps/emnocN
	 mhPklKeg61Cmg==
Date: Wed, 25 Sep 2024 22:49:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    Charles Wang <charles.goodix@gmail.com>
Subject: Re: [GIT PULL] HID for 6.12
In-Reply-To: <73f1a21c-1db1-49ce-951e-a2694567c1c6@kernel.org>
Message-ID: <nycvar.YFH.7.76.2409252247400.31206@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2409181132240.31206@cbobk.fhfr.pm> <73f1a21c-1db1-49ce-951e-a2694567c1c6@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 25 Sep 2024, Krzysztof Kozlowski wrote:

> On September 6, Rob reported that this is broken and should be fixed or
> reverted.
> https://lore.kernel.org/all/CAL_Jsq+QfTtRj_JCqXzktQ49H8VUnztVuaBjvvkg3fwEHniUHw@mail.gmail.com/
> 
> On September 10, Rob reminded that it is still broken.
> 
> Author ignored the problem, so the maintainer should revert this.. or at
> least not send these further for RC inclusion.
> 
> If no one wants to fix this code, no one cares, we are not supposed to
> take it into kernel release, right?

Yeah, sorry for that, mea culpa; I have been sort of busy for the past 
period, and sort of hoped that Charles would pick it up in meantime and 
send a fix.

That didn't happen, so I am just applying your revert and will be sending 
it to Linus tomorrow.

Thanks,

-- 
Jiri Kosina
SUSE Labs


