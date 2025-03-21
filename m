Return-Path: <linux-kernel+bounces-570671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B61A6B349
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3FC4A0ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903091E573F;
	Fri, 21 Mar 2025 03:24:17 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C278F5B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527457; cv=none; b=F9FBUWiabwx1GwCSceQfPtJ43zpAFPb7E5Sdjoewf7lNP95ttzoVr8Eh5RhD8d3q224jVkDi6aF59Qt+YJGaj0pHhORAw4WfGTS3Mku0uieQklGeMK4fmlez2+2e7ghhxoDOb6RYGdgwt1+v7pvd9n7JUkG/Y6zzQDTmkBxVPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527457; c=relaxed/simple;
	bh=QYPYqXxSk+m4QHO+riiVcBjWVmqsuhtYKZyKZkIxgLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uErdOVvC2MaEnpIQ4sbZ9kBtHNcUfp1k9UdaCvSvmXPqaIYt+7c1FaMLYbhHNksQu+72K4rH/Da6lNRLrOuxqqUNkhRFQouMQn14lupkwBN5wwaWI0oAh1EUSMP/Eygnyjyq6y9Fv6cxFd0kR2EAk8MgWo1ThiGmrN1SAIQgCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B4A64141BC9;
	Fri, 21 Mar 2025 03:15:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 5C4CA1B;
	Fri, 21 Mar 2025 03:14:57 +0000 (UTC)
Message-ID: <cf0501d3245554150b4a19ced0401228fc58b335.camel@perches.com>
Subject: Re: [PATCH v2 34/59] checkpatch: dont warn about unused macro arg
 on empty body
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-gfx-trybot@lists.freedesktop.org, Andrew Morton
 <akpm@linux-foundation.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	louis.chauvet@bootlin.com, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray	 <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>
Date: Thu, 20 Mar 2025 20:14:54 -0700
In-Reply-To: <20250320185238.447458-35-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
	 <20250320185238.447458-35-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: iyw3o7jfnibfiwm8pf6ibncbdu7sr4cj
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5C4CA1B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/d9AFXY+OSiUh0DxEBRYtGbqh22M41r8M=
X-HE-Tag: 1742526897-40709
X-HE-Meta: U2FsdGVkX19v9u9NW6oOmjvrpY1bOxIWEW9ri8JTiu4krXIx0x4kkL3s61ycTUBVYqWZAIJ7C/Ffq/K4gn5g+x1GbdOrO8rxiB8vtXETDudv0bhAPVRTw1fTVd5XJOHb/T08AWWA/4+GAzz9gnI5j6EyCey42Mqds9Lh08qsIzFVVyEcE7VHsKRjN8+S78BB3IBAQZFf7JMHDzXKhyH+lKLH5xdY8wExVk1cTEYPnOiKtwrJVMU1Eqkzz5h/loNI06mGRiIU85CSc6y1/HEX6ycoLpVjDOfobMLd1AORzTdbRT7BLQ4pU6iK/RH+RU7sISAfSyV7gS1CHTH3IGEouccv2lGAGUKbzNYhnppxyhHx9lx4ATXEqmEqFJ7l5CDT4NwyArNrcE9vTgCIoAmzJvnzTrB72hFZaDZ5l3THts2SLb00BePyImuDplXttMbBt7RPNwhWyuDOnZqrhSwXMA==

On Thu, 2025-03-20 at 12:52 -0600, Jim Cromie wrote:
> we currently get:
>   WARNING: Argument 'name' is not used in function-like macro
> on:
>   #define DRM_CLASSMAP_USE(name)  /* nothing here */
>=20
> Following this advice is wrong here, and shouldn't be fixed by
> ignoring args altogether; the macro should properly fail if invoked
> with 0 or 2+ args.
>=20
> cc: Andy Whitcroft <apw@canonical.com>
> cc: Joe Perches <joe@perches.com>
> cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Completely sensible, thanks Jim.

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b28ad331742..0c4f578ea6e7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6037,7 +6037,7 @@ sub process {
>  				}
> =20
>  # check if this is an unused argument
> -				if ($define_stmt !~ /\b$arg\b/) {
> +				if ($define_stmt !~ /\b$arg\b/ && $define_stmt) {
>  					WARN("MACRO_ARG_UNUSED",
>  					     "Argument '$arg' is not used in function-like macro\n" . "$her=
ectx");
>  				}


