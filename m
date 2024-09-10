Return-Path: <linux-kernel+bounces-323747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC49742DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0D31F250F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7371A4F3A;
	Tue, 10 Sep 2024 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="RidbVF29"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95397A945
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994649; cv=none; b=SXzv//gEpmemC5vzGtFQpnVS7aZFRdPkwsjleh0GIAtETOOvlLSaOHwETi/GLvOqQUCP3NzZp/xq/G08IBkDvoVcsBWDkRZja4L/zE3FSklsv7YFa+P5lEC/OnRwo7KgRg92R5LuejT5HbVvvniD5omaytjqnGuYqe9ONKn5dEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994649; c=relaxed/simple;
	bh=bZeq4Z0ebYhUDCoVLKa5FdvS8mzxM7LPMAKj+72Khq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwo8gogmodPElnB7Y4hopo6iQD13gQLoFHj1RolCn5HAtoY2I7GYGrsRV0iZiWDnEmB24MXw3RQQl3AGVakA331+JzGU0ZDu1bDQIZcBx55Zu1d6q0/a7A0zAIiu1/h7/Yc7kwDwSUvkIpzjVd/IRwhxN/Xu0OdescL4zFkiedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=RidbVF29; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4X3Ccc3Cd2zDqQb;
	Tue, 10 Sep 2024 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1725994640; bh=bZeq4Z0ebYhUDCoVLKa5FdvS8mzxM7LPMAKj+72Khq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RidbVF29rcddgvB1cUw8jtrfsKRJiSaaNnJf2ZwdwcaGShZfJUlSOpLs2OYkdHBSS
	 Y83L/a3wzynlNa1STRtO9KjLDRK8WNgdMEzhN4+ANvnC2RS1rEmiW7h0q/djNva5iX
	 7RG/yMG6DLH85BDbta5GLVPmEDbPSdPQqYt73V0g=
X-Riseup-User-ID: 16F9D23D34EC5F58F723AA569FAF8A047F08E4FE3B91D97D89884668576CD256
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4X3CcX1n6HzJtyM;
	Tue, 10 Sep 2024 18:57:16 +0000 (UTC)
Message-ID: <68da3932-10ab-4001-a978-f0f54034a64d@riseup.net>
Date: Tue, 10 Sep 2024 15:57:13 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Add myself as VKMS Maintainer
To: Louis Chauvet <louis.chauvet@bootlin.com>, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, sean@poorly.run
Cc: thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
 seanpaul@google.com
References: <20240910-vkms-maintainer-v1-1-e7a6c7a4ae71@bootlin.com>
Content-Language: en-US
From: Maira Canal <mairacanal@riseup.net>
In-Reply-To: <20240910-vkms-maintainer-v1-1-e7a6c7a4ae71@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/24 12:10, Louis Chauvet wrote:
> I've been actively working on VKMS to provide new features and
> participated in reviews and testing. To help Maìra with her work, add
> myself as co-maintainer of VKMS.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Acked-by: Maíra Canal <mairacanal@riseup.net>

Please, check the procedures to apply for commit rights in drm-misc and
apply it. This way you will be able to commit your patches.

Thanks for volunteering!

Best Regards,
- Maíra

> ---
> Hi everyone,
> 
> This series [1] has been waiting for a while now, it was proposed first in
> February. The first iterations had few reactions (thanks to Arthur, Pekka,
> Maìra, ...), but since v8 (in May) no major issues were reported, Maìra
> seemed satisfied, and only minor cosmetic changes were reported. Two other
> series ([2] and [3]), that I submitted first in May, did not have receive
> any reactions.
> 
> In addition, there is also some significant addition to VKMS being
> proposed, such as ConfigFS support, and without a clear maintainer having
> the time to review and approve these changes, these changes have very
> little changes to get in.
> 
> VKMS is not a fundamental driver for "normal" Linux users, but I had some
> feedback from userspace developpers that VKMS could be a very good testing
> tool if only it had more features (I think P0xx formats were asked to
> test HDR for example). This could also help to detect issues in DRM core
> by emulating a wide range of configurations.
> 
> I believe the only active maintainer is Maìra, but as she's mentioned before,
> she doesn't have much time to work on VKMS. So, I'd like to volunteer as a
> maintainer. I have plenty of time to dedicate to VKMS.
> 
> I hope I've gained enough understanding of VKMS to be helful with this role.
> I am eager to move forward and improve this subsystem. I've also talked to Sean
> about this, and he agrees that it would be good if I could commit code to
> drm-misc.
> 
> [1]: https://lore.kernel.org/all/20240809-yuv-v10-0-1a7c764166f7@bootlin.com/
> [2]: https://lore.kernel.org/all/20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com/
> [3]: https://lore.kernel.org/all/20240814-writeback_line_by_line-v2-0-36541c717569@bootlin.com/
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10430778c998b57944c1a6c5f07d676127e47faa..62f10356e11ab7fa9c8f79ba63b335eb6580d0a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7340,6 +7340,7 @@ DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
>   M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>   M:	Melissa Wen <melissa.srw@gmail.com>
>   M:	Maíra Canal <mairacanal@riseup.net>
> +M:	Louis Chauvet <louis.chauvet@bootlin.com>
>   R:	Haneen Mohammed <hamohammed.sa@gmail.com>
>   R:	Daniel Vetter <daniel@ffwll.ch>
>   L:	dri-devel@lists.freedesktop.org
> 
> ---
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> change-id: 20240910-vkms-maintainer-7b3d2210cc1b
> 
> Best regards,

