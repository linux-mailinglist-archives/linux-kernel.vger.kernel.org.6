Return-Path: <linux-kernel+bounces-248881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0492E31D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C544B273F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4515573B;
	Thu, 11 Jul 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/JewJdt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8792D02E;
	Thu, 11 Jul 2024 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688866; cv=none; b=HWICRV9A/vo52zvFNsxMkwHgdYGPfb0fZ2Wg215Ryoy6yRYhgxywO0TKLTr5Ml4DWW9GKTOk+pmIHCKbAdY0xPao9arJfcYKs4k2dxHQL7urhlAHa4ts4qDj283gW8fmv4XYRnUTfJXg6Z1eavI8waIaPVFAOtVf41i89q8+uB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688866; c=relaxed/simple;
	bh=Nbtdy1pOMs1Hscod8ce57LgV6ZcLf68E3FqIantW4ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMvNUBc0HZ5I9RNBsU+PJvpaH0NWK6AKHV/NNJCAELT9mUq+zjlWAx1ob0MYpEda7NgafTiv/x6OB1emLxvUosWltz5MedHm7aJzE6MOXhibGRPX4lqqvUMORDrA8S+vRdsJgjwnI3WzgE+PVKMiw5re1UA4K8nkbvv61vmCeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C/JewJdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D2AC116B1;
	Thu, 11 Jul 2024 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720688865;
	bh=Nbtdy1pOMs1Hscod8ce57LgV6ZcLf68E3FqIantW4ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/JewJdtKwHx2Ipm+t2CTeMB21DVhlSa2sKHpKiBeQxMOiFrMmoNIDUaEfnkOS04F
	 que1jSSGUpKGMOGXVKO771YZkrpb7pu/wMBL1AV71HTFrcQ/YH8iOhTE/rb25OQfR8
	 Qx5M4TSnCjAEUUPTW7Lm+f5IUOIG2j84Zo2VG6xo=
Date: Thu, 11 Jul 2024 11:07:42 +0200
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
Subject: Re: [PATCH v2] usb: gadget: uvc: Add H264 frame format support
Message-ID: <2024071126-napped-cobbler-4693@gregkh>
References: <20240711082304.1363-1-quic_akakum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711082304.1363-1-quic_akakum@quicinc.com>

On Thu, Jul 11, 2024 at 01:53:04PM +0530, Akash Kumar wrote:
> Add support for framebased frame format which can be used to support
> multiple formats like H264 or H265 other than mjpeg and YUV frames.
> 
> Framebased format is set to H264 by default, which can be updated to
> other formats by updating the GUID through guid configfs attribute.
> Using Different structures for all 3 formats as H264 has different
> structure than mjpeg and uncompressed which will be paased to
> frame make func based on active format instead of common frame
> structure, have updated all apis in driver accordingly.
> h264 is not recognized by hosts machine during enumeration
> with common frame structure, so we need to pass h264 frame
> structure separately.
> 
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
> ---
>  .../ABI/testing/configfs-usb-gadget-uvc       |  88 ++-
>  drivers/usb/gadget/function/uvc_configfs.c    | 570 +++++++++++++++---
>  drivers/usb/gadget/function/uvc_configfs.h    |  34 +-
>  drivers/usb/gadget/function/uvc_v4l2.c        |  80 ++-
>  include/uapi/linux/usb/video.h                |  62 ++
>  5 files changed, 714 insertions(+), 120 deletions(-)
> 
> Changes for v2:
> - Added H264 frame format Details in Documentation/ABI/
>   and new configsfs attribute path for mjpeg and
>   uncompresseed formats.
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> index 4feb692c4c1d..2580083cdcc5 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> @@ -224,13 +224,13 @@ Description:	Additional color matching descriptors
>  					  white
>  		========================  ======================================
>  
> -What:		/config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg
> -Date:		Dec 2014
> +What:		/config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg/name

You are changing an existing api, how will all existing code handle
this?  Will it not break?  What is ensuring that this will work as-is
ok?

> -#define UVCG_FRAME_ATTR(cname, aname, bits) \
> -static ssize_t uvcg_frame_##cname##_show(struct config_item *item, char *page)\
> +#define UVCG_FRAME_ATTR(cname, fname, bits) \
> +static ssize_t uvcg_frame_##fname##_##cname##_show(struct config_item *item, char *page)\
>  {									\
>  	struct uvcg_frame *f = to_uvcg_frame(item);			\
>  	struct f_uvc_opts *opts;					\
> @@ -1936,14 +1941,14 @@ static ssize_t uvcg_frame_##cname##_show(struct config_item *item, char *page)\
>  	opts = to_f_uvc_opts(opts_item);				\
>  									\
>  	mutex_lock(&opts->lock);					\
> -	result = sprintf(page, "%u\n", f->frame.cname);			\
> +	result = scnprintf(page, PAGE_SIZE, "%u\n", f->frame.fname.cname);\

sysfs_emit() is made for this.

thanks,

greg k-h

