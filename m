Return-Path: <linux-kernel+bounces-247617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EAB92D1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDFDB25582
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6C1922D0;
	Wed, 10 Jul 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVEugl14"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14421E4AF;
	Wed, 10 Jul 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615967; cv=none; b=lk6og6os23zFwEJoOlpvpKfKqBJvnyM8IvuclVTEAxx7rrDP9ZRGkfPcy4566bYMcdynC/9VrAvQIH2foI7G5kQUOC4jarMcu5LF6jvT1QgCfgUYMsHzAPYPtaILwvQd0H6oej5CEmC99NboKY78Eo7R2uEdRs+Ep0y09wwtHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615967; c=relaxed/simple;
	bh=p5q5TLsWHcIM6y8JrIJcnyuApQufaQ+cFxvzYcEXVvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS7TraFig6ck0kOoF+J0kLknP30BRwuMKYRxavUPVHU1tDgeQGJVUR6WAYMoQHF7WEUVRxPXZwBA/Z0FvIP2fhmaG6RWBe+Zl/MI8Qf9uMDFv3HdAkAw6k7lZHDTgtEayaRtKMprKs7XYGzu8g3UHd5Iz82Mwb8Iw85d89J095Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVEugl14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF83AC32781;
	Wed, 10 Jul 2024 12:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720615967;
	bh=p5q5TLsWHcIM6y8JrIJcnyuApQufaQ+cFxvzYcEXVvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVEugl14Z5E3gEmEtdZjLR8QP38vInKvQ/Sj31RRAO355Hc5sAOuZHKFHctxgLJ3z
	 w31TNMCkmYByNXQr2A3Uk3INxgCn2JX9qnrMtdvNL9XK9HGvX90qDZv4n0W9TqXR+1
	 pYxB9/01Z1Z1LbUCTvI1OjOu6Fr25H1oINKMVoBc=
Date: Wed, 10 Jul 2024 14:52:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] staging: rtl8723bs: Remove unused macros starting
 with hal_com_h2c.h
Message-ID: <2024071053-headdress-spiritual-4b23@gregkh>
References: <cover.1720245061.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720245061.git.philipp.g.hortmann@gmail.com>

On Sun, Jul 07, 2024 at 08:51:54AM +0200, Philipp Hortmann wrote:
>  12 files changed, 4 insertions(+), 2310 deletions(-)

That's always a nice diffstat to apply, great work!

greg k-h

