Return-Path: <linux-kernel+bounces-212641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA4906435
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8EA1F24B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2EE137774;
	Thu, 13 Jun 2024 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v2M4YfBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD69137761;
	Thu, 13 Jun 2024 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260702; cv=none; b=gIGIv4K/UX6nF13vU8tblAaP33eVdew/q/nrM3ltGagj5TLs/yWz/ZSCVjU6pIycrAHeAUaXAOpMmoaRkyqUIfPVQC1SlQA08eb87pdEO/S+vxzHvaDm1Sgk0W3td+6gKqmQ70jm8fOqWRqPj7j1TG3iWd1W/DzNFRN/rUaMogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260702; c=relaxed/simple;
	bh=m5NQR9vSNe9jt7EoYjpT9WHDiMr0ksjsMitObOWrQqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGlV6MFGmvJNu8e79B/r7brkuV9rQSRZUwG+8yXz8y4IX6vX5LPMEf04DziFUVL9az3MsczsTRXC/SHqyYsWI/7vMi6j9JznHRbFKOZtvtwOLdlJEVYm7eJ0qzLaDdMhoMoBRsGsmkkrsf+QYPRJu4oHKp0ESkm/VpaI4fbXmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v2M4YfBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7E2C2BBFC;
	Thu, 13 Jun 2024 06:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718260702;
	bh=m5NQR9vSNe9jt7EoYjpT9WHDiMr0ksjsMitObOWrQqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v2M4YfBtHQtTr2a5QFGMyOnfDx5boMbf3A8zQDJfXJbh+8B40y8+0KoJduOjRsN6D
	 1A/fJPCwbTKz3c7zeNF+nVBu6ImMIkLg7tmBoofIxdTV3ZfWo8+AMdm+06UUKrXQ2m
	 g/upZWtAnlxHwL0kz04j/gpUzmz4KaRJBizVpM6I=
Date: Thu, 13 Jun 2024 08:38:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Danny Lin <danny@kdrag0n.dev>,
	=?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2] .editorconfig: remove trim_trailing_whitespace option
Message-ID: <2024061340-chair-reliably-7b65@gregkh>
References: <2024061137-jawless-dipped-e789@gregkh>
 <877cetjrkh.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cetjrkh.fsf@intel.com>

On Thu, Jun 13, 2024 at 09:16:14AM +0300, Jani Nikula wrote:
> On Tue, 11 Jun 2024, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > Some editors (like the vim variants), when seeing "trim_whitespace"
> > decide to do just that for all of the whitespace in the file you are
> > saving, even if it is not on a line that you have modified.  This plays
> > havoc with diffs and is NOT something that should be intended.
> >
> > As the "only trim whitespace on modified files" is not part of the
> 
> Do you mean s/files/lines/?

Yes.  I'll edit this when I commit it as it's driving me crazy already
and I think it needs to get to Linus "soon" before we start to see lots
of busted patches sent to maintainers...

thanks,

greg k-h

