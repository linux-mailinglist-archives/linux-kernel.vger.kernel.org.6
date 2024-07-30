Return-Path: <linux-kernel+bounces-266636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E3B9403F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167DA2832A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5EFC08;
	Tue, 30 Jul 2024 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo8dUKpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04070CA6B;
	Tue, 30 Jul 2024 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722303814; cv=none; b=H1pSw2rtB9KRm2aURl3hLTQZTBEVz7Fb+jNnPpHQFKs2RugFaZRA+Z43s/vLAUGotbbf16R2hpOPkQ1Uec1NEWEMcP0wksMFZ2Iqt+3n1lzTfP1OR3etG9g3ua9Ntc4G/CljLOmZPWPi4c01rM2Wx2dSA6i9omqBVV644FG5KEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722303814; c=relaxed/simple;
	bh=AgSFgQ0//kz0E9n05CsuDbftyGjPr0ELi/qTKAqKnXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btUSAQZNmPHK95cowiAWVa/65VLtTzdnD/vQp2Yd9c6sikKSvs1tocUugx7Dq75BijnCOFKQpgHa0sJgLci7x3wxae/BvCsI5cztCg+92xZcKqIuf0Fa45tKwDL4sJYUjrR6MLF+9jh9hUdSd7w+VxiPkCPxGDqusVu1bVQk/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo8dUKpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235C7C32786;
	Tue, 30 Jul 2024 01:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722303813;
	bh=AgSFgQ0//kz0E9n05CsuDbftyGjPr0ELi/qTKAqKnXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uo8dUKpmuzO9+avDGlMhp7fUL/YZtchZEQknDFtqFZyVCgguXQuQnaCl5MFAT8Bzm
	 NOfD3gY8tDMikY+uR5sT3uLAlEVcZAdoVBPAxka/XW7vNB5lCuSzGNcVry2EEYqPS9
	 3MtNcVW7WafzBAQGjg6UmjHAQ9koRyqY94AKd6XuBhIvP2mPee9YOrAeSgOqQRDHyn
	 7WdEGZ2mAzkTRsApAzHDkPG9+jPUnkJ5IJW2dC5QCTQD1A9idRZjKSvwn0GaNGW8sc
	 IStnhL9HBijFfcy3ZVcx9iQnvSxPmtb9mlfyE0FEm3cs7qFkTwurXS+Qfc8XdcRT4T
	 pws7B6nJou13Q==
Date: Mon, 29 Jul 2024 18:43:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip:x86/microcode 1/1]
 arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is
 used uninitialized whenever 'if' condition is false
Message-ID: <20240730014331.GB685493@thelio-3990X>
References: <202407291815.gJBST0P3-lkp@intel.com>
 <20240729112614.GBZqd8Vu27mFVSHynA@fat_crate.local>
 <20240729153008.GA685493@thelio-3990X>
 <20240729165036.GGZqfIXNZLA7l5zyRH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729165036.GGZqfIXNZLA7l5zyRH@fat_crate.local>

On Mon, Jul 29, 2024 at 06:50:36PM +0200, Borislav Petkov wrote:
> On Mon, Jul 29, 2024 at 08:30:08AM -0700, Nathan Chancellor wrote:
> > It's not behind W=1, this happens in a normal build:
> 
> "reproduce (this is a W=1 build):"
> 
> I guess that mail formulation is misleading.

Yeah, I can definitely see how that can be misleading. It might be nice
if the robot could do a regular and a W=1 build at the same time to
report which warnings show up at which levels. For the record/future,
-Wsometimes-uninitialized and -Wuninitialized from clang should always
appear in a normal build; if they don't, that's a bug.

> Ok, lemme fix that then.

Thanks a lot :)

Cheers,
Nathan

