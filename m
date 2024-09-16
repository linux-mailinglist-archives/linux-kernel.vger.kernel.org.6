Return-Path: <linux-kernel+bounces-330657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C697897A25C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039721C23087
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740A14F115;
	Mon, 16 Sep 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DOwAshed"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5020A95E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489998; cv=none; b=ZizQcS30w5elbOmcpvTJHAJzQbKuOIbLvkrpo3X1SXVRqsfH5PLGAG0+6srGutq1YjV5Uq1wlWyBSwjuR45/VTQSVS2aaXdEOQqK3VXKiw7rweF/qog6qUIuB5jQqVO3dQPbROYk09AFWcn6pv1H9PyxQnZHG8FoxzKCPaZXH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489998; c=relaxed/simple;
	bh=cE9f70eGMnK9cNlf4943vsWj900wOcjX5WNZt3+ZB1M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ePJNDEs64wlV7iimBza9rMPKBbTjNorHRH1RJuczDY0XPFKSPp6/KjRdEnBCrAiUkVhWOOkRX7HfmUVfXqMs1mbZQlzPSQEGIWXOxSFMJJQKygJvPDitv1iktwlGMnX1+iZH8nonl0g+MRbrchcevals0dkWsU0WDD9XuEV1B2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DOwAshed; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=gL2+iO6QZArVJzK0IBDFRiqUDTpD/SdHAR9aTStK/ms=; b=DOwAshedaF37/clY
	Fq9nXDAm2/I/AXtM+5arWmlS70icuRMuQw0F5w5ivS91A5FNYhboE0JMPdZf+RmCNUhAfsiq3J3wa
	Re/42xi9Pq87FhcT/gN7IDGyL5oYREpT2dYpdD9e0LEedWczVkMvpzjwp7dVYCZFkkGrVplkzO60S
	nS+wa1WsHDyF+BWT4EYjJ46EgkUrAORUtMrvcxk+qZ453BiQk1ygDQsUk2oW4y801haEI9LNmDGqM
	9lwX7l5a4I1dEWgvc4qWzkyRKvZGJTbvglCbkl21P+g8XB4Ph24I4O6QwU8LUXEqGLXawDxtx+ohn
	t6DYPKtSVsIMyzgGgg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sqAum-005xNU-1P;
	Mon, 16 Sep 2024 12:33:12 +0000
Date: Mon, 16 Sep 2024 12:33:12 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org, kees@kernel.org
Subject: Dead code by symbols
Message-ID: <ZugliLgw5VFb9yau@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:04:51 up 130 days, 23:18,  1 user,  load average: 0.20, 0.10,
 0.03
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi David,
  A while ago we were chatting about me spotting dead structs, and
you wondered if it might be possible to spot dead functions that
were exported from an object but never used - and I've been trying
it for the last few days.

  I'm pretty early on, but it's already got some fun things:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
  Core code not used for ~20 years

https://lore.kernel.org/lkml/1690847.1726346402@warthog.procyon.org.uk/
  A bug! A recently added function that lost the place it was wired up
  so was currently unused.

https://lore.kernel.org/lkml/ZuXOWjvVYa64c1-5@gallifrey/
  A few small dead files.

Now, it does take some more guesswork, for example an unused function
which was added a couple of years back, might be something that's
there for consistency, might have been forgotten to be wired up,
or might just be something that's going to be used but the
authors haven't got to it yet, e.g.
   https://lore.kernel.org/lkml/ZuRGRKU9bjgC52mD@gallifrey/

My patience varies from Ooh core code, to meh old driver to very meh
for old undead staging code.

  I've got some nasty awk which kind of works some of the time;
but it does require a lot of handholding; often things like inlining
isn't spotted so gives a false positive, and I'm only looking at
the objects from a single architecture, so again have to grep
for the symbol name to make sure it's not used by a different
architecture build.

  And heck, I wish git log -G was faster.

Anyway, thanks for the suggestion!

Dave

Nasty scripts:

find . -name \*.o -exec ~/sym/dosyms {} \;

dosyms:
---------------
echo $1
DIR=$(dirname $1)
NEWN=$DIR/$(basename -s .o $1).x

readelf -W -s -r $1 | awk -f ~/sym/relocs.awk |sort|uniq > $NEWN
---------------

awk -f ~/sym/collate.awk $(find . -name \*.x)

collate.awk:
---------------

{ if (($1=="u") || ($1=="U")) {
    use[$2]=use[$2] "," FILENAME
    usecount[$2]++
  } else {
    def[$2]=def[$2] ",:" $1 ":" FILENAME
    defcount[$2]++
  }
}
END {
  for (s in def) {
    if (usecount[s] == 0) {
      printf("%s:%d: %s from %s\n", s, usecount[s], use[s], def[s]) 
    }
  }
}

---------------


-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

