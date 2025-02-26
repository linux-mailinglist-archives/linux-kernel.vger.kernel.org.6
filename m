Return-Path: <linux-kernel+bounces-534772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E1A46AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609B616DFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F63239585;
	Wed, 26 Feb 2025 19:28:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EC238D38;
	Wed, 26 Feb 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598083; cv=none; b=g/4wyoAFYZOJg+lUusxG0qKUSC4IrWsiS7WWeK9RVeqTpwRVBbKfLoEKbLes+4Fo/YyhdJlxLoPiorkqfnRd88OriW72y5ICFFmRyszbxQaP0EIy5IW1OvcZKcNDNPJioqullrFeVI4tbi+VA/uRsEL8iG9D2HheIjkHVT1rx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598083; c=relaxed/simple;
	bh=ERSCSXDI7W9PAP+11KfXeyW6oaGJnGDpl5NgLi5A6lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0b6eUWyiOGHgQXjXiR4hKoOFUTgnSKJPFA5UOy9qsQTlhmD7KQv8e73KjS56kn9zKd1nbgfqrms9pr8XYcf9bqEHXLTsomhL258XV9QNBRDqGWJ/82aqdEQBf1SAaqWEBQhtsUz1iL1rccxCbu3xRZN+7FijDLmY+UBUG4WYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8977AC4CED6;
	Wed, 26 Feb 2025 19:27:57 +0000 (UTC)
Date: Wed, 26 Feb 2025 19:27:55 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, peterz@infradead.org, hpa@zytor.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	tangyouling@loongson.cn, hejinyang@loongson.cn,
	yangtiezhu@loongson.cn, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu
Subject: Re: [PATCH v3 3/5] arm64/bug: Add ARCH_WARN_ASM macro for BUG/WARN
 asm code sharing with Rust
Message-ID: <Z79rO-wRZtN5S8f9@arm.com>
References: <20250213135759.190006-1-fujita.tomonori@gmail.com>
 <20250213135759.190006-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135759.190006-4-fujita.tomonori@gmail.com>

On Thu, Feb 13, 2025 at 10:57:57PM +0900, FUJITA Tomonori wrote:
> Add new ARCH_WARN_ASM macro for BUG/WARN assembly code sharing with
> Rust to avoid the duplication.
> 
> No functional changes.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

