Return-Path: <linux-kernel+bounces-277768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2072394A63B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6DE1F2105A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6F1DF681;
	Wed,  7 Aug 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFSKkPmJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E21B8EA8;
	Wed,  7 Aug 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027739; cv=none; b=TwegzNE++BEjVZssRH3HVATefFLwkx2zSVAnBW/d+K9M7uAEVKqDDI3uuaIw4ui5nEEglXpyOKGNoRmE1S/StNFE5lBrphJwzGcUpujU+3GSTzxNbcSt9rdgYRK7SsGuvOHggu/oBAWkDxDU4A1/FnczAEYsrQfIQdbZYhevM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027739; c=relaxed/simple;
	bh=0nJiNsMtRqtiZBkFoOne0DiY/XfVAZ4pWQwMn8S5eCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxjMnC1OIvU8NEFd9DfKVj3Y8ALvBry8vy1hFkAsyRVEu5UcJViz//aDKMkoAsks54YtA9tmJeg3MnCCfmD66q48wxFEsZ1bJZLCx6rksvfxI9m+HaPK0wGjmv3iICcth3YBUOZJYo6DuTczZDH1amHVs7jUnuhS/AMCPMboO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFSKkPmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C05CC32782;
	Wed,  7 Aug 2024 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723027738;
	bh=0nJiNsMtRqtiZBkFoOne0DiY/XfVAZ4pWQwMn8S5eCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFSKkPmJJ/qURXcxgl6DLV6isriSh8HL/ESfL+M3Nmh7ZqnLI8ECAotUeA5TuIyq9
	 g30E5eptVOqvfhq3Evxjh917Ihr9ocZ8mQzpZwpHNPtM6Wk+ZLI1xUih4xSbZDjRQO
	 kI7UmHG1/8EQTFmcXJ8vowsTJAmfHR2hx8OG2hNY=
Date: Wed, 7 Aug 2024 12:48:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fix for 6.11-rc2
Message-ID: <2024080749-corrode-displace-d9bd@gregkh>
References: <Zqzlq_8Cg8KnUwL_@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqzlq_8Cg8KnUwL_@hovoldconsulting.com>

On Fri, Aug 02, 2024 at 03:56:59PM +0200, Johan Hovold wrote:
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> 
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.11-rc2

Pulled and pushed out, thanks.

greg k-h

