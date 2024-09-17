Return-Path: <linux-kernel+bounces-331687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF8697B006
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E606B28659F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5416A959;
	Tue, 17 Sep 2024 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LjPaOx7x"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA416A930
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575363; cv=none; b=J6zPuSU1uUgX7ToXf7TcZvsqFBZ2G8WNrBIGOiU5VxeJBr43CFp3ZNmmXlUyw+oMb87Ef1OiVffIqHLEhRdc3D/bO7OJF9p4nspxzMlw1zADoVFKdp1iJxCMdpvdzGhdTgS450RyY4kgNHNMrWqzYTw9RUVAVBYc3H4bgdHUypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575363; c=relaxed/simple;
	bh=jZFbMQUcwbMtY/pZtUSmrWo0bd4B5DgQOKNIHvqm/w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7/sfmwwiYvrBWwPXVVg4ac0fc1GwqD3Do7FPf7Cge+RPalW2rFU2s3VEhsE3/L3Q/qchB13cZwrDPtrKgbVF3/t0Bbnj2T8OVVn0rBUelk2q1Gi4jWM2JUAixJppLMBTR76GHChcpMJ3ODhSRfvM+5S6qN4Bf6RVbelXGLEnCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LjPaOx7x; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=tUuwK+BCmRSw8d5B3ixan7E6pH9SFIFACTSMqu09Nd8=; b=LjPaOx7xVSOI914o
	NP4bwHMFEuktkAhzwTROwyhkE7jpdjW1Pu43yOdoJ/88NIZcoSN4P8bMe6qPqXozwre66w6pVuI20
	rJ4jYI40Qq9PEGJJmPQ6aILPdgBLsND0jVvATdqAPcYlgd7hlBM68nTOvc2y0U26zxDJ7ayRjP+cM
	uiwhGRyJKqyp46KEHMF2apyLw0GF95iyoCTvva5jsNdFFseYvADXYbcx5fljWpz4cPGFRoAQ0/D+V
	M/5j/flCJROnRHppsgzDne+zqhfsL+r6PzDIT2/TuTva2m+O/Dft4Z8ouLnCHu7P2HocPrkmdH2m2
	9mxYwTnmxWpjV4uIsw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sqX7Z-0066XY-2V;
	Tue, 17 Sep 2024 12:15:53 +0000
Date: Tue, 17 Sep 2024 12:15:53 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, kees@kernel.org
Subject: Re: Dead code by symbols
Message-ID: <Zuly-WPqwxqWXylP@gallifrey>
References: <ZugliLgw5VFb9yau@gallifrey>
 <d289061d-7dc8-41d7-a166-4b3b8dce886d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d289061d-7dc8-41d7-a166-4b3b8dce886d@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:04:34 up 131 days, 23:18,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* David Hildenbrand (david@redhat.com) wrote:
> On 16.09.24 14:33, Dr. David Alan Gilbert wrote:
> > Hi David,
> >    A while ago we were chatting about me spotting dead structs, and
> > you wondered if it might be possible to spot dead functions that
> > were exported from an object but never used - and I've been trying
> > it for the last few days.
> > 
> >    I'm pretty early on, but it's already got some fun things:
> 
> Cool, stuff! :)
> 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
> >    Core code not used for ~20 years
> > 
> > https://lore.kernel.org/lkml/1690847.1726346402@warthog.procyon.org.uk/
> >    A bug! A recently added function that lost the place it was wired up
> >    so was currently unused.
> 
> That is really nice!
> 
> > 
> > https://lore.kernel.org/lkml/ZuXOWjvVYa64c1-5@gallifrey/
> >    A few small dead files.
> > 
> > Now, it does take some more guesswork, for example an unused function
> > which was added a couple of years back, might be something that's
> > there for consistency,
> 
> I know people will find reasons to do something like that, but we really
> *shouldn't* be maintaining / dragging along dead code that nobody might ever
> use.

One example is lib/base64.c base64_encode - that's not used, but the base64_decode
in the same file is used by nvme; I've not convinced myself if it makes sense
to take the encode out or not.
(We do have ceph_base64_encode with slightly different base64 behaviour,
and then there's chap_base64_decode and ceph_base64_decode which are all different;
it's pretty hideous)

> > might have been forgotten to be wired up,
> 
> Forgotten as in "BUG" or as in "ran out of steam" ?

BUG like the afs one above where the function exists but the line
to use it got lost.
But there are 'ran out of steam' ones as well - eg bc9ab6d31c4f
added a function for 'runtime reconfiguration' to an audio codec
with a note that some systems require it; as far as I can tell
it was never used.  Since that was over 10 years ago it's probably
time for it to go, but if it was only a year or so old then maybe
it would still be something that might be getting added.

> > or might just be something that's going to be used but the
> > authors haven't got to it yet, e.g.
> >     https://lore.kernel.org/lkml/ZuRGRKU9bjgC52mD@gallifrey/
> 
> Yes, that' a valid case.
> 
> > 
> > My patience varies from Ooh core code, to meh old driver to very meh
> > for old undead staging code.
> 
> :)
> 
> > 
> >    I've got some nasty awk which kind of works some of the time;
> > but it does require a lot of handholding; often things like inlining
> > isn't spotted so gives a false positive, and I'm only looking at
> > the objects from a single architecture, so again have to grep
> > for the symbol name to make sure it's not used by a different
> > architecture build.
> > 
> >    And heck, I wish git log -G was faster.
> 
> :)
> 
> > 
> > Anyway, thanks for the suggestion!
> 
> Glad you're able to spot some nice (+fun, otherwise you wouldn't be doing it
> ;) ) things!

Dave

> -- 
> Cheers,
> 
> David / dhildenb
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

