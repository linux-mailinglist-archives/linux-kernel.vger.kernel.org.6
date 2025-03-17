Return-Path: <linux-kernel+bounces-565043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18FBA65FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1527188A820
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567761F8BC6;
	Mon, 17 Mar 2025 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOObdW+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0A3D6A;
	Mon, 17 Mar 2025 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244950; cv=none; b=W+LkqqhPbsDhi/9Yb2O5fOsdLysWTOtQ3pE6FAGaBDQXTfjVSIRum5whLeHI4QfGwgybzQFIQwKwFT4ww9kv9xKYljlw69T1CmUoK3t+N80cXiWUKxggUQwtTv/hO2zC8+hAAcVrZ7vdiRC+QwCigFFS4kVrMFDWr79KvXWrF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244950; c=relaxed/simple;
	bh=7iFGYpd72i4icc7AODNgBB6qi9f4b/MTMff+vhitl/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCPjJHDWhks9t0k5X+/wf45yeCXVE1fzmiLM8ichssouZw4mLmD3yWr4go87vTOQdoW9wsqaIaKqUZWrhGrmgBqTNH6SqWN0EnWYmu9XhA51Hb+Go+MI80zVvWcpcjiDEPjk+diEUQYS+l3iN/rXAdn88p+AXbuOO4Oj7ioqyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOObdW+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885CC4CEE3;
	Mon, 17 Mar 2025 20:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244950;
	bh=7iFGYpd72i4icc7AODNgBB6qi9f4b/MTMff+vhitl/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOObdW+R4cjvk6ITIVLHc16pRsLdUn2UAYyQeDSsvDdXRD3Cojl1wb4AVMLeIDmcA
	 en6v2byKv+kElT+fmPcmJWG6jdhef6K+pDhO3Z0GBEEeyRYcRvdCsFfziatmNsmmOP
	 w+z+pCivy+z3T6lRd24aAQ5fLXsg7hCh7W2B1yvpQn3JsInpjvvXIlUoEZf+6QHpVa
	 27ApJZaHM6lb8wxreE2jDEnBFX/eJcATLHTRsNV58wz72PLj4XLPE3V+x4iqy7xKWH
	 2HLgKFUKwnm+n4C5Y+bD9MBA2WfPlKa1vhlTIRAr3ZVOzzU3RAolHdQkafteZ4LgdC
	 QdViHCAXtegLw==
Date: Mon, 17 Mar 2025 21:55:44 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt?= du Garreau <benoit@dugarreau.fr>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	airlied@gmail.com, acourbot@nvidia.com, jhubbard@nvidia.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: auxiliary: add auxiliary registration
Message-ID: <Z9iMUHRtzuqcbSm2@cassiopeiae>
References: <20250313022454.147118-4-dakr@kernel.org>
 <20250317204310.7804-1-benoit@dugarreau.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317204310.7804-1-benoit@dugarreau.fr>

On Mon, Mar 17, 2025 at 09:42:51PM +0100, Benoît du Garreau wrote:
> On Thu, 13 Mar 2025 03:23:52 +0100 Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > +impl Registration {
> > +    /// Create and register a new auxiliary device.
> > +    pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: &CStr) -> Result<Self> {
> > +        let boxed = KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)?;
> 
> You can use `KBox::init(kernel::init::zeroed(), GFP_KERNEL)` here. It avoids
> the need for the first patch.

You're right, that works indeed, the full call looks like this.

	let boxed = KBox::init(kernel::init::zeroed::<Opaque::<bindings::auxiliary_device>>(), GFP_KERNEL)?;

However, I think Opaque::zeroed() reads a bit better. Unless anything speaks
against adding it, I think I prefer it as it is.

