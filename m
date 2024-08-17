Return-Path: <linux-kernel+bounces-290529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75195554D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E6AB2281E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C677113;
	Sat, 17 Aug 2024 04:10:55 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78736126;
	Sat, 17 Aug 2024 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723867855; cv=none; b=TOJCvLj9O14ZVd0QeRffEIqTZpEQx764mEtY5+H3/WEvV5OkMr8MlA9nrkgFfLD6SaBxbUX+zI8H/K2pizIwtLPes/DQVinwmU85YnlKOgYAYfUGaTWNI7TI/Vf9rVeOhKeQV4Y5Vn2y+SBF9hm6n/A8rlGLMW2aAtNeDx3O3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723867855; c=relaxed/simple;
	bh=3hA7pZlZmvMwa6wkdU9iL2q/B3bHksw2jO25+IYLFBI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUswSB0GsfRaIxMyAIHu3g3U7X0i+aJ5v6sraWPjL77Yhtwq1ZZPYJptJDaj2ik0et9ur1oOHW7gnIQoUzVpiQf/JcENB/vK8rUabV8aAECMSBoHhr9w3Ln9fx4FHoiocTBr9mjG93CZVjCNXPoIgfGjn4+HHr3qgDY9NAJwwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7C5E9C0476;
	Sat, 17 Aug 2024 03:54:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 93D2620025;
	Sat, 17 Aug 2024 03:54:06 +0000 (UTC)
Message-ID: <bb845fb26a97737f212c861022651e8bac82cd29.camel@perches.com>
Subject: Re: [PATCH 2/2] Documentation: admin-guide: direct people to bug
 trackers, if specified
From: Joe Perches <joe@perches.com>
To: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 16 Aug 2024 20:54:05 -0700
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
X-Rspamd-Queue-Id: 93D2620025
X-Rspamd-Server: rspamout03
X-Stat-Signature: 114jkaurwmmfjhnt7hjbpfrwqdma3157
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19sMf9el56gvs3SKyuX/nfOTxiyfAgVAEU=
X-HE-Tag: 1723866846-743539
X-HE-Meta: U2FsdGVkX1/gvUULNqStB7gGfO+iZvO+OQ0FaYt8pUIZ567triV6p6NXT1oH6dC/R/+SAo6z3y/hXmb/iz5TDWzKo94Km5+bAh8WdirrSy/2TUE5bE7xrSfYEwc4ldVSStFy6lQVGPgWz1HUIMVgpRGsxLM+w44v0qIF9sT658mFcxptecAQSS0+d85j2qGJaDepx7hSO9hXU/dO8RrneRKHUQgpbQxnjrB7BVeWL18IRO9Gi/bPObfLnAjoiWyOOTKVubPx8G0blfA/L4Ru4xafGGoycLQM6TVZ2GfeRPwYxJUkFUmJrSAFivJ4t7+hOO8k+GbZ72lyR1tJNYmKZK4HsnaZ5AupZJbePVI9nQ4AlzQbNpSp5bRtcgSg0qDA6n81sxYEhIKxN3E9SA4P8TsTUY/EiH7/x46lLBxvqsoP1z86SdhTmEw2yD559V6uT4zmsZzqx6NtEJxcbgRELgESteXzqljcW5SKa6RALBF9e9b7kNAlzv4IsToFN20M9zwNOukE7abAvznucJX75BhnSWhz3l1/LvKXbSssHj4=

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
> =20
> -	$ ./scripts/get_maintainer.pl -f drivers/media/usb/gspca/sonixj.c
> +	$ ./scripts/get_maintainer.pl --bug -f drivers/media/usb/gspca/sonixj.c

Might not be the best use as B: entries are URIs and not email addresses

Maybe change the text above it too.

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

Maybe change the example to show a file/subsystem with a B: entry.


