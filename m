Return-Path: <linux-kernel+bounces-434503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5581D9E6793
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176081885D47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B521DACBB;
	Fri,  6 Dec 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B05J4ban"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C348BE46;
	Fri,  6 Dec 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468841; cv=none; b=dpRvJRla5ogmeROW1hjLNKgV8fASYx4O4uDaKMxzUd5ZGYx/hKCJ4GqSe18n1AhfR2103CmzSoGx+VBJmKIYEKgquQKF9IyJEU7U9ATS4+eiaQcD0S16p64+XNLqSJIkasC7fZARmR8ZliLiomRTRNz88HBsO+tBTcqS/U0l3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468841; c=relaxed/simple;
	bh=Kma65pEbBAXgpytClGfAo6zPwV/27ffn+38OeWl3KE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDLOPyBLW26Y+OQsP/1DppHUNfrR3+rk7afHIIDdhn/VlRIT9Ohiiig0QKs0EGVPo11EzrXylDEawzRvpLHCXOBfAcabD4yjMcIACcwFlVYNoLsmTiO/12H0vJ1AxEi15vkZWfU/2MGevnn0unM1KHBBGna/pqMy1IbIHm8jzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B05J4ban; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7EBC4CED1;
	Fri,  6 Dec 2024 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733468841;
	bh=Kma65pEbBAXgpytClGfAo6zPwV/27ffn+38OeWl3KE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B05J4banqMzo8vVKysDoksx9/JphhLfj51T4CfXyNIdzxZHuC0ignV/TE6NrlH4LZ
	 F+ryZ/F++tg/usD6G0JPMWnrxRc+YjdKM5HArUUuKc0InpO8/AKpBByX7bdbrTNOYP
	 l60MtUOtpKxVFShEPCoN+ysLkUx4cReGGZBecaIeXPWhWw3XWUXt5sMnBgQ1ZzhZO+
	 hH7A9gCiaoIydwofVvPUcI48wLi6VOo8Qz4PqxiUl/Eas3BBvsbhYkmdXnSBj/TMfg
	 nVtjgLVlMWLFt6Hr1noQSn3tNeeQYYuijEXlsyAR6QV1Nn4C920Kz0eJ2HM/2Y3aSx
	 5VdlEd2Gvv2KA==
Date: Fri, 6 Dec 2024 07:07:15 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 5/5] MAINTAINERS: Add Rust Misc Sample to MISC entry
Message-ID: <20241206070715.GA8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-6-lee@kernel.org>
 <2024120617-directory-tiring-56e7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120617-directory-tiring-56e7@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Thu, Dec 05, 2024 at 04:25:22PM +0000, Lee Jones wrote:
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> You know I can't take changelog entries without any text :(

What more is there to say?  Okay, I'll work something out.

> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 21f855fe468b..ea5f7c628235 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5328,6 +5328,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> >  F:	drivers/char/
> >  F:	drivers/misc/
> >  F:	include/linux/miscdevice.h
> > +F:	samples/rust/rust_misc_device.rs
> 
> Nice, you are signing me up to maintain it for 20+ years?

It's fine if you don't want it.

So either I can create a new entry with Alice (with permission of
course) and I as maintainers or just leave it as the default catch-call
of samples/rust/ which is already covered by 'RUST'.

-- 
Lee Jones [李琼斯]

