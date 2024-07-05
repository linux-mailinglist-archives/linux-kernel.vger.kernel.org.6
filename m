Return-Path: <linux-kernel+bounces-242184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF929284B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54FA287712
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87867146A72;
	Fri,  5 Jul 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndhbWdS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7B145FF9;
	Fri,  5 Jul 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170406; cv=none; b=FcfIn4ouMRTA/iE0k03bIKwgOEZsQNeYjGswANvYB2zyDfl2K4XNoFKvhUQat9cs93Yux20bUvriG/2Ag9eK+vEeZrNwukIeQ7IV7pMnNWdAZ7Vz0II3+kwfGoGq5g8meQ9IWqK31f8XWl5h5o62+tfNH9bWUG3PNITKzza6H8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170406; c=relaxed/simple;
	bh=n9zRIZadghj9Zw2cWL2aSpx+pK6cYMFtWAXRLv47UCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkOE/DSYIcMfKKdpxMCzR5Hr/IMT33/bQDm5j+tc6gAVBLJH3dvOKHr5SjFCD1mqoKbLJykP85uiUozD0Ql4e39c2A+jH7QTQ3FUcEgU/sabs0M0Unkxrq6EoBcRxdazQcIrUG8h2HbxBk3Fp5NSr/oet6NUjKHJzBGZMZH2yDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndhbWdS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA56C116B1;
	Fri,  5 Jul 2024 09:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720170406;
	bh=n9zRIZadghj9Zw2cWL2aSpx+pK6cYMFtWAXRLv47UCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndhbWdS3H19m/U4WuLLQev/lZy2c50WO2LwQJRamERTk+dB4mvDJ+37aOQzFuatxK
	 ssvBCKeh1uc4yjC9og1mR3mSRPT+9g+IqlNIa10kC50XkBZwFmbcTewyO2d0d7co8F
	 8YCrJ2x8RKdD9McU6tslmcOlMzdh4TWamUtCPE+B0H7QNE4vwUIF1AVgZ/QFxbfWUI
	 6oREkxt3ha3LlWzrRIS0rZKwlJr+SD/hxOLmIIlLp+8hV2/qSqVtaciKRhz9QNo1lr
	 e3OLx+3ZxSDYRGJlXcKJN+EI8gIpUtAlVaGM6VxY/tgC+mI4lRv5IWllpVRjFi+ZSg
	 z8+jSaT8U0jdg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sPeu0-000000006Bg-3dCd;
	Fri, 05 Jul 2024 11:06:48 +0200
Date: Fri, 5 Jul 2024 11:06:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add support for Foxconn T99W651
Message-ID: <Zoe3qBwWG33AZaU9@hovoldconsulting.com>
References: <20240705081709.105496-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705081709.105496-1-slark_xiao@163.com>

On Fri, Jul 05, 2024 at 04:17:09PM +0800, Slark Xiao wrote:
> T99W651 is a RNDIS based modem device. There are 3 serial ports
> need to be enumerated: Diag, NMEA and AT.

> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied, thanks.

Johan

