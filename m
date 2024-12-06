Return-Path: <linux-kernel+bounces-435032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72E9E6EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A82E168A36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A9D202C30;
	Fri,  6 Dec 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGSoF0J1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFF1C6B8;
	Fri,  6 Dec 2024 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489683; cv=none; b=TcPJHWRVBMhJEsutN81+rB7L9DIMefcyMkicgJB4yg+aXpV0MssuUBgk8CGlJXT61hvLbdwDrGS3wh7k9FQKV+4hJvXoOFLEeTwq1DWW8omQXTooXoiLJkMYENv1GnlwTtp9qApUHuKJgJePWEjDyxyddqGUZzS3uj/LipnxMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489683; c=relaxed/simple;
	bh=zUxAg/YJWuBQqrjFTkVvFGyzoSnJHUOahX51qqmhE4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr3doGZenOqZitXLoz8Osd/hNJRx1sgYlwKG0/WC5qtc+xcaLlQAGcZhoRK38gWI8dCbvraUjxbnEtenrz5AV74VRlwpY7OVWgQu2LYwjIZliCL+nALkCSVFskegkEYuAecxOsQdA7hlcneYADsFYrsnbfKVw8K4mjnxD8MfvgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGSoF0J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE02C4CED1;
	Fri,  6 Dec 2024 12:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489683;
	bh=zUxAg/YJWuBQqrjFTkVvFGyzoSnJHUOahX51qqmhE4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGSoF0J14AOn6PYTcvqDN8BIUQLgkel6EdoDtquIdAchwnjcHZIghYtUBnXMQDoco
	 XZXvnjKSvXqQsvkuueqGzj+pWuPys7rNvOotHsjyvyFVJSwe06XAXeTkbTquAfniwz
	 7JBdd30HWnMbHyPDJN+z5fV7aPeFZEI+5cN6GV7zSq4byYOuaG06l0nALPUlTJh2gJ
	 St9dgTgM5oSNBiW0yLRu+TTPLLoOUBEwE5fXMwLCQ4O1Uy5OEAqoWf14w+/Zq8AQto
	 tVd1/ghzIMmLwnwCrX/N79xktB/wDT3BJn7XhIcjZ9RKZtc1aZNHXDrMpDtOYfUyev
	 UxqZ+yUBAfX7A==
Date: Fri, 6 Dec 2024 12:54:30 +0000
From: Lee Jones <lee@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <20241206125430.GB7684@google.com>
References: <20241206124218.165880-1-lee@kernel.org>
 <Z1LzOORuFpO0MXAZ@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1LzOORuFpO0MXAZ@pollux>

On Fri, 06 Dec 2024, Danilo Krummrich wrote:

> On Fri, Dec 06, 2024 at 12:42:11PM +0000, Lee Jones wrote:
> > It has been suggested that the driver should use dev_info() instead of
> > pr_info() however there is currently no scaffolding to successfully pull
> > a 'struct device' out from driver data post register().  This is being
> > worked on and we will convert this over in due course.
> 
> I think you're going too fast with this series.
> 
> Please address the comments you receive before sending out new versions.
> 
> Also, please document the changes you have made from one version to the next,
> otherwise it's gonna be very hard to review this.

I can add a change log.

What comments were missed?

-- 
Lee Jones [李琼斯]

