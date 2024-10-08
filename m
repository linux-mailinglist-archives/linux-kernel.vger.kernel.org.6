Return-Path: <linux-kernel+bounces-355248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A746994E10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CFA1F2264B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFE1DF25E;
	Tue,  8 Oct 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMs1DL3t"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383AA1DEFCE;
	Tue,  8 Oct 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393125; cv=none; b=gWFl3Itne3WNW8V4SX4acqmvtWLfNxx4kYrUM1r01QbVTEZ56TYbYTp9HP8wxa6YZRW73YKyPjzpqA/ljIXDhQmVGr2Nv1iIitqirDaWg/S8z5b7tsdP22DRMPsgh6YZmS+CVADMAVU1RpboyjLtZvopoPsCjgqFl5ytUlHeeQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393125; c=relaxed/simple;
	bh=Ux4suNlclXCbFSHhA7Y3I7wnHny/O30HsQjFba72H7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt2YXzifqe7fi9TULltfZPi6ofrLIvXz2aPKLjiBLfuVnlODnGwHo4sXhPPBxKx6v4V0BPPYWW/Myu/bGKvwKonITan0u2ucunIR4TgXzDVB/xl82uzuDeWBIKdt2bOV4PmDZ7oxnxnwNI9RvnXUwj/LWO49kC07sB8xAIDPdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMs1DL3t; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a99e8d5df1so568151585a.2;
        Tue, 08 Oct 2024 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728393122; x=1728997922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMYkHMwdVkbSLMxGZAZds8bTSvf1VBR7G7Hyvo2bDKo=;
        b=JMs1DL3tBbnmYZ0sVJ1w7nEI8asZ1DdfhWJ+t8fYMEp1vbtuVWcDF44lNSJOtUaATS
         Mktjgpz4cAx9nndxWtWBqKpWhFiRbvkxySGifO2IO0jXHx2j9TpXFgFkJpS0suKl+1PM
         Ju0Lo3pub2nAMGv8NnypL3PZDWl0nK7oX5m5sDMESGGcVeMsV8tSa5jINHv+P5Pi4r4c
         DnoPd5K4UalJ9EPu33b/clUrkKd4om09C5UcdKHLoFcEaCx3EF1kmYkn7e7P7TIi+no2
         vK9/GOp+oPL72d0sEMdEDlS0qQFOYbv+EwRVP2L3terXbhq/Uxke/UIApK/Dehs9C1Xv
         lXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393122; x=1728997922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMYkHMwdVkbSLMxGZAZds8bTSvf1VBR7G7Hyvo2bDKo=;
        b=HiRNt07REPaTbbxqS3brNUEa+lVMm8CoCCKrjzDHGtPwOJp1H/A231q083kmjz0YD4
         /gaNpAfCdUu7YGpSwbbGbe80TkjMZgTlVTM21QmEJUWPwv8OutMmqfo0fGNBKHQDEkT4
         65eEKjH/N2ALxbsnaUrKztyX4HF08pAkkXliZR9acyKgRIf3+2k2D9dOMe1qM6P0hVYU
         A4B5yEv5119bU6JJBUZF57OyiRZ8nZWmdkDNbEliqoDEjZuFgitvxD80qMNAJ325fxXM
         7FjeeEUw2ci+6PG9uBMB/XNI6lHbcIIib6TjhC+MSBOpiKvS7TpWbM0QNDCr6b2e8dA8
         N5YA==
X-Forwarded-Encrypted: i=1; AJvYcCWY9S3pqTAfU3Htkp3KQXZq+O0wPAWhjbqqHGuY5xTAtLvMJYWnn81IBZg/6+YqkKBKxD8Qob1VWKmcTKpjdF4=@vger.kernel.org, AJvYcCWwAQ3TqR/hBUYi/Db1br3tm9rgteoWehb83FRAOhdMrb++rYmPJFXzPanuOewJsr2JkqBJG1IsbPxtPbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eLV4xLO6DXtlf5+70VHmO5Tsznhhj9rksQIw07Mt+auaLc/t
	CvrkU29vvQIHBABVpZAlqdvzqtbVCiyWYwFMyPkKJJ8r4LRrEdkL
