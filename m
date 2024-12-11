Return-Path: <linux-kernel+bounces-441072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE809EC905
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A356164ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D10236FA1;
	Wed, 11 Dec 2024 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHpV9tak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2D236F82;
	Wed, 11 Dec 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909137; cv=none; b=TlMDkcpQ2gxZrWLIuNn/TJVGQe7aSHV4ybYN+HyXjqi67CFkw7FMwtJwi3qwx+xgzYpKjqxfDxiTs9ZOr7iDgy3rb9z1/7k/Hn/1Sh+zuWvYw+v86ZeKc+0c2zBmEx8N50JVCbv0q5TUwj+KxdgtUjHFHUuwFYTpholLsJy5Q9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909137; c=relaxed/simple;
	bh=7Z6ZEz/7EY0QbTtmfvRdaK1H/XC8daw2re/LkqTNMyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G25A69vsK1jrUmzA7n0bZlTAoGegj1e2SgZEk44Ge8LKB21UhOfuijnrxGbcK9agVeWQjb5p7+bBdAn5hEJg+WecdXRqhYFFUH/wW5U5/WqllfZllk5GSmQMuwTB73bO2FdXq4CQv3wzyfS4k0QFdk6N6DRzDP5XuMOJxLaKbJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHpV9tak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B682C4CED2;
	Wed, 11 Dec 2024 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733909137;
	bh=7Z6ZEz/7EY0QbTtmfvRdaK1H/XC8daw2re/LkqTNMyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHpV9takOa+fL5xbGTVbtpbqxyTcYNlLXYBcxqEasHy499CJONYnhTCP17O45WI6s
	 mCOo8OtwxErUqju6gHsVDH2a0s/ZK8mhj6X7KOR+0u7PZ2Y/5yXGoy9wpzNX9Aq5RB
	 ZDElbHTvgix6ebIDYmhQKJ+nG0vKdOwfauwUzV42fH1ACAc/ZZOYX1TKzLnR358SzC
	 Xvx/R7fv2SXCz662cic+O+ojHIQ0V2k7KweByaHbYxxzJkFEsAQwIUEgjRoX/VhUIv
	 1Qa/elmU4UPG1r+jn6RXESAUXYzjH0RP2d0KgiaKQohVc7yDnbOsKaEYGweXX3ovie
	 wjWBgRMG9svmQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tLIyR-0000000048B-1ldU;
	Wed, 11 Dec 2024 10:25:40 +0100
Date: Wed, 11 Dec 2024 10:25:39 +0100
From: Johan Hovold <johan@kernel.org>
To: wojackbb@gmail.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2]USB: serial: option: add MediaTek T7XX compositions
 Add the MediaTek T7XX compositions:
Message-ID: <Z1lak9hPtRVrDTRO@hovoldconsulting.com>
References: <20241128022227.717101-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128022227.717101-1-wojackbb@gmail.com>

On Thu, Nov 28, 2024 at 10:22:27AM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>

Your commit message appears to have been corrupted. The first sentence
of the message has been merged with the commit summary (i.e. is included
in Subject):

	Add the MediaTek T7XX compositions:

> T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 74 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0e8d ProdID=7129 Rev= 0.01
> S:  Manufacturer=MediaTek Inc.
> S:  Product=USB DATA CARD

> -------------------------------
> | If Number | Function        |
> -------------------------------
> | 2         | USB AP Log Port |
> -------------------------------
> | 3         | USB AP GNSS Port|
> -------------------------------
> | 4         | USB AP META Port|
> -------------------------------
> | 5         | ADB port        |
> -------------------------------
> | 6         | USB MD AT Port  |
> ------------------------------
> | 7         | USB MD META Port|
> -------------------------------
> | 8         | USB NTZ Port    |
> -------------------------------
> | 9         | USB Debug port  |
> -------------------------------
> 
> Signed-off-by: Jack Wu <wojackbb@gmail.com>
> v2: add NCTRL and more description

Thanks for the v2.

Next time, please put the change log below the --- line so that it does
not included in the commit message when I apply the patch.

I fixed up the above when applying.

Johan

