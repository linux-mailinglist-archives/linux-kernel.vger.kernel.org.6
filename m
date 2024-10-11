Return-Path: <linux-kernel+bounces-360970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9D99A1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03581B22557
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE1F213EC9;
	Fri, 11 Oct 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="sWAOpsU8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD475210C3B;
	Fri, 11 Oct 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643540; cv=none; b=az7e2xVX8PLiqJPF3N1jFxlsFPPlcbJKNxkLYxw/oSHpWgqE9lc7bl+i8Moc7HHUqfIsMq6Wn9skElnX8H2emrPJXNGJAV3r+jIH+ny8oo/AIjxLPNJ7uve85Ctpt9g/CQVeevs2/1TAP9zz3JjbzU29tbMlVTwT3hzWWPSZUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643540; c=relaxed/simple;
	bh=BeI2iALYbJAB5Qp8zFyL+V/LTnFHtUxuX3olrp6jT+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SslZdM4giEmiuoa5JLUSmXMi7CO31KWSjXaEI1cgcgmt7w/xZ+MagkywNa9Ed6OCCMFm6FmPwoyS8fiwjFWQOVC77VjCTXkmxvOBBRj2Jkl0TE7NYuWgxTrQCEtZndE/srH5A0Eme1In6FvrLuYST3VrRw24N5LGDQaPPlospac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=sWAOpsU8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728643528; x=1729248328; i=wahrenst@gmx.net;
	bh=8G26fOBQEgPqcyaPrnsd6OlzR2T5vuKSB+uJ8Zlg/kI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sWAOpsU8K0OArXpFBmjumG3Fn6EFf1F9T7PsqlQWRGtR/tUZLyGRX9UGn7rBMMKe
	 ADcSIEzDuBJHEgyBVG8BoxTNdIECGTtRXOclLsHd3IFxycum8bNS74VI9Hmk1CPhh
	 hthbOeFMr5Z1BBRq7bAzGpxnlG7kxy4+jFDP6ijgPK8Y8idHqYVF3hlQp8Fv48hbU
	 1HzZ1JIv43irgUjt9JlfMC6sOMUYDdLWXRC9fGB0RBbTkI0k0nNLTZUcNZT4hn+zb
	 XfdrjI33icjA5rdbL3swGeCb/Qu83472pQhshByGyD9zPddUWBAT5jT1Vtsdj/I2V
	 +dWmGHyVR6lf6SyBoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1tW4vJ21Af-00gNrP; Fri, 11
 Oct 2024 12:45:28 +0200
Message-ID: <b0074647-f730-4d94-a11c-ebec7f48b928@gmx.net>
Date: Fri, 11 Oct 2024 12:45:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] staging: vchiq_core: Properly log dev_err()
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 kernel-list@raspberrypi.com
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
 <20241011072210.494672-3-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241011072210.494672-3-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2tgjIbVmOZLooP4GBWwuecmgc/nUokZrNRELbIAabf9jnqwHGtz
 hyXiLe+CT71pmzUlLTI2/GZpzPNB0cx4G+iwRvtIfxC601vd/ltlSMFv1H05d+aXcGvl9vT
 dvLAy3mh+/CSnjvHrJCTtfGYiAECW1Knnh7+k5wKjWrMsj7PXyZMPs/Gp32fCuH3qSvUua3
 FyGoYjWS9ckkjuDwMJgbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p5A02gBJbZk=;RiAQQi+rC6N56Ce42fGhrDQ65zr
 AvejWXTVyVleG9FNoIK5/GDC3rVr1Zg3r+fWLTM4dYDvlagGVl1RIdJOD7mzvfkLM6NLh9HTn
 +6iWOq2NFDq5odpJXIncxs3QQHGsLrx2nSIk9+rzRzylqBhdBiz1Evp1FmsclNTdsS1G7JxQF
 bV2xQVcmu2pQqcWpvnwYZd4dMegVx2PRfNiEuttYAFSxHK8ElZ8T/fuGwjDJ7MPTjXyUu7GQK
 EyzpPz48S/VvTrSLYPVJtHRQszEdpUkLbLQIXyzQRePJbpvIarvFE42eiIkcH5eEllEEZcSze
 t76lfqZU9sjPPoT1TrRAaS1gIXnsMxfbHsr5Ns2Z3zX+L8QSb+HleAmlejTwg3VAHyvmEiBaX
 G6f3O5xILqccK92yCWbqNIVBK8/dO8kdWYFWbr8T07KR0QlUvLx2apCNIrxQHZxegsuwSTiN9
 sVcD37QLgZnpAFw01vEwR3nxRGYnfrLXbmy1RZwg6ygPVqV/th0RZBXCy9P5xaR1QPycJKubA
 EcBnzqCiyFNoSdrbD3owtDa6ju7HU5fAA0Nvugxz+5g1ZTYgK/sGWU7W0KqrtSAB9eb28yGks
 PUxkdhztaZn/6jVu82mPfA8DKcIMrffgDSpftwdUlxxb/gXpJ46B9wQtg40o9mhYD5LfNFUbW
 BQ8kyjDMvmU0aQVbXtgK8pJY+9nCtVWClbv+BBoOm+F/+lFsCq8AdgHE5Wy3Hexncs/ZSUV3i
 ejjO1v39x8UebfR+4tCfI1b7Hg/ObFT9tl0tvNILBj//Q8AClU5fVeVBPgz90/X5EjK/HywSd
 btcoIS2pdrqrsGpm+sE03Ygg==

Hi Umang,

[add Raspberry Pi guys to the loop]

Am 11.10.24 um 09:22 schrieb Umang Jain:
> Properly log a dev_err() message when the msgid is not of
> VCHIQ_MSG_PADDING type. Drop 'oldmsgid' scoped variable and improve
> on the error string as well.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../vc04_services/interface/vchiq_arm/vchiq_core.c    | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cor=
e.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index e9b60dd8d419..1dca676186b6 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -1188,13 +1188,10 @@ queue_message_sync(struct vchiq_state *state, st=
ruct vchiq_service *service,
>   	header =3D (struct vchiq_header *)SLOT_DATA_FROM_INDEX(state,
>   		local->slot_sync);
>
> -	{
> -		int oldmsgid =3D header->msgid;
> -
> -		if (oldmsgid !=3D VCHIQ_MSGID_PADDING)
> -			dev_err(state->dev, "core: %d: qms - msgid %x, not PADDING\n",
> -				state->id, oldmsgid);
> -	}
> +	if (header->msgid !=3D VCHIQ_MSGID_PADDING)
> +		dev_err(state->dev,
> +			"core: %d: qms - msgid %x, is not a PADDING message\n",
> +			state->id, header->msgid);
I'm fine with this change, but the behavior looks strange to me.

Either this is a real error, I would expect the function would return
with something like EINVAL here or this should be a warning?

Sorry, no idea what's correct here.

Best regards
>
>   	dev_dbg(state->dev, "sync: %d: qms %s@%pK,%x (%d->%d)\n",
>   		state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,


