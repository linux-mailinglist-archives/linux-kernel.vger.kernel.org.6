Return-Path: <linux-kernel+bounces-435027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24109E6E95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAF7169478
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE902066DD;
	Fri,  6 Dec 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHBGyYbe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA810E6;
	Fri,  6 Dec 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489470; cv=none; b=lcCdrEOqFnkTXp22RVfUGx+tGPUjrLkiZF6ncjgt4bXINcckDC1k9ovO40M5GQEroHsTCn0baVTTTEsU0JXQzI+omIQPC7VL/7ZDZX9PfxlJTEqkh4tISvNX77VSc+a31Ike7wszDochAS/h6TWCNIyglKhzAppCFCQqhWE9DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489470; c=relaxed/simple;
	bh=YplR6J/MThyifUE6vHS2ql3sMaD9NOZvm3ASk+xWjIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7NlAvoMGGu2AIrUPFMafX/EhERmBMbrUSW1hZKgRQiPxpf6czw3UfJybv880X1w+vqAdC+uD80Iu/Slj2Pv0T5bqLMnqDb1hXXgCZXPj2Krf6CleS5nwIZX+FKRijyh37Ruu2wWoSWCZa8O0BHzw6xE2aCULMCuJZfejoPAOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHBGyYbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C7CC4CED1;
	Fri,  6 Dec 2024 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489470;
	bh=YplR6J/MThyifUE6vHS2ql3sMaD9NOZvm3ASk+xWjIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHBGyYbeS/X7JE0VaxZhlKc3j2kW8FV67CtKscnXoyExqu+ZCLxlM23AGoyRiC+2a
	 4eIpILhyWUrNu0JL28LJTXGARNdx8QcEVdaXV30rky7oBpP8h/jevy5IbzFfFcLhgZ
	 fHK1uPBHI0BA+NPHoSkIS1OSoB16zUno1AVNoS1paHyLzkOHVPLA6No1RXJnzmRW6u
	 iAYlXnw1QsCRGQX++vZ+vwzCgKOAdSdqQ7xExa0U0CdR3tOFlzikzoRluIscEWn9Ey
	 esAAl3h4sfE3AVirfdNGZ9dFlgT1LcPthXHOZF3QAn+OJeO0okbcA35LMW34apQcBp
	 rfw5p8QiC5ZFA==
Date: Fri, 6 Dec 2024 13:51:04 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <Z1LzOORuFpO0MXAZ@pollux>
References: <20241206124218.165880-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206124218.165880-1-lee@kernel.org>

On Fri, Dec 06, 2024 at 12:42:11PM +0000, Lee Jones wrote:
> It has been suggested that the driver should use dev_info() instead of
> pr_info() however there is currently no scaffolding to successfully pull
> a 'struct device' out from driver data post register().  This is being
> worked on and we will convert this over in due course.

I think you're going too fast with this series.

Please address the comments you receive before sending out new versions.

Also, please document the changes you have made from one version to the next,
otherwise it's gonna be very hard to review this.

Thanks,
Danilo

> 
> Lee Jones (4):
>   Documentation: ioctl-number: Carve out some identifiers for use by
>     sample drivers
>   samples: rust: Provide example using the new Rust MiscDevice
>     abstraction
>   sample: rust_misc_device: Demonstrate additional get/set value
>     functionality
>   MAINTAINERS: Add Rust Misc Sample to MISC entry
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   1 +
>  samples/rust/Kconfig                          |  10 ++
>  samples/rust/Makefile                         |   1 +
>  samples/rust/rust_misc_device.rs              | 132 ++++++++++++++++++
>  5 files changed, 145 insertions(+)
>  create mode 100644 samples/rust/rust_misc_device.rs
> 
> -- 
> 2.47.0.338.g60cca15819-goog
> 
> 

