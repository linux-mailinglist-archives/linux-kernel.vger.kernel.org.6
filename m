Return-Path: <linux-kernel+bounces-325002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829FA9753CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB88CB29C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EBC19CC2D;
	Wed, 11 Sep 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RwRRnEs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196919CC0C;
	Wed, 11 Sep 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060777; cv=none; b=LSLIoLaZSK/XVLlDmfXtTp+J7yCtOlCLT50uo/eqPtZ/8pxxhSXpkStrymZmbZ7z+ywGswPUN1uGAImgKKlMKpIAgO1z+AzkRzxIQoRFRYECiRjk2WnhK31zkzuIotnPpHM6GU8cmH7wDiIryuXNF0G/062bC3f4/uVTXfWUX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060777; c=relaxed/simple;
	bh=bX9r+08NxpihP0erTf/RCd/3gq0LmmiIEQW2mECjgrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id5suQnN1R3WBBYBmm1MnQuNqiNi8BHrbMlwPd+wXYA+lmQe62uMAKi51a1zZbcKWh3ixuy/R70fT0axFyYCV5Wm8GnoO+d7U3gVwzIpe5k7If6SyOP+Bo52MbXEATrYQdCsb/NpTz9I9ov1d8+aCJMG9tMtNDkptkIRgK+EQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RwRRnEs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF313C4CEC5;
	Wed, 11 Sep 2024 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726060777;
	bh=bX9r+08NxpihP0erTf/RCd/3gq0LmmiIEQW2mECjgrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwRRnEs73l3ZLroLEGlaGCAkct6INTr1K/UfgglRRAwN1P8sAkYR11YofYXmRiKO1
	 WnzeU4sTto3+SmUqEXjKt0dLtsqt+dhxCA1yvj8X4vWTPKO8+AClhxS7HLYJfjcnDe
	 rjGtv06/Zy3+Y1sagp7m4HBZA7vagsqTYEe/lgJ0=
Date: Wed, 11 Sep 2024 15:19:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.12-rc1
Message-ID: <2024091127-comment-germproof-eca6@gregkh>
References: <ZuEzJgTKeD0RscpX@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuEzJgTKeD0RscpX@hovoldconsulting.com>

On Wed, Sep 11, 2024 at 08:05:26AM +0200, Johan Hovold wrote:
> The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:
> 
>   Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.12-rc1

Pulled and pushed out, thanks.

greg k-h

