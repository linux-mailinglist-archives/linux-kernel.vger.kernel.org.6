Return-Path: <linux-kernel+bounces-434495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF77C9E677F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366CA1885B13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB41DD88F;
	Fri,  6 Dec 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CZrLDHgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEoNQQAJ"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43890194C90;
	Fri,  6 Dec 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468028; cv=none; b=PivhxM2FWU3KcaCdi+Gr5QebatVLxtwZ7Egtuab9vctYu5JkjkNwFnoKsgEL1gtT493Xupv7CBk8OUaqMfPeRWqWuNDEWEROw2Bfw3HryBZXn8Vpogiat9jD+MMw+/4H2jFaUsgsoiWo5SJHehUkFXXHCmYF1B9dXLvZ3hDtX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468028; c=relaxed/simple;
	bh=Pg3TgxQ/3LGFuQOxp+PeivxahgA+PNI79HU3dnwOABQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=otwLHHT6O4JhasaDnvrrBaG67vfpFMhnwI89WnKxqig+5msr6aHGDUnI8Fw7LCSxtUj0+jvoWjy1CA9hn/VX9dervIkw6G4K0ANo97pXF/aFMrDJZ0KDji6lJRULNouMEkNhJZaeDOfCswf88nzJSa1HY1g3i11lX+y3AOAx8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CZrLDHgu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEoNQQAJ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9D0525400EC;
	Fri,  6 Dec 2024 01:53:44 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Dec 2024 01:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733468024;
	 x=1733554424; bh=zlZ0DXBrNDiA4CJUUAbcyn+1tu0TS2KZm3blX/sR8hw=; b=
	CZrLDHgu4UYBtfoQL8AWK0L+GAPm1lUQveV81ahog9juk/IbEtZsqrcMdP/TIblL
	rp3MqmA0VMVdc9XRMjmiDeXeZ9pHgc0c5vNTBBlNS2ZTe2pnmskkb2NOnmZH2TxS
	h0a5EsY3k+1Z1xzY9wlvkH0mlyoHBcCWrg/egkCKdm1fScK5lbPf/+g4oRCYKJw4
	7rNsqoKId0qgx9EA2z3vWsm5x7bmsDzUp3YQfDUS2RqtD7/OH06VN7ghVM2eA1or
	Mepf9D6gjOmr2zdCPlEhWHb4uJr970uD4Ls4OI43gfnc3BBFvOsc9Q9ncnqg9Ym3
	ZaQmg1ZKnnisBXrZzAhsyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733468024; x=
	1733554424; bh=zlZ0DXBrNDiA4CJUUAbcyn+1tu0TS2KZm3blX/sR8hw=; b=E
	EoNQQAJAa1dqRwoNYXb2I6/FJJu7KnzVgWIcOOCj0AvL+EyIdKrCtC9kwBWAnf8u
	WDtbzpTxh2uKDRQfYEG2m4lNFTjq+7Tinsqx1X4MGZyDJFl4HWr/ZHT54Lj1QrCI
	OT0/tjzGhdG/JwNaJTDEhaA4NLvDDyoN5opn4qM5CvK5OYk39MtThrTUcvqSRvIW
	vJVy0yT24KG8k1ZTooakka+aKv1imKN+V6J4bl9qsHcKMzzArn1JR9wKxPBwzT6h
	+c/8qJB5yzQIK5Sx4Q/t4EFa2/0eGyb9DP7AWH77bgmuE2GXQFbUzMDrWXPx6Rlt
	v2TtXguPx67oKDXuxhHGg==
X-ME-Sender: <xms:eJ9SZ9tS2bi_nAgS7o9QQ5B2AaOYSTASLHW3c-C4VuxDowfTejIzbg>
    <xme:eJ9SZ2cl04hf-4AZ3Freyxg9esqympUKEKMWyqncSlvj1WondUfIDO13CkyGa0Qkw
    gO43WfQx9n27cwpILA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphht
    thhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitg
    gvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrghes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsggvnhhnohdrlh
    hoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:eJ9SZwzP1blb1deILRkTj5d8gQA_KZTZRTW4TMyK1tTqSEql7A1EcQ>
    <xmx:eJ9SZ0NcAcQWtUhkFRmQPvLAwJFb6y96dGNrvW5gJnRxBYwUanO4IQ>
    <xmx:eJ9SZ98-gBFrqW_LiKbBVHhSThpSady7qqrSz0MGQ-2YAXm5GtTlMw>
    <xmx:eJ9SZ0W7kYTzgAZei0qicdE3YjEaNQLOBEY4GK9EzuVA9iP8BhSmUg>
    <xmx:eJ9SZwUUCSaquBXdvIN9TetSiIUSqnxJp55CGohrjkUi40Iafgto8ZLN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6496D2220072; Fri,  6 Dec 2024 01:53:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 07:52:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Lee Jones" <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org
Message-Id: <be74daeb-68af-4e6b-8091-7f9684fe424e@app.fastmail.com>
In-Reply-To: <2024120642-trend-omnivore-69d3@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
 <2024120642-trend-omnivore-69d3@gregkh>
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Dec 6, 2024, at 07:49, Greg KH wrote:
> On Thu, Dec 05, 2024 at 04:25:20PM +0000, Lee Jones wrote:
>> +
>> +#[vtable]
>> +impl MiscDevice for RustMiscDevice {
>> +    type Ptr = KBox<Self>;
>> +
>> +    fn open() -> Result<KBox<Self>> {
>> +        pr_info!("Opening Rust Misc Device Sample\n");
>> +
>> +        Ok(KBox::new(RustMiscDevice, GFP_KERNEL)?)
>> +    }
>> +
>> +    fn ioctl(
>> +        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed<'_>,
>> +        cmd: u32,
>> +        _arg: usize,
>> +    ) -> Result<isize> {
>> +        pr_info!("IOCTLing Rust Misc Device Sample\n");
>> +
>> +        match cmd {
>> +            RUST_MISC_DEV_HELLO => pr_info!("Hello from the Rust Misc Device\n"),
>> +            _ => {
>> +                pr_err!("IOCTL not recognised: {}\n", cmd);
>> +                return Err(ENOIOCTLCMD);
>
> To quote errno.h:
> 	These should never be seen by user programs
>
> The correct value here is ENOTTY.
>
> Yeah, fun stuff.  Not intuitive at all, sorry.

That should get handled by vfs_ioctl() converting the
ENOIOCTLCMD to ENOTTY.

       Arnd

