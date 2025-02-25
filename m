Return-Path: <linux-kernel+bounces-530568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA955A43530
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D85718849B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A82257422;
	Tue, 25 Feb 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKiOLds6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB59256C92;
	Tue, 25 Feb 2025 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464822; cv=none; b=ZijAhxV3WhebL+yUsgn4vEBd/DzFq787NPY6QfmAg5vV3xvq+mfiDWB7+I0M23yEU49dsJE4nJjxt9wmIymSAR/ryrDiAFghG9aamke4zIzWnoN10uMQX9ynYYXacoULcgypSgSf2xlMn9W7fYxfMJNqYhd/RLewNH2bjgBrD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464822; c=relaxed/simple;
	bh=KN2IyK+4qxOMlogFBDhVp3us+v9KROEgmandKUYf3sY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCI5GGDKthvRcPXodP9tLXFukC7FKcSz3PoBjeGG9Kkm1CaYQUydMiw5oMX1aR/vEz35780wC9uDwYENq9UUJ87fHw7wi6Qaco7h+fYQcNZxjxR7Yfq5zUEEpQ6vz9JNGGjCxO5rSxImg26dvlxbtAeHDODvcD7TJP/4iXp/qFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKiOLds6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B80DC4CEDD;
	Tue, 25 Feb 2025 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740464822;
	bh=KN2IyK+4qxOMlogFBDhVp3us+v9KROEgmandKUYf3sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uKiOLds6ul53xwa+JklX5leCg+9+kK5Rzyxz1euYXG8EtPtqj/iLZorVW9o9kVpla
	 bGLy3D+JzZovqtQU7LYQaLFLYiITuFjrv3PgzG6pWyea7SneoyKASPPo5lYD9F7f4B
	 JT7MfKUnQiMqKYHBzdq7OVpjTpjgyy3Ihzpxy+vbCdxS6tu8tCJyNy4vMRUVgwGHKP
	 dKOTfcdkZyuzzmFTqJGlFiYGXf4sEeKBKk1HpR3uwOSMBLO4Jp/ngz2pWmtb/sM1y6
	 Gvy2np4Ir8hlSjwvK4VyQTIpoj9UnVYKKa6u8mRWdC8fHnH2CiOyk+HdfaLwo5jx8N
	 Fr7QfeUlD3c5w==
Date: Tue, 25 Feb 2025 07:26:58 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/39] scripts/kernel-doc: rename it to
 scripts/kernel-doc.pl
Message-ID: <20250225072658.38e0a200@foz.lan>
In-Reply-To: <874j0j2ahi.fsf@trenco.lwn.net>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
	<52d0e3a45dac63af3dfad23103cd4365fb12686c.1740387599.git.mchehab+huawei@kernel.org>
	<874j0j2ahi.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 24 Feb 2025 16:23:21 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > In preparation for deprecating scripts/kernel-doc in favor of a
> > new version written in Perl, rename it to scripts/kernel-doc.pl.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/{kernel-doc => kernel-doc.pl} | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename scripts/{kernel-doc => kernel-doc.pl} (100%)
> >
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc.pl
> > similarity index 100%
> > rename from scripts/kernel-doc
> > rename to scripts/kernel-doc.pl
> > -- 
> > 2.48.1  
> 
> A pretty tiny nit but ... this isn't bisectable.  I'm not sure how
> worried we are about that, but I thought I'd point it out.

I wrote this in separate to make the diff clear that this patch
just renames the script without any changes. This helps you to
review.

When applying it, I would merge this one with the next patch, to
prevent bisect issues.

Thanks,
Mauro

