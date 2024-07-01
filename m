Return-Path: <linux-kernel+bounces-237109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6E91EB8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0751F22579
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FBF173335;
	Mon,  1 Jul 2024 23:48:12 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0827502A9;
	Mon,  1 Jul 2024 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877691; cv=none; b=XyMwfbnjs8yuqEGxbIbZueZwz4LMcag0APxi89Pabb9uC0cqPOpPW3aD4SyG3p3nIDcN/OI1mhoAkDjcPXXadJ/i1f450Szrh9jEtho7cutE43x8elVtIYWXkbG3OohmRoKGXZ7nyRDqMECNQVKp2t+Wwj2fmD/ICtqnJcoOOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877691; c=relaxed/simple;
	bh=mgMNZ9LW5qxu8pJDRIr7A6e906IxawaTZZPws8m/fxM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AN5SyT1FzAXBhuFNmUwYWjR6GzV7kEHQA/0QkrZWDKlBn1k617451M2yqnKKtm7l3ij0Kd696GLwNVF+Hx/kFTlSDDJF5JetOJPP9hjqUzVAoNhviRaolVapVu62AS+tpNVxDc1MK14FePkrC1ZRx/DXhhWPI3Qr4N+2u/CmJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D05B392009C; Tue,  2 Jul 2024 01:48:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C917892009B;
	Tue,  2 Jul 2024 00:48:00 +0100 (BST)
Date: Tue, 2 Jul 2024 00:48:00 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
    Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
In-Reply-To: <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2406302009480.43454@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com> <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 May 2024, Linus Torvalds wrote:

> The fact is, the original alpha is the worst architecture ever made.
> The lack of byte instructions and the absolutely horrendous memory
> ordering are fatal flaws. And while the memory ordering arguably had
> excuses for it ("they didn't know better"), the lack of byte ops was
> wilful misdesign that the designers were proud of, and made a central
> tenet of their mess.
> 
> And I say that as somebody who *loved* it originally. Yes, the lack of
> byte operations always was a pain, because it really caused the IO
> subsystem to be a nightmare, but I was young, I was stupid, it was
> interesting, and I had bought into the kool aid.

 Looking from today's perspective it was clearly a bad choice.  However it 
was 30+ years ago, it wasn't so certain as it is now that x86 was there to 
stay -- indeed as I recall it DEC had the ambition to phase x86 out with 
their Alpha (whether they approached it the right way business-wise is 
another matter) -- so the notion of having a fully byte-addressed machine 
perhaps wasn't yet so obvious to DEC engineers as it is now, when most if 
not all the current CPU architectures have these fundamentals the same.  

 As I say it may have been the final attempt to do something differently 
before x86 domination forced everyone to be at least remotely compatible.

 And there used to be weirder architectures before people moved away from 
them and settled on the current paradigm, just as nobody wants to build a 
general-purpose atmospheric railway anymore and yet a while ago not only 
it didn't appear ridiculous, but such stuff was actually built and run, 
such as the South Devon Railway.

 And then it wasn't the only failed attempt: remember the i860 or the 
iAPX432?  At least the Alphas weren't a total disaster, they made their 
impact, the worst mistakes have been fixed as the architecture evolved, 
and the engineering legacy remains, often in unexpected places.

  Maciej

