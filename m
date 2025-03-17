Return-Path: <linux-kernel+bounces-564050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD9A64CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D93188FFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF84237193;
	Mon, 17 Mar 2025 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOR4l4HZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6062230BC7;
	Mon, 17 Mar 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211191; cv=none; b=WrXsSBdjpmDAuJAn5DYAnac392Wp07qDB9FBB9mfXrD+tcUFMovPOc+6SF/+gfd7WCYEtLvbOLjAk79Ni+fHhmZ4B/QaqrXy9Fr0UetTkdrp0Y7u/NW4Ooo9IlCcxzXiOdGSpXDz1Xzo4IDoEKEiN7617duZ46ARcRFaEJtrZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211191; c=relaxed/simple;
	bh=rd5Cuw6LgtoRPaM9G9rp2KzgEi6zz6L+gi9RDgMYS28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPnpBnie5mYWOSIcofCT3oGkTnTGyRavsadMw+Cz4ZeWeR46AZIJTlwVO13VEkwLT86sGws1IeghCKgysCk1ikIgSVkIq7aSZ6E0XEO9MKZaQURCcv/THIy9kwERWPPFSIGiMSpM7SBSefxs6gDjdGiE8MM4c2GbYKu4d7/M8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOR4l4HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D87C4CEE3;
	Mon, 17 Mar 2025 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742211190;
	bh=rd5Cuw6LgtoRPaM9G9rp2KzgEi6zz6L+gi9RDgMYS28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOR4l4HZf3nwuNLaQqHijKmqlZ8em07KcBSTl6aIUKE3RqGacxJu4SkPRIyqkbQTY
	 YdmaAmywKYEl4BIvxljJ2GseQgPfWjCBvtc0hZbNSsgiEoIuZ0ZTownjwCu8tw+TwI
	 whu9mvRLmTIAbhOR1LgMT26tP9oUwcTv9ZXS7kCFOTNTQAONoiVdmW1xQvXt1Plo0m
	 RcFLe61IQgXSsrGVcQJQWItv1QT6Z4tbyB/8Ns83YdUzRqEEonDqG9C8Inru0fueSO
	 Q6XLuxneuFg4hTjqZl0ehlPLC9rBQ+S0PNzuVEn/RW11YWWLACM1MeMQ2OUyrvfsSJ
	 /2vH6n9h2VdYw==
Date: Mon, 17 Mar 2025 12:33:04 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, airlied@gmail.com, acourbot@nvidia.com,
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Auxiliary bus Rust abstractions
Message-ID: <Z9gIcL2dAj_ZTfGR@pollux>
References: <20250313022454.147118-1-dakr@kernel.org>
 <2025031754-attribute-aching-7203@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031754-attribute-aching-7203@gregkh>

On Mon, Mar 17, 2025 at 08:05:46AM +0100, Greg KH wrote:
> On Thu, Mar 13, 2025 at 03:23:49AM +0100, Danilo Krummrich wrote:
> > This series adds Rust abstractions for the auxiliary bus.
> > 
> > It implements the required abstractions to write auxiliary drivers and create
> > auxiliary device registrations. A driver sample illustrates how the
> > corresponding abstractions work.
> > 
> > The auxiliary abstractions are required for the Nova driver project, in order to
> > connect nova-core with the nova-drm driver.
> > 
> > This patch series depends on [1] (taken through the nova tree for v6.15) and
> > [2]; a branch containing the patches, including the dependency can be found in
> > [3].
> > 
> > [1] https://lore.kernel.org/rust-for-linux/20250306222336.23482-2-dakr@kernel.org/
> > [2] https://lore.kernel.org/lkml/20250313021550.133041-1-dakr@kernel.org/
> > [3] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/auxiliary
> 
> As this seems to depend on different branches in different trees, I'll
> hold off on applying these to my tree now.  But if you want to take
> them sooner (i.e. before 6.15-rc1), that's fine with me:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks! I wouldn't take them for the upcoming merge window, but maybe for the
next one through the nova tree.

