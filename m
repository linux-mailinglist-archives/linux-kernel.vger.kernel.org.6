Return-Path: <linux-kernel+bounces-268273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5494228D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A4CB20275
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0281917D1;
	Tue, 30 Jul 2024 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH7QNQ4L"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948318E053;
	Tue, 30 Jul 2024 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377197; cv=none; b=MxO2MuRAvg7iUW4u3sLz+KoLhqrSOIjT8M+Tqu5jY8UdrhBQs+UeZjCCb5WLWFlhxoibOEeEQ2f8W1ExyNmGdOxWBb+9ukzmMiCEXLwYbcOg+TwwVu9W5CxDrj9a33n6qR/dynNSYcDmZsvKYYGnvNTLKfyMmJgyAuLhOfR/2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377197; c=relaxed/simple;
	bh=1BmpShxAD1kSKxOcXy2pnrCGDF1nLz4KCDlU/sLZ8H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFLMLUidmgWfPXCT6g5GNObXSyCpNhcK8boRrLUVZT1owTASwFN8ZRZGNLINzvOkDEJWqdsyWOCb6UDk3z6fnrqBPuxbelrlIv4v43nWfJRQiFQzserYS7+ovvBNNcw7F+a7ItoSRbMFTk63hQ9cX1L2AJv7jmWCCV34NOXA/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH7QNQ4L; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44ff99fcd42so28578071cf.0;
        Tue, 30 Jul 2024 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722377195; x=1722981995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgYJaEpZ1yXSddosWIPWekS6jpSBDZuNyaUWl+IfGTk=;
        b=iH7QNQ4L1XSSfi9AkIF9ihxhHwVUL/tZKJpUcAvaZbJl00W7OGYcTO/+vwUhJhfXPU
         zZWHeY3WcB/H1aaQRnYwaNsGoNuVovynK3LcJbr3Lr8pxCpxV49dJRplfrRFIF53qagm
         yXc+q/bMVvwCLW3SqSyVFkayaC2D+vRw2cxLHTe4cJKK6Ua72zAUivrQFBQd3T0Mxw+t
         GfpVkjgScMrBWKIAHiQXL3wpc9N8hQ69QUn1ih7pYgm+U0plNpZBSZapsmEPPqA7yGYf
         PJZPPyTSFEt1l485L/vsSYtxn1BsF+YyfqGsXgOBHWKgj8TtdRX4heW9EzcOU/dbqfXS
         x2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722377195; x=1722981995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgYJaEpZ1yXSddosWIPWekS6jpSBDZuNyaUWl+IfGTk=;
        b=TaOZyAavPTwmr64vR/mPNaClZY4QnAdxgwMFZ9yvrdJ8GbHcN1zE1K2MtgsCMpWb8V
         mCD+rHXDnTok9y6qj5QDFHs/wMThuiYiH3Shnirsucz3Bkt9VYJtfbCujZe7ZFxK8tQr
         C/tKBYi6YBksh8SWfqxJJ3HCnui4fxK+Qd7CXkJ2C3GDoGcBFloncb/C73bKITELZOba
         AIV69h2xUdxJcqD81db/Pe+NkEVyhJ7VlIFe0mdEdq9KwjU2GHOK1HOZudnQLTGagvXE
         KlbkCq4xHxD0NOeH8kFqFVLpVhjv2e7R8UPG6SKybvSgKIu2Vj8yUiNGPaDN4F0x5Tp4
         F+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXthHVoHruTyiMgovIHCLtptMK8PBPotTqKBEZyd0CBwODdvTjM+mIojT8Pr7kuwzkObcQXt10PBkuXidWbObkuwkSy/h3jn5EPo2b1JrzWCS8K4K/ti9o0zQu8+OcaD0QATbo9H/lwSGI811U=
X-Gm-Message-State: AOJu0YwqDOF2mj6Kx49JPxmwfGYLsjB2WERpnIitdaJtuU9Sl70WopS1
	N43gyuJhUCzUekYggwmv0ZgtJqN8J0EKNZSw0vn4wPkfHM/oYJTI
