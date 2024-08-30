Return-Path: <linux-kernel+bounces-308887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0A966328
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84106284B28
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA741AD5D9;
	Fri, 30 Aug 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eAjBb2mP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC6172BD0;
	Fri, 30 Aug 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025312; cv=none; b=Hl4+Bnz08M7txaM28DFmZGxgvOM57NiLK2yRTXl23N5CfaG49ZircLZI8ZPSZJ4XWjoWnKicIHxbS1bmFBCrkCjuFZlyueeehNUcZ+G6PSV0frD93ObpN9gXeAfGY+GUvrTRtkG+x4rEmUHqs67LXjhLc9NBghNwhR6+JpCaBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025312; c=relaxed/simple;
	bh=eBsk9donIFES/588+C2tpjtwZv2B5kjYDRTmdbqZx34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0mPpG1e0Ftcoy8fV+/lNFleXK3X/6teykT8noGdgaGkVTUQzC50/MbyjAqjc1LwOK8QYhifCU4OoNKENSxBJN8eIJsniDiwIU2egfnoOO40xFZZXvwGIN1L1pGDcUcv8XOm/hHVJjURnkQOvCzZhVuF4UrsMkKuB0Y//BPPKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eAjBb2mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC484C4CEC2;
	Fri, 30 Aug 2024 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725025312;
	bh=eBsk9donIFES/588+C2tpjtwZv2B5kjYDRTmdbqZx34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAjBb2mPsdKWgWQkFDddEhnsl3E7+uYKD0TvSFiYmRk6gJyUMqYnmSo2eAbobIvd5
	 JWOYozhqcRY5ZN3yrPdlNtE85afuxyey2ybO4UoOnWd4szwq3rTj82ZhwU76iC2UZr
	 s30EcBPnQjdMhWgTHvvU6DHK2QI+XiJnDPUqCXH8=
Date: Fri, 30 Aug 2024 15:41:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device id for 6.11-rc6
Message-ID: <2024083040-delicate-gains-1fc8@gregkh>
References: <ZtHEVr1H6wJqihQT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtHEVr1H6wJqihQT@hovoldconsulting.com>

On Fri, Aug 30, 2024 at 03:08:38PM +0200, Johan Hovold wrote:
> The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:
> 
>   Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.11-rc6
> 
> for you to fetch changes up to 9a471de516c35219d1722c13367191ce1f120fe9:
> 
>   USB: serial: option: add MeiG Smart SRM825L (2024-08-27 08:47:29 +0200)

Pulled and pushed out, thanks.

greg k-h

