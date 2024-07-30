Return-Path: <linux-kernel+bounces-266776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 696279406AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0626B22438
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3FE161939;
	Tue, 30 Jul 2024 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wb9P5iL9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415913B780;
	Tue, 30 Jul 2024 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722315406; cv=none; b=TshTYuwbqyj91M4vcaoBJZXhijhZdW8RZAmjWXJtZKugYQkCad05tl/vlkbmeKIR7vO1c7ewu8buTBX8sHOIyqV7vmuxdd4XCDscNKn8LWj0Mfn5Ict9Vhnv1NzMukVikb0Foz+jGBxjeJUagyztfHr8G5js/hwQXdwySIPL6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722315406; c=relaxed/simple;
	bh=yfyqaVzFi5kiLtgu+bnaubt/5HHB0svlGRzVCjO9DwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTa43mKz8w7OnpTHYrCsngQ3vnEopIzlXX1oJXwvTv/Sp6hvf85AZtoGWKzcVuoBsNNdmiJBXA3UdfhIoD4UJGahLLnDuDLcRXKV/vSvbEWF+qDwfXNkslkO/vZ9EgAudPkB/qlemgRi1F/N8AJkwnj/G1K7ywRwIIVLSuiTXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wb9P5iL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF85C32782;
	Tue, 30 Jul 2024 04:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722315406;
	bh=yfyqaVzFi5kiLtgu+bnaubt/5HHB0svlGRzVCjO9DwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wb9P5iL9NfQaEtND3cBbu/a1r7txO0uTIj7hAmQK0wKxz7q5HIMIrTefGFuTugiyd
	 r8p73IeGGdLU5coAnwrqWEwF1HJRd+VHTe0+MqYreFtGlwhbrOSfW54hNXJYPJPYyq
	 JG69/GD7muyoee3KzRkMJ33xgH0+oagXogwLZt0M=
Date: Tue, 30 Jul 2024 06:56:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35918: randomize_kstack: Improve entropy diffusion
Message-ID: <2024073029-clerk-trophy-b84c@gregkh>
References: <2024051912-CVE-2024-35918-3fed@gregkh>
 <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja>
 <2024072606-outlet-stuffy-259b@gregkh>
 <D4CED3E9-5E5F-4E94-AB59-3EA617213DA1@kernel.org>
 <2024072746-ample-sponsor-bef6@gregkh>
 <u7iq6sax7trmasfpqqe5val5qr7d4odjokww3cxpav7mibgipn@fpxugdvez66s>
 <202407291715.017E39A4C@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202407291715.017E39A4C@keescook>

On Mon, Jul 29, 2024 at 05:15:52PM -0700, Kees Cook wrote:
> On Mon, Jul 29, 2024 at 04:35:52PM +0200, Michal Koutný wrote:
> > On Sat, Jul 27, 2024 at 09:34:18AM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > We assigned a CVE to 9c573cd313433 as it was implied by many that this
> > > was "fixing a weakness" in the security feature in 39218ff4c625d.  If
> > > this is not the case, then we can revoke this CVE.
> > 
> > If 9c573cd313433 (fixup) is fixing a weakness of too few bits in stack offset
> > randomization, then 39218ff4c625d (feature) is fixing such a weakness too.
> > 
> > Or equivalently, if 39218ff4c625d is not fixing a weakness of too few
> > bits in stack offset randomization, then 9c573cd313433 is not fixing it
> > neither.
> > 
> > By this reasoning I'd be for stripping this CVE. Both patches would thus
> > be equal. (As suggested by Kees.)
> > (Also to avoid going into the rabbit hole of how many bits of
> > randomization are enough.)
> 
> Yeah, I think it's best to have neither be a CVE.

The CVE has now been rejected, thanks for the review!

greg k-h

