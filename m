Return-Path: <linux-kernel+bounces-516386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F2A37078
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9A83B0B75
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31781F8F09;
	Sat, 15 Feb 2025 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="VzjQqb3l"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBE15696E;
	Sat, 15 Feb 2025 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739648858; cv=none; b=tEehhH1fRS6QBVFRKLRobQihe190b4JGWczV6rq9MwlD5XWosW/kRI9OcyOCddXItAbtKlxcjDBkbFVCMwjeNGhjn8iSccH+jAVm4fWNb347tgR2LUJiurLItt+Mz8Ttr5ETbj8ZL51FQGlBdAvdXZX+w60E02y9og3M3ipB3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739648858; c=relaxed/simple;
	bh=DYfp2i2SZiuctQ0MVI7rHStW6AJQXkGlw/Iul/pfxqo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=URtZ3GwGtlVVepP/BS56z4rp7EYd8VbAyvg2XqhmBDs9jLCkxqkLtohQDR+j0/Hgc598ypMzakrAdRvVB05S6V2zovmSRoMVkPWvwX7WG3MdA4mdZlsYVTQXftcmyhtIJCB925W6JxVQmBUbMdFUWm7KmlhRjg9Wp7gG3kodNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=VzjQqb3l; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 2413F43462;
	Sat, 15 Feb 2025 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1739648846;
	bh=DYfp2i2SZiuctQ0MVI7rHStW6AJQXkGlw/Iul/pfxqo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=VzjQqb3lWyOI32y3Ub3ByjcWQ7tonopRGCAfxXkvg/tHufVK14a9wT45GXJjmnt4s
	 7WHg+mZsdhIbnXGi8C68mDxNR2ln5yIiUNK4TKZS/XYu1+vLi17da7m/7f4MaXpS+K
	 iodVJ1WIdfb/9l6IAi4C2tpRDADwEOpwu53Zoqk9rp3etvLGuoCl9PsFDPaTCvWnlM
	 BI4YtlK9iutNXU1D5RYZ376iKoa6XdogtrnfXpfiJXzgnWViDl6o91jK1c1dksKc/G
	 8jUxzPuIJEmWIo57Q6bEJpMChpKkZKUSRGzrt9BTturSagEDKfubrPqmbVuVMhcgUX
	 as8bLSk56o3fA==
Message-ID: <cae5503e-4330-4c44-8a50-1ebf63ea5a24@asahilina.net>
Date: Sun, 16 Feb 2025 04:47:22 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rust: page: Support borrowing `struct page` and
 physaddr conversion
From: Asahi Lina <lina@asahilina.net>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Jann Horn <jannh@google.com>,
 Matthew Wilcox <willy@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 airlied@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Danilo Krummrich <dakr@kernel.org>
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
 <Z6CY4TvZwLkWmB3I@pollux>
 <a3551d7d-14c7-40a0-90ff-1fcce93be62a@asahilina.net>
Content-Language: en-US
In-Reply-To: <a3551d7d-14c7-40a0-90ff-1fcce93be62a@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 11:41 PM, Asahi Lina wrote:
> 
> 
> On 2/3/25 7:22 PM, Danilo Krummrich wrote:
>> Hi Lina,
>>
>> On Sun, Feb 02, 2025 at 10:05:42PM +0900, Asahi Lina wrote:
>>> This series refactors the existing Page wrapper to support borrowing
>>> `struct page` objects without ownership on the Rust side, and converting
>>> page references to/from physical memory addresses.
>>
>> Thanks for picking this up!
>>
>> As you know, this has been previously worked on by Abdiel. Kindly drop a note
>> if you intend to pick up something up next time, such that we don't end up doing
>> duplicated work.
> 
> Sorry! I wasn't sure if this was going to end up submitted over the
> holidays so I wasn't in a rush, but I ended up switching gears in the
> past couple of weeks and I really needed this feature now (for crashdump
> support to debug a really annoying firmware crash).
> 
> I actually only just noticed that the previous v2 already had
> Owned/Ownable... I only saw the v3 which didn't, so I didn't realize
> there was already a version of that approach in the past.
> 
> ~~ Lina

Given the discussion in the other subthreads, it looks like this is not
the best approach for page table management and using it for crash dumps
of arbitrary physical memory pages raises some eyebrows, so I'm going to
abandon this series.

Abdiel, if the first two patches are helpful to your work, please feel
free to incorporate them into a v4. Otherwise, just go ahead with
whatever works for you!

~~ Lina


