Return-Path: <linux-kernel+bounces-527516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FBA40C37
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44E41895AC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32492204F77;
	Sat, 22 Feb 2025 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maslowski.xyz header.i=@maslowski.xyz header.b="MnexX9od"
Received: from mail.maslowski.xyz (mail.maslowski.xyz [45.77.158.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB913202C24;
	Sat, 22 Feb 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.158.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268202; cv=none; b=mP1sD4w6teDAh7wPYMe215TIV7ZAMli28KZ1JQJoPfAZ9AJEQmjN5R+jtsEvkAyTH8YAo6eN7XeM3SkbbQmssqh+o4Wr459LMnH3vuvyrdDK5f+2evvTVQiOOIMtfzNERThq8X6iG5tYWjKsfuD+TWGUsHFBzIJ2/uEy3aOYxjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268202; c=relaxed/simple;
	bh=3z9CKU4X7u0WJNsFUPjx/98hXkKogbxuvLD2pclMvvY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DPPsA51oohAsjotZx6L4TnkB+PTx2xnhtsjax+CsJg1IUAwSqGg43NuToZ6tKAf0PNZZVoJ7fOjWzKHc4fHuhTePoXCPPJVeWtNCofpMbgjnELM1vjiIDkpp3pP49HDK41jATlDvSiiS9IGh27cmlkCt+RP+uciX28wwu9Wendo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maslowski.xyz; spf=pass smtp.mailfrom=maslowski.xyz; dkim=pass (2048-bit key) header.d=maslowski.xyz header.i=@maslowski.xyz header.b=MnexX9od; arc=none smtp.client-ip=45.77.158.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maslowski.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maslowski.xyz
Received: from localhost (ett230.neoplus.adsl.tpnet.pl [83.20.165.230])
	by mail.maslowski.xyz (Postfix) with ESMTPSA id 233587E9E1;
	Sat, 22 Feb 2025 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=maslowski.xyz;
	s=mail; t=1740267732;
	bh=3z9CKU4X7u0WJNsFUPjx/98hXkKogbxuvLD2pclMvvY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MnexX9odlJgn6rN1fPtImras+40ieMFdF1zlf4PS+QF9+07VJXZ1wRy2x4ctxZRF5
	 tuxpJb57YClLmKhGpKVT8otj5vZLLoZci/ZpBzLeVw7ByZ3ZKGETBNfsiGtNY+wcjM
	 G4NmOH2atBpov153fnREFEKV8SqPm3ZsTB2Jc2uiMgSYAuqfZC+Mj8pCN1Ylbow2Z9
	 bQuZZgS4zj4VAqoA4cuSeQnoDnJYpPJuoujb2ZaIrp2EyJPaqBjKrwpzOKR0NXnKpZ
	 pIv7UTrIOxWS/n+EjqlNuFH37DiWAgCBXUDzNkJRYlTUZ0LsX3iGgMfcSu5Z2BDuY1
	 mZHNvva08EoVA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Feb 2025 00:42:06 +0100
Message-Id: <D7ZDF8NZGPS3.3QBMAVC1NTUDM@maslowski.xyz>
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, "Christoph Hellwig" <hch@infradead.org>,
 "rust-for-linux" <rust-for-linux@vger.kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "David Airlie" <airlied@gmail.com>,
 <linux-kernel@vger.kernel.org>, <ksummit@lists.linux.dev>
Subject: Re: Rust kernel policy
From: =?utf-8?q?Piotr_Mas=C5=82owski?= <piotr@maslowski.xyz>
To: "Martin Uecker" <uecker@tugraz.at>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com> <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh> <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at> <2025022024-blooper-rippling-2667@gregkh> <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
In-Reply-To: <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>

On Thu Feb 20, 2025 at 9:57 AM CET, Martin Uecker wrote:
>
> For example, there is an effort to remove cases of UB.  There are about
> 87 cases of UB in the core language (exlcuding preprocessor and library)
> as of C23, and we have removed 17 already for C2Y (accepted by WG14 into
> the working draft) and we have concrete propsoals for 12 more. =C2=A0This
> currently focusses on low-hanging fruits, and I hope we get most of the
> simple cases removed this year to be able to focus on the harder issues.
>
> In particulary, I have a relatively concrete plan to have a memory safe
> mode for C that can be toggled for some region of code and would make
> sure there is no UB or memory safety issues left (I am experimenting with
> this in the GCC FE).=C2=A0 So the idea is that one could start to activat=
e this
> for certain critical=C2=A0regions of code to make sure there is no signed
> integer overflow or OOB access in it.   This is still in early stages, bu=
t
> seems promising. Temporal memory safety is harder and it is less clear
> how to do this ergonomically, but Rust shows that this can be done.
>

I'm sure you already know this, but the idea of safety in Rust isn't
just about making elementary language constructs safe. Rather, it is
primarily about designing types and code in such a way one can't "use
them wrong". As far as I understand it, anything that can blow up from
misuse (i.e. violate invariants or otherwise cause some internal state
corruption) should be marked `unsafe`, even if it does not relate to
memory safety and even if the consequences are fully defined.


In programming language theory there's this concept of total vs partial
functions. While the strict mathematical definition is simply concerned
with all possible inputs being assigned some output value, in practice
it's pretty useless unless you also make the said output meaningful.
This is quite abstract, so here's an (extremely clich=C3=A9) example:

Let's say we're working with key-value maps `Dict : Type=C3=97Type -> Type`=
.
A naive way to look up a value behind some key would be
`get : Dict<k,v> =C3=97 k -> v`. But what should the result be when a given
key isn't there? Well, you can change the return type to clearly reflect
that this is a possibility: `get : Dict<k,v> =C3=97 k -> Optional<v>`. On t=
he
other hand, if you have some special value `null : a` (for any `a`), you
can technically make the first way total as well. But this is precisely
why it's not really useful =E2=80=93 it's some special case you need to kee=
p in
mind and be careful to always handle. As someone here has said already,
besides undefined behavior we also need to avoid "unexpected behavior".

(Another way to make such function total is to show a given key will
always be there. You can achieve it by requiring a proof of this in
order to call the function:
`get : (dict : Dict<k,v>) =C3=97 (key : k) =C3=97 IsElem<dict,key> -> v`.)


Overall, making a codebase safe in this sense requires an entirely
different approach to writing code and not just some annotations
(like some other people here seem to suggest).


And while I'm at it, let me also point out that the concept of ownership
is really not about memory safety. Memory allocations are just the most
obvious use case for it. One could say that it is rather about something
like "resource safety". But instead of trying (and miserably failing) to
explain it, I'll link to this excellent blog post which talks about how
it works under the hood and what awesome things one can achieve with it:
<https://borretti.me/article/introducing-austral#linear>

Oh, and once again: I am sure you knew all of this. It's just that a lot
of people reading these threads think adding a few annotations here and
there will be enough to achieve a similar level of safety | robustness
as what newly-designed languages can offer.

Best regards,
Piotr Mas=C5=82owski

