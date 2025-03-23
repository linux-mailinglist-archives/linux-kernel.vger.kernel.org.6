Return-Path: <linux-kernel+bounces-572927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCB2A6D079
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16913ADA55
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE6A19006B;
	Sun, 23 Mar 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggqlp+R3"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63724B29;
	Sun, 23 Mar 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752769; cv=none; b=eeNT4YPbQQekfm0VhZWSCS8bwoUzvz9T6TPTcT+m6/i903i69T3G9QNjtcXvfs9CB+R4HhDKiEdzZD7kUUKQqxOp+ObOZO37o7g9QH27BQfT1aDGLUjS4mSHK8eiRwCahKIp+YaYahx4qWJ+etQpJjISEcRohD6AxTEBFhFS+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752769; c=relaxed/simple;
	bh=CV05HM2N/pgJ+by/utbNBCmmrHTeNxBdhsrtJxDPyrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjb2L7VcGjGRslAbPUBnWiQh3/37CAnu0Ypl/J9qEdwsbLPPM+wZkbUNmDRnCUGwwHYAULztIVNTYXoQ4RFB+COdOqrKCzhAz4MOyYguDEcUHDuoclYCkVzSVhYQJbPlCha0WTRpfNJrKpz9s5G5xCYIA/nzo/JaOIsaDvmXUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggqlp+R3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f8657f29so31722526d6.3;
        Sun, 23 Mar 2025 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742752766; x=1743357566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r9xkS5nNGfHWOqGvzoM7DsZs9/l4KRsJMirzjSQ+8w=;
        b=Ggqlp+R3laL1VfOfLrNu53BLX9Mil6jYaBg+R6Rm11UfsZizn2t9HdxJIGaQZPXgFv
         NjVvPl3B/Maym4PAeMB9KKx0Zc5lFwGywB40HHToutmvG0FboGtNL2k0RdpONOrWxPay
         dJVvJq4ASpfVsajyzr/0YIB4AaZzqSwQdbTUumNySTy0QXLOiXO474VTpnGwszkLRnKi
         Kffl6GkMYGoTs9bcxbKfJqB0+G6w0RTytqC23rfa+Z8w3cShQ93Y+oL9J6JjB3SePXsf
         Wg5lKCPPodUc2sE6dJvCw/nOZaoYeuFLYv+B9DsaFP6qPscERH4OzeXgCL1KDc0++Qhl
         1XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742752766; x=1743357566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r9xkS5nNGfHWOqGvzoM7DsZs9/l4KRsJMirzjSQ+8w=;
        b=acbG0rgUKj7XGU7Rg0hlYPlqNFrbcL/MwQzXNq6I+5+PhzD6bpIdpGMgyWvlU1SSBt
         HnxRftuPH/KtfWWnQzbTeT12JE0Q6c5uEnX57Nf7e8XRmbQoyykgpFEjialwqM5G9/xs
         Q/Le2WJ/ljjpZdVgR1BISt37hu0q6smbMxmtEzsCMAZt6TabOo9UQ6YJAycgwXQB7WZs
         8mGeEIg6kqL7IeuHySwno7siCqHqVfCEeE3kiWXbr29Vl5r6hV9PgELUixa/VDvSjoBf
         BIKjdVX+KnJHY+BHTSM865AYO3wXVFX7N8cf3MZ1npLvJ6eX5+nqGdG8Nf3tVbkNPg62
         aDlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkl0VD1oQEZHLn0xf6Mn+s9ngv5+7DcdMd/JM/5rqGCaB8yXgWgSa/67VYwgOVAZDuGViO3NVW/PG74t5OWbo=@vger.kernel.org, AJvYcCVxbcoLntFFIlGPvdNluH+dP6YpN0NjkFKqUljl5iMMnFVdMRFfBuTh1JrJi2/foE9O7ti6UkoRzed0x8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyepaTubE3RGRz6SFysCU3pR0LkHDm87Hcr7d39C8D9wqc+0kGA
	BPKQQwiBkr1Xf468jK994kWiQhOg4Tu/FK+6UWAY4zxGfuqn5xWz