X-Google-Smtp-Source: AGHT+IE6FlMfDP/tE05wVVKbS/i1WEI0nrgLIiH9CAMH74xpNNxZ/gwvvD9f/OxULhUW5WXLeSVe5w==
X-Received: by 2002:a05:622a:8b:b0:447:ed6d:db79 with SMTP id d75a77b69052e-45004aa77bdmr178462291cf.0.1722377194945;
        Tue, 30 Jul 2024 15:06:34 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8154a71sm54431491cf.38.2024.07.30.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:06:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1A08C1200078;
	Tue, 30 Jul 2024 17:58:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 17:58:29 -0400
X-ME-Sender: <xms:BWKpZkJ0qb0p3YyXjvmXZRltEuIHm25n0QR0qi7qiMrnUSNAzASXGA>
    <xme:BWKpZkLoZ7CQ0CO3P-I-nmpj2PuD3MQIIA7dz0kO75BsoHc4_VNyjTyeHP6XYZPM2
    RW8qP2i5FCNGiQRvg>
X-ME-Received: <xmr:BWKpZkuIIcckIxfPogT-3_Pl5OwbbO-_zQXDnWElSg7GKbn6SBGTM0jQ4s5H8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepheegvedvieevvdefvddutdffgeefteegteehfedtgeeggeefffejudefudet
    hfdtnecuffhomhgrihhnpegrnhgurhhoihgurdgtohhmpdhkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqie
    elvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdr
    tghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:BWKpZhbWwd2YdWffJIpxIt_LGPa6mw01CojjaecObq4WxS_LlvERPw>
    <xmx:BWKpZravaz4n3X1lEocSNHZ2RJz7QKlCgoh8dlN_mXAHlq4H58CMag>
    <xmx:BWKpZtDwZaQBM0JlcFc5hYLPFbzI2X42Dpg3F2doFI14iY9HlWIhEQ>
    <xmx:BWKpZhb6H2gygaIFWXtabQltqHBTFiPOElDQ_5WVhlBsasHUb_N-DA>
    <xmx:BWKpZjoMRrnBHIR-wMbDApFxXA0qYSuaOYUu4_lbgqQwB3JCwPNY8tS0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 17:58:28 -0400 (EDT)
Date: Tue, 30 Jul 2024 14:57:45 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Michel Lespinasse <michel@lespinasse.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] Red-black tree abstraction needed by Rust Binder
Message-ID: <Zqlh2S75s4TW5Qhw@boqun-archlinux>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727-b4-rbtree-v8-0-951600ada434@google.com>

