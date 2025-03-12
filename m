Return-Path: <linux-kernel+bounces-558380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE25A5E50C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19123A70BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544131EBFE3;
	Wed, 12 Mar 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic/dPZ2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FAC1ADC6C;
	Wed, 12 Mar 2025 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810193; cv=none; b=ZJ1SqTeYAJbQZMhoTzMq+8/TXTrP2Lvd4V1WIleurxnRKAl/zxckDpXraQzn01KCRhey/Lp7AlGb0WC9mBLXskclYaVZNrEAHjQEvlIjq/7d5aMh7+TaEjZA+Gz9z1n9A00Dzo+74kAijIJVA0Qvdl1c+/o9EwJ/V+rs4D5bTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810193; c=relaxed/simple;
	bh=YqDU9IupWA2FXPNUCWAYnD1z65tgFicyvwqxqmBULbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2Zi1XWgbHMZ35M0kX+xQfrG8fUvtpCO4NyU283JBdWg8RaPQFgahmDWAXMLv99h1rg8rfL2I4zPKZJK1pe6pWfLexhjIxnnToNw9TE6YkwdPuQszzf21YYDJPzQG1jecTGHi8nAvm+LLAymPflY4C7ImjW5eeoVtmvjf5+J/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic/dPZ2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57B7C4CEDD;
	Wed, 12 Mar 2025 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741810193;
	bh=YqDU9IupWA2FXPNUCWAYnD1z65tgFicyvwqxqmBULbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ic/dPZ2OIWnwEnIEQRaQ8bwdTDyqnmf5vw1EMDrKLQYJrt6LWogV6wxFFuhyoQufs
	 7nn+KMSbjAcMLaWMn6QxkC8a6zG1RTtj9oBe5az/wtpY2jnLkVD3bz6Gww6LhYccvB
	 RjKy3MBQ3ne8SEJKStSvcyDK0s9Ddx48WbLufBse4TTEaVTP6NNtfDbQL1sQi2lApc
	 uS+OPM4XHZuBsBvEOh4TiJSHHw54DuSJdYDgv1bL/qon5lDifd3gyDXnmZ9DI973Vn
	 BMEnMvSWgx8Nc15yhFTJhfn4VAS8LJl1qAgfC6b9fd1F/BbK8NcqFEDbQzEIPWECh1
	 wuUr/wP82NNOg==
Date: Wed, 12 Mar 2025 21:09:47 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, airlied@gmail.com, acourbot@nvidia.com,
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Auxiliary bus Rust abstractions
Message-ID: <Z9HqC_EeiyScCaEL@cassiopeiae>
References: <20250312002741.453350-1-dakr@kernel.org>
 <2025031228-saline-preset-ba9b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031228-saline-preset-ba9b@gregkh>

On Wed, Mar 12, 2025 at 08:14:24AM +0100, Greg KH wrote:
> On Wed, Mar 12, 2025 at 01:19:06AM +0100, Danilo Krummrich wrote:
> > This series adds Rust abstractions for the auxiliary bus.
> > 
> > It implements the required abstractions to write auxiliary drivers and create
> > auxiliary device registrations. A driver sample illustrates how the
> > corresponding abstractions work.
> > 
> > The auxiliary abstractions are required for the Nova driver project, in order to
> > connect nova-core with the nova-drm driver.
> 
> Nice!
> 
> > This patch series depends on [1] (taken through the nova tree for v6.15); a
> > branch containing the patches, including the dependency can be found in [2].
> > 
> > [1] https://lore.kernel.org/rust-for-linux/20250306222336.23482-2-dakr@kernel.org/
> > [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/auxiliary
> 
> Do you want this to wait until that lands in 6.15-rc1 or do you want to
> take this now through the nova tree?  Either is fine with me.

Thanks! Let's wait for things to land in Linus' tree and give people some time
to review.

I will also send a v2 soon, fixing up a soundness issue I'm also working on
a fix for platform and PCI.

