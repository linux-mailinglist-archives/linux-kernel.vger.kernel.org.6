Return-Path: <linux-kernel+bounces-342058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D5C988A24
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00D8283533
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E51C2310;
	Fri, 27 Sep 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KeHZGXVP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF751C2307;
	Fri, 27 Sep 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727462200; cv=none; b=YZIBgKCBc1nU4LqSW+HnkEs900Brr7hNUWZiZ0ZsxWzDS1CgOSXR0MsxivTZ5ZD7/4/0a2Ehxe86SVefi7eaO4wGV9t/mXjZJa+po9aUoESSl8+8zmmPp/Qq5U9/O5rwZCZWpHFprUagFJXEd3wPebwAkd8Ul+AK+SKn19V7Xog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727462200; c=relaxed/simple;
	bh=1/nGFk1XtOGiLs9Yx/+m4a662aaPTQUFpsaQUB6rEng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrhHPEHOG/6X3y0i9PlbYRmYLBbBNix0wk7gdywT5YIT3KImpFbPtWtAxhHBZBAgbhgRRqa6LzjDolKnfiQUe/7DaClWM+MA6YSceF2Tro57AOFGbzMntoex/lEa5Zn6LRQm1LSSIwo2m4h+0dulvWUgioDaJ7nqKIZiikOCLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KeHZGXVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA26EC4CEC9;
	Fri, 27 Sep 2024 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727462199;
	bh=1/nGFk1XtOGiLs9Yx/+m4a662aaPTQUFpsaQUB6rEng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeHZGXVP2vSBXlItY7xAGSnQbMSKgX/FPU2l0dicMbRa0reLvWFdaE/sZ96sK/I4N
	 KZJTjZquP8fnyytl9oMYErLrI8FMEk4iJzHJaH7lkXMVqlMV3jF776wTjyvwDp9Hrt
	 QSPtT8q2x6T43GuQOtpl7inEsRfz0f7Da2lbtik0=
Date: Fri, 27 Sep 2024 20:36:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xingquan Liu <b1n@b1n.io>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix unnecessary parentheses warnings
Message-ID: <2024092735-domain-sharply-cfb2@gregkh>
References: <20240927151637.82772-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927151637.82772-1-b1n@b1n.io>

On Fri, Sep 27, 2024 at 11:16:36PM +0800, Xingquan Liu wrote:
> Fix all unnecessary parentheses warnings in checkpath.

That's not what this commit does at all.

> Signed-off-by: Xingquan Liu <b1n@b1n.io>
> ---
> I ran clang-format additionally because I noticed the Linux community
> recommends submitting code formatting patches along with other patches.

No they do not at all, where was that written down, it needs to be
changed.

> I'm not sure if there are any issues with this.

so many issues, would you take a patch that did this?  (hint, I will
not...)

thanks,

greg k-h

