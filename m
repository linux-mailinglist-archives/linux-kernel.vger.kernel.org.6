Return-Path: <linux-kernel+bounces-240804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F939927306
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACF6283DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB11AB51A;
	Thu,  4 Jul 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1X1jcqzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDC1AAE30;
	Thu,  4 Jul 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085335; cv=none; b=HbqlUsVQV3GeYjqKpmGMfuf/puK+sHA8MXqCyL0ABnN4NDsntrlAXN6CJWGaexUGmtuSZ/JOTZY571kqpfbyHex4yjmhcJT1nBlH9XVaRmdrX46BVepBhK9QDefsSTsqwynufWPHRpoAyLqqsTLnGzVa0I83nBYhhZ2gj91sXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085335; c=relaxed/simple;
	bh=77clekpa8nlbta5kCQm7ekukTsxOEhNX+CIOiu76l0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmpD+hFUgWStXEFWUupIuiXQK/scaHMki5kHGfv+iAJjaVuhKTTGjaLZD8/U+ENiUSMN1/dSa8st6rOp/4QEy/Gab7JB+P4kLbkXIpRdsNtZw9LrAwJH+fllLKSqfhL5CzLR8H0dzxLR/ZF6vzO4lI1fTG/T/ov0Nl1dQ2/9HaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1X1jcqzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9065C3277B;
	Thu,  4 Jul 2024 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720085335;
	bh=77clekpa8nlbta5kCQm7ekukTsxOEhNX+CIOiu76l0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1X1jcqzVerMqMm82oOjqERfADLqDeHn8StFAnn5416bYoANr0UNNZO79Td/XJoJhn
	 gTOIX9EDlsKcJTVh7aH/ZFtNahAA4nEbCNA9JmbYjDjTBidw7PuNAwT7jiy0V2KNMj
	 dF/yt2u3oc0yG4a00Zx6nJtiSUdiJ/HBKbPVoD+c=
Date: Thu, 4 Jul 2024 11:22:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: jfalempe@redhat.com, a.hindborg@samsung.com, airlied@gmail.com,
	alex.gaynor@gmail.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@redhat.com,
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, gary@garyguo.net,
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, tzimmermann@suse.de,
	wedsonaf@gmail.com
Subject: Re: [PATCH 4/4] drm/panic: Add a qr_code panic screen
Message-ID: <2024070407-pregnancy-hazing-add9@gregkh>
References: <20240703154309.426867-5-jfalempe@redhat.com>
 <20240704091109.1453809-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704091109.1453809-1-aliceryhl@google.com>

On Thu, Jul 04, 2024 at 09:11:09AM +0000, Alice Ryhl wrote:
> As long as the above requirements are satisfied, calling
> `drm_panic_qr_generate` should never cause memory unsafety, so this is
> an appropriate list of safety requirements.
> 
> (You also require that `data_len <= data_size`, but if this is violated
> you get a kernel panic which isn't a memory safety problem, so it does
> not need to be listed in the safety requirements.)

Panicing while trying to print out a panic message is not a good idea,
so enforcing this would be nice :)

thanks,

greg k-h

