Return-Path: <linux-kernel+bounces-523093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EEFA3D1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D05A47A8072
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8EC1EC01B;
	Thu, 20 Feb 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="eGWYjnnD"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C761E5B7B;
	Thu, 20 Feb 2025 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035475; cv=none; b=bHK+SMmgcYyrrrxWUJLAQ9y10F64Sdw+M/kpyZi+wyEQ9hEQxZ4O4fMTHUN8DUnpe2Q6XC+qq2u7oFJRWEpfMVrsgXAhgyakYpi37xOodR2kycksHZO8YnNXVYLe3WSR6V7I7K42s7fK1VCTtckQl6vftzmjKMv579cR8jdIVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035475; c=relaxed/simple;
	bh=J0B0YXdvQsUgkAZoGQd5DGyef4ealLirHSCqBDZV8BM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gc+7njep0xt0JOjmc/CPz9SqCSwogNtsBliapH8fx+qF628XpoBe2p+MON1EI35/FslPFCkkYUgf2+JTjUhT3RgWFw6WroWyANIPjIQbgIxd3NcyaBaKDruPayUDKvmhulVhPjlxMLCgIgKi0acHUwJzHaR0nyaqu5yjpXsgim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=eGWYjnnD; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-197.tugraz.at (vra-171-197.tugraz.at [129.27.171.197])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Yz43B6Twbz1JJCN;
	Thu, 20 Feb 2025 08:03:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Yz43B6Twbz1JJCN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740034984;
	bh=79iOrJleI/iz7iPUnPOpIes+Agw9KU6s5TsUDIe2kI8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eGWYjnnDWcq2gSYJ3zhmIau23n3qUpPkDeNK3NIf2LI7sS6HcF1CpXmRrj8iS7ayS
	 pa0aJJCHb5NzL4hJPb9NmNFtAsXdtbLtzKousOHESayZ28MvBFZL94LOQBjkFDtRRI
	 1FRXeIeh5Yv2aH2YAsIhQkzn+qjgktzuGW26oFD4=
Message-ID: <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Thu, 20 Feb 2025 08:03:02 +0100
In-Reply-To: <2025021954-flaccid-pucker-f7d9@gregkh>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	 <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	 <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh>
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
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117

Am Mittwoch, dem 19.02.2025 um 06:39 +0100 schrieb Greg KH:
> On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> > On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> > [...]
> > > > >=20
...
>=20
>=20
> I'm all for moving our C codebase toward making these types of problems
> impossible to hit, the work that Kees and Gustavo and others are doing
> here is wonderful and totally needed, we have 30 million lines of C code
> that isn't going anywhere any year soon.  That's a worthy effort and is
> not going to stop and should not stop no matter what.

It seems to me that these efforts do not see nearly as much attention
as they deserve.

I also would like to point out that there is not much investments
done on C compiler frontends (I started to fix bugs in my spare time
in GCC because nobody fixed the bugs I filed), and the kernel=C2=A0
community also is not currently involved in ISO C standardization.

I find this strange, because to me it is very obvious that a lot more
could be done towards making C a lot safer (with many low hanging fruits),
and also adding a memory safe=C2=A0subset seems possible.

Martin




