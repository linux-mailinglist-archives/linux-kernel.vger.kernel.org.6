Return-Path: <linux-kernel+bounces-434548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD8A9E6821
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8199318851B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351311DD88F;
	Fri,  6 Dec 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYaFThl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3032C8B;
	Fri,  6 Dec 2024 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471089; cv=none; b=RGE5+BdUK8VnpFnFpDJw3Qb98lOcv20tQeuO0CwBgyG3JIqs1UGLDL2i57j8HBT/3nZH5JPfNc1vPVZuAlh2gkdAKydy4AnqH3wlRQWaSYES+h9FJvQ1cEPiibhVk2+noU6D6g2K+rwl1SC4N7WFxraz9vv/yoIiM5ueNKbAyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471089; c=relaxed/simple;
	bh=CfzG560eBtBK6aHbLV/Ulyg9yy2XbK0ZTDl7TzDnaww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG1z6o5PobukRNWGhE/qfiXUOdF7XDcAOymMzPR8prfy8OiANtUuCBUpWVKc1TC8IgWVft7TWXyv/zCMWuauMPTGH6huxsgwnxu1m3z6KHk5+WTYWzOoVQd+0GoRQMze/Vx+dXq6xjD3d2BrS4C4ShlghZ691CdZT56sd6xrvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYaFThl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840FFC4CED1;
	Fri,  6 Dec 2024 07:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733471089;
	bh=CfzG560eBtBK6aHbLV/Ulyg9yy2XbK0ZTDl7TzDnaww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYaFThl79cHLQiWcmW/AHa/dJSh4GTWmawNN8PRDgft/uzry3U5KQnfzCvHjn/ZzU
	 JPXxQB/5aBMkX7T/Q/sPkofvBIcacHPmzc2DTLl+EvqqDT225/UpMpq9QS0DLukpbo
	 2G66pw7osWh2BcCYU/Stk3nliD+RoMMoIZEicBa/2EJ8S9dXG7bauv2K10iqU0IUE1
	 0rYuATt5HE0yOYP+/UtxQTy3Bm71aSFOdLekocc0sQxDu87LqAB01lUT75vYdtwYT4
	 JZYJRrRimwgGZueS5SJ7NAoAcwbUvuWNZ1BuYn+FU6jjdcrNSJw4od+qMcyPZRnK5d
	 8t8ZChRHRhPWg==
Date: Fri, 6 Dec 2024 07:44:43 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <20241206074443.GJ8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <2024120632-hardwired-hardhead-1906@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120632-hardwired-hardhead-1906@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Thu, Dec 05, 2024 at 04:25:17PM +0000, Lee Jones wrote:
> > It has been suggested that the driver should use dev_info() instead of
> > pr_info() however there is currently no scaffolding to successfully pull
> > a 'struct device' out from driver data post register().  This is being
> > worked on and we will convert this over in due course.
> 
> But the miscdevice.rs change provides this to you, right?  Or if not,
> why not?

This does allow us to pull the 'struct device *` out from `struct
miscdevice`; however, since this resides in MiscDeviceRegistration,
which we lose access to after .init, we have no means to call it.

Alice is going to work on a way to use ThisModule to get the
MiscDeviceRegistration reference back from anywhere in the module. Until
that piece lands, we can't call MiscDeviceRegistration::device() outside
of RustMiscDeviceModule.

One option that I investigated involved global mutable variable that we
could store the &Device into during MiscDeviceRegistration, however this
got messy (actually just bloaty) fast.  Alice's solution will be
cleaner and more universally useful.

-- 
Lee Jones [李琼斯]

