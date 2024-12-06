Return-Path: <linux-kernel+bounces-435062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B16D9E6EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C42B1884728
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3A201278;
	Fri,  6 Dec 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc/UHJ+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88F1B4122;
	Fri,  6 Dec 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490410; cv=none; b=fgLOPXnb/Tn1mGFPZlM9oMEyqNzQ03rfjQUZTuYMR5COtelvprA9sDbCaSbXSoIB2gOewYS1ZeTDHcmYQQBMwRKaQzPehKihg8c/MzkSntsCdJtqCIe5naclnTy3CGcb+tbJkc719F3cKDTqmukjWXeTOOsB8wGlLtq/3USGa1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490410; c=relaxed/simple;
	bh=up30GlcVvBI0Xy6cqKBrq0wBFy8mljvMaYeXKxSq4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9AGtjt+MfycYDSQKDS8zAAje04prPXNBBZE7ow2y7GzlvR/VP+kndXyHFpIDsZ6AaA5utYoVNmnapE6r++NGnvp0n2TSrRpVWu46M7kpAfGmYBj0xjP2NM2ro12d4YdDFXSajQF+63JsmjIzY2JvKf+mVwzwdrk+Ra8AtVkPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc/UHJ+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83187C4CED1;
	Fri,  6 Dec 2024 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490410;
	bh=up30GlcVvBI0Xy6cqKBrq0wBFy8mljvMaYeXKxSq4LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kc/UHJ+TO7Eeo+1qG6J9LSn4JQ+R2/1LX4iHLyHPLnHbPdSdD3pEI4sIl0qr28m+A
	 XQ1MFIMpQ0eRrDWqUqVVxDCIz6PzzWwPfAbnkpn8s36k4RiqsDhLdzMuglOc21CPq+
	 jD7/CDXE08l9vzrkk+Vc+6OOrhodijP6ORyDTE2buc5NDhDcW1+7Q8LviO6p+18qmX
	 Pia7afE44I/K+jLwrxiqXDpYSMeHUDj+h1Jhehtb9vPV3VvhX40+nm9YN2NWG1xMP3
	 2W9CwHlWuM3YKaelTL8eGT1G/UpEz+oUNSZHLEbHq/G+SQVTYPje5jP7In3doBTxMx
	 nGBllcWjwpRtQ==
Date: Fri, 6 Dec 2024 13:06:30 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/4] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
Message-ID: <20241206130630.GD7684@google.com>
References: <20241206124218.165880-1-lee@kernel.org>
 <20241206124218.165880-4-lee@kernel.org>
 <2024120652-champion-chute-4e74@gregkh>
 <20241206130449.GC7684@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206130449.GC7684@google.com>

On Fri, 06 Dec 2024, Lee Jones wrote:

> On Fri, 06 Dec 2024, Greg KH wrote:
> 
> > On Fri, Dec 06, 2024 at 12:42:14PM +0000, Lee Jones wrote:
> > > Expand the complexity of the sample driver by providing the ability to
> > > get and set an integer.  The value is protected by a mutex.
> > > 
> > > Here is a simple userspace program that fully exercises the sample
> > > driver's capabilities.
> > 
> > nit, subject line should have "samples" not "sample" :)
> 
> Ack.
> 
> > > +    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
> > > +        let guard = self.inner.lock();
> > > +        let value = guard.value;
> > > +
> > > +        // Refrain from calling write() on a locked resource
> > > +        drop(guard);
> > > +
> > > +        pr_info!("-> Copying data to userspace (value: {})\n", &value);
> > > +
> > > +        writer.write::<i32>(&value)?;
> > > +        Ok(0)
> > > +    }
> > 
> > I don't understand why you have to drop the mutex before calling
> > pr_info() and write (i.e. copy_to_user())?  It's a mutex, not a
> > spinlock, so you can hold it over that potentially-sleeping call, right?
> > Or is there some other reason why here?
> 
> This was a request from Alice to demonstrate how to unlock a mutex.

It's common practice to apply guards only around the protected value.

Why would this be different?

-- 
Lee Jones [李琼斯]

