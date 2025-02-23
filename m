Return-Path: <linux-kernel+bounces-527617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE478A40D56
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5FE17B048
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B011DACA1;
	Sun, 23 Feb 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="WWaxrVTl"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813161FFE;
	Sun, 23 Feb 2025 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740298266; cv=none; b=KyfRU40w9wpluTbFPt3jA8DSdhfh/kuKbUXrRsv7+ef+osZI6WjZZJhgHx+XGmnK4ZnDZetZ+GQE/ulzQ6j9tM5HUbRNNY1MaJG3lFnKKrwCAsRW5GxUfRfgvlAsr26Gj0fLLAGZoIKu/RJD+A88LtC0KGEri3Qwg/ERAE1Qb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740298266; c=relaxed/simple;
	bh=FO+ewNzs077bRy2Y7BPoaLABNBn813HrzRSMC+/zC0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jH+zAWGSNMzTWzui5KXLtx0k5Y0UoNHEgd8aoWj4/kBu+p/93lkd50lapaAlUIUZ+1WVNqN8mlxb44WiCAU3sejTINfaNhPsXxYiWgFrugzcfVaoaisQITaZuoIeWj1WJwYLkClMm4b6xKBpDrUThTlOFEM1u6X3qEfOteRfvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=WWaxrVTl; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-172-163.tugraz.at (vra-172-163.tugraz.at [129.27.172.163])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z0xPt52wlz3wPk;
	Sun, 23 Feb 2025 09:10:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740298243;
	bh=LMpP0PNtOPYY2TeGglWfTOfZrmn0PHBp00YQa8N0dVk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WWaxrVTlShi5aCaXfkcSEkDelV6036VV/oNtbKakqH03VZVZYTc3GFTPaFa99E4el
	 ZUAraMwFNo4xw9OMfOsfxb1kb3gugsitbKKxS84yJVUcBerX5HOFCJHl4mIdozvyv/
	 +K9dPq1pzYQ04yJ4MfUZBxhYyD5/PFVg2BotrTHQ=
Message-ID: <06a07d325f7555c3dc72e4aac90580541ca61697.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Piotr =?UTF-8?Q?Mas=C5=82owski?= <piotr@maslowski.xyz>
Cc: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
  "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Sun, 23 Feb 2025 09:10:41 +0100
In-Reply-To: <D7ZDF8NZGPS3.3QBMAVC1NTUDM@maslowski.xyz>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	 <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	 <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh>
	 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	 <2025022024-blooper-rippling-2667@gregkh>
	 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	 <D7ZDF8NZGPS3.3QBMAVC1NTUDM@maslowski.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116

Am Sonntag, dem 23.02.2025 um 00:42 +0100 schrieb Piotr Mas=C5=82owski:
> On Thu Feb 20, 2025 at 9:57 AM CET, Martin Uecker wrote:
...
>=20
> Oh, and once again: I am sure you knew all of this. It's just that a lot
> of people reading these threads think adding a few annotations here and
> there will be enough to achieve a similar level of safety | robustness
> as what newly-designed languages can offer.

I have been looking at programming languages, safety,=C2=A0
and type theory for a long time, even before Rust existed.
I heard all these arguments and I do not believe that we=C2=A0
need (or should use) a newly-designed language.

(Of course, adding annotations would not usually be enough,
one often would have to refactor the code a bit, but if
it is already well designed, not too much)

But while I would love discussing this more, I do not=C2=A0
think this is the right place for these discussion nor
would it be insightful in the current situation.

In any case, there is so much existing C code that
it should be clear that we also have to do something
about it.  So I do not think the question is even that
relevant.=20


Martin




