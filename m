Return-Path: <linux-kernel+bounces-523739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333ABA3DA95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163BF19C075B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD5B1F583C;
	Thu, 20 Feb 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mr7m4nGM"
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B441F582D;
	Thu, 20 Feb 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056210; cv=none; b=NuRAkZntm6ahjvKc4lAo12U+NayGiL2/+NygGjf0S1m4KE2kmS6ss3HI75GXB0WirOrodCJVJbC/nBsdTsbS6BPdvomXIa6YNGB2ubTZBNVMfLUcgs38albLTeiiDvtypInHAFGDnYKFdVuvnYUtRoqCtqfcPXBqlDWORQPWVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056210; c=relaxed/simple;
	bh=cQIhLi26tFIrH6kBJV8dUrYUU3ZnLxK7Why21ahopxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4vqqT2iM4/AuqFodRxqtfnR5+EhnAepVeD8+aE1AFaX1793EfPZ1pQKGSk4k4U2dGiPI2JXshg9AjPafePrMlYInzHUvn/7f6gyRKikBxLPjCoX+1FrPWEtMOW0R57+A5aVRXtECMictKR97ACs7e4Rie9+3gtkRFxqhHqs3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mr7m4nGM; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740056207;
	bh=cQIhLi26tFIrH6kBJV8dUrYUU3ZnLxK7Why21ahopxc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=mr7m4nGMHy5Ec0f7MeshFTLsebdq7j3mA86NUB/Y+8M8d+G+wS13LnwQQnyhNf62B
	 RXQJu3AZJDnUeRTNJAY5EZL0mAuQHiJC37wx7iiy7WnoPYfucij+i/JWAnK3f/SDfA
	 iY6dp4njEwpkZZdW5gj+zrhL1BgbZMBvgmuttnQg=
Received: from [IPv6:2601:5c4:4302:c21::db7] (unknown [IPv6:2601:5c4:4302:c21::db7])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id EBE621C254F;
	Thu, 20 Feb 2025 07:56:46 -0500 (EST)
Message-ID: <1f52fa44062e9395d54ed6733780aea0830ee6a5.camel@HansenPartnership.com>
Subject: Re: Rust kernel policy
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>,  linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Thu, 20 Feb 2025 07:56:46 -0500
In-Reply-To: <Z7bQRvHNcK_MmDQn@infradead.org>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
	 <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
	 <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
	 <Z7bQRvHNcK_MmDQn@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-02-19 at 22:48 -0800, Christoph Hellwig wrote:
> On Wed, Feb 19, 2025 at 11:03:28AM -0500, James Bottomley wrote:
> > > This has come up a few times, and we indeed would like to have
> > > some annotations in the C headers so that we can generate more
> > > (and to keep the information local).
> > > 
> > > For instance, it would be nice to have bindgen's `__opaque` near
> > > the C items, or being able to mark functions as `__safe`, or to
> > > have other `enum`s-related annotations, or even custom
> > > attributes, as well as "formatted-formally-enough" docs so that
> > > can be rendered properly on the Rust side, or even
> > > references/lifetimes with an eventual "Safe C"-like approach, and
> > > so on and so forth.
> > > 
> > > However, even if we automate more and even reach a point where
> > > most C APIs are e.g. "safe" (which would be great),
> > 
> > I wouldn't say C API safety would be the main goal, although it
> > might be a nice add on feature.
> 
> Why not?  Why is safety suddenly less a goal when you don't use the
> right syntactic sugar?

Well a) because of the way C works, I don't believe you can get memory
safety with just header annotations and b) even if we got safe C it
still doesn't fix the unstable API propagation to rust problem, which
is why I don't think it should be a goal in a project aiming to fix the
unstable API issue. If we got it, I'd like it, which is why I listed it
as a nice add on feature.

Regards,

James


