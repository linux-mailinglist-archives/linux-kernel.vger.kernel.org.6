Return-Path: <linux-kernel+bounces-520944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FF0A3B188
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B82D1700D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B581BC077;
	Wed, 19 Feb 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLdoCnYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49F4C6D;
	Wed, 19 Feb 2025 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946040; cv=none; b=qcCVSDbx4jjx42mV/7k/wnxHe2m3dWyH4N++2xlNpmJI82tn1u/vlYpz2+2LWo622b5f+yDAYxnRfwrSGmtKo48S7KHWi/gAShlAv8GDt+LCvdfgvXKlKEk1V58avplev2ZjRQYHjC5QUlapI2SFWHvDbEnsvHzMchnp/DnAjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946040; c=relaxed/simple;
	bh=mvpIJujt6K2Fgjy733qQ0XmMrWAySwCrA5Yn0K0WhYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U53Lj2/Xh7//d97vOBP/xeQFo6K+39447scL/tA6xETbqG1Yp5GXcSfH3Ma751JhjUMkDbT/Us/Wl8fGMopB/upVgQhaAuJbCTcx3SksWEzSwX8Wi8QYaBEy95hRoBM8ZwEc3MjSVe2mXRrqwHdamo8t5S/zDR6lz4m3Spy6ISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLdoCnYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C326AC4CED1;
	Wed, 19 Feb 2025 06:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739946039;
	bh=mvpIJujt6K2Fgjy733qQ0XmMrWAySwCrA5Yn0K0WhYQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SLdoCnYjuw/R2HaxyvNKEZrnZL7obJAM+iNu8pNRzkdsLCFpO2HIlLqvGgA8geeO9
	 9EXSjdTfUsmOsO/sl2EwdyOUenstL5HR62lHM6tkChPDuldgVoqXMlt+9BK8pQveiJ
	 YZx9UhLQCQM32RY+nTDXqgv5X0/20RNdPMNFGbYHxxquRpt0oTzGB+zklfz4y5i0n9
	 V9prwUX7IwSTQuHAdG4lQQGoa3KuYGRgBwqHcrFWpHV8uNN3jFt8HZqPrJOyOJ6YS5
	 LK1OGBY5JWG9hB7qoNmhrdzmZX25mp2U+VOSyCe4LI5DFc2wN667vz/wcmNIUkbxSM
	 Av1b08Tpr0VgA==
Message-ID: <615ce44fa528ad7be28ba518e14a970f04481078.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Miguel Ojeda	
 <miguel.ojeda.sandonis@gmail.com>, rust-for-linux	
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, 	linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Wed, 19 Feb 2025 08:20:31 +0200
In-Reply-To: <Z7T5_WGX_VXBby9k@boqun-archlinux>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
	 <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
	 <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>
	 <Z7T5_WGX_VXBby9k@boqun-archlinux>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 13:22 -0800, Boqun Feng wrote:
> FWIW, usually Rust code has doc tests allowing you to run it with
> kunit,
> see:
>=20
> 	https://docs.kernel.org/rust/testing.html=09

I know this document and this was what I used to compile DMA patches.
Then I ended up into "no test, no go" state :-)

I put this is way. If that is enough, or perhaps combined with
submitting-patches.rst, why this email thread exists?

>=20
> , I took a look at the DMA patches, there is one doc test, but
> unfortunately it's only a function definition, i.e. it won't run
> these
> DMA bindings.
>=20
> I agree that test payload should be provided, there must be something
> mentioning this in Documentation/process/submitting-patches.rst
> already?

Partly yes. This what was exactly what I was wondering when I read
through the thread, i.e. why no one is speaking about tests :-)

>=20
> Regards,
> Boqun

Thanks for responding, definitely not picking a fight here. I
actually just wanted to help, and doing kernel QA is the best
possible way to take the first baby steps on a new subsystem,
and sort of area where I'm professional already as a kernel
maintainer.

BR, Jarkko

