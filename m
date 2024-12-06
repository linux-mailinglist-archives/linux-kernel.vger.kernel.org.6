Return-Path: <linux-kernel+bounces-435058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A939D9E6EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F78283561
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3B206F0F;
	Fri,  6 Dec 2024 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgHTO4hf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34320011B;
	Fri,  6 Dec 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490301; cv=none; b=oY7PkdUcviTJwRMQY5Y5ugB1lKz2GtA3tq/EQp4Y8gfZ9VjBtokziKdewVJEqYj/ZL4AL+ZQ7YsfDvYf4yeNplQVfh9jjVsgeou7LYNpQFZlZmtyk+ar4TplUz/KOty0a4kljMan91RIA8MeevV61EEQXmSHwQAP6oKW2yUhdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490301; c=relaxed/simple;
	bh=zlKdLM8kapGyhcJuH9MTKHeJKLM2/vVDSC6MxPiGEg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgdQN4yETXUluPMyxloLH6bJfihNvmi9SF8umAMarlBmXX1MmnvRQqryQCvT6AwDAXKd2qb9DL0aLbsx0WmnGhVfraqNH0lpBlnWcdxZ3Vi1xFy9xT0ejPJKr69sSwPhj/1WSV9ux6fKgwU3/ExMUumdkymRfbnU4Zel6nt/Tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgHTO4hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0474EC4CED1;
	Fri,  6 Dec 2024 13:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490300;
	bh=zlKdLM8kapGyhcJuH9MTKHeJKLM2/vVDSC6MxPiGEg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgHTO4hf+tmyf5sQ7sH+6p+J7BMii9YChE+cl8iCEJXjCn7VbdS1jQS9KY/th/MfU
	 YvMcFkW6HMWnnjyKYUW4K5teIFHC7MCZSLK6KyvMyGercqdRvy1h89Y4IfahjShr9Z
	 LqT8laaR14xQ0+L1VtTfx2aF5xuky59VXLKesl+CozODSgoIPwDylWBoTGmlVX/8P5
	 gXyRVgNoW6hg2Aq+AIMBsXa4zl/a5ceNvmitkYrzXqb+WWiQIU9Gw/WLnSM3m5Zrx2
	 Ln0BpgsEnSxcQiVjDSAC/gHN3r40TNws9XSaL1M47Du7g7A5iT+bKvTkCXi4RQYGqq
	 WGjGeRZH/jIhQ==
Date: Fri, 6 Dec 2024 13:04:49 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
Message-ID: <20241206130449.GC7684@google.com>
References: <20241206124218.165880-1-lee@kernel.org>
 <20241206124218.165880-4-lee@kernel.org>
 <2024120652-champion-chute-4e74@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120652-champion-chute-4e74@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Fri, Dec 06, 2024 at 12:42:14PM +0000, Lee Jones wrote:
> > Expand the complexity of the sample driver by providing the ability to
> > get and set an integer.  The value is protected by a mutex.
> > 
> > Here is a simple userspace program that fully exercises the sample
> > driver's capabilities.
> 
> nit, subject line should have "samples" not "sample" :)

Ack.

> > +    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
> > +        let guard = self.inner.lock();
> > +        let value = guard.value;
> > +
> > +        // Refrain from calling write() on a locked resource
> > +        drop(guard);
> > +
> > +        pr_info!("-> Copying data to userspace (value: {})\n", &value);
> > +
> > +        writer.write::<i32>(&value)?;
> > +        Ok(0)
> > +    }
> 
> I don't understand why you have to drop the mutex before calling
> pr_info() and write (i.e. copy_to_user())?  It's a mutex, not a
> spinlock, so you can hold it over that potentially-sleeping call, right?
> Or is there some other reason why here?

This was a request from Alice to demonstrate how to unlock a mutex.

-- 
Lee Jones [李琼斯]

