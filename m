Return-Path: <linux-kernel+bounces-325962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C1E976041
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7ABF283B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C41718891C;
	Thu, 12 Sep 2024 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmXrsFgQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DC7DA81;
	Thu, 12 Sep 2024 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726118007; cv=none; b=GAUfr/thiNPAf270qDKnwWdW4LCHXHKNXAMgreZ7EJnW1FlkJ5jkMpoHc8Y9uL5aXbQUVTpnZPJ1awR5sjGA7QyMffhrI2jUrODFJKzGlnsGRbs8nrnW5B4UYBdFZF4h9IE6E9g/1BJV4OJlAp2ZViBsBudkHIJdJXuupNlxWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726118007; c=relaxed/simple;
	bh=ateoTELeY0lN5wdYmcVoRt1ZSVOjMBCgGYhJVQybraE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5fEp5sUJkZ+j+2AWC3gJwj+Xr6EDfcUzeMRXicMxJEoPNx9GY2tl60R7RRvmkFF6+GY6wV641cbjoGzdNDHzkE/mU/Is6OrdJXbcECPSt/+gJzdXCaLv6ialPx4XaAZD7np4mhf7Pu91TBC4BKNNIafP1rquNeH0YxmKCn+tQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmXrsFgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8855CC4CEC3;
	Thu, 12 Sep 2024 05:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726118006;
	bh=ateoTELeY0lN5wdYmcVoRt1ZSVOjMBCgGYhJVQybraE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmXrsFgQO/XFpaMK+sbDICcN7OuvJ49Vv5GZXmdgNvug2R+bmHyWeK2y5C4uQgTPp
	 FgZOmC09Zkt/W3ypeRQ0YD66pv0Lk5pUXFWgigiFivMTgwC6Dkoc+8200VPHZ3x4SX
	 Ea/ADn2/T5+KSbHPrUrqq5e3yK9xUVb7/tLHgnw0=
Date: Thu, 12 Sep 2024 07:13:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hridesh MG <hridesh699@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Jens Axboe <axboe@kernel.dk>,
	Matt Gilbride <mattgilbride@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] rust: kernel: clean up empty `///` lines
Message-ID: <2024091253-bling-syndrome-da28@gregkh>
References: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>

On Wed, Sep 11, 2024 at 11:14:34PM +0530, Hridesh MG wrote:
> From: hridesh <hridesh699@gmail.com>
> 
> Remove unnecessary empty `///` lines in the rust docs.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1109
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>

This name needs to match your "From:" line, sorry.  Can you fix that up
and send a v3 series?

thanks,

greg k-h

