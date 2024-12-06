Return-Path: <linux-kernel+bounces-435073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3B9E6F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F0C1884DC8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599820764F;
	Fri,  6 Dec 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fky88nM3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E11FCD11;
	Fri,  6 Dec 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491049; cv=none; b=qjVocgZKnNFP47QIpugsp3nLouLldz5dBwjBFqW3coOBn2hqXLoSKtNpCFAa/J65n+NuSlRauTfy85nJP2rpslY/TgRoG8ZJl0M4Vx9Fuu+9cO5EcvhxGWNVqqrZv/wBi0nD/nEk3HSwgRHDgBCw6xYUJdJ0WCXXY1vnOD2l1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491049; c=relaxed/simple;
	bh=JSxJ/A3qBbdoVQTY0FusBl+IExWoxTKF+CRs14VxLrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si8zzi/YcdKq8hIo1GiMW0JonnR0SGeJyM4TNY2U/dwM8+aA1qRiOwZ6RA0qpdEtKa8UrHig8gSaYtM+pih6ZuNJUOsW1NSnjN7kaJ2oY3zy865lDNoqBtVsOKpYXWc+v6PjtLqNHbRbMEwJRif4OnwByq0n4WcAmP34JfzMKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fky88nM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431E6C4CED1;
	Fri,  6 Dec 2024 13:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733491049;
	bh=JSxJ/A3qBbdoVQTY0FusBl+IExWoxTKF+CRs14VxLrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fky88nM3uTjGKEdfnwzBY4SZ1Pz7d9YUi6vczbDEwEfGBO7y1bt/EgkBA1mD/ZBiy
	 c/hHz1jFv3i0MKOnx3EQzGhzEOat4pT6YyW5aabfJhK3X/PqSlFByw0ZJUTY+Hd61X
	 rKTedQSpfNIvVcNwSz+fS7cNVD4z2grHpYG6MUNjB1XLYs2MBt5udZ84eGyXLBDRXD
	 XYAP5xcAg9gpiRj5GqOy4bYC2+Nlt7yBZItwk4Er12cI3j8AcTIMXi1Pl0TOKKP8fP
	 +0TTDUyfu+/Mi4aHY0b6HI1hh3xbP6QKM2ykLYlrc9mr+LMtKk1WRQZQgAUDAbNz7r
	 9huA+sxnmW1Ag==
Date: Fri, 6 Dec 2024 13:17:16 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
Message-ID: <20241206131716.GF7684@google.com>
References: <20241206124218.165880-1-lee@kernel.org>
 <20241206124218.165880-4-lee@kernel.org>
 <2024120652-champion-chute-4e74@gregkh>
 <20241206130449.GC7684@google.com>
 <20241206130630.GD7684@google.com>
 <2024120637-handoff-monetary-c2f5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120637-handoff-monetary-c2f5@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Fri, Dec 06, 2024 at 01:06:30PM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Lee Jones wrote:
> > > On Fri, 06 Dec 2024, Greg KH wrote:
> > > > On Fri, Dec 06, 2024 at 12:42:14PM +0000, Lee Jones wrote:
> > > > > +    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
> > > > > +        let guard = self.inner.lock();
> > > > > +        let value = guard.value;
> > > > > +
> > > > > +        // Refrain from calling write() on a locked resource
> > > > > +        drop(guard);
> > > > > +
> > > > > +        pr_info!("-> Copying data to userspace (value: {})\n", &value);
> > > > > +
> > > > > +        writer.write::<i32>(&value)?;
> > > > > +        Ok(0)
> > > > > +    }
> > > > 
> > > > I don't understand why you have to drop the mutex before calling
> > > > pr_info() and write (i.e. copy_to_user())?  It's a mutex, not a
> > > > spinlock, so you can hold it over that potentially-sleeping call, right?
> > > > Or is there some other reason why here?
> > > 
> > > This was a request from Alice to demonstrate how to unlock a mutex.
> > 
> > It's common practice to apply guards only around the protected value.
> > 
> > Why would this be different?
> 
> It isn't, it's just that you are implying that the guard has to be
> dropped because of the call to write(), which is confusing.  It's only
> "needed" because you want to guard a single cpu instruction that is
> guaranteed atomic by the processor :)
> 
> As this is an example driver, documentation is essential, so maybe the
> comment should be:
> 	// Drop the mutex as we can now use our local copy
> or something like that.

Sounds reasonable.

I've ran out of time this week.  I'll take another peek next week.

-- 
Lee Jones [李琼斯]

