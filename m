Return-Path: <linux-kernel+bounces-376122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786D9AA061
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3699E283815
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971019AA46;
	Tue, 22 Oct 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw70unA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1E18859B;
	Tue, 22 Oct 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594373; cv=none; b=NR4UcWG8qxDSkdDdrXgmqnycClwx4cPdtbREEmfxcruZI9Y1Hy9xsH/gQaWTA/zFVZJd4w5yadZ5fjt4KIhhqvJkzCHBNMEMPGTXknEw3ed6v73GkhWXxWgD97WMJ2nYWh9LO0bpiL1jfxuMcHTPpx8TeI5hxy8pHKT4CT6XMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594373; c=relaxed/simple;
	bh=MUKg4urYutSwi5MoxB33zsedV9rA3l8h/FZ4eS61Fv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnCoGnarr/tK4YVNfv9AUjX7wdi0uwuYbV6Qi90gIKLfMqOazaaRrwwH2s3ZF9hDjyOpSKYEk5bzipCceSzNl+xQGZ/mUjuotsKiUwXDqTPZVoHIWNoJcVLmk4+UyTMufGbbds4Ccv397znEwTzYp9ClT34iExiDBnb9D7W+HBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw70unA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E339CC4CEC3;
	Tue, 22 Oct 2024 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729594373;
	bh=MUKg4urYutSwi5MoxB33zsedV9rA3l8h/FZ4eS61Fv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mw70unA+Afn678+LGoS6u/4odcAkuw613pgN+BS62AOFtGnPLYXbJseJjPL62EJqF
	 OR6oqReAlNdJY1hHzSHAfEj2oeNpw8nqYhTdsb1s18OWUe881plUv1wYSAyA3Ohre7
	 /t+MJLeM3ZNdUCTeIT4U8LeZTi78doJeDh9Z4N9YSMC+EgsUACiLApNez7YsBVz/gJ
	 F6RHDlFkvnhh2BTx6Z1RtYmzP9U2y8NTkeEui7gMV0DJ+D6kvqPlzHdSqs+OGB6O00
	 NTRScPNMKqGI4n7ULwXGBgVzm6FTfoNkv4etDX/DuDZxOmjDdLNYKtkNzFgj7lk1uN
	 DtmsefzKqF8Ww==
Date: Tue, 22 Oct 2024 06:52:51 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxeEA6i_xfBMxJm4@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZxdKwtTd7LvpieLK@infradead.org>

On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
>On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
>> For example, for a given PR, the bot can report:
>>
>> - Were the patches CCed to a mailing list?
>> - A histogram of how long the patches were in next (to show bake times)
>> - Are any patches associated with test failures? (0day and many other
>> CIs are already running tests against -next; parse those reports)
>>
>> We could have a real pre-submit checker! :)
>
>That would be very useful.  Items 1 and 2 should be trivial, 3 would
>require a bit of work but would still be very useful.

So I've ended up writing something hacky that does (1) and (2) above, and
ran it on the existing (already merged) PRs on the mailing list to give
it a spin.

The script tripped on the very first PR it looked at:
https://lore.kernel.org/all/20241021171728.274997-1-pbonzini@redhat.com/

And in particular, this commit: afa9b48f327c ("KVM: arm64: Shave a few
bytes from the EL2 idmap code")

(sorry, not trying to pick on anyone/anything, just an example...)

The commit can't be found on lore.kernel.org, it was never in -next, and
yet Linus pulled it promptly without questioning anything.

So yes, we could argue that a bot sending out this information would
have informed Linus of this issue, but somehow I suspect that Linus is
not an idiot and he has enough scripts in place already to alert him of
these issues, which he chooses to ignore in some cases.

-- 
Thanks,
Sasha

