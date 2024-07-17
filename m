Return-Path: <linux-kernel+bounces-255755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA29344B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14001C2160C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CF648CDD;
	Wed, 17 Jul 2024 22:22:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3441C6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254931; cv=none; b=FmoOkZeyTmvCUmgNkGjxGZ+ihZ3zt1Ag+UR6RZxfH1dMmREB3fY4wLgj+jQRgudHbbTo3amwkW19jdsEiOXsIHQi00GLePr3KTToKG4oW0SUSYBiMdfRJiNtEp2KyMdpBknZngXtKLb/2vw0vgCNcz8L5GtXSPjaz0ivRRu8o+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254931; c=relaxed/simple;
	bh=hT2CjsCd0ZMm0vXf7EP5+KWSv752HwtNJMgWTIAPx20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2FQ8Tkw2KKt/JS9C8eaPYOkrmoAIEojVqqOR/B+4P1toScHHjRJX4UoH9JvqfylddKRwo3huYF2sdAhgS0J6jhQlmY+CmtXdI3ZcwfLOkNwkdAyKnN96OFkQiTw5IWtsvthNtTVvl+Cp3tTh7mLHzz7l5QnUcA5rbK28kuid4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1sUD2A-00025O-J0; Thu, 18 Jul 2024 00:22:02 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1sUD2A-000JHN-56; Thu, 18 Jul 2024 00:22:02 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1sUD2A-002Fco-0A;
	Thu, 18 Jul 2024 00:22:02 +0200
Date: Thu, 18 Jul 2024 00:22:02 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Avichal Rakesh <arakesh@google.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: gadget: uvc: add g_parm and s_parm for frame
 interval
Message-ID: <ZphEChcy_ftCp86s@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
 <20240403-uvc_request_length_by_interval-v2-2-12690f7a2eff@pengutronix.de>
 <9ad8b7fc-2c5e-4b2e-ba8c-e956171c2893@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OlOZ4YsWels5DESd"
Content-Disposition: inline
In-Reply-To: <9ad8b7fc-2c5e-4b2e-ba8c-e956171c2893@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--OlOZ4YsWels5DESd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Avichal,

On Wed, Jun 26, 2024 at 11:30:58AM -0700, Avichal Rakesh wrote:
>On 6/22/24 4:48 PM, Michael Grzeschik wrote:
>> The uvc gadget driver is lacking the information which frame interval
>> was set by the host. We add this information by implementing the g_parm
>> and s_parm callbacks.
>
>This change requires the userspace application (uvc-gagdet equivalent)
>to call s/g_parm when the FPS negotiations are finished. This is fine,
>but we should document that in the commit message here so implementers
>know that something needs to be done to take advantage of the change.

Fair point! I will do that for v3.

>On a similar note, the reference uvc-gadget should also be updated to
>call the added functions (and apologies if you've already put up a
>patch for it, I was unable find one).

Since I am only working with gstreamer with the uvcsink nowadays I
missed that. The internal v4l2sink does already do everything right. But
you are absolutely right. I will send an patch for uvc-gadget.

Regards,
Michael

