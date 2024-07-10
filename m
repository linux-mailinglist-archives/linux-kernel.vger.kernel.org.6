Return-Path: <linux-kernel+bounces-247546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144F92D105
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9951D1F24610
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C941190688;
	Wed, 10 Jul 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mjm0Ft4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61FB18FA39;
	Wed, 10 Jul 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612307; cv=none; b=BYuNgbG8oI4rdrZ/Bq7k4fXdsIThUYMplUgPXL/4KO45wnxSybR2P7scglZPMnoQlmNPidE8vgYArjpkvgR6bfHYvlwVDqnxtxq8cmkKjYxcT172iV92JlnXF4L5vA2pV1MhvX4W53oJpqRZQas+ZMCU8SyAJnAXN0QhuxdIZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612307; c=relaxed/simple;
	bh=+8Hn6GirerIMLeoeogts/cGCrU1jbWtvtugPsuhHr8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGiqygYyCLO137luLYGTR6nHjxqjoxvpwezy6QbZevcLNua1sIW0KbfXewqVjQsgNXElzpkvMOKod6xlKCnxBDmzzePaUhq1o7UHzRc6UIyXws3frtl8qRCBxj3qqRPOSpLGc/IOlIK1BDj/TGXQqIK3oQP+JKrvVmKvLUmpbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mjm0Ft4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926EBC32781;
	Wed, 10 Jul 2024 11:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720612307;
	bh=+8Hn6GirerIMLeoeogts/cGCrU1jbWtvtugPsuhHr8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjm0Ft4jZI39dqIpTr6DOyr1YfcrZd+bvWZvDz07VCTPvnit+IvmONgtvltSco4nR
	 SX4UlRX2si4Xz1ipLGKhC4FY/lV1OvD+MJNQeYxn6bapyyEvMD3BP7HigJitmRrrAv
	 0Xmj4H52NNyK6kQnjDFCEfUvgYvvBb8/aFzBd3TQ=
Date: Wed, 10 Jul 2024 13:51:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Akash Kumar <quic_akakum@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
	Jack Pham <quic_jackp@quicinc.com>, kernel@quicinc.com,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Add H264 frame format support
Message-ID: <2024071054-anatomist-purchase-1e98@gregkh>
References: <20240708041328.1942-1-quic_akakum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708041328.1942-1-quic_akakum@quicinc.com>

On Mon, Jul 08, 2024 at 09:43:28AM +0530, Akash Kumar wrote:
> Add support for framebased frame format which can be used to support
> multiple formats like H264 or H265 other than mjpeg and YUV frames.
> 
> Framebased format is set to H264 by default, which can be updated to
> other formats by updating the GUID through guid configfs attribute.
> 
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
> ---
>  drivers/usb/gadget/function/uvc_configfs.c | 570 ++++++++++++++++++---
>  drivers/usb/gadget/function/uvc_configfs.h |  34 +-
>  drivers/usb/gadget/function/uvc_v4l2.c     |  80 ++-
>  include/uapi/linux/usb/video.h             |  62 +++
>  4 files changed, 638 insertions(+), 108 deletions(-)

DOn't you need to add the new configfs entries to Documentation/ABI/?

And how is anyone going to know about this new api or format if there
are not new files?  WHere is it now documented?

thanks,

greg k-h

