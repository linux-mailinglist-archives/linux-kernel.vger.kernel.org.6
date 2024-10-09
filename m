Return-Path: <linux-kernel+bounces-356723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB279965B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05E51C2487F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7E18A959;
	Wed,  9 Oct 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m56B5u3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8182189520;
	Wed,  9 Oct 2024 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466888; cv=none; b=EjPGSeP1BnaDmsuVTkTnzh89e9TNi5oEsk5uHT9f7GKjq6J+tp/fU/E5b+ABCRuA0pMe9l8E7eR588dkt06klicgrQ4a5Uif/NgQEqwgVUYyxoww9jEEa0J47SGAsJbPv8ocaomKKXXRy1padbTBwOtQsvEml1mND8FyRqtMmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466888; c=relaxed/simple;
	bh=CWh34LibZXlyJNOO3srJJdsoa1wvoEYUnQ31EqCgTnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ1y2C92G4v62R4MqWLlz1NuIpSNVrl7MvM6oTnqZYt8ubK+JfMOspQKhrVUSgLliAN5tvFy2fwoiS4AJm8/b1fPqrAh/BhPPkDLgc3AobI+Hm2NDAvZcC2m/dnuSkm5gqVPWQHLuXpSOIDoCtVQgHb33z8J0VzqApVwFitS4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m56B5u3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B39C4CEC5;
	Wed,  9 Oct 2024 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728466888;
	bh=CWh34LibZXlyJNOO3srJJdsoa1wvoEYUnQ31EqCgTnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m56B5u3plVQIILtme8axsIxFzywwjtTvcDhJdLpO8cHKXNAlZVCn/QVeH0PFSGWFh
	 sjbL2xK3iXJfCmeuuHFRcxw0Y5jTmFOMUynFkSTF+ZitW+bDWENm5JWADKQ0U5qXDf
	 kotyRrAaxFDmurTb5esblLuHLr/UXQLQkslnmjqo=
Date: Wed, 9 Oct 2024 11:41:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Jonathan Kim <jonathankim@gctsemi.com>, Dean ahn <deanahn@gctsemi.com>,
	Won Kang <wonkang@gctsemi.com>, support@gctsemi.com,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [RFC] staging: gdm724x: Proposal to delete drivers gdmtty and
 gdmulte
Message-ID: <2024100910-smoky-condiment-2298@gregkh>
References: <f82fffbf-a983-4ab4-897b-b5a810426f04@gmail.com>
 <igi27iwrzg3ovgj3sym4gsi45timpkt4vkl5ss5dbftdzat6p4@ctxcjocvunpt>
 <78b521eb-4e89-4c01-8dfc-1fb990e6887d@gmail.com>
 <50020db0-3bad-41f5-8da3-c66bc0a90fe6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50020db0-3bad-41f5-8da3-c66bc0a90fe6@gmail.com>

On Sat, Sep 28, 2024 at 08:41:51AM +0200, Philipp Hortmann wrote:
> Dear Sirs,
> 
> Won Kang from gct contributed the driver gdm724x to the Linux kernel staging
> subsystem in 2013.
> 
> The following points let me propose to delete the driver:
> - This driver generates maintenance workload (for example  CVE)
> - The manufacturer is not interested and does not care as Emails or
> inquiries, to support or involved persons of gct, got unanswered.
> - Did not find a possibility to buy the chips.
> - Did not find minimal documentation on the web.
> - Did not find a device where it is build in and the user is able to install
> any Linux. Therefore it is not possible to do any testing of the driver from
> the community.
> - No blog entries about anyone using the gdmtty and gdmulte.
> - No response about usage of this drivers to the Email from April 2024
> https://lore.kernel.org/all/78b521eb-4e89-4c01-8dfc-1fb990e6887d@gmail.com/
> 
> Thanks for any response about your thoughts.

Sounds good, let's delete it, send me a patch and I'll be glad to take
it.

thanks,

greg k-h