>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>> ---
>> v1 -> v2: -
>> ---
>>  drivers/usb/gadget/function/uvc.h      |  1 +
>>  drivers/usb/gadget/function/uvc_v4l2.c | 52 +++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/func=
tion/uvc.h
>> index cb35687b11e7e..d153bd9e35e31 100644
>> --- a/drivers/usb/gadget/function/uvc.h
>> +++ b/drivers/usb/gadget/function/uvc.h
>> @@ -97,6 +97,7 @@ struct uvc_video {
>>  	unsigned int width;
>>  	unsigned int height;
>>  	unsigned int imagesize;
>> +	unsigned int interval;
>>  	struct mutex mutex;	/* protects frame parameters */
>>
>>  	unsigned int uvc_num_requests;
>> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget=
/function/uvc_v4l2.c
>> index a024aecb76dc3..5b579ec1f5040 100644
>> --- a/drivers/usb/gadget/function/uvc_v4l2.c
>> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
>> @@ -307,6 +307,56 @@ uvc_v4l2_set_format(struct file *file, void *fh, st=
ruct v4l2_format *fmt)
>>  	return ret;
>>  }
>>
>> +static int uvc_v4l2_g_parm(struct file *file, void *fh,
>> +			    struct v4l2_streamparm *parm)
>> +{
>> +	struct video_device *vdev =3D video_devdata(file);
>> +	struct uvc_device *uvc =3D video_get_drvdata(vdev);
>> +	struct uvc_video *video =3D &uvc->video;
>> +	struct v4l2_fract timeperframe;
>> +
>> +	if (parm->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> +		return -EINVAL;
>> +
>> +	/* Return the actual frame period. */
>> +	timeperframe.numerator =3D video->interval;
>> +	timeperframe.denominator =3D 10000000;
>> +	v4l2_simplify_fraction(&timeperframe.numerator,
>> +		&timeperframe.denominator, 8, 333);
>> +
>> +	uvcg_dbg(&uvc->func, "Getting frame interval of %u/%u (%u)\n",
>> +		timeperframe.numerator, timeperframe.denominator,
>> +		video->interval);
>> +
>> +	parm->parm.output.timeperframe =3D timeperframe;
>> +	parm->parm.output.capability =3D V4L2_CAP_TIMEPERFRAME;
>> +
>> +	return 0;
>> +}
>> +
>> +static int uvc_v4l2_s_parm(struct file *file, void *fh,
>> +			    struct v4l2_streamparm *parm)
>> +{
>> +	struct video_device *vdev =3D video_devdata(file);
>> +	struct uvc_device *uvc =3D video_get_drvdata(vdev);
>> +	struct uvc_video *video =3D &uvc->video;
>> +	struct v4l2_fract timeperframe;
>> +
>> +	if (parm->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> +		return -EINVAL;
>> +
>> +	timeperframe =3D parm->parm.output.timeperframe;
>> +
>> +	video->interval =3D v4l2_fraction_to_interval(timeperframe.numerator,
>> +		timeperframe.denominator);
>> +
>> +	uvcg_dbg(&uvc->func, "Setting frame interval to %u/%u (%u)\n",
>> +		timeperframe.numerator, timeperframe.denominator,
>> +		video->interval);
>> +
>> +	return 0;
>> +}
>> +
>>  static int
>>  uvc_v4l2_enum_frameintervals(struct file *file, void *fh,
>>  		struct v4l2_frmivalenum *fival)
>> @@ -577,6 +627,8 @@ const struct v4l2_ioctl_ops uvc_v4l2_ioctl_ops =3D {
>>  	.vidioc_dqbuf =3D uvc_v4l2_dqbuf,
>>  	.vidioc_streamon =3D uvc_v4l2_streamon,
>>  	.vidioc_streamoff =3D uvc_v4l2_streamoff,
>> +	.vidioc_s_parm =3D uvc_v4l2_s_parm,
>> +	.vidioc_g_parm =3D uvc_v4l2_g_parm,
>>  	.vidioc_subscribe_event =3D uvc_v4l2_subscribe_event,
>>  	.vidioc_unsubscribe_event =3D uvc_v4l2_unsubscribe_event,
>>  	.vidioc_default =3D uvc_v4l2_ioctl_default,
>>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--OlOZ4YsWels5DESd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmaYRAkACgkQC+njFXoe
LGQGEw//QrjBsWAPagCpV/RN0pRPygEuYoGiXWzw/MbfT3bqNu76eVKdAelv9Fal
WM4pNl7hz6a+uoo3jOh+RnmLUyIH2X1Be/mVWRTM/C5y/MOcJ1Ns7p8X/gNkI+mx
z4oY5PYO95BzkP/flpjTrFpCRoWOyRfuWt55UL8ka/5qnoo7mTEMn3gyyuudtEH7
4wRO4kU9dTKKlqHLZ8han4wTmHuM5vpkN7Po+SN13SJSwT3WESgx7dP+R7Foi4st
nRK2Pws3zRPKLC5tL71PqaF3UoLrLcBx4zAESUkkZ9ETENrCCB7gIRpjEBHCmMVm
KIaArN+iFjGHFLbwTy6xS9lnSX5FRWl+B6H4Vy5P6AVbA64Ow3IPXuIyTR12+H0j
wPtqXBBdEu/mRIIHdutiUzgMzRZEwhZ1LxFToxpYb1h6FbfDodTKwK3BNpdRt0Ow
d5wclN1qHx5nF5Xy6/qVpldJv6EkYQr2A+lflHgOlEVmcXQtVSBEYNXWW0UPkdrN
y4V11THzTL5klrQkKPxvh5RBG0obAX8Y+YHWSpUGMR5QqK0R0pZpbKMxe7fT/pZD
7HKZk7eJR1jfzsf62Fxha3ZlvEc7hlZRIDEKlCF5xLTcB9eGQLp89f+O5A0GtAA4
DAJ18vkJvtifA/gLwx8JIMURs4QEXP5n9wzcQgyc3myq2xHZUuw=
=X3cz
-----END PGP SIGNATURE-----

--OlOZ4YsWels5DESd--