On Sat, Jul 27, 2024 at 08:30:45PM +0000, Matt Gilbride wrote:
> This patchset contains the red-black tree abstractions needed by the Rust
> implementation of the Binder driver.
> 
> Binder driver benefits from O(log n) search/insertion/deletion of
> key/value mappings in various places, including `process.rs` and
> `range_alloc.rs`.  In `range_alloc.rs`, the ability to store and
> search by a generic key type is also useful.
> 
> Please see the Rust Binder RFC for usage examples [1]. Note that
> the `container_of` macro is currently used only by `rbtree` itself.
> 
> Users of "rust: rbtree: add red-black tree implementation backed by the C version"
>     [PATCH RFC 03/20] rust_binder: add threading support
>     [PATCH RFC 05/20] rust_binder: add nodes and context managers
>     [PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: rbtree: add iterator"
>     [PATCH RFC 17/20] rust_binder: add oneway spam detection
> 
> Users of "rust: rbtree: add mutable iterator"
>     [PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: rbtree: add `RBTreeCursor`"
>     [PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: rbtree: add RBTree::entry"
>     Not used in the original RFC, but introduced after further
>     code review.  See: https://r.android.com/2849906
> 
> The Rust Binder RFC addresses the upstream deprecation of red-black
> tree. Quoted here for convenience:
> 
> "This RFC uses the kernel's red-black tree for key/value mappings, but we
> are aware that the red-black tree is deprecated. We did this to make the
> performance comparison more fair, since C binder also uses rbtree for
> this. We intend to replace these with XArrays instead. That said, we
> don't think that XArray is a good fit for the range allocator, and we
> propose to continue using the red-black tree for the range allocator."
> 
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Again, I drop patch #1 and put it in rust-dev with conflicts fixed.

Regards,
Boqun

> ---
> Changes in v8:
> - Fix small style nit (use ? operator)
> - Fix doc comment pointing at a private item
> - Link to v7: https://lore.kernel.org/r/20240726-b4-rbtree-v7-0-aee88caaf97c@google.com
> 
> Changes in v7:
> - make `RawVacantEntry.rbtree` a raw pointer like
>   `RawVacantEntry.child_field_of_parent`, since the latter can
>   technically point at a field of the former. We prefer that the
>   implementation be explicit about the safety guarantees of both because
>   of the relationship between them.
> - Link to v6: https://lore.kernel.org/r/20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com
> 
> Changes in v6:
> - Minimize usage of `*mut bindings::rb_node`, replacing with
>   `NonNull<bindings::rb_node>`. Specifically, changing
>   `RBTreeCursor.current` to be `NonNull<bindings::rb_node>` and updating
>   the corresponding functions.
> - Update `RBTreeCursor:to_key_value` helpers to have their own lifetime
>   (they are not instance methods, using a different lifetime than that
>   of the `impl` block they are in makes things more clear.
> - Fix misplaced semicolon in `cursor_lower_bound`.
> - Link to v5: https://lore.kernel.org/r/20240606-b4-rbtree-v5-0-96fe1a0e97c0@google.com
> 
> Changes in v5:
> - Used `Box::write` in `RBTreeNodeReservation::into_node`, removing
>   unnecessary `unsafe` blocks.
> - Updated `RBTreeCursor::remove_current` to return the removed node.
> - Link to v4: https://lore.kernel.org/r/20240603-b4-rbtree-v4-0-308e43d6abfc@google.com
> 
> Changes in v4:
> - rebased onto the tip of rust-for-linux/rust-next (97ab3e8eec0ce79d9e265e6c9e4c480492180409)
> - addressed comments from draft PR on GitHub: https://github.com/Rust-for-Linux/linux/pull/1081
> - Link to v3: https://lore.kernel.org/r/20240418-b4-rbtree-v3-0-323e134390ce@google.com
> 
> Changes in v3:
> - Address various feedback re: SAFETY and INVARIANT comments from v2.
> - Update variable naming and add detailed comments for the `RBTree::insert` (later moved to
>   `RBTree::raw_entry`) implementation.
> - Link to v2: https://lore.kernel.org/r/20240219-b4-rbtree-v2-0-0b113aab330d@google.com
> 
> Changes in v2:
> - Update documentation link to the C header file
> - Use `core::convert::Infallible` in try_reserve_node
> - Link to v1: https://lore.kernel.org/r/20240205-b4-rbtree-v1-0-995e3eee38c0@google.com
> 
> ---
> Alice Ryhl (1):
>       rust: rbtree: add `RBTree::entry`
> 
> Benno Lossin (1):
>       rust: kernel: add `drop_contents` to `BoxExt`
> 
> Matt Gilbride (1):
>       rust: rbtree: add `RBTreeCursor`
> 
> Wedson Almeida Filho (3):
>       rust: rbtree: add red-black tree implementation backed by the C version
>       rust: rbtree: add iterator
>       rust: rbtree: add mutable iterator
> 
>  rust/helpers.c               |    7 +
>  rust/kernel/alloc/box_ext.rs |   24 +-
>  rust/kernel/lib.rs           |    1 +
>  rust/kernel/rbtree.rs        | 1288 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1319 insertions(+), 1 deletion(-)
> ---
> base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
> change-id: 20231205-b4-rbtree-abb1a016f0a0
> 
> Best regards,
> -- 
> Matt Gilbride <mattgilbride@google.com>
> 

