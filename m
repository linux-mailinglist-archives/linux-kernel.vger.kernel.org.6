Return-Path: <linux-kernel+bounces-521034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74CA3B2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F294E3AB77A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DB21C07F3;
	Wed, 19 Feb 2025 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbjp1PYO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A680101DE;
	Wed, 19 Feb 2025 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952038; cv=none; b=Hy0ynxZlAZqRB1OAln1r7eCwdDYFFZH5+uTt9GJkc0iZhvE2G/CklJc0h0LRwsjaErm4finB0xqkZAl1/qZI6F0BAfXQk617dgXWpnX3Ek5JI2jyL8H9f658lgVDSGNyUTgFm0xmTMqd0Xj203/8weYSaX4oXvzOxLqpbKGIuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952038; c=relaxed/simple;
	bh=4mcDkZDRYRLpL+KKvlRqof3jKTG0c70xlIDRxwonwLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oc3c/wxQzc4oxJqtpBTsAF72AhSzLceCXYEbtazSf3lbVb1IPsK3ZmsJ39gMGHt7Bf7PeuDcpOSLhM+ud9nW0CoJ3FsxKLPzMNq4hz5u3WovovESWCbdc+gPqMF1MfFf/tHHVg55i+Uzo+8wI0rhTq193qr/myZMm5x2YopMuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbjp1PYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA98C4CED1;
	Wed, 19 Feb 2025 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739952037;
	bh=4mcDkZDRYRLpL+KKvlRqof3jKTG0c70xlIDRxwonwLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lbjp1PYO7qONQrpnklGq1hCyFdfjpnUakQpnab9xmkJTyCGE86ZqVG1ZoIIqTxE87
	 tCcH8EV2TFm1DlcKOdEnPl3DTfoP64Ui4mLy7Q4JSAwuuST8+/EQ7AFYx3VPQsOWg1
	 yKa5R9xO/fpNUw/Z8zqwMkqvxO0RGa2XDNObwX+9Sod/YdnRpnxHBpbp/dSM42k2sX
	 0EcXKe5tcBlx1OmR1Tn28LK10y8PvgtNGwlmNb+d1CtAzpA3Y7axysB94YwjOgEqPl
	 OenUhC40/YxtR7Myra8DTQ7bhcC6QVBXMR2eTR2IF39271CQ/DQsF7JVq93WdHDdEB
	 RfbvEe2cJ7Dgg==
Date: Wed, 19 Feb 2025 09:00:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: remove an obscure logic from
 kernel-doc
Message-ID: <20250219090033.03a7b170@foz.lan>
In-Reply-To: <87wmdnm0kh.fsf@trenco.lwn.net>
References: <fd3b28dec36ba1668325d6770d4c4754414337fc.1739340170.git.mchehab+huawei@kernel.org>
	<87wmdt6bv5.fsf@trenco.lwn.net>
	<20250214032457.6444ee93@foz.lan>
	<87wmdnm0kh.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 18 Feb 2025 13:59:10 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > With regards to the Python transition, since our Makefile allows
> > switching to a different script since ever[1], I'm playing with 
> > the idea of sending a patch series with:
> >
> > Patch 1: 
> >   - drops Sphinx version check from both kerneldoc 
> >     (-sphinx-version parameter) and the corresponding Sphinx extension;
> >
> > patch 2: 
> >   - renames kerneldoc to kerneldoc.pl
> >   - creates a symlink:
> > 	kerneldoc.pl -> kerneldoc
> >
> > patch 3:
> >   - adds kerneldoc.py:
> >
> > patch 4:
> >   - add info messages on both versions related to the transition,
> >     and instructions about using KERNELDOC=<script> makefile and ask
> >     people to report eventual regressions with new script.
> >
> > patch 5:
> >   - change kerneldoc symlink to point to kerneldoc.py
> >
> > We can then keep both for maybe one Kernel cycle and see how it goes,
> > stop accepting patches to the Perl version, in favor of doing the needed
> > changes at the Python one.
> >
> > If everything goes well, we can remove the venerable Perl version on the 
> > upcoming merge window, and change the Sphinx extension to use the Python
> > classes directly instead of running an external executable code.
> >
> > What do you think?  
> 
> Seems like a fine plan in general.  I wonder if we might want to keep
> the old kernel-doc a bit longer just in case, but we can decide that as
> we go.

Yeah, I'm unsure about keeping the old kernel-doc or not. Anyway, I'll
send a patch series without dropping the old kernel-doc script. 

We can remove it when we feel it is time for it.

> 
> > I'm in doubt if I should split the Kernel classes for the Python version
> > into a scripts/lib/kdoc directory on this series or doing such change
> > only after we drop the Perl version.
> >
> > Keeping it on a single file helps to do more complex code adjustments 
> > on a single place, specially if we end renaming/shifting stuff[2].  
> 
> Do whatever makes it easiest for you at this point, I'd say.

Ok, I'm opting to split it on multiple files, on separate patches. This
way, it is easier to review/compare the new script with the old one, in
case someone wants to do that.

For now, I opted to keep the two output classes (for rest and man output),
plus a base class used by both altogether. We may split it further in the
future, as needed.

With that, the final patchset will contain those files:

scripts/kernel-doc.py		- Command line tool
scripts/lib/kdoc/kdoc_re.py     - Regex ancillary classes
scripts/lib/kdoc/kdoc_parser.py - kernel-doc single file parser
scripts/lib/kdoc/kdoc_output.py - output classes
scripts/lib/kdoc/kdoc_files.py  - kernel-doc dispatcher for multiple 
				  files, providing a glue between the
				  parser and the output classes.

Please notice that the new tool can now parse multiple files at the
same time. For instance, if you want to generate a ReST file with
everything inside the Kernel tree, you could run:

	./scripts/kernel-doc.py .

(on my machine, this takes about 1 minute to run)

Such extra functionality is given by the class inside kdoc_files.py.

> > On a separate but related issue, perhaps we should start talking about
> > coding style. We don't have anything defined at the Kernel, and
> > different scripts follow different conventions (or most likely
> > don't follow any convention at all). We should probably think having 
> > something defined in the future.  
> 
> I've generally tried to stick to something that looks as close to the C
> coding style as possible.  Formalizing that might not be a bad idea at
> all.

Ok, I'll prepare something in the future to formalize a coding style.

For now, I'll add a .pylintrc file just to include the scripts/lib/*
directories we're currently using.

Thanks,
Mauro

