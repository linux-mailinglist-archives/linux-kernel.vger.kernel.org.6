Return-Path: <linux-kernel+bounces-191318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089098D09CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DFB1C22191
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1E15F3F4;
	Mon, 27 May 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDSEdTto"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5E61FDC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833728; cv=none; b=KqIWTlRF+5kEl1d2nX7Hki7tSozC3q0wz8ICtP/Nm8pXCBicKVrGMIsuSDj+rLcttSW+GzA6jWVoRh8oOoDxhWaJ4eKntzdW38u7xrOByWn1zJvCIDC0yMTAijOkj+jlKvKGbjtW3AWoxAsgAkAUQ01ioRCxW7LR/radf4n5zBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833728; c=relaxed/simple;
	bh=T0y8bXCJEZH+eS8ee7C5dR+fg3yTcWZMqPHkcbuqMW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oy6mx6zTP77v0FtsHk0xtXDVti8prGH2mrFLSp6GXceNbVGjzaDta0iHa0DV6JrCuTg/pfJvU0IYQvvpmnvmhTC4NGs5mL3zL7exGUo3pv8LA7IE+2jy7cl/e9OdqLC8FjkOMpRpl7+rVrelwio6BQqsrg/gC2+MmEVEdu6xkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDSEdTto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C150C2BBFC;
	Mon, 27 May 2024 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716833727;
	bh=T0y8bXCJEZH+eS8ee7C5dR+fg3yTcWZMqPHkcbuqMW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDSEdTtoC0S3ZJMeSMk9KPqlkAjTXi3rUcqk7rVmPAFLrL9j4WsjMaRbVFf90AmbS
	 Wokuzxh+lD9Eec8KaCegxqyAugiVia6qLVXeP+ZNK9OFb8yE8UV30o0VUp4SbPTjTk
	 sYHNDCVzX3MRsfZ4c615e2ava8rrOqUPfp3rlGag=
Date: Mon, 27 May 2024 20:15:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [stable 6.6, 6.8, 6.9] backport 2fd3ef1b9265
Message-ID: <2024052700-avatar-hardhead-1414@gregkh>
References: <CAK7LNAQo43-iUhhjKNPRJmh=SeMuZCX5=FK3BKemb0Oj9S2_CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQo43-iUhhjKNPRJmh=SeMuZCX5=FK3BKemb0Oj9S2_CA@mail.gmail.com>

On Mon, May 27, 2024 at 06:53:47PM +0900, Masahiro Yamada wrote:
> Hello Greg, Sasha,
> 
> 
> Do you have a plan to backport this commit?
> 
>  2fd3ef1b9265eda7f53b9506f1ebfb67eb6435a2
> 
>  selftests/ftrace: Fix BTFARG testcase to check fprobe is enabled correctly
> 
> 
> 
> It has a Fixes tag.

It also has a cc: stable@ tag, so yes, we will, give us a chance to
catch up :)

> So, maybe it is already caught by your raders.
> 
> If not, could you consider it for backporting?
> (to 6.6.y, 6.8,y and 6.9.y)
> 
> With my quick test, it fixed the kselftests/ftrace issue for me.

Great, I'll queue it up now, thanks.

greg k-h

