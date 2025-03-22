Return-Path: <linux-kernel+bounces-572246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F72A6C830
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53DE46192E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90089198E8C;
	Sat, 22 Mar 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJDWgnOG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12202AF04
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742630665; cv=none; b=pe0c782EFOLLs3OoAXjGnFwX0zuo3ET4FuooAhZ67Dda7QyLnjKr6HT4phgTTOEgiecok1me/muwnHJyDEA9Hfpy3hwtpD7XaLQvJT4ruTrYYSTL1kY0oVAHPr9ishcmxHgltFNF/bZlfIqmeyHnub+RGD4i2cLIL2aiNyMzU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742630665; c=relaxed/simple;
	bh=VS372D8YXF4lFI5XBSp4Hy/qPdaRBi+3DN7mmyIgP0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6XYkh/FCRLHDCqBF/HWWUQOFqN3mwyRsDegZ/X5b3Dw9FrlvpoElwfZckfZ0hjOeE+hplf6/h/GkCAZcfzwGwk1Y+VgOYur/S0f0mtHpLgwfVNwmc6cLWc9qQ3MIVQWYS+dxSTq3KnOyj1Q4xtVcynNuJYiHD8Vp5SZ5th2QR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJDWgnOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E66C4CEDD;
	Sat, 22 Mar 2025 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742630664;
	bh=VS372D8YXF4lFI5XBSp4Hy/qPdaRBi+3DN7mmyIgP0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJDWgnOG5GeFJ1htESs7PkFg92n66kfjC0mSg6jV1TUXlJu9lcI5p+zBB63mksbNz
	 iKQZ1MYdfpzmgUIjPWzv8eICHv+iTm/1hHDeMtjOgrEryf/21Uv8OkwanvJv0EqRcC
	 ERvrUL+mpxcy+grxbuZ7xT0Gh+FbwfI2bDX+D+WDtY+1wyMihhda5nKwPDC8rspl32
	 Adj0b3v1yIBQJ6JGs6U1yVvRDb1ITFy6868FgQL25DvO1nz2WEBrVW3KVg6weArn5G
	 AoR7NFWOC/nBXPeuyYkoqXY/+ACxQ4Lg3/dWeQRjwE7G7WwCCWxc1ARHBFJYlO5cSx
	 gKIq0Q2nUVWhA==
Date: Sat, 22 Mar 2025 09:04:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>,
	Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: Re: commit 7ffb791423c7 breaks steam game
Message-ID: <Z95vAzzNOlXvZeJH@gmail.com>
References: <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <Z9vZYIbXOz2wF59j@gmail.com>
 <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>
 <Z90-VOyC5oanCC8z@gmail.com>
 <01414c31-82c8-4de7-920f-87020610580b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01414c31-82c8-4de7-920f-87020610580b@nvidia.com>


* Balbir Singh <balbirs@nvidia.com> wrote:

> > How frequently does this happen and what is the impact to users if 
> > this happens?
> 
> It happens a 100% of the time when the BAR space lies beyond the 
> 10TiB region.

And how frequently is the BAR space beyond the 10TiB region, on modern 
systems?

Thanks,

	Ingo

