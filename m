Return-Path: <linux-kernel+bounces-251717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4060A9308C6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 08:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7062D1C20B41
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825F134C6;
	Sun, 14 Jul 2024 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T3B7uTa5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1DF9F7;
	Sun, 14 Jul 2024 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720937800; cv=none; b=bmhBRluOBCcl1EcBKheI3jxQjNKPzzrzYqTbk+KhD5pgM7jEn3amYOKkDlG68fYJWmCnDH0CA8OYkb5xKUWXF8J/loZjx7Nh3H52tIwYjoO0OcXBuwphw8yHuMf1D23JIoe6m7SbUcQ6pNI8+43I0n4dvlTEltpX/58CgCFLYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720937800; c=relaxed/simple;
	bh=Rfbcaj32eY3615/cuJlKE/JNFiyObDcg0NOtD3Oyj4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTfdCyGkzrAKJ0Jwp0JGZI5CSAd3aEl0G5cwcEoFFBLCEVEN80spNYtdJpGbJJbT9T176aTpbR0ejxTfPfjrEDk5aepZrPQfUubfq8vNC8X/wMqGxY7Fu9PSsM2UH/r87j45POY9/BLLPNjh3FuffxnJkZsLfW1ufyHHsoJCZfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T3B7uTa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC38C116B1;
	Sun, 14 Jul 2024 06:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720937800;
	bh=Rfbcaj32eY3615/cuJlKE/JNFiyObDcg0NOtD3Oyj4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3B7uTa5zni6A+GI1W7yd+ppIhuPSI8gWAi8WnBcdoqeTHCxhBobT4WhltSSunGI7
	 jcOaztmPY5AMpLOlb/jB5TfCssZBMEz66OhqVyCpyyutgYsCRkb4U67IpuxPKXSR5G
	 CrEGHf6c1mKEKvZf8MJ6CNkxSNp/BLXP1IbERtB8=
Date: Sun, 14 Jul 2024 08:16:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: miguel.ojeda.sandonis@gmail.com, a.hindborg@samsung.com,
	alex.gaynor@gmail.com, aliceryhl@google.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	andrewjballance@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, ojeda@kernel.org,
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org,
	skhan@linuxfoundation.org, wedsonaf@gmail.com
Subject: Re: [PATCH v2] rust: firmware: fix invalid rustdoc link
Message-ID: <2024071418-precook-catatonic-587a@gregkh>
References: <CANiq72=6LSGwRsc+deE+U8H=mdgFisrKEPOYgVkZfHhGm8hwog@mail.gmail.com>
 <20240709004426.44854-1-andrewjballance@gmail.com>
 <ZpKUEKHh6gK7SODR@pollux.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpKUEKHh6gK7SODR@pollux.localdomain>

On Sat, Jul 13, 2024 at 04:49:52PM +0200, Danilo Krummrich wrote:
> Hi Greg,
> 
> On Mon, Jul 08, 2024 at 07:44:26PM -0500, Andrew Ballance wrote:
> > remove an extra quote from the doc comment so that rustdoc
> > no longer genertes a link to a nonexistent file.
> > 
> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> > Reviewed-by: Danilo Krummrich <dakr@redhat.com>
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
> > Fixes: de6582833db0 ("rust: add firmware abstractions")
> 
> Can you please pick this one up?

Will do after -rc1 is out, sorry, my trees are closed now for the merge
window.

greg k-h

