Return-Path: <linux-kernel+bounces-399509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DE9C0001
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F094B214CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B91D7E50;
	Thu,  7 Nov 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AAXJaD3U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7D38FB0;
	Thu,  7 Nov 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968476; cv=none; b=Mlbbc/vEbz9Cbob3Vto3hz0UkdS6OvnJM5XwJO4wc/tPm5791aD6nUGcst7k018mHPh3nZ6C4R8nG+NAnWC+Q5O78h4ynI4PqwKxyujM3bW6TzuIZgN6FSmwgcZIhHO8uad6yJOx3K22M4JwxD37zpYku4OJ+qBRTlrNrd+027w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968476; c=relaxed/simple;
	bh=ekfKStdaRvxQJ8LnLOTxDNbCdjD/Ffnq9L/mjy1VY3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrqSRHxpXmR3FVtvjHfLt7OfhPr8F4hHMEqykLocTtHpV/xhGoGBiTCbWU7vHY1seJvGSbo6A+JN3QbOgNPTb+bM5h19ixjElnpQFYO0lwAQWHqn5PkbbgElZmrHgsvMgs6iddc0m/M3qz4Ql41SRaGI59sEJoi2+73BvwSHIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AAXJaD3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B21BC4CECC;
	Thu,  7 Nov 2024 08:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730968475;
	bh=ekfKStdaRvxQJ8LnLOTxDNbCdjD/Ffnq9L/mjy1VY3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAXJaD3UZ0pIe5Zb+H5PrAOqqYxl+hu6sVhz+/a5gLCVgRToujV+i7YZbM5Ne2n92
	 RoVevRrtY6vgO16does91zknKuqf7n5KmWhIjTNuK6rUSbFQr4SKQg2W0gDLgg0lYr
	 ZxWE9YwKZHxw2vlDeO75a2U6amknWfLro6LBf1LA=
Date: Thu, 7 Nov 2024 09:14:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Haowei Cheng(Harvey)" <harvey.cheng@fibocom.com>
Cc: "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI0=?= =?utf-8?Q?=3A?=
 0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch
Message-ID: <2024110705-manmade-nullify-b95b@gregkh>
References: <SEZPR02MB54953820B2A9EEBD807D0ED18E512@SEZPR02MB5495.apcprd02.prod.outlook.com>
 <2024110512-popcorn-germless-01be@gregkh>
 <SEZPR02MB5495A8637098B92CDEBBFC6C8E532@SEZPR02MB5495.apcprd02.prod.outlook.com>
 <2024110735-lunacy-salvation-684c@gregkh>
 <SEZPR02MB5495C6CAF78EC669F65CD6398E5C2@SEZPR02MB5495.apcprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR02MB5495C6CAF78EC669F65CD6398E5C2@SEZPR02MB5495.apcprd02.prod.outlook.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Nov 07, 2024 at 07:47:14AM +0000, Haowei Cheng(Harvey) wrote:
> Hi greg k-h,
>    We have configured the USB RNDIS port protocol by default on the product and conducted extensive stress testing and validation.

Where are the RNDIS stress testing and validation tests?  What host did
you use for this testing, Linux or Windows?

> This issue was discovered during compatibility verification, and after making clear modifications to the API usage,
> the issue has not been reproduced in subsequent tests.

I do not understand what you mean by this, sorry.

Again, you need to submit this patch properly if you wish to have it
applied...

thanks,

greg k-h

