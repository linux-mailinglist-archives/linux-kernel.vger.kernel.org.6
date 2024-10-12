Return-Path: <linux-kernel+bounces-361988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30299AFB1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638D4285DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BBB8C0B;
	Sat, 12 Oct 2024 00:37:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B528F7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728693470; cv=none; b=NVR3OG7sDHGZBZGb+vvz5PEdZkavX6qKoblWQvKwES8dTu3j6LS2N1kNJlP9StFK0Iv6ijcwxXC8WpHZd37IOrH0LUad5KC5T6xCl1DQFDtNnF4PxH62/sY98sW8H1BlLOZ/YEzrpMwB7TwgZS5Cob5OhVXUlZflgM6LESsmjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728693470; c=relaxed/simple;
	bh=akt+qiorfJW3uv2CvmhrDIxivhbD8aGkS8ruzDuVuFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk5YA97CeQZ7joZ/WovPnr7MDfggtiljfnrHb8tMM2pCyCso/Hc4PY4D61DQIbGKeHT8ltQ7nzU5RcgWJNK3pzBNSIU+un3yhCUqsIhyhc9dQb5KgFIpnCTOB+IARCMrYrE1qpfxC4+9l6lVZBTkZWQmOHlyie0unY8sKlbPc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D25E31650
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:38:16 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 076D43F5A1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:37:46 -0700 (PDT)
Date: Sat, 12 Oct 2024 01:37:40 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Shivam Chaudhary <cvam0000@gmail.com>, sudeep.holla@arm.com,
	lpieralisi@kernel.org, linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix typo in versatile.c
Message-ID: <ZwnE1Dk5HwjzryXq@e110455-lin.cambridge.arm.com>
References: <20241005085117.438715-1-cvam0000@gmail.com>
 <CACRpkdZF2UiaOxifOua=JP2Jjx-GcZyQ-yDd1DEm=KOqMciniw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZF2UiaOxifOua=JP2Jjx-GcZyQ-yDd1DEm=KOqMciniw@mail.gmail.com>

On Fri, Oct 11, 2024 at 09:32:42PM +0200, Linus Walleij wrote:
> On Sat, Oct 5, 2024 at 10:51 AM Shivam Chaudhary <cvam0000@gmail.com> wrote:
> 
> > Corrected minor typo in versatile.c
> > - Fixed "documentaton" to "documentation"
> >
> > Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> 
> I applied the patch to a branch with Versatile stuff, that I will
> send upstream whenever we have some more stuff to queue.

Many thanks, Linus!

Best regards,
Liviu

> 
> Yours,
> Linus Walleij

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

