Return-Path: <linux-kernel+bounces-571226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9DA6BAA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AA817B628
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D273226545;
	Fri, 21 Mar 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ykw+MUFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A327225761;
	Fri, 21 Mar 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559936; cv=none; b=O4+Zmmpiye+F5S1DRvQNX8KhksLKkVaqC/2kdEomjcouSVEgfHIElN0FEWK8+QmyDphHMgYARlnjfotcw+tsSBnCCwXFRloUhM0AsCOY9/270ImF8v/v7t1Ldsbc7hFkyk2ThIKhR1xbBbsn0k8aSb9FNvhrzE8ersDCb7LcKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559936; c=relaxed/simple;
	bh=i+IG2fA8Z0bs8YjGeW1YZRWkmPZPG7E8hMzKSXgw5zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIOzSlEcltUvpdKCULYbAzL9K6rexT1BN2ydmBb8GiKyD0XlmrKQ9KAX3FjPemFJxn2LmS9hk10sNhSiZJCfXM8IGiiF1pWBJboaSsUEQzToyK2XYItl4I7lYfNc8O1bgyPnsNcokhtqsh7Zzk27KRabwsBOp0VbJfz8LGwU6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ykw+MUFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B4AC4CEE3;
	Fri, 21 Mar 2025 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742559935;
	bh=i+IG2fA8Z0bs8YjGeW1YZRWkmPZPG7E8hMzKSXgw5zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ykw+MUFFbXJNMkrIj/0ENTyUR5/IPKbhIQiJQgvo+JOuDJA9Usff1aXzqzPoYbN1I
	 LX+W8XgF3isl1Dy86VoCDcXCKfJWAGORg1Fbi5x8eFhrfKLaLP/HmTwUQOd40lyDGv
	 TinMtGSy6e7j3OYI5pFqNS/H1LryXZ+HyjUP7CVWQvoA4V98aKgzHMlUXNH8yXTP5J
	 4pxruwSk5RwRhF6w9LSu/gcGZOCAXSaiL6zP+vA8hXdDrlQhMEsMJl6xUL2w/Rb0pH
	 5H4imtUamYudmCSnIwhTIc/yAK0+j4ySZUgLELtnn3eeUffeTk/L1yxJrOc74bWmxm
	 pmzZtOZfz3A0Q==
Date: Fri, 21 Mar 2025 13:25:31 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benno Lossin <benno.lossin@proton.me>,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v2 0/7] Additional methods for Vec
Message-ID: <Z91au1h1zhDT9IxQ@pollux>
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>

On Fri, Mar 21, 2025 at 12:09:55PM +0000, Alice Ryhl wrote:
> This adds various Vec methods. Some of them are needed by Rust Binder,
> and others are needed in other places. Each commit explains where it is
> needed.
> 
> I'm not sure what we concluded on the set_len / dec_len changes, so I
> don't depend on that series for now.

So far I see no reason to assume otherwise, so it probably makes sense to
rebase. Unless Tamir is fine to rebase his changes onto this series.

> 
> This series is based on top of Vec::truncate from
> https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrewjballance@gmail.com/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v2:
> - Add two more methods that I needed.
> - Introduce some uses of set_len.

I think the added Vec::remove() modifies self.len directly.

> - Add example to retain.
> - Simplify pop.
> - Adjust 11 to 10 in push_within_capacity example.
> - Link to v1: https://lore.kernel.org/r/20250320-vec-methods-v1-0-7dff5cf25fe8@google.com
> 
> ---
> Alice Ryhl (7):
>       rust: alloc: add Vec::clear
>       rust: alloc: add Vec::pop
>       rust: alloc: add Vec::push_within_capacity
>       rust: alloc: add Vec::drain_all
>       rust: alloc: add Vec::retain
>       rust: alloc: add Vec::remove
>       rust: alloc: add Vec::insert_within_capacity
> 
>  rust/kernel/alloc/kvec.rs | 202 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
> ---
> base-commit: a337a03281efc4553191b432d757d4c04884bf4c
> change-id: 20250320-vec-methods-adfa41e55311
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

