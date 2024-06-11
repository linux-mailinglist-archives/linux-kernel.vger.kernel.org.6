Return-Path: <linux-kernel+bounces-209335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E849032EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1D81F2662B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8D171E4F;
	Tue, 11 Jun 2024 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQ9Kz/5e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC417167F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088283; cv=none; b=kWkmWQt9IuIrO0mCp3XQ8PhiPPSltSuGaXFvsdUTNrK47V+rF/or08FsLeCeGar4kS+udrzdHKAUB1cecsc/6X61PYS6OFS4UPpi7RHn+y1PrXiqNDS3FkX+zqxXFpCqvb/oTcA2AVxHMg273hi1eepAfjgilyDHWB73iQJwiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088283; c=relaxed/simple;
	bh=o2we8r9Ahksrb3sGmQK18levJUOeWOO/po6c1cqIDXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cev8EtelERTNV9SbMgsWlFg7Oi3UrcCXY1Bi3hxaSxy49xY35b7AyshvFTZ2k6lurmJoomVI2A1nJ68pRlRCdS/v5eATZtnqRXPbojH5g9Ebf7U3vKnZubgCe4xiIrBEMGTsAxRSUWEnfkz9z4OLuqRwW9BWKuEAPtC04OvaQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQ9Kz/5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77BBC2BD10;
	Tue, 11 Jun 2024 06:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718088283;
	bh=o2we8r9Ahksrb3sGmQK18levJUOeWOO/po6c1cqIDXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQ9Kz/5exOpmFjVURe5pJhN1XQ3w2cU1BpuNHlHQU6dngLWGxWZR8m8kaV6KPzm1I
	 k94i9haO/aF4cbFOY/SShbBhICkfspBL1BBCc6aQ6puBcxLn3j1k9I64gG2wsHnH5z
	 5hqNUzspw951Is79YY0EgUwa8dJ8kskZPSQ3Hlwc=
Date: Tue, 11 Jun 2024 08:44:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
	danny@kdrag0n.dev, mic@digikod.net, linux-kernel@vger.kernel.org,
	joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
Message-ID: <2024061159-armless-conductor-3cd1@gregkh>
References: <20230601075333.14021-1-ihuguet@redhat.com>
 <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net>
 <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
 <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
 <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
 <20240603121853.GA19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603121853.GA19897@nvidia.com>

On Mon, Jun 03, 2024 at 09:18:53AM -0300, Jason Gunthorpe wrote:
> On Sun, Jun 02, 2024 at 05:30:51PM +0200, Mateusz Guzik wrote:
> 
> > As is I think the config mostly gets in the way and most people have a
> > setup which does not use it (for example my vim does not). Alternatively
> > maye it is neovim which is overzalous here and other editors don't treat
> > the entire file. If there is a way to convince the thing to only tend to
> > whitespace issues in edited lines that would be great.
> 
> Yes, I think that is quite overzealous, I'd view it as a vim issue.

What?  No, vim is doing exactly what it is asked for here, it "trims all
whitespace" when saving the file.

I too just ran into this today, and it's a pain.  This needs to be
fixed, sorry.

greg k-h

