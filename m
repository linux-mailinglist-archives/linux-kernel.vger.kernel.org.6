Return-Path: <linux-kernel+bounces-441724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD69ED314
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AEC166A41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11901DE4EB;
	Wed, 11 Dec 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQIwca6R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7A1DAC90
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936891; cv=none; b=mUs/7FHiY7Dse8Mb9LMAerOOjD0vbfmWjeqs9O3dg65CX1okUOml9oRA4KlWbRRxCTW6usIvS1KaxYUW8QQw28qY+LkrN89h6FUALVdlaDmwHQk8ncJ2KxFWbg2RsCpg8La+mERDvdfC10TougVA3cp6cgpT5YqyqjyDx1g/P20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936891; c=relaxed/simple;
	bh=MWR+E/5loBEPcMX4d6YZwVJYy9dtlG4v5f4HNnJnRVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaPtit0jXp+mXRXKbKJ/3ofN6IRhOFxq5JTFx4ZE9wJBJE5VPSrEIgfAiBak80QMSNMapB4fgeuUjyDkRQ4MakYcp3qbVtTs8G+nqcMSMj0luXBVKEcjziBpU+N+0+BFWYw7e/xpC1LnGCUalwZgRAK7SC1fxZe9Ho5qvEUBh5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQIwca6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6800C4CED2;
	Wed, 11 Dec 2024 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733936890;
	bh=MWR+E/5loBEPcMX4d6YZwVJYy9dtlG4v5f4HNnJnRVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQIwca6RNJ/cQfwK42TKzNsPfQEoVKhN9bL2zKDWmDEaF5DOhRpQW94whHTNrb/1T
	 vwkEjSh17BTJxiA0RH4d+1UA/2WYPXmP20T26S8wHdCwW6LvFZaxSg7XAYy9KaFwuf
	 b9V06MnVxQZopKJ39XrOQmCZA+OWSWkETM6Noz2+UTjAti/XQ8RZVUkglEfWh0wZYP
	 ejY8zmtTv5ofgP59sEeVPQUL/rjNpeXvsnSnuDVPSPLdLheH/h02LWk1+eM/c6hs7I
	 ziG+AJmUP00OBuGNImCyoDOMmdv9Oqyqh90nRlUWpuU9EPTCMFPworr+VOlnOdHrhj
	 OB5Ol9FMn2Dag==
Date: Wed, 11 Dec 2024 17:08:08 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"hanqi@vivo.com" <hanqi@vivo.com>
Subject: Re: Unicode conversion issue
Message-ID: <Z1nG-PSEe6tPOZIG@google.com>
References: <Z1mzu4Eg6CPURra3@google.com>
 <87v7vqyzh4.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7vqyzh4.fsf@mailhost.krisman.be>

On 12/11, Gabriel Krisman Bertazi wrote:
> Jaegeuk Kim <jaegeuk@kernel.org> writes:
> 
> > Hi Linus/Gabriel,
> >
> > Once Android applied the below patch [1], some special characters started to be
> > converted differently resulting in different length, so that f2fs cannot find
> > the filename correctly which was created when the kernel didn't have [1].
> >
> > There is one bug report in [2] where describes more details. In order to avoid
> > this, could you please consider reverting [1] asap? Or, is there any other
> > way to keep the conversion while addressing CVE? It's very hard for f2fs to
> > distinguish two valid converted lengths before/after [1].
> 
> I got this report yesterday. I'm looking into it.
> 
> It seems commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable
> code points") has affected more than ignorable code points, because that
> U+2764 is not marked as Ignorable in the unicode database.
> 
> I still think the solution to the original issue is eliminating
> ignorable code points, and that should be fine.  Let me look at why this
> block of characters is mishandled.

Thank you so much. If it takes some time to find the root cause, may I
propose the revert first to unblock production? The problem is quite severe
as users cannot access their files.

> 
> >
> > [1] 5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=219586
> 
> -- 
> Gabriel Krisman Bertazi

