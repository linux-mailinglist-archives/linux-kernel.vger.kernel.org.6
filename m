Return-Path: <linux-kernel+bounces-427465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FF9E01B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AA0284094
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A24200105;
	Mon,  2 Dec 2024 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="f98/YX0L"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2401FF61B;
	Mon,  2 Dec 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141009; cv=none; b=oT83ZlrLxPozyQ2f2M0isFb4hLaB9wNyB5OvKxo2/B6rx1/rIM77kPNBQvejYU52fazjC9qMD8y9t5nrHRMUu4K1Q2TJyvaRpt1frfr0xmDj5bdSIiYEyCBpMXjWTc5CSO/OQx+auVtgbtnIryAGUHA1FAr4od+GxKdXGDjfp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141009; c=relaxed/simple;
	bh=onS7sMEZzhB3hatzLxUuQi9CQ2E6VuzwtA57t/RQsVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJf9Jg2EZxTPYNZK/NR2J0OmQoKk1HoIeYQq31t/YDDkWy7u+Yb68Mbz8aPhiYwXpseaZlbsXYs9HQTMO/ne+LXGPVbOvyY1QB2svMEroNcl71+EXublS11WManjPR/L7eq+qK9/6/sDvp95f/kqeZuI4U+Qt9oPeUuEE5wLmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=f98/YX0L; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 9F3F041F5F;
	Mon,  2 Dec 2024 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1733140997;
	bh=onS7sMEZzhB3hatzLxUuQi9CQ2E6VuzwtA57t/RQsVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f98/YX0LZ94SDNc5clXjsqU6GG73u+HVJXUJuZqNU7Epauwq62L8EQQiNcRUkxt8F
	 K5V0OtD7vncPCPqb3coENjgoyRVcM4KQzwVuG8hPsEK679BhlefNV5jYDr8fGp7vdC
	 TRHGdKbOmakPZAoLa9yGJcwdWtqTecv/CSEfmH2uhP0yC8V8lW2jYdCFnPabNlmSPD
	 sVOhxGRt2qz9W8IomGvcQPXCwb8uJexdPknBWPszkJIiPl+8Ay6Rs0IB71JgOSoD62
	 v+bHMOsY9zwRG2Gwvp4WkNVr96DGy9FK0a5ETeM3BDcUvErfJNLOkYe5O4ae4Q49At
	 NnygM/rk0Ux3Q==
Message-ID: <4c58b3b7-0c2a-441d-9b2c-7be65cb39bf2@asahilina.net>
Date: Mon, 2 Dec 2024 21:03:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 8:24 PM, Abdiel Janulgue wrote:
> This series aims to add support for pages that are not constructed by an
> instance of the rust Page abstraction, for example those returned by
> vmalloc_to_page() or virt_to_page().
> 
> Changes sinve v3:
> - Use the struct page's reference count to decide when to free the
>   allocation (Alice Ryhl, Boqun Feng).
> - Make Page::page_slice_to_page handle virt_to_page cases as well
>   (Danilo Krummrich).
> - Link to v2: https://lore.kernel.org/lkml/20241022224832.1505432-1-abdiel.janulgue@gmail.com/
> 
> Changes since v2:
> - Use Owned and Ownable types for constructing Page as suggested in
>   instad of using ptr::read().
> - Link to v1: https://lore.kernel.org/rust-for-linux/20241007202752.3096472-1-abdiel.janulgue@gmail.com/
> 
> Abdiel Janulgue (2):
>   rust: page: use the page's reference count to decide when to free the
>     allocation
>   rust: page: Extend support to existing struct page mappings
> 
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/page.c             |  20 +++++
>  rust/kernel/page.rs             | 135 ++++++++++++++++++++++++++++----
>  3 files changed, 142 insertions(+), 14 deletions(-)
> 
> 
> base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb

Just wanted to comment on an upcoming use case I have that will need
this, to make sure we're aligned. I want to use the page allocator to
manage GPU page tables (currently done via an io-pgtable patch and
abstraction but that's going away because it turned out to be too
intrusive to upstream).

Since I'm dealing with page tables which are their own tree ownership
structure, and I don't want to duplicate management of the page life
cycles, this means I need to be able to:

- Convert a Rust-allocated and owned page *into* its physical address
(page_to_phys()).
- Convert a physical address *into* a Rust-allocated and owned page
(phys_to_page()).
- Borrow a Rust Page from a physical address (so I can do read/write
operations on its data without intending to destroy it).

Conceptually, the first two are like ARef::into_raw() and
ARef::from_raw() (or Box for that matter), while the third would
basically return a &Page with an arbitrary lifetime (up to the caller to
enforce the rules). The latter two would be unsafe functions by nature,
of course.

I think this would work just as well with some kind of Owned/Ownable
solution. Basically, I just need to be able to express the two concepts
of "Page owned and allocated by Rust" and "Page borrowed from a physical
address".

This maps to pagetable management like this:
- On PT allocation, a Page is allocated, cleared, and turned into its
physical address (to be populated in the parent PTE or top-level TTB)
- On PT free, a page physical address is converted back to a Page, its
PTEs are walked to recursively free child PTs or verify they are empty
entries for leaf PTs (invariant: no leaf PTEs, all mappings should be
removed before PT free) and dropped.
- On PT walk/PTE insertion and removal, a physical address is borrowed
as a Page, then `Page::with_page_mapped()` is used to perform R/W
operations on the PTEs contained within.

Tying the lifetime of actual leaf data pages mapped into the page table
to the page table itself is a higher-level concern that isn't relevant
here, drm_gpuvm handles that part and those pages are not allocated
directly via the page allocator, but rather as GEM objects which
ultimately come from shmem)

(Note: this hardware is always 64-bit without highmem so those concerns
don't apply here.)

~~ Lina