X-Google-Smtp-Source: AGHT+IGsWTvqPZueDUbUsaCDXQY0K9BJDQnEBOl7ormRevhhHgRvlWLX1J+0XIrR/GM5eBOE1MGz0A==
X-Received: by 2002:a05:620a:394e:b0:7ac:de4d:9129 with SMTP id af79cd13be357-7ae6f44cd21mr2452591985a.31.1728393121978;
        Tue, 08 Oct 2024 06:12:01 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75760e8dsm351608585a.108.2024.10.08.06.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:12:01 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 028621200068;
	Tue,  8 Oct 2024 09:12:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 08 Oct 2024 09:12:01 -0400
X-ME-Sender: <xms:oC8FZ-jDRw0l2DoP-MufIWAa8ZDImBhPBq6VYI96yBfgcDo5R73uyA>
    <xme:oC8FZ_D1ZjNS2hUHqEvvbbNppgEzJE79yOkyVFH8AFykCfnd1X1XRZRgfH6-x8HCg
    K5BYmDWSBn0ltaGaQ>
X-ME-Received: <xmr:oC8FZ2GvbDS45Yik065MTTNvjSVclGb5zvi-shYlHGbf-YX1R5A8_M7GxRE_3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhg
    rgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopeifvggushhonhgrfhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhn
    uggsohhrghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:oC8FZ3Q-Jwj-0e9an1ZpLoMcZPB1dgpOTs-csIQCNXTGQq0JFsM33Q>
    <xmx:oC8FZ7yTBSIMoAob86McNaSjbv32jgNjjyPfZ1uikJ_UcHyJq5nwQQ>
    <xmx:oC8FZ15rUTm2Ix5bdB98l6jretZZ5TSV-DMbsf_UEbtu89SW-3H5yQ>
    <xmx:oC8FZ4y8Zn8fwQDDoDLmATgTymsviq_7EG8UhFDj4yv6DFylXUd7jQ>
    <xmx:oC8FZ3jc5M02a071o9q4oZRrCTAPPN_RK3DM-1dFe_qe7hT1vV32TOVe>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 09:12:00 -0400 (EDT)
Date: Tue, 8 Oct 2024 06:10:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 07/29] rust: alloc: add module `allocator_test`
Message-ID: <ZwUvT4Zsg-1Dww8b@boqun-archlinux>
References: <20241004154149.93856-1-dakr@kernel.org>
 <20241004154149.93856-8-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004154149.93856-8-dakr@kernel.org>

On Fri, Oct 04, 2024 at 05:41:11PM +0200, Danilo Krummrich wrote:
> `Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
> subsequent patches, and hence this dependency propagates throughout the
> whole kernel.
> 
> Add the `allocator_test` module that provides an empty implementation
> for all `Allocator`s in the kernel, such that we don't break the
> `rusttest` make target in subsequent patches.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs                |  9 +++++++--
>  rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100644 rust/kernel/alloc/allocator_test.rs
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 91b2a26faf3d..f8ddc8d96da9 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -2,12 +2,17 @@
>  
>  //! Extensions to the [`alloc`] crate.
>  
> -#[cfg(not(test))]
> -#[cfg(not(testlib))]
> +#[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod box_ext;
>  pub mod vec_ext;
>  
> +#[cfg(any(test, testlib))]
> +pub mod allocator_test;
> +
> +#[cfg(any(test, testlib))]
> +pub use self::allocator_test as allocator;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> new file mode 100644
> index 000000000000..4785efc474a7
> --- /dev/null
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#![allow(missing_docs)]
> +
> +use super::{AllocError, Allocator, Flags};
> +use core::alloc::Layout;
> +use core::ptr::NonNull;
> +
> +pub struct Kmalloc;
> +
> +unsafe impl Allocator for Kmalloc {
> +    unsafe fn realloc(
> +        _ptr: Option<NonNull<u8>>,
> +        _layout: Layout,

The `old_layout` parameter is missing here.

Regards,
Boqun

> +        _flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        panic!();
> +    }
> +}
> -- 
> 2.46.1
> 

