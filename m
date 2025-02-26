Return-Path: <linux-kernel+bounces-534874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE29A46C23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E1F7A23CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7117D2755FE;
	Wed, 26 Feb 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LZmK+rnQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48F10F2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601004; cv=none; b=j32rAU+w4ghd65nlgsSSdgGRM3tO+9WmfM/zm3iVIf2//byiNPuIu22sct3PB3vMuTlonb0ufG7XIYOexam35NcY6Nm4tsd2cL66sc7QjjMcyfjm7SZxn5S3MZZSl4tKB82bD8A6E3GAuQ5OHVBzGsQBYOEnxD2N4SeH/aAWfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601004; c=relaxed/simple;
	bh=37DvqOPn9uy1mbasvVuWfivennlICRP/S8sgcd5uoVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VenqNrw8GXlwWHp2jyI98bTMg2F6nnQdNAzPD9+Op3hRPvq4Gv+3+nsZBNFV1BUcN97MC8smnOaYmMvIbsaGtfdIOgT3VhlVsNAeHrtvucCpk9B9Ns8oFGGfMI+//tlThe5xUw/3abPvxqWNjORlMMF6iF8nApwrw3nU7PbkETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LZmK+rnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F141C4CED6;
	Wed, 26 Feb 2025 20:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740601004;
	bh=37DvqOPn9uy1mbasvVuWfivennlICRP/S8sgcd5uoVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZmK+rnQVJex1eH+Dq0ke9QjNO1if1+2//6EBnAJB88iyjvUbAPeHsRR5X2RDHJdy
	 CzbTIQaVlynI9R1G6qxl1Y9nT6QmB09a93QDvCUOhz7l0zLUWx/wOEmnAoK8Bt36VM
	 9jvNdZ5a4wzKzL+qmwtQR02zW5AK3Y7E82WjjXBA=
Date: Wed, 26 Feb 2025 15:16:43 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: users@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: git.kernel.org -> web.git.kernel.org
Message-ID: <20250226-cheerful-delicate-partridge-33280c@lemur>
References: <20250226-enlightened-dragon-from-wonderland-09c2de@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226-enlightened-dragon-from-wonderland-09c2de@lemur>

On Wed, Feb 26, 2025 at 03:08:21PM -0500, Konstantin Ryabitsev wrote:
> Hi, all:
> 
> The change is now in place -- all browser requests to git.kernel.org will be
> redirected to web.git.kernel.org, which is a CDN service currently fronted by
> Fastly. The backend requests for web.git.kernel.org are sent to a dedicated
> set of systems that are separate from git.kernel.org frontends, so hopefully
> this will help shift a large chunk of load from the systems where we actually
> want to serve git and lore traffic.
> 
> Please report any problems you encounter to helpdesk@kernel.org.

I just realized that I cc'd the linux-kernel list on this announcement, but
they don't have all of the context for why this change was needed (it was
discussed just on the users list).

So, here is why this was necessary:

- We've been struggling with near-ddos levels of bot traffic that tries to
  grab as many URLs as possible as fast as possible without any regard for the
  impact it has on a public service like git.kernel.org. It's a problem
  experienced by nearly all public resources -- see a write-up by LWN here
  that describes the problem, and goes into why obvious answers like "just
  throttle the bots" doesn't really work:
  https://lwn.net/Articles/1008897/

- For this reason, we've taken the decision to move repository browsing (and
  only repository browsing) to a separate domain that is backed by a different
  set of systems, so that if bots do knock out the web interface, it will not
  affect git operations.

- This change only affects browsing git repositories via the cgit interface.
  Git checkouts with their origin as  https://git.kernel.org will continue to
  work as-is without any change necessary.

- Existing URLs will continue to work, issuing a redirect from the
  old to the new location, so there is no need to adjust any existing links.

- Similarly, you can continue to use git.kernel.org links as before without
  needing to change your scripts.

If you have any other questions, please do not hesitate to ask.

-K

