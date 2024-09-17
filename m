Return-Path: <linux-kernel+bounces-332000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A58697B3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2511C22076
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABA1891BB;
	Tue, 17 Sep 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TdEowdeO"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE81245BEC;
	Tue, 17 Sep 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726596066; cv=none; b=XLtyM5CCtyWg1VUAZvtcH0CoTmhI6zvpAdLeSk4aU6Ozb2ZtT5yhHTQkJzGGDFMTRF//KMsnzCEkSBvlBjWOCInU+B5px41RnZSY1csJZXm84fjYxmU9xYEosEdxPCI1OcrKeVPVi37ZlRCB50IdGxJgbn+EjuRStQf4oSEw+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726596066; c=relaxed/simple;
	bh=SzIPpoz5vRioVwcU2NPU0N1Id1AdePpy+2IhzM85PIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeZuNByznjMtbxfKhEZyu5NNw/ABlEEQ1+9WPQSHECP8ntBIb9f/+AXlCnM5y0eZuVO8T3lo2At67DLwvp/+1zimq/UWpki2/YB084MgLBkoGjqIx3d8gVRZ4LVGn+XKDYnUl+mXGFd+94DRw11POJMYMQGH74E7c9pXq/ud1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TdEowdeO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1194)
	id 29C9A20C095C; Tue, 17 Sep 2024 11:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29C9A20C095C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726596063;
	bh=V4qe9HDDgdOF61DGMBtQSmlpHMiRxOZMDOMGGI/r19c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdEowdeOEo/96+nhoDeW0x+h1cNQfUBcHabwxHTuv3mDz1ucZKflCzmyro/cc/nqK
	 SSJP22bTz+iQdNInSViBOROaFppXT9PehF182pQ/Q/uLbv7GBudI19vDWCtwQeTsdt
	 6sA2fv0ZdCw++o1YyWdHRgc1URaBMLk137bsFst8=
Date: Tue, 17 Sep 2024 11:01:03 -0700
From: Nell Shamrell-Harrington <nells@linux.microsoft.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, tmgross@umich.edu, linux@obei.io,
	kernel@valentinobst.de, kent.overstreet@gmail.com,
	matthew.d.roper@intel.com, kartikprajapati987@gmail.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: Adds examples for the `Either` type
Message-ID: <20240917180103.GA16431@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240916233507.11779-1-nells@linux.microsoft.com>
 <1037016e-d3fc-45a5-9607-38ca85eeb65c@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1037016e-d3fc-45a5-9607-38ca85eeb65c@de.bosch.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Sep 17, 2024 at 10:35:20AM +0200, Dirk Behme wrote:
> On 17.09.2024 01:35, Nell Shamrell-Harrington wrote:
> >Adds examples for the `Either` type
> 
> You might want to check
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> "Describe your changes in imperative mood, e.g. “make xyzzy do
> frotz” instead of “[This patch] makes xyzzy do frotz” or
> “[I] changed xyzzy to do frotz”, as if you are giving orders to
> the codebase to change its behaviour."
> 
> For example:
> 
> [PATCH] rust: types: Add examples for the `Either` type
> 
> Add examples for the `Either` types.

Will do!

> 
> 
> >Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> >Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>
> >---
> >  rust/kernel/types.rs | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> >diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> >index 9e7ca066355c..f22f6e289198 100644
> >--- a/rust/kernel/types.rs
> >+++ b/rust/kernel/types.rs
> >@@ -461,6 +461,12 @@ fn drop(&mut self) {
> >  }
> >  /// A sum type that always holds either a value of type `L` or `R`.
> 
> It looks to me that the default is to add
> 
> /// # Examples

Thank you, I will add this in and resubmit the patch.

> 
> followed by some verbose explanation before the test code below.
> 
> >+/// ```
> >+/// use kernel::types::Either;
> >+///
> >+/// let left_value: Either<i32, &str> = Either::Left(7);
> >+/// let right_value: Either<i32, &str> = Either::Right("right value");
> >+/// ```
> 
> I ran that on the the target and got:
> 
> # rust_doctest_kernel_types_rs_3.location: rust/kernel/types.rs:485
> ok 107 rust_doctest_kernel_types_rs_3
> 
> So:
> 
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thank you for doing this, I appreciate you taking the time!

> 
> Thanks
> 
> Dirk
> 
> 