X-Gm-Gg: ASbGnct8UOl4OTBpI/47/kTUul60nNT2RvioXefkWbfWwXVeJ5p6teCeKqCLt/V/ro1
	RgI+XsPwQ2IsWye35gGSjRQjpFZLvvLD8HT/2EZHfxf6cYEch4DZpGmYLQPxPdKXJIZgyDDC8WN
	3kOIiI55aXKaxt8ekluW4+8BMoMz/1zM9cW/bvrLco7fSEUhUnxnZLQPY/z0yDVIR4zUxC3ya5Z
	yeqD2z3P+O8Tov8gJWyMZCjgfGj8iuFsJiPYh1frWj7zH+MgFmxJFsEiKj/8N2DqA5DUlQmHCim
	fo7Z1NpB7OlDXoTXayy77Z3liJo8p0MZfbkvrlvWzMc3SQ5oZep2gezw6isIbMJ8HeTO51LZ2ER
	ALu5dDplPU8E2LcwaLLeVNZBf/KWnYWEFrIo=
X-Google-Smtp-Source: AGHT+IEBB/efSwLvmsR6PjdytJDIIxsqMlrTQm2bxHFbaAJqm8s77YSBZnCFBn4/4T6UCs3lmqWYUQ==
X-Received: by 2002:a05:6214:500d:b0:6e8:f4a1:68a4 with SMTP id 6a1803df08f44-6eb3f34f5e8mr164354776d6.39.1742752766441;
        Sun, 23 Mar 2025 10:59:26 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efdc416sm33644366d6.94.2025.03.23.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 10:59:26 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6DDFF1200043;
	Sun, 23 Mar 2025 13:59:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 23 Mar 2025 13:59:25 -0400
X-ME-Sender: <xms:_UvgZ-btw38nNMBU1wppsi7hIOyKcwGqVK3eRcbRl_7V7izMUNW-uQ>
    <xme:_UvgZxYLJ3qxA9VGzdeetJ2C88qpzeznwSaABiHV5WE-oqsVQeCz4LC4kBHUxe695
    -RVwiGnUM1Pw5XNyQ>
X-ME-Received: <xmr:_UvgZ4_UPVpAGaAUem69VfThUQ-MBQCFk3w3RKFBxECYN27PmKXN_4_v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepkhhunhifuhdrtghhrghnsehlihhnuhigrdguvghvpdhrtghpthhtohepohhjvggu
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:_UvgZwpnAzQNaarsMKT90DyyW53qf7s12U812QaSROZ2pB5wKR25Bg>
    <xmx:_UvgZ5qfgRmz3KHf_0HlhtrZ3cunF70ghitagmjJUnn_bZX2cFYp4Q>
    <xmx:_UvgZ-Tsc4AzG0anZSZxu4Sgs6ot7Jdq1Ff6RX0_Bb-YqMBM5DRiPw>
    <xmx:_UvgZ5pG_mR2l6jPuACjwIpbpFpOgfsLybbLL17nIjNojc1urUrPZA>
    <xmx:_UvgZ244Wx7e-7L2AXWzBFaXKtMIDmntQVqj_D5c96O8nmdcNtP4kW5L>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 13:59:24 -0400 (EDT)
Date: Sun, 23 Mar 2025 10:59:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@gmail.com>
Subject: Re: [PATCH] rust: sync: optimize rust symbol generation for CondVar
Message-ID: <Z-BL_DFA3afcRYGE@Mac.home>
References: <20250317081351.2503049-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317081351.2503049-1-kunwu.chan@linux.dev>

On Mon, Mar 17, 2025 at 04:13:50PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $nm vmlinux | grep ' _R'.*CondVar | rustfilt
> ... T <kernel::sync::condvar::CondVar>::notify_all
> ... T <kernel::sync::condvar::CondVar>::notify_one
> ... T <kernel::sync::condvar::CondVar>::notify_sync
> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
> 
> These notify* symbols are trivial wrappers around the C functions
> __wake_up and __wake_up_sync.
> It doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
> ---
>  rust/kernel/sync/condvar.rs | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index 7df565038d7d..a826896ba3f0 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -181,6 +181,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
>      }
>  
>      /// Calls the kernel function to notify the appropriate number of threads.
> +    #[inline]
>      fn notify(&self, count: c_int) {

Hmm.. I think CondVar::notify() gets inlined even without this
`#[inline]` attribute, do we need this actually?

Regards,
Boqun

>          // SAFETY: `wait_queue_head` points to valid memory.
>          unsafe {
[...]

