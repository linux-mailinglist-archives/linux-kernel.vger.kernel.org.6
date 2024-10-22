Return-Path: <linux-kernel+bounces-376426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210C69AB14D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A92B2474C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A381A2642;
	Tue, 22 Oct 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFfeRZN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644C19D089;
	Tue, 22 Oct 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608423; cv=none; b=OAHFntdGYB9ksgvmqHomlr5zU2KlVmFpocQRcVOAYVDRLWrOI80b/Npd5m1N1HV1ep1mE+KtC3gkQ6l2HXd+OakyAdSUwpJfbYO8ecJvxj/e1smJKkkI2oaC00TX8fMTFtwG3y4RKDG8ZqCxqPvGM4mEQf66v4glyLZJNnyr9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608423; c=relaxed/simple;
	bh=B+uOdsm26qWeVQQUdj+KD0IE8Tl65RK8whsElX9VGdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbpnPg+IPcgW2nmdXK4wN9v4JvMCnXxXa2ZCg+/51VCzA0nijLINz7nHu0dDOiH/Ove/l5gTErD5G8+ipo0X12OzCeSFKW2TeihNPwnCVnH/sAASht14Jhipv28jZyPQ3pwbJoRketrNu1knjFXhrXVkpHLddKah2AA2mVdNuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFfeRZN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A0EC4CEC3;
	Tue, 22 Oct 2024 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729608422;
	bh=B+uOdsm26qWeVQQUdj+KD0IE8Tl65RK8whsElX9VGdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFfeRZN/6PgpDdCwOE6UFV/Kxz+FVfrdfxwtjfRHdXfHrEtbZJXU0rlYMCIfAqVXP
	 2dpkPUzsNXPK6U7x13Kll/h1J1yJBY//E3CjxLxR6o7FRwuOamoSnUWzl25ec/7x1v
	 tssddtUWAN8c5nA2IgcISqJNaSIGu51+Y8zvSWKqEX9IWAw/mEYLAg1+/Pi/xiO2oC
	 PVKsKLiLYJLZN9L79XjGD/7j67dpI7uOIAeIl5tKRsLdGvJ3oVU5VdQDgIl2/u7bG0
	 APLlGh7IE9aMCUAgVcBF4pW2oS5WGaJop902/ZQakumIa/JAIQsYOxxcxpxwZ4EcMQ
	 Wb/Xr7cQRL6aQ==
Date: Tue, 22 Oct 2024 10:47:01 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <Zxe65Zu3GRdwzXjo@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxeEA6i_xfBMxJm4@sashalap>
 <1e89542d-6f9e-4e85-8292-ebb49091433a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e89542d-6f9e-4e85-8292-ebb49091433a@sirena.org.uk>

On Tue, Oct 22, 2024 at 12:50:50PM +0100, Mark Brown wrote:
>On Tue, Oct 22, 2024 at 06:52:51AM -0400, Sasha Levin wrote:
>> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
>
>> The script tripped on the very first PR it looked at:
>> https://lore.kernel.org/all/20241021171728.274997-1-pbonzini@redhat.com/
>
>> And in particular, this commit: afa9b48f327c ("KVM: arm64: Shave a few
>> bytes from the EL2 idmap code")
>
>> (sorry, not trying to pick on anyone/anything, just an example...)
>
>> The commit can't be found on lore.kernel.org, it was never in -next, and
>> yet Linus pulled it promptly without questioning anything.
>
>That was on the list at least, but buried in the replies to a thread
>rather than posted separately:
>
>  https://lore.kernel.org/86msjc56mi.wl-maz@kernel.org

If folks are interested in collaborating around -next analysis and maybe
adding a bot/dashboard/etc, I've pushed my scripts to
https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/

Right now they're enough to generate a histogram showing how many
patches spent N days in -next:

$ git log --format="%H" --no-merges origin/master..next/master | shuf | head -n500 | xargs histo.sh ~/next-analysis/db/
Days in -next:
----------------------------------------
  0  |
  1  | ████████████████████ (40)
  2  | ███████████████████████████████ (62)
  3  | █████████████ (27)
  4  | █████████████ (27)
  5  | ███████████████████ (39)
  6  | ██████████████ (28)
  7  | ████████ (16)
  8  | ██████████████████ (37)
  9  | ██████ (12)
10  | █████████████████████ (42)
11  | █████████████████████████ (50)
12  | ██████ (12)
13  | █████ (10)
14+ | █████████████████████████████████████████████████ (98)

As well as find commits that did not appear on lore:

$ git log --format="%H" --no-merges origin/master..next/master | shuf | head -n100 | xargs no-lore.sh ~/next-analysis/db/
c88414f56c37f XArray: Prevent node leaks in xas_alloc()

-- 
Thanks,
Sasha

