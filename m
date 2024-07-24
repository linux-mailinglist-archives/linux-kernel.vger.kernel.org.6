Return-Path: <linux-kernel+bounces-260701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4293AD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F9A1C21BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F156A325;
	Wed, 24 Jul 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uSjUcsiZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A699210FB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806307; cv=none; b=cdLUqk/tftZXfrBx/b+qLXkivJD+Ns5Q4IhevfawfHWGmBjktM+5GT2erCoPyykMG1SFtTmYUqc39BvdJlrlEMP5qurN9ZJHq95cgjeOAWNBJMvwOR2M+AE8Kvja7Y8Ll1jPOQ/0CrkDpVDw3AfviookLIsCpH1nYdX5fiwYa+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806307; c=relaxed/simple;
	bh=yHKa1eRub2GSiZcpo2SlLqTVD/HmobTEfgkejUhS7P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OndqOdbVIX8Qx5fckriaLdk37ZHFKaEbfNVoZZygsxsEZUVq7bag3CFU6lcxq2F4Ydc0SL+uS9bIcT+19RhSDamldb5q8clRgOqtUqM9dJbRmfrHzHsnniKw7TQuyiuE+Jd7uOdkuZK/d4mlxIaaWXBBvgpZkuJRKRIfWIxcIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uSjUcsiZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from ideasonboard.com (unknown [IPv6:2001:b07:5d2e:52c9:24bf:30c5:c4f3:c9fe])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 139FE4CD;
	Wed, 24 Jul 2024 09:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721806255;
	bh=yHKa1eRub2GSiZcpo2SlLqTVD/HmobTEfgkejUhS7P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSjUcsiZbePndggffUeRAySBOn7FdtRSa3jOZM758phh+i1ccRfz3MBEfwRI26IXo
	 D4TxmuXDgPgoB+vOqwWczSsq8cdc0bWs4RoFE+15uwx+qecMcl5tzL7vJqIGHgCV+1
	 fRJfBgNsKcXGVocqWuZ2KvNMMBBBGkfXzE9GfjgI=
Date: Wed, 24 Jul 2024 09:31:34 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Robert Mader <robert.mader@collabora.com>
Cc: linux-kernel@vger.kernel.org, jacopo@jmondi.org, 
	sakari.ailus@linux.intel.com, javierm@redhat.com
Subject: Re: [PATCH] media: i2c: imx355: Parse and register properties
Message-ID: <4rkbs3adnnxalbi237u5anydgm326nvu2ztgiyzufpl6r23vc5@d345nvc4zdqc>
References: <20240723185856.92814-1-robert.mader@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240723185856.92814-1-robert.mader@collabora.com>

Hi Robert

On Tue, Jul 23, 2024 at 08:58:56PM GMT, Robert Mader wrote:
> Analogous to e.g. the imx219. This enables propagating
> V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera

and V4L2_CID_CAMERA_ORIENTATION

> can detect the correct rotation from the device tree
> and propagate it further to e.g. Pipewire.

Well, yes, that's a consequence. As long as Linux is concerned, this
serves to register the two above mentioned controls.

>
> Signed-off-by: Robert Mader <robert.mader@collabora.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

> ---
>  drivers/media/i2c/imx355.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
> index 7e9c2f65fa08..0dd25eeea60b 100644
> --- a/drivers/media/i2c/imx355.c
> +++ b/drivers/media/i2c/imx355.c
> @@ -1520,6 +1520,7 @@ static const struct v4l2_subdev_internal_ops imx355_internal_ops = {
>  static int imx355_init_controls(struct imx355 *imx355)
>  {
>  	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
> +	struct v4l2_fwnode_device_properties props;
>  	struct v4l2_ctrl_handler *ctrl_hdlr;
>  	s64 exposure_max;
>  	s64 vblank_def;
> @@ -1531,7 +1532,7 @@ static int imx355_init_controls(struct imx355 *imx355)
>  	int ret;
>
>  	ctrl_hdlr = &imx355->ctrl_handler;
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 12);
>  	if (ret)
>  		return ret;
>
> @@ -1603,6 +1604,15 @@ static int imx355_init_controls(struct imx355 *imx355)
>  		goto error;
>  	}
>
> +	ret = v4l2_fwnode_device_parse(&client->dev, &props);
> +	if (ret)
> +		goto error;
> +
> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx355_ctrl_ops,
> +					      &props);
> +	if (ret)
> +		goto error;
> +
>  	imx355->sd.ctrl_handler = ctrl_hdlr;
>
>  	return 0;
> --
> 2.45.2
>

