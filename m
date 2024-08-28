Return-Path: <linux-kernel+bounces-305133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3E9629F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC69A284C93
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928D18991E;
	Wed, 28 Aug 2024 14:13:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13129185E6A;
	Wed, 28 Aug 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854431; cv=none; b=kQ6ipR9SFLwML/zWHYJ1F8wvaU6OiRJOaKzOR/OZx/J0fpGbapaiuLsnkFZdDPXV3EGGTIbWTDLcxqAsHdk/k5pKcF/pHnOriyh25uCTKtNN1Ng3+/egLBFCEVxiRr23qgg18W30947qCzsJtbukF/dc5HoQVbEZ2jQ1K4tGNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854431; c=relaxed/simple;
	bh=OocOkei8Zp4c4pu+D3/k/pc1FFm//F2m4L5mwnzrkh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBjsRKFxwhGipVOjNcWQXaxgMG2cZf0MpTG24LCuWqD7CQ4w2XqUAS7BadZ68ouW59+mFJp4St9KMwlqeaQklmyX8ALHS9/DI/LbDjqklrn1TZc+HC8GyW4HXCPceY9Q9AIzTb6k5yYKhXf4TRBHNtWITQQJoDWumZZxAOoieAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C0A6F1A2094;
	Wed, 28 Aug 2024 14:04:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 64D842002E;
	Wed, 28 Aug 2024 14:04:32 +0000 (UTC)
Message-ID: <e6f95527de2c0b93cf340d38944e85024edb6605.camel@perches.com>
Subject: Re: [PATCH 2/2] Documentation: admin-guide: direct people to bug
 trackers, if specified
From: Joe Perches <joe@perches.com>
To: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 28 Aug 2024 07:04:31 -0700
In-Reply-To: <20240815113450.3397499-2-jani.nikula@intel.com>
References: <20240815113450.3397499-1-jani.nikula@intel.com>
	 <20240815113450.3397499-2-jani.nikula@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 64D842002E
X-Stat-Signature: m3887h4jpa5urb63xos7wshe4x5a588x
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/8TLGUPBeVAnbVCieF+BdSqiG4gyyRFo4=
X-HE-Tag: 1724853872-890906
X-HE-Meta: U2FsdGVkX1/Q3+MXrnNBVeD4ttljiwWrgqv0b4ihs3etH42K/5di2EOObLHoTa/Z3sWCip2QTj19ViT9W5GVB89ni8TnHNtuPBxTFf7iSLx8YGy2qP05g/qD3sOgtkxDel9kQm5Mu2E+/Y//XPzNgXrvazyqP+7u4kD4nkhrkQlR3Q+aybLHBpBgC0T90N63W9Dk+3IErAaHBfhh+Tzoz2GdjLwGAhP1OeOug5OD8GmgALxmtzqwdT0hnuE1t8Y3nzQYQQceRdTrJQ1K6vo7gbABDHzIxKk4BGEFuF9cycqbHiWdnj+Mtu+Y6JfMeQYmrX0AkWTt3vQtaJkDO1FrqaefEd3yNenjdX8vOxGrq7uPBLkKtZYtEVHYsB0eUPBx/qNDE2Ybccfzv+B/utf87j8SmP8DoI7sPiJdUYf/lDRGKFtp4z/96fUvpOruVCRUrkHhwCS7uWZrmDEIOfxf6iWqHKUW2F/QIMvwreakJAwmhubKb8JHFdHAN1cmajCXOOaq1pSU0k2p3iKZsFRmfBEKUyUY8U5ymTPyGSirg1E=

On Thu, 2024-08-15 at 14:34 +0300, Jani Nikula wrote:
> Update bug reporting info in bug-hunting.rst to direct people to
> driver/subsystem bug trackers, if explicitly specified with the
> MAINTAINERS "B:" entry. Use the new get_maintainer.pl --bug option to
> print the info.
>=20
> Cc: Joe Perches <joe@perches.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  Documentation/admin-guide/bug-hunting.rst | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/bug-hunting.rst b/Documentation/ad=
min-guide/bug-hunting.rst
> index 95299b08c405..1d0f8ceb3075 100644
> --- a/Documentation/admin-guide/bug-hunting.rst
> +++ b/Documentation/admin-guide/bug-hunting.rst
> @@ -244,14 +244,14 @@ Reporting the bug
>  Once you find where the bug happened, by inspecting its location,
>  you could either try to fix it yourself or report it upstream.
> =20
> -In order to report it upstream, you should identify the mailing list
> -used for the development of the affected code. This can be done by using
> -the ``get_maintainer.pl`` script.
> +In order to report it upstream, you should identify the bug tracker, if =
any, or
> +mailing list used for the development of the affected code. This can be =
done by
> +using the ``get_maintainer.pl`` script.
> =20
>  For example, if you find a bug at the gspca's sonixj.c file, you can get
>  its maintainers with::

Please use examples with and without B: entries.

> =20
> -	$ ./scripts/get_maintainer.pl -f drivers/media/usb/gspca/sonixj.c
> +	$ ./scripts/get_maintainer.pl --bug -f drivers/media/usb/gspca/sonixj.c
>  	Hans Verkuil <hverkuil@xs4all.nl> (odd fixer:GSPCA USB WEBCAM DRIVER,co=
mmit_signer:1/1=3D100%)
>  	Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT INFR=
ASTRUCTURE (V4L/DVB),commit_signer:1/1=3D100%)
>  	Tejun Heo <tj@kernel.org> (commit_signer:1/1=3D100%)
> @@ -267,11 +267,12 @@ Please notice that it will point to:
>  - The driver maintainer (Hans Verkuil);
>  - The subsystem maintainer (Mauro Carvalho Chehab);
>  - The driver and/or subsystem mailing list (linux-media@vger.kernel.org)=
;
> -- the Linux Kernel mailing list (linux-kernel@vger.kernel.org).
> +- The Linux Kernel mailing list (linux-kernel@vger.kernel.org);
> +- The bug reporting URIs for the driver/subsystem (none in the above exa=
mple).
> =20
> -Usually, the fastest way to have your bug fixed is to report it to maili=
ng
> -list used for the development of the code (linux-media ML) copying the
> -driver maintainer (Hans).
> +If the listing contains bug reporting URIs at the end, please prefer the=
m over
> +email. Otherwise, please report bugs to the mailing list used for the
> +development of the code (linux-media ML) copying the driver maintainer (=
Hans).

I think that's quite poorly described as it could ignore
any other reporter/developer or person that introduced
the defect.



